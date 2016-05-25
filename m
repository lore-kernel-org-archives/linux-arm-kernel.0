From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 25 May 2016 14:49:03 +0100
Subject: [PATCH v4 06/12] KVM: arm64: implement basic ITS register handlers
In-Reply-To: <5704D8B8.4000504@linaro.org>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <1458958450-19662-7-git-send-email-andre.przywara@arm.com>
 <5704D8B8.4000504@linaro.org>
Message-ID: <0c89ea29-4c40-ce87-f499-d600c466ace4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 06/04/16 10:36, Eric Auger wrote:
> Hi Andre,
> On 03/26/2016 03:14 AM, Andre Przywara wrote:
>> Add emulation for some basic MMIO registers used in the ITS emulation.

...

>> +
>> +/*
>> + * By writing to CWRITER the guest announces new commands to be processed.
>> + * Since we cannot read from guest memory inside the ITS spinlock, we
>> + * iterate over the command buffer (with the lock dropped) until the read
>> + * pointer matches the write pointer. Other VCPUs writing this register in the
>> + * meantime will just update the write pointer, leaving the command
>> + * processing to the first instance of the function.
>> + */
>> +static int vgic_mmio_write_its_cwriter(struct kvm_vcpu *vcpu,
>> +				       struct kvm_io_device *this,
>> +				       gpa_t addr, int len, const void *val)
>> +{
>> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>> +	struct vgic_its *its = &dist->its;
>> +	gpa_t cbaser = its_cmd_buffer_base(vcpu->kvm);
>> +	u64 cmd_buf[4];
>> +	u32 reg;
>> +	bool finished;
>> +
>> +	reg = mask64(its->cwriter & 0xfffe0, addr & 7, len, val);
>> +	reg &= 0xfffe0;
>> +	if (reg > its_cmd_buffer_size(vcpu->kvm))
>> +		return 0;
>> +
>> +	spin_lock(&its->lock);
>> +
>> +	/*
>> +	 * If there is still another VCPU handling commands, let this
>> +	 * one pick up the new CWRITER and process "our" new commands as well.
>> +	 */
>> +	finished = (its->cwriter != its->creadr);
> empty?

Maybe that is indeed less misleading ...

>> +	its->cwriter = reg;
>> +
>> +	spin_unlock(&its->lock);
> Assuming we have 2 vcpus attempting a cwriter write at the same moment I
> don't understand what does guarantee they are not going to execute the
> following loop concurrently and possibly execute vits_handle_command
> twice on the same cmd from the same its->creadr start?

So does my explanation of the algorithm in that other mail today explain
it? Or do you still see a hole in the locking scheme here?

>> +
>> +	while (!finished) {
>> +		int ret = kvm_read_guest(vcpu->kvm, cbaser + its->creadr,
>> +					 cmd_buf, 32);
>> +		if (ret) {
>> +			/*
>> +			 * Gah, we are screwed. Reset CWRITER to that command
>> +			 * that we have finished processing and return.
>> +			 */
>> +			spin_lock(&its->lock);
>> +			its->cwriter = its->creadr;
> don't get why do you set the queue empty?

So from a guest's point of view this is something like an ITS internal
error which shouldn't happen. So I just bail out, but leave the queue in
a consistent (read: empty) state to allow possible future commands to be
processed at best effort.
I guess this is the best we can come up with, since there is no feasible
way of communicating errors back(?)

Cheers,
Andre.

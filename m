From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 09:46:21 +0100
Subject: [PATCH 04/14] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <53A3F21E.5070306@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
 <1403171152-24067-5-git-send-email-andre.przywara@arm.com>
 <a090b95a6bf343e9b0ae036f387dc4aa@BY2PR07MB203.namprd07.prod.outlook.com>
 <53A3F21E.5070306@arm.com>
Message-ID: <53A3F4DD.1090405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/14 09:34, Andre Przywara wrote:
> 
> On 19/06/14 22:15, Chalamarla, Tirumalesh wrote:
>>
>>
>> -----Original Message-----
>> From: kvmarm-bounces at lists.cs.columbia.edu [mailto:kvmarm-bounces at lists.cs.columbia.edu] On Behalf Of Andre Przywara
>> Sent: Thursday, June 19, 2014 2:46 AM
>> To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
>> Cc: christoffer.dall at linaro.org
>> Subject: [PATCH 04/14] arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
>>
>> Some GICv3 registers can and will be accessed as 64 bit registers.
>> Currently the register handling code can only deal with 32 bit accesses, so we do two consecutive calls to cover this.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  virt/kvm/arm/vgic.c |   48 +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c index 4c6b212..b3cf4c7 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -906,6 +906,48 @@ static bool vgic_validate_access(const struct vgic_dist *dist,  }
>>  
>>  /*
>> + * Call the respective handler function for the given range.
>> + * We split up any 64 bit accesses into two consecutive 32 bit
>> + * handler calls and merge the result afterwards.
>> + */
>> +static bool call_range_handler(struct kvm_vcpu *vcpu,
>> +			       struct kvm_exit_mmio *mmio,
>> +			       unsigned long offset,
>> +			       const struct mmio_range *range) {
>> +	u32 *data32 = (void *)mmio->data;
>> +	struct kvm_exit_mmio mmio32;
>> +	bool ret;
>> +
>> +	if (likely(mmio->len <= 4))
>> +		return range->handle_mmio(vcpu, mmio, offset);
>> +
>> +	/*
>> +	 * We assume that any access greater than 4 bytes is actually
>> +	 * 8 bytes long, caused by a 64-bit access
>> +	 */
>> +
>> +	mmio32.len = 4;
>> +	mmio32.is_write = mmio->is_write;
>> +
>> +	mmio32.phys_addr = mmio->phys_addr + 4;
>> +	if (mmio->is_write)
>> +		*(u32 *)mmio32.data = data32[1];
>> +	ret = range->handle_mmio(vcpu, &mmio32, offset + 4);
>> +	if (!mmio->is_write)
>> +		data32[1] = *(u32 *)mmio32.data;
>> +
>> +	mmio32.phys_addr = mmio->phys_addr;
>> +	if (mmio->is_write)
>> +		*(u32 *)mmio32.data = data32[0];
>> +	ret |= range->handle_mmio(vcpu, &mmio32, offset);
>> +	if (!mmio->is_write)
>> +		data32[0] = *(u32 *)mmio32.data;
>> +
>> +	return ret;
>> +}
>>
>> Any reason to use two 32 bits instead of one 64 bit. AArch32 on ARMv8 may be.
> 
> For the registers we care about right now we get along with this split.
> And it seems to be less intrusive.
> I have a patch to support native 64-bit accesses, but it needs some more
> work. If there is high demand for it, I can post it (but Marc didn't
> like the first version so much ;-) )

The main reason is that GICv3 doesn't mandate nor guarantee any form of
64bit atomicity. There is strictly no need to provide a guarantee that
the architecture doesn't/cannot offer (think AArch32 guests for example).

	M.
-- 
Jazz is not dead. It just smells funny...

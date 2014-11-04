From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 04 Nov 2014 12:18:16 +0000
Subject: [PATCH v3 04/19] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <20141103132543.GE16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-5-git-send-email-andre.przywara@arm.com>
 <20141103132543.GE16132@cbox>
Message-ID: <5458C408.5070102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 03/11/14 13:25, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:39PM +0000, Andre Przywara wrote:
>> Some GICv3 registers can and will be accessed as 64 bit registers.
>> Currently the register handling code can only deal with 32 bit
>> accesses, so we do two consecutive calls to cover this.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  virt/kvm/arm/vgic.c |   48 +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 704be48..0cbdde9 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1033,6 +1033,48 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
>>  }
>>  
>>  /*
>> + * Call the respective handler function for the given range.
>> + * We split up any 64 bit accesses into two consecutive 32 bit
>> + * handler calls and merge the result afterwards.
>> + */
>> +static bool call_range_handler(struct kvm_vcpu *vcpu,
>> +			       struct kvm_exit_mmio *mmio,
>> +			       unsigned long offset,
>> +			       const struct mmio_range *range)
>> +{
>> +	u32 *data32 = (void *)mmio->data;
>> +	struct kvm_exit_mmio mmio32;
>> +	bool ret;
>> +
>> +	if (likely(mmio->len <= 4))
>> +		return range->handle_mmio(vcpu, mmio, offset);
>> +
>> +	/*
>> +	 * Any access bigger than 4 bytes (that we currently handle in KVM)
>> +	 * is actually 8 bytes long, caused by a 64-bit access
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
> 
> Please think about the endianness issues here.

I didn't only think about it, I traced the code and tested it:
So it works like written above (I actually had a hickup in my kvmtool
setup that denied booting the bigendian initrds, so I thought that BE
was broken).

So the GIC is always LE, that's why we swap the bytes to LE in any
32-bit register in mmio_data_{write,read}, which gets called for each
vGIC register access via the vgic_reg_access() function.

So the memory order that the actual register handler functions
implicitly expect is always LE, regardless of the guest or host
endianness. vgic_reg_access() makes this transparent for the host code.

Now if we eventually assemble the 64-bit value from the two 32-bit
values, we also have to always do this in LE fashion. Hence the
hardcoded LE assignment here. Eventually this LE value will be copied
into the guest, which will access it through readq, which uses
le64_to_cpu() to convert it to the CPU native value.

So the branch as posted (or present in the repo) works fine (boot-tested
only so far) with all 8 combinations of (host endianness, guest
endianness, guest v2/v3 GIC).

I will add a comment to the function explaining this.

Regards,
Andre.

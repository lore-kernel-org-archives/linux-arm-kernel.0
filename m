From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 24 Nov 2014 13:50:27 +0000
Subject: [PATCH v4 04/19] arm/arm64: KVM: wrap 64 bit MMIO accesses with
 two 32 bit ones
In-Reply-To: <20141123094253.GU3401@cbox>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-5-git-send-email-andre.przywara@arm.com>
 <20141123094253.GU3401@cbox>
Message-ID: <547337A3.8090103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 23/11/14 09:42, Christoffer Dall wrote:
> On Fri, Nov 14, 2014 at 10:07:48AM +0000, Andre Przywara wrote:
>> Some GICv3 registers can and will be accessed as 64 bit registers.
>> Currently the register handling code can only deal with 32 bit
>> accesses, so we do two consecutive calls to cover this.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog v3...v4:
>> - add comment explaining little endian handling
>>
>>  virt/kvm/arm/vgic.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 5eee3de..dba51e4 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1033,6 +1033,51 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
>>  }
>>  
>>  /*
>> + * Call the respective handler function for the given range.
>> + * We split up any 64 bit accesses into two consecutive 32 bit
>> + * handler calls and merge the result afterwards.
>> + * We do this in a little endian fashion regardless of the host's
>> + * or guest's endianness, because the GIC is always LE and the rest of
>> + * the code (vgic_reg_access) also puts it in a LE fashion already.
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
> 
> nit: if handle_mmio returns multiple error codes, we will now not
> (necessarily) be preserving either, so you may just want to do a check
> on ret above and return early in the case of error.  Only worth it if
> you respin anyway.

Mmh, if I read this correctly, the return value actually turns into
updated_state, so technically I wouldn't call this an error code. I
think we must not exit after the first half and also have to keep the
OR-ing semantics of the two parts, right?

Cheers,
Andre.

> 
> Otherwise:
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
>> +	if (!mmio->is_write)
>> +		data32[0] = *(u32 *)mmio32.data;
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>>   * vgic_handle_mmio_range - handle an in-kernel MMIO access
>>   * @vcpu:	pointer to the vcpu performing the access
>>   * @run:	pointer to the kvm_run structure
>> @@ -1063,10 +1108,10 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>  	spin_lock(&vcpu->kvm->arch.vgic.lock);
>>  	offset -= range->base;
>>  	if (vgic_validate_access(dist, range, offset)) {
>> -		updated_state = range->handle_mmio(vcpu, mmio, offset);
>> +		updated_state = call_range_handler(vcpu, mmio, offset, range);
>>  	} else {
>> -		vgic_reg_access(mmio, NULL, offset,
>> -				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +		if (!mmio->is_write)
>> +			memset(mmio->data, 0, mmio->len);
>>  		updated_state = false;
>>  	}
>>  	spin_unlock(&vcpu->kvm->arch.vgic.lock);
>> -- 
>> 1.7.9.5
>>
> 

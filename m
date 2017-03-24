From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 24 Mar 2017 11:38:33 +0100
Subject: [PATCH v3 06/19] KVM: arm64: ITS: Implement
 vgic_mmio_uaccess_write_its_creadr
In-Reply-To: <f5e4781d-3d13-e956-1056-2339a2fb2247@arm.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-7-git-send-email-eric.auger@redhat.com>
 <f5e4781d-3d13-e956-1056-2339a2fb2247@arm.com>
Message-ID: <4057e9b7-db65-f1da-4213-6ebee8659b63@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 20/03/2017 19:14, Andre Przywara wrote:
> Hi Eric,
> 
> On 06/03/17 11:34, Eric Auger wrote:
>> GITS_CREADR needs to be restored so let's implement the associated
>> uaccess_write_its callback.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Can you please rebase this (whole series) on the latest kernel? My patch
> to fix command processing with the ITS being disabled got merged just a
> few patches after -rc1. This will conflict here, but looks like a
> requirement anyway.
OK done
> 
>>
>> ---
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index e9c8f9f..6120c6e 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -1225,6 +1225,25 @@ static unsigned long vgic_mmio_read_its_creadr(struct kvm *kvm,
>>  	return extract_bytes(its->creadr, addr & 0x7, len);
>>  }
>>  
>> +static void vgic_mmio_uaccess_write_its_creadr(struct kvm *kvm,
>> +					       struct vgic_its *its,
>> +					       gpa_t addr, unsigned int len,
>> +					       unsigned long val)
>> +{
>> +	u32 reg;
>> +
>> +	mutex_lock(&its->cmd_lock);
>> +	reg = update_64bit_reg(its->creadr, addr & 7, len, val);
>> +	reg = ITS_CMD_OFFSET(reg);
>> +	if (reg >= ITS_CMD_BUFFER_SIZE(its->cbaser)) {
>> +		mutex_unlock(&its->cmd_lock);
>> +		return;
>> +	}
> 
> So do we need to specify some register order here? I think since CREADR
> is RO in the spec this isn't covered there, but I see issues here otherwise:
> - If we write CREADR while the ITS is enabled, this will probably
> confuse the state machine, since only the ITS (emulation engine) is
> supposed to change CREADR. So we should forbid setting CREADR in this
> case (easily doable with the fix mentioned above).
Added a check for this
> - CBASER resets both CREADR (as said in the spec) and CWRITER (our
> implementation choice), so it should be restored before any of those get
> restored. I think that should be mentioned in arm-vgic-its.txt.
Added this in the documentation

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>> +
>> +	its->creadr = reg;
>> +	mutex_unlock(&its->cmd_lock);
>> +}
>> +
>>  #define BASER_INDEX(addr) (((addr) / sizeof(u64)) & 0x7)
>>  static unsigned long vgic_mmio_read_its_baser(struct kvm *kvm,
>>  					      struct vgic_its *its,
>> @@ -1320,7 +1339,8 @@ static struct vgic_register_region its_registers[] = {
>>  		vgic_mmio_read_its_cwriter, vgic_mmio_write_its_cwriter, NULL,
>>  		8, VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
>>  	REGISTER_ITS_DESC(GITS_CREADR,
>> -		vgic_mmio_read_its_creadr, its_mmio_write_wi, NULL, 8,
>> +		vgic_mmio_read_its_creadr, its_mmio_write_wi,
>> +		vgic_mmio_uaccess_write_its_creadr, 8,
>>  		VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
>>  	REGISTER_ITS_DESC(GITS_BASER,
>>  		vgic_mmio_read_its_baser, vgic_mmio_write_its_baser, NULL, 0x40,
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

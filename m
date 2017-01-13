From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 13 Jan 2017 09:31:51 +0100
Subject: [RFC 06/13] KVM: arm64: ITS: Expose ITT_Entry_Size in GITS_TYPER
In-Reply-To: <3efc34ee-36c1-860a-365a-a9363b7fc8e5@arm.com>
References: <1484236613-24633-1-git-send-email-eric.auger@redhat.com>
 <1484236613-24633-7-git-send-email-eric.auger@redhat.com>
 <3efc34ee-36c1-860a-365a-a9363b7fc8e5@arm.com>
Message-ID: <a47500ab-5084-cc5b-f32f-7a911b6ffc72@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 12/01/2017 18:06, Andre Przywara wrote:
> Hi Eric,
> 
> On 12/01/17 15:56, Eric Auger wrote:
>> An ITT_Entry_Size of 2x8Bytes is reported to the guest
>> to provision for ITTE state storage.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/linux/irqchip/arm-gic-v3.h | 1 +
>>  virt/kvm/arm/vgic/vgic-its.c       | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 170e00a..8cfd81bc 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -233,6 +233,7 @@
>>  #define GITS_CTLR_QUIESCENT		(1U << 31)
>>  
>>  #define GITS_TYPER_PLPIS		(1UL << 0)
>> +#define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
>>  #define GITS_TYPER_IDBITS_SHIFT		8
>>  #define GITS_TYPER_DEVBITS_SHIFT	13
>>  #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index e174220..96378b8 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -33,6 +33,8 @@
>>  #include "vgic.h"
>>  #include "vgic-mmio.h"
>>  
>> +#define ITTE_SIZE 16
>> +
>>  /*
>>   * Creates a new (reference to a) struct vgic_irq for a given LPI.
>>   * If this LPI is already mapped on another ITS, we increase its refcount
>> @@ -399,6 +401,7 @@ static unsigned long vgic_mmio_read_its_typer(struct kvm *kvm,
>>  	 */
>>  	reg |= 0x0f << GITS_TYPER_DEVBITS_SHIFT;
>>  	reg |= 0x0f << GITS_TYPER_IDBITS_SHIFT;
>> +	reg |= ITTE_SIZE << GITS_TYPER_ITT_ENTRY_SIZE_SHIFT;
> 
> The field is defined as the "... number of bytes per translation table
> entry, minus one.". So it should be: (ITTE_SIZE - 1) << ...

You're perfectly right. I will fix that

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>>  
>>  	return extract_bytes(reg, addr & 7, len);
>>  }
>>

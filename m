From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 24 Nov 2015 09:36:28 -0500
Subject: [PATCH] xen/events: Always allocate legacy interrupts on PV guests
In-Reply-To: <alpine.DEB.2.02.1511201634500.1107@kaball.uk.xensource.com>
References: <1448036704-18630-1-git-send-email-boris.ostrovsky@oracle.com>
 <alpine.DEB.2.02.1511201634500.1107@kaball.uk.xensource.com>
Message-ID: <565475EC.40804@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/20/2015 11:35 AM, Stefano Stabellini wrote:
> On Fri, 20 Nov 2015, Boris Ostrovsky wrote:
>> After commit 8c058b0b9c34 ("x86/irq: Probe for PIC presence before
>> allocating descs for legacy IRQs") early_irq_init() will no longer
>> preallocate descriptors for legacy interrupts if PIC does not
>> exist, which is the case for Xen PV guests.
>>
>> Therefore we may need to allocate those descriptors ourselves.
>>
>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

I realized that I neglected to add ARM64 maintainers here. Adding them now.

(And this also need an ACK/NACK from Russell)

-boris

>
>
>> v3: Add arm64 definition of nr_legacy_irqs()
>>
>>   arch/arm/include/asm/irq.h       | 4 ++++
>>   arch/arm64/include/asm/irq.h     | 6 ++++++
>>   drivers/xen/events/events_base.c | 5 +++--
>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
>> index be1d07d..b864f60 100644
>> --- a/arch/arm/include/asm/irq.h
>> +++ b/arch/arm/include/asm/irq.h
>> @@ -2,6 +2,10 @@
>>   #define __ASM_ARM_IRQ_H
>>   
>>   #define NR_IRQS_LEGACY	16
>> +static inline int nr_legacy_irqs(void)
>> +{
>> +	return NR_IRQS_LEGACY;
>> +}
>>   
>>   #ifndef CONFIG_SPARSE_IRQ
>>   #include <mach/irqs.h>
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index 23eb450..24ba8d8 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -7,4 +7,10 @@ struct pt_regs;
>>   
>>   extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>>   
>> +#define NR_IRQS_LEGACY  0
>> +static inline int nr_legacy_irqs(void)
>> +{
>> +	return NR_IRQS_LEGACY;
>> +}
>> +
>>   #endif
>> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
>> index 849500e..524c221 100644
>> --- a/drivers/xen/events/events_base.c
>> +++ b/drivers/xen/events/events_base.c
>> @@ -39,6 +39,7 @@
>>   #include <asm/irq.h>
>>   #include <asm/idle.h>
>>   #include <asm/io_apic.h>
>> +#include <asm/i8259.h>
>>   #include <asm/xen/pci.h>
>>   #endif
>>   #include <asm/sync_bitops.h>
>> @@ -420,7 +421,7 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
>>   		return xen_allocate_irq_dynamic();
>>   
>>   	/* Legacy IRQ descriptors are already allocated by the arch. */
>> -	if (gsi < NR_IRQS_LEGACY)
>> +	if (gsi < nr_legacy_irqs())
>>   		irq = gsi;
>>   	else
>>   		irq = irq_alloc_desc_at(gsi, -1);
>> @@ -446,7 +447,7 @@ static void xen_free_irq(unsigned irq)
>>   	kfree(info);
>>   
>>   	/* Legacy IRQ descriptors are managed by the arch. */
>> -	if (irq < NR_IRQS_LEGACY)
>> +	if (irq < nr_legacy_irqs())
>>   		return;
>>   
>>   	irq_free_desc(irq);
>> -- 
>> 2.1.0
>>

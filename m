From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Fri, 20 Nov 2015 10:17:14 -0500
Subject: [PATCH v2] xen/events: Always allocate legacy interrupts on PV
 guests
In-Reply-To: <alpine.DEB.2.02.1511201117120.1107@kaball.uk.xensource.com>
References: <1447870445-17199-1-git-send-email-boris.ostrovsky@oracle.com>
 <alpine.DEB.2.02.1511201117120.1107@kaball.uk.xensource.com>
Message-ID: <564F397A.8010203@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 06:24 AM, Stefano Stabellini wrote:
> On Wed, 18 Nov 2015, Boris Ostrovsky wrote:
>> After commit 8c058b0b9c34 ("x86/irq: Probe for PIC presence before
>> allocating descs for legacy IRQs") early_irq_init() will no longer
>> preallocate descriptors for legacy interrupts if PIC does not
>> exist, which is the case for Xen PV guests.
>>
>> Therefore we may need to allocate those descriptors ourselves.
>>
>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> You need to do this for arm64 too.
>
> FYI you can download arm64 cross-compilers from
> https://releases.linaro.org/14.04/components/toolchain/binaries/
> then you can use them by exporting ARCH=arm64 and
> CROSS_COMPILE=/path/to/gcc-linaro-aarch64-linux-gnu-version/bin/aarch64-linux-gnu-

I did test on arm but didn't realize that arm64 uses different include 
files.

Does arm64 not have any legacy interrupts?

BTW, I got this build error:

   STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
0000000000000000 R_AARCH64_ABS64   __efistub_sort
0000000000000008 R_AARCH64_ABS64   .init__ksymtab_strings
drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references 
not allowed in the EFI stub
drivers/firmware/efi/libstub/Makefile:63: recipe for target 
'drivers/firmware/efi/libstub/lib-sort.stub.o' failed
make[4]: *** [drivers/firmware/efi/libstub/lib-sort.stub.o] Error 1
scripts/Makefile.build:403: recipe for target 
'drivers/firmware/efi/libstub' failed
make[3]: *** [drivers/firmware/efi/libstub] Error 2
scripts/Makefile.build:403: recipe for target 'drivers/firmware/efi' failed
make[2]: *** [drivers/firmware/efi] Error 2
scripts/Makefile.build:403: recipe for target 'drivers/firmware' failed
make[1]: *** [drivers/firmware] Error 2
Makefile:943: recipe for target 'drivers' failed
make: *** [drivers] Error 2

I worked around this by removing some of EFI config options but 
presumably this needs to be properly fixed.

-boris


>
>
>> v2: Use nr_legacy_irqs() instead of NR_IRQS_LEGACY (needs definition for ARM)
>>
>>   arch/arm/include/asm/irq.h       | 4 ++++
>>   drivers/xen/events/events_base.c | 5 +++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
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

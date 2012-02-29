From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Feb 2012 16:28:36 -0600
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <201202292153.03056.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <1330547147-22867-20-git-send-email-robherring2@gmail.com>
 <201202292153.03056.arnd@arndb.de>
Message-ID: <4F4EA694.5060003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 03:53 PM, Arnd Bergmann wrote:
> On Wednesday 29 February 2012, Rob Herring wrote:
> 
>> +static struct map_desc pci_io_desc __initdata = {
>> +       .virtual        = PCI_IO_VIRT_BASE,
>> +       .pfn            = 0,
>> +       .length         = SZ_1M,
>> +       .type           = MT_DEVICE,
>> +};
>> +
>> +void __init pci_map_io(unsigned long paddr[], int nr)
>> +{
>> +       int i;
>> +
>> +       if (nr > 1)
>> +               pci_io_desc.length = SZ_64K;
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               pci_io_desc.pfn = __phys_to_pfn(paddr[i]);
>> +               iotable_init(&pci_io_desc, 1);
>> +
>> +               pci_io_desc.virtual += SZ_64K;
>> +       }
>> +}
>> +
>> +void __init pci_map_io_single(unsigned long paddr)
>> +{
>> +       pci_map_io(&paddr, 1);
>> +}
> 
> Very clever interface, I like that!
> 
>> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
>> index d7861b9..f0af548 100644
>> --- a/arch/arm/include/asm/io.h
>> +++ b/arch/arm/include/asm/io.h
>> @@ -111,6 +111,10 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
>>   */
>>  #ifdef CONFIG_NEED_MACH_IO_H
>>  #include <mach/io.h>
>> +#elif defined(CONFIG_PCI)
>> +#define PCI_IO_VIRT_BASE 0xfef00000
>> +#define IO_SPACE_LIMIT ((resource_size_t)0xfffff)
>> +#define __io(a)                __typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
>>  #else
>>  #define __io(a)                ({ (void)(a); __typesafe_io(0); })
>>  #endif
> 
> Should we shrink the vmalloc area now so it stays clear of the io port range?
> 

No, then the mapping will fail. I do need to double check all the
mappings and make sure there is no overlap but we only care on the PCI
platforms I converted.

Also, it should be noted this shrinks the i/o space on some platforms.
dove and kirkwood had 1MB x 2 buses and now have 64KB per bus. ixp2000 I
think has 32MB with a note saying they need "a lot". Is there really a
use for lots of i/o space?

Rob

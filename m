From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Feb 2012 22:11:35 -0600
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <20120229221341.GF16999@n2100.arm.linux.org.uk>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <1330547147-22867-20-git-send-email-robherring2@gmail.com>
 <20120229221341.GF16999@n2100.arm.linux.org.uk>
Message-ID: <4F4EF6F7.3000702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 04:13 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 29, 2012 at 02:25:38PM -0600, Rob Herring wrote:
>> diff --git a/arch/arm/common/pci.c b/arch/arm/common/pci.c
>> new file mode 100644
>> index 0000000..d255e85
>> --- /dev/null
>> +++ b/arch/arm/common/pci.c
>> @@ -0,0 +1,46 @@
>> +/*
>> + * Copyright 2012 Calxeda, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <asm/sizes.h>
>> +#include <asm/mach/map.h>
> 
> I assume you've not tried building this with sparse, because it probably
> complains that these functions aren't static and are missing extern
> declarations (you're missing an include file.)
> 

No, fixed now. BTW, you can add this particular check with newer
versions gcc.

>> +
>> +static struct map_desc pci_io_desc __initdata = {
>> +	.virtual	= PCI_IO_VIRT_BASE,
>> +	.pfn		= 0,
>> +	.length		= SZ_1M,
>> +	.type		= MT_DEVICE,
>> +};
>> +
>> +void __init pci_map_io(unsigned long paddr[], int nr)
>> +{
>> +	int i;
>> +
>> +	if (nr > 1)
>> +		pci_io_desc.length = SZ_64K;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		pci_io_desc.pfn = __phys_to_pfn(paddr[i]);
>> +		iotable_init(&pci_io_desc, 1);
>> +
>> +		pci_io_desc.virtual += SZ_64K;
>> +	}
>> +}
>> +
>> +void __init pci_map_io_single(unsigned long paddr)
>> +{
>> +	pci_map_io(&paddr, 1);
>> +}
> 
> Is there a reason this can't live in arch/arm/kernel/bios32.c or
> arch/arm/kernel/isa.c ?
> 

No, I've moved it to bios32.c.

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
> 
> So what's wrong with the standard definition of IO_SPACE_LIMIT below
> this place?
>

It's a 1MB region rather than 64K to support multiple buses. I can
increase the existing one instead.

>> +#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
> 
> Why do you want ISA/PCI io port addresses to wrap?
> 
>>  #else
>>  #define __io(a)		({ (void)(a); __typesafe_io(0); })
>>  #endif
>> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
>> index d943b7d..b6d6f8c 100644
>> --- a/arch/arm/include/asm/mach/pci.h
>> +++ b/arch/arm/include/asm/mach/pci.h
>> @@ -60,6 +60,19 @@ struct pci_sys_data {
>>  void pci_common_init(struct hw_pci *);
>>  
>>  /*
>> + * Setup fixed I/O mapping. Must be called from .map_io function.
>> + */
>> +#ifdef CONFIG_PCI
>> +extern void pci_map_io(unsigned long paddr[], int nr);
>> +#else
>> +static inline void pci_map_io(unsigned long paddr[], int nr) {}
>> +#endif
>> +static inline void __init pci_map_io_single(unsigned long paddr)
>> +{
>> +	pci_map_io(&paddr, 1);
>> +}
> 
> What's the reason for having this as an inline function, and as a
> separate global function in pci.c ?

Because I forgot to remove the non-inline version...

I've changed this some to use pfn directly rather than physaddr as
iop13xx has 64-bit phys addresses.

Rob

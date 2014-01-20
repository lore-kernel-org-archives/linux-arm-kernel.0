From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 16:08:01 +0800
Subject: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when
 PCI is enabled
In-Reply-To: <201401171504.24525.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-7-git-send-email-hanjun.guo@linaro.org>
 <201401171504.24525.arnd@arndb.de>
Message-ID: <52DCD961.70303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-17 22:04, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>> +++ b/arch/arm64/pci/Makefile
>> @@ -0,0 +1 @@
>> +obj-y                 += pci.o
>> diff --git a/arch/arm64/pci/pci.c b/arch/arm64/pci/pci.c
>> new file mode 100644
>> index 0000000..4e46790
>> --- /dev/null
>> +++ b/arch/arm64/pci/pci.c
>> @@ -0,0 +1,33 @@
>> +#include <linux/acpi.h>
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +/**
>> + * raw_pci_read - Platform-specific PCI config space access.
>> + *
>> + * Default empty implementation.  Replace with an architecture-specific setup
>> + * routine, if necessary.
>> + */
>> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
>> +			unsigned int devfn, int reg, int len, u32 *val)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>> +			unsigned int devfn, int reg, int len, u32 val)
>> +{
>> +	return -EINVAL;
>> +}
> 
> I'd rather not see __weak functions here. Just provide them unconditionally
> so that we can add a proper implementation when needed. You could also
> define these as 'static inline' in a header file to keep them from consuming
> space in the object code.

Ok, I will remove __weak in next version.

> 
>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
>> index 3c8521d..1835b21 100644
>> --- a/drivers/acpi/plat/arm-core.c
>> +++ b/drivers/acpi/plat/arm-core.c
>> @@ -100,6 +100,25 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>  
>> +int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
>> +{
>> +	return -1;
>> +}
>> +
>> +int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
>> +{
>> +	/* TBD */
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(acpi_register_ioapic);
>> +
>> +int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
>> +{
>> +	/* TBD */
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(acpi_unregister_ioapic);
>> +
> 
> My feeling is that these are better handled in the ACPI code by not
> calling them on architectures that have no ISA or no IOAPIC support.
> 
> We have configuration symbols for both, so you don't have to make
> it depend on CONFIG_ARM64 or CONFIG_X86.

Do you mean introduce a stub function when there is no ISA support?

acpi_register_ioapic()/acpi_unregister_ioapic() will be used for IOAPIC
hotplug and GIC distributor is something like IOAPIC on x86, so I think
these two functions can be reserved for future use.

Thanks
Hanjun

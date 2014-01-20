From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 17:33:09 +0800
Subject: [PATCH 01/20] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <CAErSpo6tsZtqFfgBp9mwU9Ln7yDmKLWJFKK8eW9_m4Sgb=E3eg@mail.gmail.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-2-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6tsZtqFfgBp9mwU9Ln7yDmKLWJFKK8eW9_m4Sgb=E3eg@mail.gmail.com>
Message-ID: <52DCED55.1080903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-18 0:00, Bjorn Helgaas wrote:
> [+cc Jens, James, Ben, Fujita (authors of PCI_DMA_BUS_IS_PHYS usage)]
> 
> On Fri, Jan 17, 2014 at 5:24 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Not all the ARM64 targets that are using ACPI have PCI, so introduce
>> some stub functions to make PCI optional for ACPI, and make ACPI core
>> run without CONFIG_PCI on ARM64.
>>
>> pcibios_penalize_isa_irq() is arch dependent, introduce asm/pci.h to
>> include it.
>>
>> Since ACPI on X86 and IA64 depends on PCI, it will not break X86 and
>> IA64 with this patch.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/pci.h |   20 ++++++++++++++++++++
>>  drivers/acpi/Makefile        |    2 +-
>>  drivers/acpi/internal.h      |    7 +++++++
>>  drivers/acpi/osl.c           |    3 ++-
>>  include/linux/pci.h          |   33 ++++++++++++++++++++++++---------
>>  5 files changed, 54 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/pci.h
>>
>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> new file mode 100644
>> index 0000000..455909d
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/pci.h
>> @@ -0,0 +1,20 @@
>> +#ifndef __ASMARM64_PCI_H
>> +#define __ASMARM64_PCI_H
>> +
>> +#ifdef __KERNEL__
>> +
>> +static inline void pcibios_penalize_isa_irq(int irq, int active)
>> +{
>> +       /* We don't do dynamic PCI IRQ allocation */
>> +}
>> +
>> +/*
>> + * The PCI address space does equal the physical memory address space.
>> + * The networking and block device layers use this boolean for bounce
>> + * buffer decisions.
>> + */
>> +#define PCI_DMA_BUS_IS_PHYS     (1)
> 
> I'm not sure this is accurate.  The arm code uses
> pci_add_resource_offset() with non-zero offsets, which means a
> physical memory address is not the same as a PCI bus address.  I don't
> know what arm64 does for PCI, but I suspect it is similar.

I'm not sure either. I copied this code from arm/asm/pci.h and I
thought it will be the same for ARM64.

> 
> I think PCI_DMA_BUS_IS_PHYS is due for some overhaul.  I'm dubious
> that it is working as intended anymore.  At the very least, it seems
> like something that is dependent on the device in question.
> 
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index a13d682..726cf2a 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> ...
>> +static inline int raw_pci_read(unsigned int domain, unsigned int bus,
>> +               unsigned int devfn, int reg, int len, u32 *val)
>> +{ return -EINVAL; }
>> +
>> +static inline int raw_pci_write(unsigned int domain, unsigned int bus,
>> +               unsigned int devfn, int reg, int len, u32 val)
>> +{return -EINVAL; }
> 
> Fix the spacing here (missing a space before "return").
> 
> With that, this include/linux/pci.h change is:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

Hanjun

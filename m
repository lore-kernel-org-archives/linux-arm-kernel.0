From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Nov 2016 12:12:08 +0000
Subject: [PATCH] arm64: acpi: arch_apei_get_mem_attributes() should use
 memblock
In-Reply-To: <20161108102714.29931-1-james.morse@arm.com>
References: <20161108102714.29931-1-james.morse@arm.com>
Message-ID: <CAKv+Gu9+T0TYqk+uTUWa5K0E49WXDBpUK4Px_q=52jR0ON1zGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 8 November 2016 at 10:27, James Morse <james.morse@arm.com> wrote:
> arm64's arch_apei_get_mem_attributes() tries to use
> efi_mem_attributes() to read the memory attributes from the efi
> memory map.
>
> drivers/firmware/efi/arm-init.c:efi_init() calls efi_memmap_unmap(),
> which clears the EFI_MEMMAP bit from efi.flags once efi_init() has
> finished with the memory map. This causes efi_mem_attributes() to
> return 0 meaning PROT_DEVICE_nGnRnE is the chosen memory type for
> all ACPI APEI mappings.
>
> APEI may call this from NMI context, so we can't re-map the EFI
> memory map as this may need to allocate virtual address space.
> 'ghes_ioremap_area' is APEIs cache of virtual address space to
> access the buffer once we tell it the memory attributes.
>
> Do as acpi_os_ioremap() does, and consult memblock to learn if
> the provided address is memory, or not.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Fixes: 89e44b51cc0d ("arm64, acpi/apei: Implement arch_apei_get_mem_attributes()")
>
> This doesn't code even get built on mainline as HAVE_ACPI_APEI isn't
> defined, until https://lkml.org/lkml/2016/8/10/231 gets merged.
> I don't think this should go to stable.
>
> I also took the opportunity to remove some unnecessarily ifdef'd
> includes.
>
>  arch/arm64/kernel/acpi.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 252a6d9c1da5..985f721f3bdd 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
>  #include <linux/cpumask.h>
> +#include <linux/efi.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> @@ -28,13 +29,9 @@
>
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
> +#include <asm/pgtable.h>
>  #include <asm/smp_plat.h>
>
> -#ifdef CONFIG_ACPI_APEI
> -# include <linux/efi.h>
> -# include <asm/pgtable.h>
> -#endif
> -
>  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
>  EXPORT_SYMBOL(acpi_disabled);
> @@ -241,22 +238,13 @@ void __init acpi_boot_table_init(void)
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>  {
>         /*
> -        * According to "Table 8 Map: EFI memory types to AArch64 memory
> -        * types" of UEFI 2.5 section 2.3.6.1, each EFI memory type is
> -        * mapped to a corresponding MAIR attribute encoding.
> -        * The EFI memory attribute advises all possible capabilities
> -        * of a memory region. We use the most efficient capability.
> +        * The EFI memmap isn't mapped, instead read the version exported
> +        * into memblock. EFI's reserve_regions() call adds memory with the
> +        * WB attribute to memblock via early_init_dt_add_memory_arch().
>          */
> +       if (!memblock_is_memory(addr))
> +               return __pgprot(PROT_DEVICE_nGnRnE);
>
> -       u64 attr;
> -
> -       attr = efi_mem_attributes(addr);
> -       if (attr & EFI_MEMORY_WB)
> -               return PAGE_KERNEL;
> -       if (attr & EFI_MEMORY_WT)
> -               return __pgprot(PROT_NORMAL_WT);
> -       if (attr & EFI_MEMORY_WC)
> -               return __pgprot(PROT_NORMAL_NC);
> -       return __pgprot(PROT_DEVICE_nGnRnE);
> +       return PAGE_KERNEL;

As you know, we recently applied [0] to ensure that memory regions
that are marked by UEFI was write-through cacheable (WT) or
write-combining (WC) are not misidentified by the kernel as having
strongly ordered semantics.

This means that in this case, you may be returning PAGE_KERNEL for
regions that are lacking the EFI_MEMORY_WB attribute, which kind of
defeats the purpose of this function (AIUI), to align the kernel's
view of the region's attributes with the view of the firmware. I would
expect that, for use cases like this one, the burden is on the
firmware to ensure that only a single EFI_MEMORY_xx attribute is set
if any kind of coherency between UEFI and the kernel is expected. If
that single attribute is WT or WC, PAGE_KERNEL is most certainly
wrong.


[0] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=cb82cce7035

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Dec 2015 17:02:57 +0000
Subject: [PATCH v2] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1449068345-9021-1-git-send-email-fu.wei@linaro.org>
References: <1449068345-9021-1-git-send-email-fu.wei@linaro.org>
Message-ID: <20151202170257.GB20520@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 10:59:05PM +0800, fu.wei at linaro.org wrote:

[...]

> +#ifdef CONFIG_ACPI_APEI
> +extern int acpi_disable_cmcff;
> +#endif
>  
>  static inline void disable_acpi(void)
>  {
> @@ -94,6 +97,7 @@ static inline const char *acpi_get_enable_method(int cpu)
>  
>  #ifdef	CONFIG_ACPI_APEI
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> +void arch_apei_flush_tlb_one(unsigned long addr);
>  #endif
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2..811fea2 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -32,6 +32,7 @@
>  #ifdef CONFIG_ACPI_APEI
>  # include <linux/efi.h>
>  # include <asm/pgtable.h>
> +# include <asm/tlbflush.h>
>  #endif
>  
>  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
> @@ -41,6 +42,10 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>  
> +#ifdef CONFIG_ACPI_APEI
> +int acpi_disable_cmcff;
> +#endif

There must be a reason why we keep all these arch agnostic ACPI flags
in arch specific code, is there ?

Lorenzo

> +
>  static bool param_acpi_off __initdata;
>  static bool param_acpi_force __initdata;
>  
> @@ -233,4 +238,9 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>  		return __pgprot(PROT_NORMAL_NC);
>  	return __pgprot(PROT_DEVICE_nGnRnE);
>  }
> +
> +void arch_apei_flush_tlb_one(unsigned long addr)
> +{
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +}
>  #endif
> -- 
> 2.5.0
> 

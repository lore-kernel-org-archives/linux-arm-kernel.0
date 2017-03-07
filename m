From: james.morse@arm.com (James Morse)
Date: Tue, 07 Mar 2017 11:37:34 +0000
Subject: [PATCH V12 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <1488833103-21082-6-git-send-email-tbaicar@codeaurora.org>
References: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
 <1488833103-21082-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <58BE9B7E.4070904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 06/03/17 20:44, Tyler Baicar wrote:
> ARM APEI extension proposal added SEA (Synchronous External Abort)
> notification type for ARMv8.
> Add a new GHES error source handling function for SEA. If an error
> source's notification type is SEA, then this function can be registered
> into the SEA exception handler. That way GHES will parse and report
> SEA exceptions when they occur.
> An SEA can interrupt code that had interrupts masked and is treated as
> an NMI. To aid this the page of address space for mapping APEI buffers
> while in_nmi() is always reserved, and ghes_ioremap_pfn_nmi() is
> changed to use the helper methods to find the prot_t to map with in
> the same way as ghes_ioremap_pfn_irq().

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d178dc0..b2d57fc 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -41,6 +41,8 @@
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
>  
> +#include <acpi/ghes.h>
> +
>  static const char *fault_name(unsigned int esr);
>  
>  #ifdef CONFIG_KPROBES
> @@ -498,6 +500,17 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>  		 fault_name(esr), esr, addr);
>  
> +	/*
> +	 * Synchronous aborts may interrupt code which had interrupts masked.
> +	 * Before calling out into the wider kernel tell the interested
> +	 * subsystems.
> +	 */
> +	if (IS_ENABLED(ACPI_APEI_SEA)) {

IS_ENABLED() needs the CONFIG_ version of the symbols, otherwise this doesn't
get built.

(I guess the testing from the previous always-enabled version is still valid)


> +		nmi_enter();
> +		ghes_notify_sea();
> +		nmi_exit();
> +	}
> +
>  	info.si_signo = SIGBUS;
>  	info.si_errno = 0;
>  	info.si_code  = 0;
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index b0140c8..c545dd1 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -39,6 +39,21 @@ config ACPI_APEI_PCIEAER
>  	  PCIe AER errors may be reported via APEI firmware first mode.
>  	  Turn on this option to enable the corresponding support.
>  
> +config ACPI_APEI_SEA
> +	bool "APEI Synchronous External Abort logging/recovering support"
> +	depends on ARM64 && ACPI_APEI && ACPI_APEI_GHES

Nit: ACPI_APEI_GHES already depends on ACPI_APEI


> +	default y
> +	help
> +	  This option should be enabled if the system supports
> +	  firmware first handling of SEA (Synchronous External Abort).
> +	  SEA happens with certain faults of data abort or instruction
> +	  abort synchronous exceptions on ARMv8 systems. If a system
> +	  supports firmware first handling of SEA, the platform analyzes
> +	  and handles hardware error notifications from SEA, and it may then
> +	  form a HW error record for the OS to parse and handle. This
> +	  option allows the OS to look for such hardware error record, and
> +	  take appropriate action.
> +
>  config ACPI_APEI_MEMORY_FAILURE
>  	bool "APEI memory error recovering support"
>  	depends on ACPI_APEI && MEMORY_FAILURE


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

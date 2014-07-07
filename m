From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 07 Jul 2014 23:06:05 +0200
Subject: [PATCH 1/4] ACPI: ARM64 does not have a BIOS add config for BIOS
 table scan.
In-Reply-To: <1404290847-7671-2-git-send-email-hanjun.guo@linaro.org>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1430951.SWzYBgFe0M@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 02, 2014 04:47:23 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> With the addition of ARM64 that does not have a traditional BIOS to
> scan, add a config option which is selected on x86 and ia64 to do
> the traditional BIOS scanning for tables.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/Kconfig    |    1 +
>  arch/x86/Kconfig     |    1 +
>  drivers/acpi/Kconfig |    3 +++
>  drivers/acpi/osl.c   |    4 +++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 2f3abcf..f82b352 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -47,6 +47,7 @@ config IA64
>  	select MODULES_USE_ELF_RELA
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select ACPI_SCAN_BIOS_NOT_EFI

I would call this ACPI_LEGACY_TABLES_LOOKUP or something like that.

Also please do

+	select ACPI_LEGACY_TABLES_LOOKUP if ACPI

in analogy with patch [3/4] in this series.

>  	default y
>  	help
>  	  The Itanium Processor Family is Intel's 64-bit successor to
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a8f749e..4865d44 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -131,6 +131,7 @@ config X86
>  	select HAVE_CC_STACKPROTECTOR
>  	select GENERIC_CPU_AUTOPROBE
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select ACPI_SCAN_BIOS_NOT_EFI
>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index a34a228..70eaf7a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -2,6 +2,9 @@
>  # ACPI Configuration
>  #
>  
> +config ACPI_SCAN_BIOS_NOT_EFI
> +	bool
> +
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on !IA64_HP_SIM
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index bad25b0..5ba0b74 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -259,12 +259,14 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>  			       "System description tables not found\n");
>  			return 0;
>  		}
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_ACPI_SCAN_BIOS_NOT_EFI)) {
>  		acpi_physical_address pa = 0;
>  
>  		acpi_find_root_pointer(&pa);
>  		return pa;
>  	}
> +
> +	return 0;
>  }
>  
>  /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

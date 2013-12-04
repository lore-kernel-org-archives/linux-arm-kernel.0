From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Wed, 4 Dec 2013 10:10:50 +0000
Subject: [RFC part1 PATCH 7/7] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <1386088611-2801-8-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-8-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131204101050.GQ2395@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 12:36:51AM +0800, Hanjun Guo wrote:
> Add Kconfigs to build ACPI on ARM64, and make ACPI runable on ARM64.
> 
> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
> depends on X86 || IA64, and implement it on ARM in the furture.
> 
> In order to make arm-core.c can both run on ARM and ARM64, introduce
> CONFIG_ACPI_ARM to support it.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/Kconfig         |    2 ++
>  drivers/acpi/Kconfig       |   12 +++++++++---
>  drivers/acpi/plat/Makefile |    2 +-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 88c8b6c1..a37795f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -280,6 +280,8 @@ source "net/Kconfig"
>  
>  source "drivers/Kconfig"
>  
> +source "drivers/acpi/Kconfig"
> +
>  source "fs/Kconfig"
>  
>  source "arch/arm64/kvm/Kconfig"
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 53f0f16..f43485e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -2,13 +2,17 @@
>  # ACPI Configuration
>  #
>  
> +config ACPI_ARM
> +	bool
> +	select ACPI_REDUCED_HARDWARE
> +
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on !IA64_HP_SIM
> -	depends on IA64 || X86
> -	depends on PCI
> +	depends on ((IA64 || X86) && PCI) || ARM64
>  	select PNP
> -	default y
> +	select ACPI_ARM if (ARM || ARM64)
> +	default y if !(ARM || ARM64)

Should only be ARM64 here with the current files in this series, I think
this is causing others confusion looking for arm 32bit support in patches
where there is none yet!

>  	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
>  	  Linux requires an ACPI-compliant platform (hardware/firmware),
> @@ -149,6 +153,7 @@ config ACPI_PROCESSOR
>  	tristate "Processor"
>  	select THERMAL
>  	select CPU_IDLE
> +	depends on X86 || IA64
>  	default y
>  	help
>  	  This driver installs ACPI as the idle handler for Linux and uses
> @@ -250,6 +255,7 @@ config ACPI_DEBUG
>  config ACPI_PCI_SLOT
>  	bool "PCI slot detection driver"
>  	depends on SYSFS
> +	depends on PCI
>  	default n
>  	help
>  	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
> diff --git a/drivers/acpi/plat/Makefile b/drivers/acpi/plat/Makefile
> index 46bc65e..3a61176 100644
> --- a/drivers/acpi/plat/Makefile
> +++ b/drivers/acpi/plat/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_ARM64)	+= arm-core.o
> +obj-$(CONFIG_ACPI_ARM)	+= arm-core.o
> -- 
> 1.7.9.5
> 

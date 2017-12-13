From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 Dec 2017 17:26:47 +0000
Subject: [PATCH v5 3/9] ACPI: Enable PPTT support on ARM64
In-Reply-To: <20171201222330.18863-4-jeremy.linton@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-4-jeremy.linton@arm.com>
Message-ID: <20171213172647.GA3316@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 04:23:24PM -0600, Jeremy Linton wrote:
> Now that we have a PPTT parser, in preparation for its use
> on arm64, lets build it.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/Kconfig    | 1 +
>  drivers/acpi/Kconfig  | 3 +++
>  drivers/acpi/Makefile | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a93339f5178f..e62fd1e08c1f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -7,6 +7,7 @@ config ARM64
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if ACPI
>  	select ACPI_SPCR_TABLE if ACPI
> +	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 46505396869e..df7aebf0af0e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -545,6 +545,9 @@ config ACPI_CONFIGFS
>  
>  if ARM64
>  source "drivers/acpi/arm64/Kconfig"
> +
> +config ACPI_PPTT
> +	bool

We need to make a choice here. Either PPTT is considered ARM64 only and
we move code and config to drivers/acpi/arm64/Kconfig or we leave it in
drivers/acpi/pptt.c and we add a Kconfig entry in drivers/acpi/Kconfig
(and we make pptt.c compile on !ARM64 - which is what it should be given
that there is nothing ARM64 specific in it).

Lorenzo

>  endif
>  
>  config TPS68470_PMIC_OPREGION
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 41954a601989..b6056b566df4 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> -- 
> 2.13.5
> 

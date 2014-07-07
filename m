From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 07 Jul 2014 23:13:05 +0200
Subject: [PATCH 3/4] ACPI / processor: Introduce ARCH_HAS_ACPI_PDC
In-Reply-To: <1404290847-7671-4-git-send-email-hanjun.guo@linaro.org>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2064691.ZpxCs0gfL8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 02, 2014 04:47:25 PM Hanjun Guo wrote:
> The use of _PDC is deprecated in ACPI 3.0 in favor of _OSC,
> as ARM platform is supported only in ACPI 5.0 or higher version,
> _PDC will not be used in ARM platform, so make Make _PDC only for
> platforms with Intel CPUs.
> 
> Introduce ARCH_HAS_ACPI_PDC and move _PDC related code in ACPI
> processor driver into a single file processor_pdc.c, make x86
> and ia64 select ARCH_HAS_ACPI_PDC when ACPI is enabled.
> 
> This patch also use pr_* to replace printk to fix the checkpatch
> warning and factor acpi_processor_alloc_pdc() a little bit to
> avoid duplicate pr_err() code.
> 
> Suggested-by: Robert Richter <rric@kernel.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/Kconfig             |    1 +
>  arch/x86/Kconfig              |    1 +
>  drivers/acpi/Kconfig          |   10 ++
>  drivers/acpi/Makefile         |    1 +
>  drivers/acpi/internal.h       |    5 +
>  drivers/acpi/processor_core.c |  198 ---------------------------------------
>  drivers/acpi/processor_pdc.c  |  206 +++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 224 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/acpi/processor_pdc.c
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index f82b352..cde2626 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -10,6 +10,7 @@ config IA64
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select PCI if (!IA64_HP_SIM)
>  	select ACPI if (!IA64_HP_SIM)
> +	select ARCH_HAS_ACPI_PDC if ACPI

The ARCH_HAS part doesn't seem to be particularly consistent with
the existing naming.  ARCH_MIGHT_HAVE_ACPI_PDC would be better IMO.

>  	select PM if (!IA64_HP_SIM)
>  	select HAVE_UNSTABLE_SCHED_CLOCK
>  	select HAVE_IDE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4865d44..d60cec7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -21,6 +21,7 @@ config X86_64
>  ### Arch settings
>  config X86
>  	def_bool y
> +	select ARCH_HAS_ACPI_PDC if ACPI
>  	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 70eaf7a..0e6f72d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -367,6 +367,16 @@ config ACPI_REDUCED_HARDWARE_ONLY
>  
>  	If you are unsure what to do, do not enable this option.
>  
> +config ARCH_HAS_ACPI_PDC
> +	bool
> +	help
> +	  The _PDC object provides OSPM a mechanism to convey to the platform
> +	  the capabilities supported by OSPM for processor power management.
> +	  This allows the platform to modify the ACPI namespace objects returning
> +	  configuration information for processor power management based on the
> +	  level of support provided by OSPM.The use of _PDC is deprecated in
> +	  ACPI 3.0 in favor of _OSC.

Is the help actually useful?  This doesn't seem to be user-selectable, does it?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

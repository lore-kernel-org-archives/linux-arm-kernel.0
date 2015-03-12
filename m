From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 12 Mar 2015 23:57:19 +0100
Subject: [PATCH v10 06/21] ACPI / sleep: Introduce
 CONFIG_ACPI_GENERIC_SLEEP
In-Reply-To: <1426077587-1561-7-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <3629643.daQYNeVrsM@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 11, 2015 08:39:32 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() and acpi_sleep_init()
> for device power management, so introduce CONFIG_ACPI_GENERIC_SLEEP
> and select it for x86 and ia64 only to make sleep functions available,
> and also introduce stub function to allow other drivers to function
> until S states are defined for ARM64.
> 
> It will be no functional change for x86 and IA64.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/Kconfig       | 1 +
>  arch/x86/Kconfig        | 1 +
>  drivers/acpi/Kconfig    | 4 ++++
>  drivers/acpi/Makefile   | 2 +-
>  drivers/acpi/internal.h | 4 ++++
>  5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 074e52b..e8728d7 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -10,6 +10,7 @@ config IA64
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select PCI if (!IA64_HP_SIM)
>  	select ACPI if (!IA64_HP_SIM)
> +	select ACPI_GENERIC_SLEEP if ACPI
>  	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>  	select HAVE_UNSTABLE_SCHED_CLOCK
>  	select HAVE_IDE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b7d31ca..9804431 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -22,6 +22,7 @@ config X86_64
>  ### Arch settings
>  config X86
>  	def_bool y
> +	select ACPI_GENERIC_SLEEP if ACPI
>  	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>  	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>  	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e6c3ddd..a7b9120 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -48,9 +48,13 @@ config ACPI_LEGACY_TABLES_LOOKUP
>  config ARCH_MIGHT_HAVE_ACPI_PDC
>  	bool
>  
> +config ACPI_GENERIC_SLEEP
> +	bool
> +
>  config ACPI_SLEEP
>  	bool
>  	depends on SUSPEND || HIBERNATION
> +	depends on ACPI_GENERIC_SLEEP
>  	default y
>  
>  config ACPI_PROCFS_POWER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 623b117..2397822 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -23,7 +23,7 @@ acpi-y				+= nvs.o
>  
>  # Power management related files
>  acpi-y				+= wakeup.o
> -acpi-y				+= sleep.o
> +acpi-$(CONFIG_ACPI_GENERIC_SLEEP) += sleep.o
>  acpi-y				+= device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
>  
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 56b321a..b5eef4c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -161,7 +161,11 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
>  /*--------------------------------------------------------------------------
>                                    Suspend/Resume
>    -------------------------------------------------------------------------- */
> +#ifdef CONFIG_ACPI_GENERIC_SLEEP
>  extern int acpi_sleep_init(void);
> +#else
> +static inline int acpi_sleep_init(void) { return -ENOSYS; }

Please change the return value here, preferably to -ENXIO.

-ENOSYS *specifically* means "system call not implemented" and should only be
used to indicate this particular condition.

> +#endif
>  
>  #ifdef CONFIG_ACPI_SLEEP
>  int acpi_sleep_proc_init(void);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

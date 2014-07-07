From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 07 Jul 2014 23:08:16 +0200
Subject: [PATCH 2/4] ACPI: Don't use acpi_lapic in ACPI core code
In-Reply-To: <1404290847-7671-3-git-send-email-hanjun.guo@linaro.org>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2058650.s5vKv1ibCp@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 02, 2014 04:47:24 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Now ARM64 support is being added to ACPI so architecture specific
> values can not be used in core ACPI code.
> 
> Following on the patch "ACPI / processor: Check if LAPIC is present
> during initialization" which uses acpi_lapic in acpi_processor.c,
> on ARM64 platform, GIC is used instead of local APIC, so acpi_lapic
> is not a suitable value for ARM64.
> 
> What is actually important at this point is the SMPness of the system,
> so introduce acpi_arch_is_smp() to be arch specific and generic.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/include/asm/acpi.h  |    5 +++++
>  arch/x86/include/asm/acpi.h   |    5 +++++
>  drivers/acpi/acpi_processor.c |    2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
> index 75dc59a..2fc0757 100644
> --- a/arch/ia64/include/asm/acpi.h
> +++ b/arch/ia64/include/asm/acpi.h
> @@ -40,6 +40,11 @@ extern int acpi_lapic;
>  #define acpi_noirq 0	/* ACPI always enabled on IA64 */
>  #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
>  #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
> +
> +static inline bool acpi_arch_is_smp(void)

Why this name?  In particular, local APIC being present doesn't imply SMP.

> +{
> +	return acpi_lapic;

Also

	return !!acpi_lapic;

would be cleaner IMO.

> +}
>  #endif
>  #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
>  static inline void disable_acpi(void) { }
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index e06225e..939d377 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -121,6 +121,11 @@ static inline void arch_acpi_set_pdc_bits(u32 *buf)
>  		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
>  }
>  
> +static inline bool acpi_arch_is_smp(void)
> +{
> +	return acpi_lapic;
> +}
> +
>  #else /* !CONFIG_ACPI */
>  
>  #define acpi_lapic 0
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 1c08574..8622a0e 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -268,7 +268,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	pr->apic_id = apic_id;
>  
>  	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
> -	if (!cpu0_initialized && !acpi_lapic) {
> +	if (!cpu0_initialized && !acpi_arch_is_smp()) {
>  		cpu0_initialized = 1;
>  		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
>  		if ((cpu_index == -1) && (num_online_cpus() == 1))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

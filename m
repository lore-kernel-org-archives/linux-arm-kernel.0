From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 11 Jan 2014 00:20:33 +0100
Subject: [PATCH v6 3/6] ACPI: HW reduced mode does not allow use of the
 FADT sci_interrupt field
In-Reply-To: <1389394340-2680-4-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <1389394340-2680-4-git-send-email-al.stone@linaro.org>
Message-ID: <13769273.zu9PcWNH5N@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 10, 2014 03:52:17 PM al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> In HW reduced mode, the use of the SCI interrupt is not allowed.  In
> all those places that use the FADT sci_interrupt field, make sure we
> do not execute that path when in HW reduced mode.
> 
> In the case of acpi_os_install_interrupt_handler() in osl.c, this allows
> us to open up the routine to installing interrupt handlers other than
> acpi_gbl_FADT.sci_interrupt regardless of whether we are in ACPI legacy
> mode or reduced HW mode; acpi_os_remove_interrupt_handler() changes to
> maintain symmetry.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/bus.c      | 30 ++++++++++++++++--------------
>  drivers/acpi/osl.c      | 18 +++++++-----------
>  drivers/acpi/pci_link.c |  2 ++
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 0710004..d871859 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -552,21 +552,23 @@ void __init acpi_early_init(void)
>  	}
>  
>  #ifdef CONFIG_X86
> -	if (!acpi_ioapic) {
> -		/* compatible (0) means level (3) */
> -		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
> -			acpi_sci_flags &= ~ACPI_MADT_TRIGGER_MASK;
> -			acpi_sci_flags |= ACPI_MADT_TRIGGER_LEVEL;

I wonder why exactly you want to make this change.  It surely doesn't matter
for ARM and do you have any HW-reduced x86 hardware to test it?

> +	if (!acpi_gbl_reduced_hardware) {
> +		if (!acpi_ioapic) {
> +			/* compatible (0) means level (3) */
> +			if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
> +				acpi_sci_flags &= ~ACPI_MADT_TRIGGER_MASK;
> +				acpi_sci_flags |= ACPI_MADT_TRIGGER_LEVEL;
> +			}
> +			/* Set PIC-mode SCI trigger type */
> +			acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt,
> +				(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
> +		} else {
> +			/*
> +			 * now that acpi_gbl_FADT is initialized,
> +			 * update it with result from INT_SRC_OVR parsing
> +			 */
> +			acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
>  		}
> -		/* Set PIC-mode SCI trigger type */
> -		acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt,
> -					 (acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
> -	} else {
> -		/*
> -		 * now that acpi_gbl_FADT is initialized,
> -		 * update it with result from INT_SRC_OVR parsing
> -		 */
> -		acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
>  	}
>  #endif
>  
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 44c07eb..c946a3a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
>  
>  static acpi_osd_handler acpi_irq_handler;
>  static void *acpi_irq_context;
> +static u32 acpi_irq_number;
>  static struct workqueue_struct *kacpid_wq;
>  static struct workqueue_struct *kacpi_notify_wq;
>  static struct workqueue_struct *kacpi_hotplug_wq;
> @@ -178,6 +179,10 @@ static void __init acpi_request_region (struct acpi_generic_address *gas,
>  
>  static int __init acpi_reserve_resources(void)
>  {
> +	/* Handle hardware reduced mode: i.e., do nothing. */
> +	if (acpi_gbl_reduced_hardware)
> +		return 0;

Does it actually break things if we do that?

> +
>  	acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block, acpi_gbl_FADT.pm1_event_length,
>  		"ACPI PM1a_EVT_BLK");
>  
> @@ -795,13 +800,6 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
>  
>  	acpi_irq_stats_init();
>  
> -	/*
> -	 * ACPI interrupts different from the SCI in our copy of the FADT are
> -	 * not supported.
> -	 */
> -	if (gsi != acpi_gbl_FADT.sci_interrupt)
> -		return AE_BAD_PARAMETER;
> -
>  	if (acpi_irq_handler)
>  		return AE_ALREADY_ACQUIRED;
>  
> @@ -818,15 +816,13 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
>  		acpi_irq_handler = NULL;
>  		return AE_NOT_ACQUIRED;
>  	}
> +	acpi_irq_number = irq;
>  
>  	return AE_OK;
>  }
>  
>  acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
>  {
> -	if (irq != acpi_gbl_FADT.sci_interrupt)
> -		return AE_BAD_PARAMETER;
> -
>  	free_irq(irq, acpi_irq);
>  	acpi_irq_handler = NULL;
>  
> @@ -1806,7 +1802,7 @@ acpi_status __init acpi_os_initialize1(void)
>  acpi_status acpi_os_terminate(void)
>  {
>  	if (acpi_irq_handler) {
> -		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
> +		acpi_os_remove_interrupt_handler(acpi_irq_number,
>  						 acpi_irq_handler);
>  	}
>  
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 2652a61..d5c155e 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -505,6 +505,8 @@ int __init acpi_irq_penalty_init(void)
>  		}
>  	}
>  	/* Add a penalty for the SCI */
> +	if (acpi_gbl_reduced_hardware)
> +		return 0;
>  	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
>  	return 0;
>  }

Is ARM really going to use the code in pci_link.c?  If so, then how exactly?

Rafael

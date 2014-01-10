From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 11 Jan 2014 00:32:18 +0100
Subject: [PATCH v6 5/6] ACPI: do not map/unmap memory regions for FADT
 entries in reduced HW mode
In-Reply-To: <1389394340-2680-6-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <1389394340-2680-6-git-send-email-al.stone@linaro.org>
Message-ID: <3512616.qUD2F1beoi@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 10, 2014 03:52:19 PM al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Several of the FADT fields are normally kept in specific memory
> regions.  Since these fields are to be ignored in hardware reduced
> ACPI mode, do not map those addresses when in that mode, and of
> course do not release the mappings that have not been made.
> 
> The function acpi_os_initialize() could become a stub in the header
> file but is left here in case it can be of further use.

Why exactly is this change necessary?

Will things work incorrectly on HW-reduced ACPI systems if we don't make it?

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/osl.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index c946a3a..7822821 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1778,10 +1778,12 @@ __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
>  
>  acpi_status __init acpi_os_initialize(void)
>  {
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +	if (!acpi_gbl_reduced_hardware) {
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +	}
>  
>  	return AE_OK;
>  }
> @@ -1806,10 +1808,12 @@ acpi_status acpi_os_terminate(void)
>  						 acpi_irq_handler);
>  	}
>  
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +	if (!acpi_gbl_reduced_hardware) {
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +	}
>  
>  	destroy_workqueue(kacpid_wq);
>  	destroy_workqueue(kacpi_notify_wq);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

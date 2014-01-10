From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 11 Jan 2014 00:33:50 +0100
Subject: [PATCH v6 6/6] ACPI: make sure ECs do not use the ACPI global lock
In-Reply-To: <1389394340-2680-7-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <1389394340-2680-7-git-send-email-al.stone@linaro.org>
Message-ID: <1826710.CJqGCqohkh@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 10, 2014 03:52:20 PM al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> ACPI ECs (Embedded Controllers) are allowed to use the ACPI global
> lock in legacy mode.  Since there is no global lock in hardware
> reduced mode, make sure that ECs cannot inadvertently use it with
> older ACPI tables that may have defined an _GLK method for the
> EC device.  Since an individual lock can and should be defined for
> each EC, access to each EC should still be properly controlled.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/ec.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index ba5b56d..3f15110 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -745,9 +745,17 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  	if (ACPI_FAILURE(status))
>  		return status;
>  	ec->gpe = tmp;
> -	/* Use the global lock for all EC transactions? */
> +	/*
> +	 * Use the global lock for all EC transactions?
> +	 *
> +	 * If ACPI is in hardware reduced mode, there is no global lock.
> +	 * If a _GLK method is defined, it needs to be ignored, just
> +	 * in case it returns "true", which could happen if the ASL is
> +	 * written incorrectly.

What is going to happen if it is defined and works correctly in turn?

> +	 */
>  	tmp = 0;
> -	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
> +	if (!acpi_gbl_reduced_hardware)
> +		acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>  	ec->global_lock = tmp;
>  	ec->handle = handle;
>  	return AE_CTRL_TERMINATE;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 11 Jan 2014 00:31 +0100
Subject: [PATCH v6 4/6] ACPI: in HW reduced mode,
 using FADT PM information is not allowed.
In-Reply-To: <1389394340-2680-5-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <1389394340-2680-5-git-send-email-al.stone@linaro.org>
Message-ID: <4248842.kTIlfoGImy@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 10, 2014 03:52:18 PM al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Per the ACPI 5.0 specification, section 5.2.9, none of the power
> management fields in the FADT are to be used.  Short-circuit using
> any of those fields in acpi_processor_get_power_info_fadt().

So the spec says that we're supposed to ignore the information in
certain FADT fields if the HW_REDUCED_ACPI flag is set.

However, what about systems in which that information is actually
valid even though HW_REDUCED_ACPI is set?

Does it break things if we attempt to use that information?

> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index eac984a..89f0a0f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>  	if (!pr->pblk)
>  		return -ENODEV;
>  
> +	/*
> +	 * Using power management information from the FADT is not
> +	 * allowed when in HW reduced mode.  See ACPI 5.0, section
> +	 * 5.2.9.
> +	 */
> +	if (acpi_gbl_reduced_hardware)
> +		return -ENODEV;
> +
>  	/* if info is obtained from pblk/fadt, type equals state */
>  	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
>  	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

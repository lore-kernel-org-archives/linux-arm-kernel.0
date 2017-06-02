From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 15:59:34 +0100
Subject: [PATCH v2 1/3] perf: xgene: Parse PMU subnode from the match table
In-Reply-To: <1491238077-20666-2-git-send-email-hotran@apm.com>
References: <1491238077-20666-1-git-send-email-hotran@apm.com>
 <1491238077-20666-2-git-send-email-hotran@apm.com>
Message-ID: <20170602145934.GK28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoan,

Apologies for the last reply.

On Mon, Apr 03, 2017 at 09:47:55AM -0700, Hoan Tran wrote:
> +static const struct acpi_device_id xgene_pmu_acpi_type_match[] = {
> +	{"APMC0D5D", PMU_TYPE_L3C},
> +	{"APMC0D5E", PMU_TYPE_IOB},
> +	{"APMC0D5F", PMU_TYPE_MCB},
> +	{"APMC0D60", PMU_TYPE_MC},
> +	{},
> +};
> +
> +static const struct acpi_device_id *xgene_pmu_acpi_match_type(
> +					const struct acpi_device_id *ids,
> +					struct acpi_device *adev)
> +{
> +	const struct acpi_device_id *match_id = NULL;
> +	const struct acpi_device_id *id;
> +
> +	for (id = ids; id->id[0] || id->cls; id++) {
> +		if (!acpi_match_device_ids(adev, id))
> +			match_id = id;
> +		else if (match_id)
> +			break;
> +	}
> +
> +	return match_id;
> +}

I don't believe this look is necessary. AFAICT, acpi_match_device_ids()
already iterates over the id table it is given.

> +
>  static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
>  				    void *data, void **return_value)
>  {
> +	const struct acpi_device_id *acpi_id;
>  	struct xgene_pmu *xgene_pmu = data;
>  	struct xgene_pmu_dev_ctx *ctx;
>  	struct acpi_device *adev;
> @@ -1059,17 +1085,11 @@ static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
>  	if (acpi_bus_get_status(adev) || !adev->status.present)
>  		return AE_OK;
>  
> -	if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
> -		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
> -		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
> -		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
> -		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);
> -	else
> -		ctx = NULL;
> +	acpi_id = xgene_pmu_acpi_match_type(xgene_pmu_acpi_type_match, adev);
> +	if (!acpi_id)
> +		return AE_OK;

As above, and as I covered in my reply to v1, I think the above should
be:

	acpi_id = acpi_match_device_ids(adev, xgene_pmu_acpi_type_match);
	if (!acpi_id)
		return AE_OK;

... or am I missing something?

With that change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  
> +	ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, (u32)acpi_id->driver_data);
>  	if (!ctx)
>  		return AE_OK;
>  
> -- 
> 1.9.1
> 

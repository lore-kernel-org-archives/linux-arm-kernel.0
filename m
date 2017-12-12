From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 12 Dec 2017 12:05:05 +0200
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <1512170904-4749-5-git-send-email-timur@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
Message-ID: <1513073105.25007.618.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-12-01 at 17:28 -0600, Timur Tabi wrote:
> Newer versions of the firmware for the Qualcomm Datacenter
> Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted
> GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but
> set
> the pin count for the unavailable GPIOs to zero.  The pinctrl-msm
> driver will block those unavailable GPIOs from being accessed.
> 
> To allow newer kernels to support older firmware, the driver retains
> support for QCOM8001.

> +static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
> +	{"QCOM8001", QDF2XXX_V1},
> +	{"QCOM8002", QDF2XXX_V2},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
> 

> +	const struct acpi_device_id *id =
> +		acpi_match_device(qdf2xxx_acpi_ids, &pdev->dev);

JFYI: there is no need to move IDs like this.
Use members of struct device_driver wisely.

> -static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
> -	{"QCOM8001"},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

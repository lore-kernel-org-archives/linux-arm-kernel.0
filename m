From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 14 Jul 2017 10:21:21 -0700
Subject: [PATCH 2/2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <1499982763-29619-3-git-send-email-timur@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-3-git-send-email-timur@codeaurora.org>
Message-ID: <20170714172121.GN20973@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 13 Jul 14:52 PDT 2017, Timur Tabi wrote:

> Newer versions of the firmware for the Qualcomm Datacenter Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but set
> the pin count for the unavailable GPIOs to zero.  The pinctrl-msm
> driver will block those unavailable GPIOs from being accessed.
> 
> To allow newer kernels to support older firmware, the driver retains
> support for QCOM8001.
> 

This approach looks sane.

> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 157 +++++++++++++++++++++++----------
>  1 file changed, 111 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> index bb3ce5c..266f2e6 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> @@ -38,83 +38,148 @@
>  /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
>  #define NAME_SIZE	8
>  
> +enum {
> +	QDF2XXX_V1,
> +	QDF2XXX_V2,
> +};
> +
> +static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
> +	{"QCOM8001", QDF2XXX_V1},
> +	{"QCOM8002", QDF2XXX_V2},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);

NB. too bad there doesn't seem to be an equivalent of
of_device_get_match_data().

> +
>  static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
>  {
> +	const struct acpi_device_id *id =
> +		acpi_match_device(qdf2xxx_acpi_ids, &pdev->dev);
> +	struct device *dev = &pdev->dev;
>  	struct pinctrl_pin_desc *pins;
>  	struct msm_pingroup *groups;
>  	char (*names)[NAME_SIZE];
>  	unsigned int i;

The result of the patch looks fine, but unfortunately there's some noise
in the patch due to the transition from &pdev->dev to dev and num_gpios
to max_gpios.

> -	u32 num_gpios;
> +	unsigned int num_gpios; /* The number of GPIOs we support */
> +	u32 max_gpios; /* The highest number GPIO that exists */

Could you please keep the "num_gpios" naming and name the new variable
"avail_gpios" or something similar.

> +	u16 *gpios; /* An array of supported GPIOs */
>  	int ret;

>  
> -	/* Query the number of GPIOs from ACPI */
> -	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
> +	/* The total number of GPIOs that exist */
> +	ret = device_property_read_u32(dev, "num-gpios", &max_gpios);
>  	if (ret < 0) {
> -		dev_warn(&pdev->dev, "missing num-gpios property\n");
> +		dev_err(dev, "missing or invalid 'num-gpios' property\n");

While this makes sense it's not entirely related to this patch. My
suggestion is that you prepend a patch transitioning &pdev->dev to dev
and change these to dev_err in the same.

Regards,
Bjorn

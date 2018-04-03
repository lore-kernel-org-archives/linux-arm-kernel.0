From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Apr 2018 21:07:39 -0700
Subject: [PATCH 2/2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <1521848700-22214-2-git-send-email-timur@codeaurora.org>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
 <1521848700-22214-2-git-send-email-timur@codeaurora.org>
Message-ID: <20180403040739.GB453@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 16:45 PDT 2018, Timur Tabi wrote:

> Newer versions of the firmware for the Qualcomm Datacenter Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but
> fill in the data only for available GPIOs.  This ensures that the driver
> cannot accidentally access an unavailable GPIO.
> 
> The pinctrl-msm driver also scans the "gpios" property to determine
> which pins are available, and ensure that only those can be registered.
> 
> Support for QCOM8001 is removed as there is no longer any firmware that
> implements it.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 114 +++++++++++++++++++++------------
>  1 file changed, 73 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> index bb3ce5c3e18b..1dfbe42dd895 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> @@ -30,9 +30,7 @@
>  
>  #include "pinctrl-msm.h"
>  
> -static struct msm_pinctrl_soc_data qdf2xxx_pinctrl;
> -
> -/* A reasonable limit to the number of GPIOS */
> +/* A maximum of 256 allows us to use a u8 array to hold the GPIO numbers */
>  #define MAX_GPIOS	256
>  
>  /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
> @@ -40,77 +38,111 @@
>  
>  static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
>  {
> +	struct msm_pinctrl_soc_data *pinctrl;
>  	struct pinctrl_pin_desc *pins;
>  	struct msm_pingroup *groups;
>  	char (*names)[NAME_SIZE];
>  	unsigned int i;
>  	u32 num_gpios;
> +	unsigned int avail_gpios; /* The number of GPIOs we support */
> +	u8 gpios[MAX_GPIOS];      /* An array of supported GPIOs */
>  	int ret;
>  
>  	/* Query the number of GPIOs from ACPI */
>  	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
>  	if (ret < 0) {
> -		dev_warn(&pdev->dev, "missing num-gpios property\n");
> +		dev_err(&pdev->dev, "missing 'num-gpios' property\n");
>  		return ret;
>  	}
> -
>  	if (!num_gpios || num_gpios > MAX_GPIOS) {
> -		dev_warn(&pdev->dev, "invalid num-gpios property\n");
> +		dev_err(&pdev->dev, "invalid 'num-gpios' property\n");
> +		return -ENODEV;
> +	}
> +
> +	/* The number of GPIOs in the approved list */
> +	ret = device_property_read_u8_array(&pdev->dev, "gpios", NULL, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "missing 'gpios' property\n");
> +		return ret;
> +	}
> +	/*
> +	 * The number of available GPIOs should be non-zero, and no
> +	 * more than the total number of GPIOS.
> +	 */
> +	if (!ret || ret > num_gpios) {
> +		dev_err(&pdev->dev, "invalid 'gpios' property\n");
>  		return -ENODEV;
>  	}
> +	avail_gpios = ret;
>  
> +	ret = device_property_read_u8_array(&pdev->dev, "gpios", gpios,
> +					    avail_gpios);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read list of GPIOs\n");
> +		return ret;
> +	}
> +
> +	pinctrl = devm_kzalloc(&pdev->dev, sizeof(*pinctrl), GFP_KERNEL);
>  	pins = devm_kcalloc(&pdev->dev, num_gpios,
>  		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
>  	groups = devm_kcalloc(&pdev->dev, num_gpios,
>  		sizeof(struct msm_pingroup), GFP_KERNEL);
> -	names = devm_kcalloc(&pdev->dev, num_gpios, NAME_SIZE, GFP_KERNEL);
> +	names = devm_kcalloc(&pdev->dev, avail_gpios, NAME_SIZE, GFP_KERNEL);
>  
> -	if (!pins || !groups || !names)
> +	if (!pinctrl || !pins || !groups || !names)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Initialize the array.  GPIOs not listed in the 'gpios' array
> +	 * still need a number, but nothing else.
> +	 */
>  	for (i = 0; i < num_gpios; i++) {
> -		snprintf(names[i], NAME_SIZE, "gpio%u", i);
> -
>  		pins[i].number = i;
> -		pins[i].name = names[i];
> -
> -		groups[i].npins = 1;
> -		groups[i].name = names[i];
>  		groups[i].pins = &pins[i].number;
> +	}
>  
> -		groups[i].ctl_reg = 0x10000 * i;
> -		groups[i].io_reg = 0x04 + 0x10000 * i;
> -		groups[i].intr_cfg_reg = 0x08 + 0x10000 * i;
> -		groups[i].intr_status_reg = 0x0c + 0x10000 * i;
> -		groups[i].intr_target_reg = 0x08 + 0x10000 * i;
> -
> -		groups[i].mux_bit = 2;
> -		groups[i].pull_bit = 0;
> -		groups[i].drv_bit = 6;
> -		groups[i].oe_bit = 9;
> -		groups[i].in_bit = 0;
> -		groups[i].out_bit = 1;
> -		groups[i].intr_enable_bit = 0;
> -		groups[i].intr_status_bit = 0;
> -		groups[i].intr_target_bit = 5;
> -		groups[i].intr_target_kpss_val = 1;
> -		groups[i].intr_raw_status_bit = 4;
> -		groups[i].intr_polarity_bit = 1;
> -		groups[i].intr_detection_bit = 2;
> -		groups[i].intr_detection_width = 2;
> +	/* Populate the entries that are meant to be exposed as GPIOs. */
> +	for (i = 0; i < avail_gpios; i++) {
> +		unsigned int gpio = gpios[i];
> +
> +		groups[gpio].npins = 1;
> +		snprintf(names[i], NAME_SIZE, "gpio%u", gpio);
> +		pins[gpio].name = names[i];
> +		groups[gpio].name = names[i];
> +
> +		groups[gpio].ctl_reg = 0x10000 * gpio;
> +		groups[gpio].io_reg = 0x04 + 0x10000 * gpio;
> +		groups[gpio].intr_cfg_reg = 0x08 + 0x10000 * gpio;
> +		groups[gpio].intr_status_reg = 0x0c + 0x10000 * gpio;
> +		groups[gpio].intr_target_reg = 0x08 + 0x10000 * gpio;
> +
> +		groups[gpio].mux_bit = 2;
> +		groups[gpio].pull_bit = 0;
> +		groups[gpio].drv_bit = 6;
> +		groups[gpio].oe_bit = 9;
> +		groups[gpio].in_bit = 0;
> +		groups[gpio].out_bit = 1;
> +		groups[gpio].intr_enable_bit = 0;
> +		groups[gpio].intr_status_bit = 0;
> +		groups[gpio].intr_target_bit = 5;
> +		groups[gpio].intr_target_kpss_val = 1;
> +		groups[gpio].intr_raw_status_bit = 4;
> +		groups[gpio].intr_polarity_bit = 1;
> +		groups[gpio].intr_detection_bit = 2;
> +		groups[gpio].intr_detection_width = 2;
>  	}
>  
> -	qdf2xxx_pinctrl.pins = pins;
> -	qdf2xxx_pinctrl.groups = groups;
> -	qdf2xxx_pinctrl.npins = num_gpios;
> -	qdf2xxx_pinctrl.ngroups = num_gpios;
> -	qdf2xxx_pinctrl.ngpios = num_gpios;
> +	pinctrl->pins = pins;
> +	pinctrl->groups = groups;
> +	pinctrl->npins = num_gpios;
> +	pinctrl->ngroups = num_gpios;
> +	pinctrl->ngpios = num_gpios;
>  
> -	return msm_pinctrl_probe(pdev, &qdf2xxx_pinctrl);
> +	return msm_pinctrl_probe(pdev, pinctrl);
>  }
>  
>  static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
> -	{"QCOM8001"},
> +	{"QCOM8002"},

I presume you're okay with not being able to run mainline on your old
firmware?

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

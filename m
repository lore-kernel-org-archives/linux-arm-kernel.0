From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 14 Jan 2015 16:03:34 -0800
Subject: [PATCH] i.MX6-SabreAuto: EIM: pull PAD_EIM_D18 low for NOR probe
In-Reply-To: <1421278609-8446-1-git-send-email-alison_chaiken@mentor.com>
References: <1421278609-8446-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <20150115000334.GA9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-arm-kernel, maintainers, devicetree

Shawn, Sascha: should this driver be listed under the Freescale IMX
MAINTAINERS entry?

On Wed, Jan 14, 2015 at 03:36:49PM -0800, alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> PAD_EIM_D18 must be pulled low at boot in order for the parallel NOR
> connected to the EIM switch to probe properly.  Otherwise
> cfi_qry_present() may return "U-V-]" rather than "Q-R-Y" if the
> PAD_EIM_D18 is high.  Add a nor-gpios property to the nor node in the
> SabreAuto device-tree and add a function to the imx-weim probe to set
> GPIO5 to drive the pad.
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |  1 +
>  drivers/bus/imx-weim.c                   | 43 ++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 009abd6..dd5e3bc 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -454,5 +454,6 @@
>  		bank-width = <2>;
>  		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
>  				0x0000c000 0x1404a38e 0x00000000>;
> +		nor-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;

Such a binding needs to be documented. Also, if it's going to be named
generically like that, it needs to be generically useful and supported
under MTD code, not platform-specific bus code.

So what pin is this, exactly? A write-protect pin? An address pin? A
toaster control, where the toaster is keeping the flash too hot?

>  	};
>  };
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 0958b69..b3c2ca6 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -14,6 +14,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/regmap.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
>  
>  struct imx_weim_devtype {
>  	unsigned int	cs_count;
> @@ -108,6 +110,40 @@ err:
>  	return -EINVAL;
>  }
>  
> +/* set the GPIO to control PAD_EIM_D18 so cfi_qry_present() works properly */
> +static int __init nor_gpio_setup(struct device_node *np, struct device *parent)
> +{
> +	unsigned nor_gpio, level;
> +	enum of_gpio_flags of_flags;
> +	int ret;
> +
> +	nor_gpio = of_get_named_gpio_flags(np, "nor-gpios", 0, &of_flags);
> +
> +	/* this child is not a NOR chip */
> +	if (!nor_gpio)
> +		return 0;
> +
> +	if (gpio_is_valid(nor_gpio)) {
> +		ret = devm_gpio_request_one(parent, nor_gpio,
> +					GPIOF_DIR_OUT, "nor-gpio");
> +	} else {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	level = ((of_flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1);
> +
> +	gpio_set_value(nor_gpio, level);
> +
> +	return 0;
> +out:
> +	dev_err(parent, "Unable to request EIM_D18 GPIO for NOR.\n");
> +	return ret;
> +}
> +
>  /* Parse and set the timing for this device. */
>  static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  				    const struct imx_weim_devtype *devtype)
> @@ -160,6 +196,13 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  				child->full_name);
>  			return ret;
>  		}
> +
> +		ret = nor_gpio_setup(child, &pdev->dev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "%s gpios setup failed.\n",
> +				child->full_name);
> +			return ret;
> +		}
>  	}
>  
>  	ret = of_platform_populate(pdev->dev.of_node,

Brian

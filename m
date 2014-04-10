From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 10 Apr 2014 14:39:13 +0530
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <53465FB9.7070002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Wednesday 09 April 2014 05:24 PM, Vivek Gautam wrote:
> Adding support to enable/disable VBUS hooked to a gpio
> to enable vbus supply on the port.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
> 
> Based on 'phy-exynos5-usbdrd' patches:
> [PATCH V4 0/5] Add Exynos5 USB 3.0 phy driver based on generic PHY framework
> http://www.spinics.net/lists/linux-usb/msg105507.html
> 
>  drivers/phy/phy-exynos5-usbdrd.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
> index ff54a7c..5ca7485 100644
> --- a/drivers/phy/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/phy-exynos5-usbdrd.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> @@ -176,6 +177,7 @@ struct exynos5_usbdrd_phy {
>  	struct clk *ref_clk;
>  	unsigned long ref_rate;
>  	unsigned int refclk_reg;
> +	int gpio;
>  };
>  
>  #define to_usbdrd_phy(inst) \
> @@ -460,6 +462,9 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>  	if (!IS_ERR(phy_drd->usb30_sclk))
>  		clk_prepare_enable(phy_drd->usb30_sclk);
>  
> +	/* Toggle VBUS gpio - on */
> +	gpio_set_value(phy_drd->gpio, 1);
> +
>  	/* Power-on PHY*/
>  	inst->phy_cfg->phy_isol(inst, 0);
>  
> @@ -476,6 +481,9 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
>  	/* Power-off the PHY */
>  	inst->phy_cfg->phy_isol(inst, 1);
>  
> +	/* Toggle VBUS gpio - off */
> +	gpio_set_value(phy_drd->gpio, 0);
> +
>  	if (!IS_ERR(phy_drd->usb30_sclk))
>  		clk_disable_unprepare(phy_drd->usb30_sclk);
>  
> @@ -585,6 +593,16 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
>  
>  	phy_drd->drv_data = drv_data;
>  
> +	/* Get required GPIO for vbus */
> +	phy_drd->gpio = of_get_named_gpio(dev->of_node,
> +					  "samsung,vbus-gpio", 0);

Is this dt property documented somewhere?
> +	if (!gpio_is_valid(phy_drd->gpio))
> +		dev_dbg(dev, "no usbdrd-phy vbus gpio defined\n");

No return here? Can the PHY be functional even without the VBUS?

Thanks
Kishon

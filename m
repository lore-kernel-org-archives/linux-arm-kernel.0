From: balbi@ti.com (Felipe Balbi)
Date: Fri, 11 Apr 2014 22:37:18 -0500
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140412033718.GA18777@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 05:24:45PM +0530, Vivek Gautam wrote:
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

It seems like you'd be better off using a regulator_enable() call for
this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/58a0f506/attachment.sig>

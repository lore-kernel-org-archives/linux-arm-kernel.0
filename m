From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 14:54:26 +0530
Subject: [PATCH v6 1/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1477451211-31979-2-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-2-git-send-email-david@lechnology.com>
Message-ID: <64127331-7afd-9af7-60d0-d735aa6af628@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:

> diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
> index f141f51..71a6d85 100644
> --- a/arch/arm/mach-davinci/usb-da8xx.c
> +++ b/arch/arm/mach-davinci/usb-da8xx.c
> @@ -1,20 +1,248 @@
>  /*
>   * DA8xx USB
>   */
> -#include <linux/dma-mapping.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/platform_data/usb-davinci.h>
>  #include <linux/platform_device.h>
> +#include <linux/mfd/da8xx-cfgchip.h>
>  #include <linux/usb/musb.h>
>  
> +#include <mach/clock.h>
>  #include <mach/common.h>
>  #include <mach/cputype.h>
>  #include <mach/da8xx.h>
> -#include <mach/irqs.h>

Looks like you have cleaned up some unneeded includes. Thats fine, just
mention it in the commit description too, so its clear that it is intended.

Also, when adding new include files, please do it in alphabetical order.

> +static struct clk usb_refclkin = {
> +	.name		= "usb_refclkin",
> +	.set_rate	= davinci_simple_set_rate,
> +};
> +
> +static struct clk_lookup usb_refclkin_lookup =
> +	CLK(NULL, "usb_refclkin", &usb_refclkin);
> +
> +static struct clk usb20_phy_clk = {
> +	.name		= "usb20_phy",
> +	.clk_enable	= usb20_phy_clk_enable,
> +	.clk_disable	= usb20_phy_clk_disable,
> +	.set_parent	= usb20_phy_clk_set_parent,
> +};
> +
> +static struct clk_lookup usb20_phy_clk_lookup =
> +	CLK(NULL, "usb20_phy", &usb20_phy_clk);

NULL device name here is wrong. There is a PHY device that gets added
3/5. The name of that device should appear here. Since that phy device
is the consumer of this clock. You can change the order of patches so
the device appears before the associated clocks.

> +static struct clk usb11_phy_clk = {
> +	.name		= "usb11_phy",
> +	.set_parent	= usb11_phy_clk_set_parent,
> +};
> +
> +static struct clk_lookup usb11_phy_clk_lookup =
> +	CLK(NULL, "usb11_phy", &usb11_phy_clk);

here too, please have the phy device name as the consumer of this clock.

It is okay to have NULL device name for the usb_refclkin since that is a
root clock not associated with any device.

Thanks,
Sekhar

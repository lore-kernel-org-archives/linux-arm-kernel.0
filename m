From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 15:27:20 +0300
Subject: [PATCH 2/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1458081473-8223-2-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-2-git-send-email-david@lechnology.com>
Message-ID: <56E95128.5000607@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/16/2016 1:37 AM, David Lechner wrote:

> Up to this point, the USB phy clock configuration was handled manually in
> the board files and in the usb drivers. This adds proper clocks so that
> the usb drivers can use clk_get and clk_enable and not have to worry about
> the details. Also, the related code is removed from the board files.
>
> Signed-off-by: David Lechner <david@lechnology.com>
[...]
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 7187e7f..213fb17e 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
[...]
> @@ -346,6 +340,12 @@ static struct clk i2c1_clk = {
>   	.gpsc		= 1,
>   };
>
> +static struct clk usb_ref_clk = {
> +	.name		= "usb_ref_clk",
> +	.rate		= 48000000,
> +	.set_rate	= davinci_simple_set_rate,
> +};
> +
>   static struct clk usb11_clk = {
>   	.name		= "usb11",
>   	.parent		= &pll0_sysclk4,
> @@ -353,6 +353,115 @@ static struct clk usb11_clk = {
>   	.gpsc		= 1,
>   };
>
> +static struct clk usb20_clk = {
> +	.name		= "usb20",
> +	.parent		= &pll0_sysclk2,
> +	.lpsc		= DA8XX_LPSC1_USB20,
> +	.gpsc		= 1,
> +};

    Why move it?

> +
> +static void usb20_phy_clk_enable(struct clk *clk)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	/*
> +	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
> +	 * host may use the PLL clock without USB 2.0 OTG being used.
> +	 */
> +		val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
> +		val |= CFGCHIP2_PHY_PLLON;

    Wrong indentation.

> +
> +	/* Set the mux depending on the parent clock. */
> +	if (clk->parent == &pll0_aux_clk)
> +		val |= CFGCHIP2_USB2PHYCLKMUX;
> +	else if (clk->parent == &usb_ref_clk)
> +		val &= ~CFGCHIP2_USB2PHYCLKMUX;

    Don't we have clk_set_parent()for that?

> +	else
> +		pr_err("Bad parent on USB 2.0 PHY clock.\n");
> +
[...]
> +		writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));

    Wrong indentation again.

> +
> +	pr_info("Waiting for USB 2.0 PHY clock good...\n");
> +		while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
> +							 & CFGCHIP2_PHYCLKGD))
> +			cpu_relax();

    And again.

> +	}
> +
> +static void usb20_phy_clk_disable(struct clk *clk)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +	val |= CFGCHIP2_PHYPWRDN;

    I'm not sure that powering down the PHY can be regarded as disabling the 
clock...

> +	__raw_writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));

    Please don't mix readl() and __raw_writel().

[...]
> +static void usb11_phy_clk_enable(struct clk *clk)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
> +	if (clk->parent == &usb20_phy_clk)
> +		val &= ~CFGCHIP2_USB1PHYCLKMUX;
> +	else if (clk->parent == &usb_ref_clk)
> +		val &= ~CFGCHIP2_USB1PHYCLKMUX;

     Huh? When do you set this bit?

[...]
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 97d8779..649d3fa 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -19,6 +19,7 @@
>   #include <linux/cpufreq.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/usb-davinci.h>
>
>   #include <asm/mach/map.h>
>
> @@ -333,6 +334,12 @@ static struct clk aemif_clk = {
>   	.flags		= ALWAYS_ENABLED,
>   };
>
> +static struct clk usb_ref_clk = {
> +	.name		= "usb_ref_clk",
> +	.rate		= 48000000,
> +	.set_rate	= davinci_simple_set_rate,
> +};
> +
>   static struct clk usb11_clk = {
>   	.name		= "usb11",
>   	.parent		= &pll0_sysclk4,
> @@ -347,6 +354,109 @@ static struct clk usb20_clk = {
[...]
> +static void usb11_phy_clk_enable(struct clk *clk)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
> +	if (clk->parent == &usb20_phy_clk)
> +		val &= ~CFGCHIP2_USB1PHYCLKMUX;
> +	else if (clk->parent == &usb_ref_clk)
> +		val &= ~CFGCHIP2_USB1PHYCLKMUX;

    When do you set this bit?

[...]

MBR, Sergei

From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 22:26:24 +0530
Subject: [PATCH v2 04/11] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1458181615-27782-5-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-5-git-send-email-david@lechnology.com>
Message-ID: <56F2CAB8.3090705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
> Up to this point, the USB phy clock configuration was handled manually in
> the board files and in the usb drivers. This adds proper clocks so that
> the usb drivers can use clk_get and clk_enable and not have to worry about
> the details. Also, the related code is removed from the board files.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes: Move clock mux code to set_parent callback. Also fixed some other
> issues from feedback on the previous patch.
> 
> 
>  arch/arm/mach-davinci/board-da830-evm.c     |  12 ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c |   7 --
>  arch/arm/mach-davinci/da830.c               | 143 ++++++++++++++++++++++++++++
>  arch/arm/mach-davinci/da850.c               | 143 ++++++++++++++++++++++++++++
>  4 files changed, 286 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 3d8cf8c..f3a8cc9 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -115,18 +115,6 @@ static __init void da830_evm_usb_init(void)
>  	 */
>  	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>  
> -	/* USB2.0 PHY reference clock is 24 MHz */
> -	cfgchip2 &= ~CFGCHIP2_REFFREQ;
> -	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
> -
> -	/*
> -	 * Select internal reference clock for USB 2.0 PHY
> -	 * and use it as a clock source for USB 1.1 PHY
> -	 * (this is the default setting anyway).
> -	 */
> -	cfgchip2 &= ~CFGCHIP2_USB1PHYCLKMUX;
> -	cfgchip2 |=  CFGCHIP2_USB2PHYCLKMUX;
> -
>  	/*
>  	 * We have to override VBUS/ID signals when MUSB is configured into the
>  	 * host-only mode -- ID pin will float if no cable is connected, so the
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index ee62486..d27e753 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -251,13 +251,6 @@ static __init void omapl138_hawk_usb_init(void)
>  		return;
>  	}
>  
> -	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
> -
> -	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> -	cfgchip2 &= ~CFGCHIP2_REFFREQ;
> -	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
> -	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> -
>  	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
>  			GPIOF_DIR_OUT, "USB1 VBUS");
>  	if (ret < 0) {
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 7187e7f..ee942b0 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/clk.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/usb-davinci.h>
>  
>  #include <asm/mach/map.h>
>  
> @@ -346,6 +347,12 @@ static struct clk i2c1_clk = {
>  	.gpsc		= 1,
>  };
>  
> +static struct clk usb_ref_clk = {
> +	.name		= "usb_ref_clk",
> +	.rate		= 48000000,
> +	.set_rate	= davinci_simple_set_rate,
> +};

can we call this usb_refclkin so it matches the TRM name? Also, should
this node be not be coming through individual board files as the rate
depends on what is connected to the usb_refclkin pin? Or is the
expectation that boards will call clk_set_rate() on this clock to the
correct value? If yes, I think it is misleading to populate the .rate here.

> +
>  static struct clk usb11_clk = {
>  	.name		= "usb11",
>  	.parent		= &pll0_sysclk4,
> @@ -353,6 +360,139 @@ static struct clk usb11_clk = {
>  	.gpsc		= 1,
>  };
>  
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
> +	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
> +	val |= CFGCHIP2_PHY_PLLON;
> +
> +	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	pr_info("Waiting for USB 2.0 PHY clock good...\n");
> +	while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
> +						& CFGCHIP2_PHYCLKGD))
> +		cpu_relax();

I guess this is copying some earlier code, but still, it will be nice to
see a timeout mechanism here, rather than loop endlessly.

> +}
> +
> +static void usb20_phy_clk_disable(struct clk *clk)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +	val |= CFGCHIP2_PHYPWRDN;
> +	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +}
> +
> +static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 __iomem *cfgchip2;
> +	u32 val;
> +
> +	/*
> +	 * Can't use DA8XX_SYSCFG0_VIRT() here since this can be called before
> +	 * da8xx_syscfg0_base is initialized.
> +	 */
> +	cfgchip2 = ioremap(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG, 4);

Again, not sure if this is juts a theoretical possibility. If yes, I
would rather see you bail out if syscfg0_base is not initialized by the
time you get here than do an ioremap() again.

> +	val = readl(cfgchip2);
> +
> +	/* Set the mux depending on the parent clock. */
> +	if (parent == &pll0_aux_clk)
> +		val |= CFGCHIP2_USB2PHYCLKMUX;
> +	else if (parent == &usb_ref_clk)
> +		val &= ~CFGCHIP2_USB2PHYCLKMUX;
> +	else {
> +		pr_err("Bad parent on USB 2.0 PHY clock.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* reference frequency also comes from parent clock */
> +	val &= ~CFGCHIP2_REFFREQ;
> +	switch (clk_get_rate(parent)) {
> +	case 12000000:
> +		val |= CFGCHIP2_REFFREQ_12MHZ;
> +		break;
> +	case 13000000:
> +		val |= CFGCHIP2_REFFREQ_13MHZ;
> +		break;
> +	case 19200000:
> +		val |= CFGCHIP2_REFFREQ_19_2MHZ;
> +		break;
> +	case 20000000:
> +		val |= CFGCHIP2_REFFREQ_20MHZ;
> +		break;
> +	case 24000000:
> +		val |= CFGCHIP2_REFFREQ_24MHZ;
> +		break;
> +	case 26000000:
> +		val |= CFGCHIP2_REFFREQ_26MHZ;
> +		break;
> +	case 38400000:
> +		val |= CFGCHIP2_REFFREQ_38_4MHZ;
> +		break;
> +	case 40000000:
> +		val |= CFGCHIP2_REFFREQ_40MHZ;
> +		break;
> +	case 48000000:
> +		val |= CFGCHIP2_REFFREQ_48MHZ;
> +		break;
> +	default:
> +		pr_err("Bad parent clock rate on USB 2.0 PHY clock.\n");
> +		return -EINVAL;
> +	}
> +
> +	writel(val, cfgchip2);
> +
> +	return 0;
> +}
> +
> +static struct clk usb20_phy_clk = {
> +	.name		= "usb20_phy",
> +	.parent		= &pll0_aux_clk,
> +	.clk_enable	= usb20_phy_clk_enable,
> +	.clk_disable	= usb20_phy_clk_disable,
> +	.set_parent	= usb20_phy_clk_set_parent,
> +};

I hope you have checked that all boards in mainline use the AUXCLK as
the reference USB 2.0 frequency?

> +
> +static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 __iomem *cfgchip2;
> +	u32 val;
> +
> +	/*
> +	 * Can't use DA8XX_SYSCFG0_VIRT() here since this can be called before
> +	 * da8xx_syscfg0_base is initialized.
> +	 */
> +	cfgchip2 = ioremap(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG, 4);
> +	val = readl(cfgchip2);
> +
> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
> +	if (parent == &usb20_phy_clk)
> +		val &= ~CFGCHIP2_USB1PHYCLKMUX;
> +	else if (parent == &usb_ref_clk)
> +		val |= CFGCHIP2_USB1PHYCLKMUX;
> +	else {
> +		pr_err("Bad parent on USB 1.1 PHY clock.\n");
> +		return -EINVAL;
> +	}
> +
> +	writel(val, cfgchip2);
> +
> +	return 0;
> +}
> +
> +static struct clk usb11_phy_clk = {
> +	.name		= "usb11_phy",
> +	.parent		= &usb20_phy_clk,
> +	.set_parent	= usb11_phy_clk_set_parent,
> +};

Same thing here. I hope all current boards use USB2.0 clk as reference
for USB 1.1 phy

> +
>  static struct clk emif3_clk = {
>  	.name		= "emif3",
>  	.parent		= &pll0_sysclk5,
> @@ -420,7 +560,10 @@ static struct clk_lookup da830_clks[] = {
>  	CLK("davinci_mdio.0",   "fck",          &emac_clk),
>  	CLK(NULL,		"gpio",		&gpio_clk),
>  	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
> +	CLK(NULL,		"usb_ref_clk",	&usb_ref_clk),
>  	CLK(NULL,		"usb11",	&usb11_clk),
> +	CLK(NULL,		"usb20_phy",	&usb20_phy_clk),
> +	CLK(NULL,		"usb11_phy",	&usb11_phy_clk),
>  	CLK(NULL,		"emif3",	&emif3_clk),
>  	CLK(NULL,		"arm",		&arm_clk),
>  	CLK(NULL,		"rmii",		&rmii_clk),
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 8c8f31e..8089a82 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -19,6 +19,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/usb-davinci.h>
>  
>  #include <asm/mach/map.h>
>  
> @@ -360,6 +361,12 @@ static struct clk aemif_clk = {
>  	.flags		= ALWAYS_ENABLED,
>  };
>  
> +static struct clk usb_ref_clk = {
> +	.name		= "usb_ref_clk",
> +	.rate		= 48000000,
> +	.set_rate	= davinci_simple_set_rate,
> +};
> +
>  static struct clk usb11_clk = {
>  	.name		= "usb11",
>  	.parent		= &pll0_sysclk4,
> @@ -374,6 +381,139 @@ static struct clk usb20_clk = {
>  	.gpsc		= 1,
>  };
>  
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
> +	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
> +	val |= CFGCHIP2_PHY_PLLON;
> +
> +	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	pr_info("Waiting for USB 2.0 PHY clock good...\n");
> +	while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
> +						& CFGCHIP2_PHYCLKGD))
> +		cpu_relax();
> +}

Looks like this is pretty much going to be the same code repeated for
DA850 and DA830. So can we move these to a common file like da8xx-usb.c?
You can even register these USB clocks from that file by using
clkdev_add() and clk_register(). This way they can remain to be file local.

Thanks,
Sekhar

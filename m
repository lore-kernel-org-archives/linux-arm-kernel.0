From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Mar 2016 15:12:08 +0300
Subject: [PATCH v2 04/11] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1458181615-27782-5-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-5-git-send-email-david@lechnology.com>
Message-ID: <56EA9F18.1070908@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 5:26 AM, David Lechner wrote:

> Up to this point, the USB phy clock configuration was handled manually in
> the board files and in the usb drivers. This adds proper clocks so that
> the usb drivers can use clk_get and clk_enable and not have to worry about
> the details. Also, the related code is removed from the board files.
>
> Signed-off-by: David Lechner <david@lechnology.com>
[...]
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 7187e7f..ee942b0 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
[...]
> @@ -346,6 +347,12 @@ static struct clk i2c1_clk = {
>   	.gpsc		= 1,
>   };
>
> +static struct clk usb_ref_clk = {
> +	.name		= "usb_ref_clk",

    I'd leave out "_clk" for consistency.

[...]
> @@ -353,6 +360,139 @@ static struct clk usb11_clk = {
[...]
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

    You should be able to use IO_ADDRESS(), no?

[...]
> @@ -420,7 +560,10 @@ static struct clk_lookup da830_clks[] = {
>   	CLK("davinci_mdio.0",   "fck",          &emac_clk),
>   	CLK(NULL,		"gpio",		&gpio_clk),
>   	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
> +	CLK(NULL,		"usb_ref_clk",	&usb_ref_clk),

    I'd leave out "_clk" agai.

>   	CLK(NULL,		"usb11",	&usb11_clk),
> +	CLK(NULL,		"usb20_phy",	&usb20_phy_clk),
> +	CLK(NULL,		"usb11_phy",	&usb11_phy_clk),
>   	CLK(NULL,		"emif3",	&emif3_clk),
>   	CLK(NULL,		"arm",		&arm_clk),
>   	CLK(NULL,		"rmii",		&rmii_clk),
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 8c8f31e..8089a82 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c

    Same comments on this file...

MBR, Sergei

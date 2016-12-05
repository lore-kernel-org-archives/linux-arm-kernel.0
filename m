From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Dec 2016 14:08:12 +0530
Subject: [PATCH v2 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1480693134-31324-2-git-send-email-bgolaszewski@baylibre.com>
References: <1480693134-31324-1-git-send-email-bgolaszewski@baylibre.com>
 <1480693134-31324-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <34f9e4c4-917e-0472-72af-96fbc7e0c6db@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 December 2016 09:08 PM, Bartosz Golaszewski wrote:
> The aemif clock is added twice to the lookup table in da850.c. This
> breaks the children list of pll0_sysclk3 as we're using the same list
> links in struct clk. When calling clk_set_rate(), we get stuck in
> propagate_rate().
> 
> Create a separate clock for nand, inheriting the rate of the aemif
> clock and retrieve it in the davinci_nand module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c   | 7 ++++++-
>  drivers/mtd/nand/davinci_nand.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index e770c97..1fcc986 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -367,6 +367,11 @@ static struct clk aemif_clk = {
>  	.flags		= ALWAYS_ENABLED,
>  };
>  
> +static struct clk nand_clk = {
> +	.name		= "nand",
> +	.parent		= &aemif_clk,
> +};
> +
>  static struct clk usb11_clk = {
>  	.name		= "usb11",
>  	.parent		= &pll0_sysclk4,
> @@ -537,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
>  	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
>  	CLK("ti-aemif",		NULL,		&aemif_clk),
> -	CLK(NULL,		"aemif",	&aemif_clk),
> +	CLK(NULL,		"nand",		&nand_clk),

Why use a NULL device name here?

>  	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
>  	CLK("musb-da8xx",	"usb20",	&usb20_clk),
>  	CLK("spi_davinci.0",	NULL,		&spi0_clk),
> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index 27fa8b8..5857d06 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -694,7 +694,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
>  
>  	ret = -EINVAL;
>  
> -	info->clk = devm_clk_get(&pdev->dev, "aemif");
> +	info->clk = devm_clk_get(&pdev->dev, "nand");

This driver is used by keystone devices too. So just changing the
connection id will likely break them. Why do you need to change the
connection id?

Thanks,
Sekhar

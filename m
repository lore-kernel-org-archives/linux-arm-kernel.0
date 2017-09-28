From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Sep 2017 12:27:52 +0200
Subject: [PATCH 1/3] clk: sunxi-ng: add mux and pll notifiers for A64 CPU
 clock
In-Reply-To: <20170923001531.14285-2-icenowy@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
 <20170923001531.14285-2-icenowy@aosc.io>
Message-ID: <20170928102752.ceo54qccqakb4xyx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 23, 2017 at 12:15:29AM +0000, Icenowy Zheng wrote:
> The A64 PLL_CPU clock has the same instability if some factor changed
> without the PLL gated like other SoCs with sun6i-style CCU, e.g. A33,
> H3.
> 
> Add the mux and pll notifiers for A64 CPU clock to workaround the
> problem.
> 
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 2bb4cabf802f..b55fa69dd0c1 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -879,11 +879,26 @@ static const struct sunxi_ccu_desc sun50i_a64_ccu_desc = {
>  	.num_resets	= ARRAY_SIZE(sun50i_a64_ccu_resets),
>  };
>  
> +static struct ccu_pll_nb sun50i_a64_pll_cpu_nb = {
> +	.common	= &pll_cpux_clk.common,
> +	/* copy from pll_cpux_clk */
> +	.enable	= BIT(31),
> +	.lock	= BIT(28),
> +};
> +
> +static struct ccu_mux_nb sun50i_a64_cpu_nb = {
> +	.common		= &cpux_clk.common,
> +	.cm		= &cpux_clk.mux,
> +	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
> +	.bypass_index	= 1, /* index of 24 MHz oscillator */
> +};
> +
>
>  static int sun50i_a64_ccu_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	void __iomem *reg;
>  	u32 val;
> +	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	reg = devm_ioremap_resource(&pdev->dev, res);
> @@ -897,7 +912,18 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
>  
>  	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
>  
> -	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
> +	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
> +	if (ret)
> +		return ret;
> +
> +	/* Gate then ungate PLL CPU after any rate changes */
> +	ccu_pll_notifier_register(&sun50i_a64_pll_cpu_nb);
> +
> +	/* Reparent CPU during PLL CPU rate changes */
> +	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
> +				  &sun50i_a64_cpu_nb);
> +
> +	return 0;

So this is the fourth user of the exact same code, can you turn that
into a shared function?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/37210ae1/attachment-0001.sig>

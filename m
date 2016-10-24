From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 17:05:42 +0200
Subject: [PATCH v4 6/9] clk: sunxi-ng: Add A64 clocks
In-Reply-To: <20161020184601.GB26139@codeaurora.org>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <cd4dd81821b8910d40626baab2dbfdabd94b1b98.1476196031.git-series.maxime.ripard@free-electrons.com>
 <20161020184601.GB26139@codeaurora.org>
Message-ID: <20161024150542.cle7iw2l7c5ybbrr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Oct 20, 2016 at 11:46:01AM -0700, Stephen Boyd wrote:
> On 10/11, Maxime Ripard wrote:
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > new file mode 100644
> > index 000000000000..c0e96bf6d104
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > +
> > +static int sun50i_a64_ccu_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res;
> > +	void __iomem *reg;
> > +	u32 val;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	reg = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(reg)) {
> > +		dev_err(&pdev->dev, "Could not map the clock registers\n");
> 
> devm_ioremap_resource() should already spit out an error.
> 
> > +		return PTR_ERR(reg);
> > +	}
> > +
> > +	/* Force the PLL-Audio-1x divider to 4 */
> > +	val = readl(reg + SUN50I_A64_PLL_AUDIO_REG);
> > +	val &= ~GENMASK(19, 16);
> > +	writel(val | (3 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
> > +
> > +	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
> > +
> > +	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
> > +}
> > +
> > +static const struct of_device_id sun50i_a64_ccu_ids[] = {
> > +	{ .compatible = "allwinner,sun50i-a64-ccu" },
> > +	{ },
> 
> Nitpick: drop the comma

Thanks for your comments, it's fixed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/962b7cf5/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Sep 2016 16:23:58 +0200
Subject: [PATCH v2 1/4] clk: sunxi-ng: Add A64 clocks
In-Reply-To: <20160914214554.GH7243@codeaurora.org>
References: <20160909201029.24530-1-maxime.ripard@free-electrons.com>
 <20160909201029.24530-2-maxime.ripard@free-electrons.com>
 <20160914214554.GH7243@codeaurora.org>
Message-ID: <20160917142358.GD17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Sep 14, 2016 at 02:45:54PM -0700, Stephen Boyd wrote:
> On 09/09, Maxime Ripard wrote:
> > index 106cba27c331..964f22091a10 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -22,3 +22,4 @@ obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> >  obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
> >  obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
> >  obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
> > +obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
> 
> Maybe do alphanumeric ordering?

Yes, of course.

> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > new file mode 100644
> > index 000000000000..d51ee416f515
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > @@ -0,0 +1,870 @@
> > +
> > +static void __init sun50i_a64_ccu_setup(struct device_node *node)
> > +{
> > +	void __iomem *reg;
> > +	u32 val;
> > +
> > +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +	if (IS_ERR(reg)) {
> > +		pr_err("%s: Could not map the clock registers\n",
> > +		       of_node_full_name(node));
> > +		return;
> > +	}
> > +
> > +	/* Force the PLL-Audio-1x divider to 4 */
> > +	val = readl(reg + SUN50I_A64_PLL_AUDIO_REG);
> > +	val &= ~GENMASK(19, 16);
> > +	writel(val | (3 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
> > +
> > +	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
> > +
> > +	sunxi_ccu_probe(node, reg, &sun50i_a64_ccu_desc);
> > +}
> > +CLK_OF_DECLARE(sun50i_a64_ccu, "allwinner,sun50i-a64-ccu",
> > +	       sun50i_a64_ccu_setup);
> 
> Is there a reason it can't be a platform driver?

We have timers connected to those clocks. I'm not sure we'll ever use
them, since we also have the arch timers, and we can always change
that later, I'll change that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160917/cb0efd43/attachment.sig>

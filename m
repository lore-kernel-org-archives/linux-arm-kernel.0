From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 27 Jun 2016 17:53:37 -0700
Subject: [PATCH v2 14/15] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160626123409.GK4000@lukather>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-15-maxime.ripard@free-electrons.com>
 <146681451703.35033.17009542256505173233@resonance>
 <20160626123409.GK4000@lukather>
Message-ID: <146707521689.89261.8354851392822550901@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2016-06-26 05:34:09)
> On Fri, Jun 24, 2016 at 05:28:37PM -0700, Michael Turquette wrote:
> > Quoting Maxime Ripard (2016-06-07 13:41:53)
> > > +static struct ccu_common *sun8i_h3_ccu_clks[] = {
> > > +       [CLK_PLL_CPUX]          = &pll_cpux_clk.common,
> > > +       [CLK_PLL_AUDIO_BASE]    = &pll_audio_base_clk.common,
> > > +       [CLK_PLL_AUDIO]         = &pll_audio_clk.common,
> > 
> > OK, it looks like you followed the qcom clk driver approach here, which
> > is a nice way to do things. However, as Stephen alluded to in his
> > response to the cover letter, the clk_hw_* api's are an even more
> > friendly interface for clock providers. For example, check out the gxbb
> > clk driver probe:
> > 
> >       static int gxbb_clkc_probe(struct platform_device *pdev)
> >       {
> >               void __iomem *clk_base;
> >               int ret, clkid, i;
> >               struct device *dev = &pdev->dev;
> >       
> >               /*  Generic clocks and PLLs */
> >               clk_base = of_iomap(dev->of_node, 0);
> >               if (!clk_base) {
> >                       pr_err("%s: Unable to map clk base\n", __func__);
> >                       return -ENXIO;
> >               }
> >       
> >               /* Populate base address for PLLs */
> >               for (i = 0; i < ARRAY_SIZE(gxbb_clk_plls); i++)
> >                       gxbb_clk_plls[i]->base = clk_base;
> >       
> >               /* Populate base address for MPLLs */
> >               for (i = 0; i < ARRAY_SIZE(gxbb_clk_mplls); i++)
> >                       gxbb_clk_mplls[i]->base = clk_base;
> > 
> >               ...
> > 
> >               /*
> >                * register all clks
> >                */
> >               for (clkid = 0; clkid < NR_CLKS; clkid++) {
> >                       ret = devm_clk_hw_register(dev, gxbb_hw_onecell_data.hws[clkid]);
> >                       if (ret)
> >                               goto iounmap;
> >               }
> 
> Ok, I'll move the fixed factor clocks out of the common list, and
> initialize the clk_hw_onedata_cell structure to register it.

Cool, thanks! This driver will be one of the early adopters :-)

> 
> > The nice thing about struct ccu_common is that you don't have to walk
> > the list of clocks for each separate clock type like the above probe
> > function does. I'm still thinking of the best way to solve this
> > generically. Maybe add a .base member struct clk_hw? I dunno, and I've
> > resisted the urge to add stuff to struct clk_hw in the past... But I
> > really want to minimize this .probe as much as possible, and I do not
> > want every clock provider driver to be forced to invent something like
> > struct ccu_common every time.
> 
> We'd need a few more things (in this case) at least: the register
> offset and a private field to store our flags.

A bit of mumbling to myself below:

Hmm, upon further reflection, walking the list of ccu clocks is rather
identical to walking the list of each clock type, as I do in the gxbb
driver, where ccu_common is the one and only clock type.

So that in itself is not a big deal and isn't a problem that needs
solving.

What needs solving is a way to populate base addresses for each clock at
runtime in a way that does not *force* you to invent something like
ccu_common if you do not need it.

You would hit this issue if you broke your common gate or divider clocks
out and did not wrap them in the ccu_common structure. I solved this by
overloading the ->reg value of each of the common types as static data,
and then did the following when registering them:

	/* Populate base address for gates */
	for (i = 0; i < ARRAY_SIZE(gxbb_clk_gates); i++)
		gxbb_clk_gates[i]->reg = clk_base +
			(u64)gxbb_clk_gates[i]->reg;

Any thoughts on how to fix this for other common gate types that need
their base addresses populated from an OF node at runtime?

> 
> > Anyways, that is not a blocker for your implementation to be merged,
> > but Stephen's question in patch #4 got me thinking about this
> > again...
> > 
> > The real nice part is the call to devm_clk_hw_register. That uses the
> > new clk_hw_* apis and struct clk_hw_onecell_data, which is initialized
> > statically like so:
> > 
> >       static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
> >               .hws = {
> >                       [CLKID_SYS_PLL]      = &gxbb_sys_pll.hw,
> >                       [CLKID_CPUCLK]        = &gxbb_cpu_clk.hw,
> >                       ...
> >               },
> >               .num = NR_CLKS,
> >       };
> > 
> > Unfortunately I believe it impossible to replace NR_CLKS with some
> > ARRAY_SIZE stuff because C. As Stephen mentioned, please use this method
> > instead.
> 
> That's unfortunate :/

But also not a big deal if you hide clocks from your DT ABI. You can
store NR_CLKS in kernel code, and never expose it to the DT ABI.

> 
> > > diff --git a/include/dt-bindings/clock/sun8i-h3.h b/include/dt-bindings/clock/sun8i-h3.h
> > > new file mode 100644
> > > index 000000000000..96eced56e7a2
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/sun8i-h3.h
> > > @@ -0,0 +1,162 @@
> > > +#ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
> > > +#define _DT_BINDINGS_CLK_SUN8I_H3_H_
> > > +
> > > +#define CLK_PLL_CPUX           0
> > > +#define CLK_PLL_AUDIO_BASE     1
> > > +#define CLK_PLL_AUDIO          2
> > > +#define CLK_PLL_AUDIO_2X       3
> > > +#define CLK_PLL_AUDIO_4X       4
> > 
> > Are you sure you want to expose all of these clocks as part of the ABI?
> > I exposed the bare minimum clocks for the gxbb driver in the DT shared
> > header (we can always add more later) and kept the rest internal to the
> > kernel source.
> 
> I thought about it, but that would require a third array with
> basically the same clocks:
> 
>   * the ccu_common array to patch to set the lock and base pointers,
>   * the list of clocks to register
>   * the clk_hw_onecell_data to deal with the dt binding.

"the list of clocks to register" and "the clk_hw_onecell_data to deal
with the dt binding" are the same array.

You only need two arrays:

1) the ccu_common init data
2) the clk_hw_onecell_data array of clk_hw pointers that points to
clk_hw statically defined in the ccu_common array

And then only expose the clocks that you want via the shared header in
the DT include chroot. See:

https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/diff/drivers/clk/meson/gxbb.h?h=clk-s905&id=738f66d3211d7ae0cd0012ba6457dac9a03bfd6b

https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/diff/include/dt-bindings/clock/gxbb-clkc.h?h=clk-s905&id=738f66d3211d7ae0cd0012ba6457dac9a03bfd6b

In summary, there is only one array of "clocks to be registered", and we
limit DT exposure via the shared header. Again, your choice to expose
whatever you want via DT, but I thought I'd explain my approach
(especially b/c the SoC I'm hacking on has incomplete docs).

Regards,
Mike

> 
> That seems a bit overkill.
> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

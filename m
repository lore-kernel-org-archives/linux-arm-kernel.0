From: christian.ruppert@abilis.com (Christian Ruppert)
Date: Thu, 11 Apr 2013 11:19:53 +0200
Subject: [PATCH] clk: Add device tree binding to clk-fixed-factor
In-Reply-To: <20130410162747.GG32603@ab42.lan>
References: <1365608443-30350-1-git-send-email-christian.ruppert@abilis.com>
 <51658BA9.7030508@free-electrons.com>
 <20130410162747.GG32603@ab42.lan>
Message-ID: <20130411091952.GF8400@ab42.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Since there doesn't seem to be anyone opposing this feature I just
checked your patch and after adding the CLK_OF_DECLARE macro in the end
it works well for us. Tell me if you would like to rebase and resubmit
your patch or if I should follow up on our own.

Greetings,
  Christian

On Wed, Apr 10, 2013 at 06:27:47PM +0200, christian ruppert wrote:
> Hi Gregory,
> 
> We use derived clocks with fixed ratios for our TB10x platform. I
> originally had this in the platform code but Vineet (the platform
> maintainer) rightly pointed out that the common clock framework would
> be the correct place for it.
> Is there any reason not to support this functionality? After all, the
> generic fixed rate clock also has a device tree binding and I'd guess
> we're not the only ones statically deriving one clock from another in
> our SOCs.
> 
> Greetings,
>   Christian
> 
> On Wed, Apr 10, 2013 at 05:56:25PM +0200, Gregory CLEMENT wrote:
> > Hi Christian,
> > 
> > On 04/10/2013 05:40 PM, Christian Ruppert wrote:
> > > This patch adds a device tree binding for the simple fixed factor clock
> > > divider/multiplier of the common clock tree binding.
> > 
> > This patch remind me of something :
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/116405.html
> > 
> > Do you have a use case for it, this time?
> > 
> > My version have been hold off waiting for an user for it.
> > Will you need it for a driver?
> > 
> > Regards,
> > 
> > > 
> > > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > > ---
> > >  .../bindings/clock/fixed-factor-clkdiv.txt         |   24 +++++++++++++++
> > >  drivers/clk/clk-fixed-factor.c                     |   32 ++++++++++++++++++++
> > >  include/linux/clk-provider.h                       |    1 +
> > >  3 files changed, 57 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clkdiv.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clkdiv.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clkdiv.txt
> > > new file mode 100644
> > > index 0000000..352bac4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clkdiv.txt
> > > @@ -0,0 +1,24 @@
> > > +Device Tree Clock bindings for plat-tb10x
> > > +
> > > +This binding uses the common clock binding[1].
> > > +
> > > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +
> > > +Required properties:
> > > +- compatible : shall be "fixed-factor-clkdiv"
> > > +- #clock-cells: from common clock binding; shall be set to 0
> > > +- clocks: shall be the input parent clock phandle for the clock.
> > > +- clock-mult: defines the multiplication factor of the output clock frequency
> > > +  wrt. the input clock frequency.
> > > +- clock-div: defines the division factor of the output clock frequency wrt.
> > > +  the input clock frequency.
> > > +
> > > +Example:
> > > +cpu_clk: clkdiv_cpu {	/* CPU clock derived from pll0. 1/2 of pll frequency */
> > > +	compatible = "fixed-factor-clkdiv";
> > > +	#clock-cells = <0>;
> > > +	clocks = <&pll0>;
> > > +	clock-mult = <1>;
> > > +	clock-div = <2>;
> > > +	clock-output-names = "cpu_clk";
> > > +};
> > > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > > index 1ef271e..85e45f1 100644
> > > --- a/drivers/clk/clk-fixed-factor.c
> > > +++ b/drivers/clk/clk-fixed-factor.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/clk-provider.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/err.h>
> > > +#include <linux/of.h>
> > >  
> > >  /*
> > >   * DOC: basic fixed multiplier and divider clock that cannot gate
> > > @@ -96,3 +97,34 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
> > >  
> > >  	return clk;
> > >  }
> > > +
> > > +#ifdef CONFIG_OF
> > > +/**
> > > + * of_fixed_factor_clkdiv_setup() - Set up simple fixed factor clock divider
> > > + */
> > > +void of_fixed_factor_clkdiv_setup(struct device_node *node)
> > > +{
> > > +	struct clk *clk;
> > > +	const char *clk_name = node->name;
> > > +	const char *parent_name;
> > > +	u32 mult, div;
> > > +
> > > +	if (of_property_read_u32(node, "clock-mult", &mult))
> > > +		return;
> > > +
> > > +	if (of_property_read_u32(node, "clock-div", &div))
> > > +		return;
> > > +
> > > +	parent_name = of_clk_get_parent_name(node, 0);
> > > +
> > > +	of_property_read_string(node, "clock-output-names", &clk_name);
> > > +
> > > +	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
> > > +					mult, div);
> > > +	if (!IS_ERR(clk))
> > > +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > > +}
> > > +EXPORT_SYMBOL_GPL(of_fixed_factor_clkdiv_setup);
> > > +CLK_OF_DECLARE(fixed_clkdiv, "fixed-factor-clkdiv",
> > > +		of_fixed_factor_clkdiv_setup);
> > > +#endif
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > index 7f197d7..d4937cf 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -184,6 +184,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
> > >  		unsigned long fixed_rate);
> > >  
> > >  void of_fixed_clk_setup(struct device_node *np);
> > > +void of_fixed_factor_clkdiv_setup(struct device_node *node);
> > >  
> > >  /**
> > >   * struct clk_gate - gating clock
> > > 
> > 
> > 
> > -- 
> > Gregory Clement, Free Electrons
> > Kernel, drivers, real-time and embedded Linux
> > development, consulting, training and support.
> > http://free-electrons.com
> 
> -- 
>   Christian Ruppert              ,          <christian.ruppert@abilis.com>
>                                 /|
>   Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr?-Fleuri
>                              _// | bilis Systems   CH-1228 Plan-les-Ouates

-- 
  Christian Ruppert              ,          <christian.ruppert@abilis.com>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr?-Fleuri
                             _// | bilis Systems   CH-1228 Plan-les-Ouates

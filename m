From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 20 Jun 2013 23:25:47 +0200
Subject: [PATCH v2 3/5] clk: dt: binding for basic multiplexer clock
In-Reply-To: <201306180253.59691.heiko@sntech.de>
References: <1371437905-15567-1-git-send-email-mturquette@linaro.org>
 <1371437905-15567-4-git-send-email-mturquette@linaro.org>
 <201306180253.59691.heiko@sntech.de>
Message-ID: <201306202325.47481.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. Juni 2013, 02:53:59 schrieb Heiko St?bner:
> Am Montag, 17. Juni 2013, 04:58:23 schrieb Mike Turquette:
> > Device Tree binding for the basic clock multiplexer, plus the setup
> > function to register the clock.  Based on the existing fixed-clock
> > binding.
> > 
> > Includes minor beautification of clk-provider.h where some whitespace is
> > added and of_fixed_factor_clock_setup is relocated to maintain a
> > consistent style.
> > 
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > ---
> > 
> > +void of_mux_clk_setup(struct device_node *node)
> > +{
> > +	struct clk *clk;
> > +	const char *clk_name = node->name;
> > +	void __iomem *reg;
> > +	int num_parents;
> > +	const char **parent_names;
> > +	int i;
> > +	u8 clk_mux_flags = 0;
> > +	u32 mask = 0;
> > +	u8 shift = 0;
> > +
> > +	of_property_read_string(node, "clock-output-names", &clk_name);
> > +
> > +	num_parents = of_clk_get_parent_count(node);
> > +	if (num_parents < 1) {
> > +		pr_err("%s: mux-clock %s must have parent(s)\n",
> > +				__func__, node->name);
> > +		return;
> > +	}
> > +
> > +	parent_names = kzalloc((sizeof(char*) * num_parents),
> > +			GFP_KERNEL);
> > +
> > +	for (i = 0; i < num_parents; i++)
> > +		parent_names[i] = of_clk_get_parent_name(node, i);
> > +
> > +	reg = of_iomap(node, 0);
> > +
> > +	if (of_property_read_u32(node, "bit-mask", &mask)) {
> > +		pr_err("%s: missing bit-mask property for %s\n", __func__, node-
> >
> >name);
> >
> > +		return;
> > +	}
> > +
> > +	if (of_property_read_u8(node, "bit-shift", &shift)) {
> > +		shift = __ffs(mask);
> > +		pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
> > +				__func__, shift, node->name);
> > +	}
> 
> I'm not really sure if either I am or the code is doing something wrong.
> For me here of_property_read_u8 is always setting shift to 0, with
> bit-shift values normally being <8>, <15> etc.
> 
> When I change the type of shift to u32 and use the corresponding
> of_property_read_u32 everything works fine.
> 
> And when I switch both function and var back to u8 again, it again reads 0
> for everything.
> 
> 
> For reference one of my muxes looks like:
> 
> 		mux_uart2: mux-uart2 at 20000080 {
> 			compatible = "mux-clock";
> 			reg = <0x20000080 0x04>;
> 			clocks = <&clk_gates1 12>, <&dummy>, <&xin24m>;
> 			bit-mask = <0x3>;
> 			bit-shift = <8>;
> 			hiword-mask;
> 			#clock-cells = <0>;
> 		};
> 
> Same is of course also true for the divider-clock.
> 

found the issue ... the same missing "/bits/ 8" mentioned in the divider 
review causes of_property_read_u8 to return wrong values.

So the binding example should probably include this, i.e.

			bit-shift = /bits/ 8 <6>;


Heiko

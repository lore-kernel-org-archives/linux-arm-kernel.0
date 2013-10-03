From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Oct 2013 12:32:13 +0200
Subject: [PATCH 04/10] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <524A095A.9050306@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
 <1380426579-32458-5-git-send-email-emilio@elopez.com.ar>
 <20130930172137.GE5287@lukather> <524A095A.9050306@elopez.com.ar>
Message-ID: <20131003103213.GE32149@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 08:29:30PM -0300, Emilio L?pez wrote:
> El 30/09/13 14:21, Maxime Ripard escribi?:
> >On Sun, Sep 29, 2013 at 12:49:33AM -0300, Emilio L?pez wrote:
> >>+/**
> >>+ * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
> >>+ */
> >
> >This comment doesn't seem to be at the right place in your code.
> 
> I use these comments as kind of a delimiter too, all the struct
> definitions done below are used on sunxi_divs_clk_setup, which is
> immediately after. Factors, mux, dividers and gates have the comment
> that way too.

Still, it looks odd that you're mostly commenting a function here, while
the function is 20-ish lines below. Maybe you can just add a small
comment here saying something like "Here come drag^Wclock dividers".

> >>+	clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
> >>+	if (!clks) {
> >>+		kfree(clk_data);
> >>+		return;
> >>+	}
> >>+	clk_data->clks = clks;
> >>+
> >>+	/* It's not a good idea to have automatic reparenting changing
> >>+	 * our RAM clock! */
> >>+	clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
> >>+
> >>+	for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
> >>+		if (of_property_read_string_index(node, "clock-output-names",
> >>+						  i, &clk_name) != 0)
> >>+			break;
> >>+
> >>+		if (data->div[i].fixed) {
> >>+			clks[i] = clk_register_fixed_factor(NULL, clk_name,
> >>+						parent, clkflags,
> >>+						1, data->div[i].fixed);
> >>+		} else {
> >>+			flags = data->div[i].pow ? CLK_DIVIDER_POWER_OF_TWO : 0;
> >>+			clks[i] = clk_register_divider_table(NULL, clk_name,
> >>+						parent, clkflags, reg,
> >>+						data->div[i].shift,
> >>+						SUNXI_DIVISOR_WIDTH, flags,
> >>+						data->div[i].table, &clk_lock);
> >>+		}
> >
> >Hmmm, I don't get why you were calling sunxi_clk_factors_setup
> >unconditionally, and now you put a condition on the registration?
> 
> The factor clock is the 'parent' part and the condition is there to
> decide which kind of divisor gets registered under it. For example
> 
>                   PLL6 CLOCK
>            ________________________
>           |         ___pll6_sata---|----> to consumer
> osc24M->--|  pll6--/___pll6_other--|----> to consumer
>           |        \_______________|____> to consumer
>           |________________________|
> 
> 
> pll6 is the factor part, pll6_sata is a table divider, and
> pll6_other is a fixed factor

That should definitely go in the comments :)

> 
> >(Plus, your indentation here looks a bit odd.)
> 
> If I align the parameters with the starting (, I can fit at most 1
> parameter per line and I end up with a pile of mostly unreadable
> parameters which uses a lot of lines (and still some don't fit in
> under 80 cols). I thought using one tab less was a good compromise,
> and preferable to going over 80 chars. If you have any better
> suggestion, I'm all ears :)

Ok, whatever you feel best in that case.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/0c450dcc/attachment-0001.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Aug 2014 20:48:29 +0200
Subject: [PATCH 4/9] clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
In-Reply-To: <CAGb2v67EBHL+A0N=3o8B+1z=oLya+vRjsrN2_SqWQrPcQsnbtA@mail.gmail.com>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-5-git-send-email-emilio@elopez.com.ar>
 <20140803124458.GV3952@lukather>
 <CAGb2v67EBHL+A0N=3o8B+1z=oLya+vRjsrN2_SqWQrPcQsnbtA@mail.gmail.com>
Message-ID: <20140803184829.GC3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 11:58:16PM +0800, Chen-Yu Tsai wrote:
> >> +     /* PLL2, also known as PLL2x1 */
> >> +     of_property_read_string_index(np, "clock-output-names", 0, &clk_name);
> >> +     clks[0] = clk_register_composite(NULL, clk_name, &parent, 1, NULL, NULL,
> >> +                                      &pll2->hw, pll2_ops,
> >> +                                      &gate->hw, &clk_gate_ops, 0);
> >> +     WARN_ON(IS_ERR(clks[0]));
> >> +     clk_set_rate(clks[0], 22579200);
> >> +     parent = clk_name;
> >> +
> >> +     /* PLL2x2, 1/4 the rate of PLL2x8 */
> >> +     of_property_read_string_index(np, "clock-output-names", 1, &clk_name);
> >> +     clks[1] = clk_register_fixed_factor(NULL, clk_name, parent,
> >> +                                         CLK_SET_RATE_PARENT, 2, 1);
> >> +     WARN_ON(IS_ERR(clks[1]));
> >> +
> >> +     /* PLL2x4, 1/2 the rate of PLL2x8 */
> >> +     of_property_read_string_index(np, "clock-output-names", 2, &clk_name);
> >> +     clks[2] = clk_register_fixed_factor(NULL, clk_name, parent,
> >> +                                         CLK_SET_RATE_PARENT, 4, 1);
> >> +     WARN_ON(IS_ERR(clks[2]));
> >> +
> >> +     /* PLL2x8, double of PLL2 without the post divisor */
> >> +     of_property_read_string_index(np, "clock-output-names", 3, &clk_name);
> >> +     clks[3] = clk_register_fixed_factor(NULL, clk_name, parent,
> >> +                                         CLK_SET_RATE_PARENT, 2 * 4, 1);
> >
> > Why have you declared them here, instead of using fixed factors in the
> > DT directly, like we have done in the past?
> 
> IIRC, We have not done so for the PLL clocks. This is how it was, though
> it was with the more complicated divs clocks.

I don't see any obvious multipliers in the clock-output-names.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140803/b4cfdba1/attachment.sig>

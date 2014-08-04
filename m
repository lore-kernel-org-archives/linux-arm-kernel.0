From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Aug 2014 22:02:00 +0200
Subject: [PATCH 4/9] clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
In-Reply-To: <53DEB181.1080902@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-5-git-send-email-emilio@elopez.com.ar>
 <20140803124458.GV3952@lukather> <53DEB181.1080902@elopez.com.ar>
Message-ID: <20140804200200.GK3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 07:02:41PM -0300, Emilio L?pez wrote:
> Hi,
> 
> El 03/08/14 a las 09:44, Maxime Ripard escibi?:
> >On Thu, Jul 31, 2014 at 06:28:07PM -0300, Emilio L?pez wrote:
> >>This patch adds support for PLL2 and derivates on sun4i, sun5i and
> >>sun7i SoCs. As this PLL is only used for audio and requires good
> >>accuracy, we only support two known good rates.
> >>
> >>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>---
> >>
> (...)
> >>+	/* PLL2x8, double of PLL2 without the post divisor */
> >>+	of_property_read_string_index(np, "clock-output-names", 3, &clk_name);
> >>+	clks[3] = clk_register_fixed_factor(NULL, clk_name, parent,
> >>+					    CLK_SET_RATE_PARENT, 2 * 4, 1);
> >
> >Why have you declared them here, instead of using fixed factors in the
> >DT directly, like we have done in the past?
> 
> I'd prefer to see one clock with four outputs represented as one
> clock with four outputs rather than one clock with one output and
> other three weirdly named nodes floating around.

Except that you have no control over these 3 other outputs, that
directly derive from the only one you can control.

Plus, their name wouldn't be weirded than the one you gave in
clock-output-names ;)

> I can only see four uses of fixed-factor-clock in our DTSI, three of
> which are "pass through" clocks for ahb and ar100 on sun6/8i, and a
> fourth one to implement the 32k that results from reducing the 24M
> osc on sun7i.

And PLLx2, PLL2x4, PLL2x8 are really just pass-through clocks
too. Once PLL2 is controlled, those will just be enabled.

> As a second reason, implementing it as fixed factors would be
> slightly incorrect, as it's only "x8" when you use the limited set
> of factors that Allwinner and us are using for audio.

Hu? What do you mean by that?

> If we were ever to support the full range of the PLL. the DT binding
> would suddenly be off. By using a single binding, the meaning is
> self-contained in the driver.
> 
> As a third reason, of_fixed_factor_clk_setup() does not set
> CLK_SET_RATE_PARENT, which we'd need to propagate the rate change
> upstream.

That would be easy to fix.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/8661cf34/attachment.sig>

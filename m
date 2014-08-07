From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Aug 2014 13:23:37 +0200
Subject: [PATCH 4/9] clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
In-Reply-To: <53DFEBD0.4050704@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-5-git-send-email-emilio@elopez.com.ar>
 <20140803124458.GV3952@lukather> <53DEB181.1080902@elopez.com.ar>
 <20140804200200.GK3952@lukather> <53DFEBD0.4050704@elopez.com.ar>
Message-ID: <20140807112337.GA15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 05:23:44PM -0300, Emilio L?pez wrote:
> El 04/08/14 a las 17:02, Maxime Ripard escibi?:
> >On Sun, Aug 03, 2014 at 07:02:41PM -0300, Emilio L?pez wrote:
> >>Hi,
> >>
> >>El 03/08/14 a las 09:44, Maxime Ripard escibi?:
> >>>On Thu, Jul 31, 2014 at 06:28:07PM -0300, Emilio L?pez wrote:
> >>>>This patch adds support for PLL2 and derivates on sun4i, sun5i and
> >>>>sun7i SoCs. As this PLL is only used for audio and requires good
> >>>>accuracy, we only support two known good rates.
> >>>>
> >>>>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>>>---
> >>>>
> >>(...)
> >>>>+	/* PLL2x8, double of PLL2 without the post divisor */
> >>>>+	of_property_read_string_index(np, "clock-output-names", 3, &clk_name);
> >>>>+	clks[3] = clk_register_fixed_factor(NULL, clk_name, parent,
> >>>>+					    CLK_SET_RATE_PARENT, 2 * 4, 1);
> >>>
> >>>Why have you declared them here, instead of using fixed factors in the
> >>>DT directly, like we have done in the past?
> >>
> >>I'd prefer to see one clock with four outputs represented as one
> >>clock with four outputs rather than one clock with one output and
> >>other three weirdly named nodes floating around.
> >
> >Except that you have no control over these 3 other outputs, that
> >directly derive from the only one you can control.
> 
> You do have one degree of control, see below.
> 
> >Plus, their name wouldn't be weirded than the one you gave in
> >clock-output-names ;)
> 
> Allwinner chose those names on the user manual, not me :)
> 
> >>I can only see four uses of fixed-factor-clock in our DTSI, three of
> >>which are "pass through" clocks for ahb and ar100 on sun6/8i, and a
> >>fourth one to implement the 32k that results from reducing the 24M
> >>osc on sun7i.
> >
> >And PLLx2, PLL2x4, PLL2x8 are really just pass-through clocks
> >too. Once PLL2 is controlled, those will just be enabled.
> 
> Yes and no.
> 
> >>As a second reason, implementing it as fixed factors would be
> >>slightly incorrect, as it's only "x8" when you use the limited set
> >>of factors that Allwinner and us are using for audio.
> >
> >Hu? What do you mean by that?
> 
> PLL2 (aka PLL2x1) is 24 * N / pre / post
> PLL2x8 is 24 * 2 * N / pre
> 
> So PLL2 * 8 == PLL2x8 only if post == 4, which holds true on our
> software implementation as well as AW's, but may not always hold
> true hardware wise.

Ah, right. I was looking at the wrong datasheet for this, my bad.

Then, at least document the bindings properly :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/f4332e60/attachment.sig>

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 03 Jul 2015 10:38:09 +0200
Subject: [PATCH] arm64: dts: mt8173: add clock_null
In-Reply-To: <1435909512.3526.71.camel@mtksdaap41>
References: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omCk50Q5b=ey5v1z2gha5Ybc+Fus0Ls+S=5n08xu7Svacw@mail.gmail.com>
 <1435909512.3526.71.camel@mtksdaap41>
Message-ID: <4128666.7Kmsrhssyu@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. Juli 2015, 15:45:12 schrieb James Liao:
> On Thu, 2015-07-02 at 12:23 +0800, Daniel Kurtz wrote:
> > On Thu, Jul 2, 2015 at 11:06 AM, James Liao <jamesjj.liao@mediatek.com> 
wrote:
> > > These clocks such as clkph_mck_o are configured by other modules before
> > > kernel init, and their rates may different among platforms.
> > 
> > What other modules?
> > Do you mean the rates are configured by firmware?
> > How are the rates set?
> > Are there registers that configure its rate?
> > If so, why can't the kernel read these registers and compute the current
> > rate?
> CLKPH_MCK_O for example, it's a DRAM related clock, and initialized in
> preloader (before kernel init). It's setting may be different because
> using different DRAM module. And the setting may be changed dynamically
> in runtime.

If it's set in the preloader (and maybe changed at runtime) this means, its 
setting can also be read back to determine its current clock rate, so this is 
a non-argument here ;-)


> We don't care CLKPH_MCK_O's rate in CCF because we don't need to change
> mem_sel's setting in kernel, and there is not driver need to know
> mem_sel's rate.

As Daniel said, some of these clocks may be parents of other clocks, and not 
knowing their rate might hurt in the future - especially when it's easy after 
all to get its actual value like in your CLKPH_MCK_O example above.


Heiko


> > For mt8173, we are essentially discussing the following clocks (whose
> > sole parent is clk_null):
> > 
> > FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> > FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
> > FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> > FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> > GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "clk_null", 15),
> > GATE_MM1(CLK_MM_DSI0_DIGITAL, "mm_dsi0_digital", "clk_null", 5),
> > GATE_MM1(CLK_MM_DSI1_DIGITAL, "mm_dsi1_digital", "clk_null", 7),
> > GATE_MM1(CLK_MM_DPI1_PIXEL, "mm_dpi1_pixel", "clk_null", 10),
> > GATE_MM1(CLK_MM_LVDS_PIXEL, "mm_lvds_pixel", "clk_null", 16),
> > GATE_MM1(CLK_MM_LVDS_CTS, "mm_lvds_cts", "clk_null", 17),
> > 
> > clkph_mck_o - This is the parent for dmpll_*, which are themselves
> > (potential) parent clocks for nearly every subsystem.
> > In fact, as shown above, the dmpll_* is the selected parent for
> > several other clocks, which all end up with an unknown rate.
> > So, I think it is worth investigating a little more how to properly
> > read or otherwise specify the rate for clkph_mck_o.
> 
> Please see above.
> 
> > dpi_ck, infra_cpum, mm_dsi0_digital, mm_dsi1_digital, mm_lvds_cts -
> > These are a dead-end (internal?) clock.
> > It is probably fine if their rates are unknown (0 Hz).
> > 
> > usb_syspll_125m - This sounds like a fixed 125 MHz clock.  It is also
> > a possible parent usb30 clock, so its value will propagate.
> > 
> > hdmitx_dig_cts - This is the root clock for the tree leading to
> > mm_hdmi_pllck, which includes hdmitxpll_d* and hdmi_sel.
> > However, I don't know how "mm_hdmi_pllck" is used.
> > 
> > mm_dpi1_pixel, mm_lvds_pixel - These two look very suspicious.  The
> > similar "mm_dpi0_pixel" and "mm_hdmi_pixel" have parent dpi0_sel.
> > It looks like maybe they should have "dpi1_sel" or "dpilvds_sel" as
> > parents, but the _sel are not hooked up.
> 
> Subsystem clocks with parent clk_null may have different reasons. I'll
> get back to you later.
> 
> 
> Best regards,
> 
> James

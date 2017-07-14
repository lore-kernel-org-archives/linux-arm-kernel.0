From: plaes@plaes.org (Priit Laes)
Date: Fri, 14 Jul 2017 13:48:54 +0000
Subject: [linux-sunxi] [PATCH v5 2/6] clk: sunxi-ng: Add sun4i/sun7i CCU
 driver
In-Reply-To: <d178101c-bcc7-3914-481e-1edc4f5d7b60@schinagl.nl>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <65066c74b8dedfeb8de27d90b5fecfea3a700178.1499197129.git-series.plaes@plaes.org>
 <5099cd90-e019-8a65-38e5-02b3c939a7a8@schinagl.nl>
 <20170713192358.GB22375@plaes.org>
 <d178101c-bcc7-3914-481e-1edc4f5d7b60@schinagl.nl>
Message-ID: <20170714134854.GA7579@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 09:46:57PM +0200, Olliver Schinagl wrote:
> Hey Priit,
> 
> On 07/13/17 21:23, Priit Laes wrote:
> > On Mon, Jul 10, 2017 at 11:45:32AM +0200, Olliver Schinagl wrote:
> >> Hi Pleas,
> >>
> >> again, but this time with content :)
> >>
> >> On 04-07-17 22:04, Priit Laes wrote:
> >>> Introduce a clock controller driver for sun4i A10 and sun7i A20
> >>> series SoCs.
> > [ ... ]
> >
> >>> +++ b/drivers/clk/sunxi-ng/Kconfig
> >>> @@ -11,6 +11,19 @@ config SUN50I_A64_CCU
> >>> 	default ARM64 && ARCH_SUNXI
> >>> 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> >>>
> >>> +config SUNXI_A10_CCU
> >> I understand why you say sunXi here (it's support for both sun4i and sun7i)
> >> but then why A10, as it also supports the A20.
> >>
> >> I guess the CCU is identical on the A20 and the A10, right? Thus would it
> >> not be sensible to just call it sun4i_ccu (like we do for sun5i_ccu below?
> > No, it's not identical.
> But then saying SUNXI_A10_CCU is not correct? Since it is not identical
> on the A20? So what does the A10 stand for?

There's no easy way it supports both SUN4I_A10 and SUN7I_A20, therefore
I used SUNXI_A10 where SUNXI may indicate it's not only for SUN4I and
I'm currently keeping it as is...

[ ... ]
> >>> +/* Not present on A20 */
> >>> +static SUNXI_CCU_GATE(axi_dram_clk,	"axi-dram",	"ahb",
> >>> +		      0x05c, BIT(31), 0);
> >> Same here I guess, two defines make this a bit more readable.
> > You mean SUN4I_CCU_GATE? and SUN7I_CCU_GATE defines?
> > I don't think it makes things more readable...
> you think 0x05c and BIT(31) are easier to read? I'll do a pop quiz in 6
> months from now and see if you remember :p

Can you give an example on how it should be written?

> >
> >>> +
> >>> +static SUNXI_CCU_GATE(ahb_otg_clk,	"ahb-otg",	"ahb",
> > ...
> >>> +		      0x060, BIT(14), CLK_IS_CRITICAL);
> >> <snip>
> >>
> >>> +static struct ccu_reset_map sun7i_a20_ccu_resets[] = {
> >>> +	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
> >>> +	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
> >>> +	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
> >>> +	[RST_GPS]		= { 0x0d0, BIT(0) },
> >>> +	[RST_DE_BE0]		= { 0x104, BIT(30) },
> >>> +	[RST_DE_BE1]		= { 0x108, BIT(30) },
> >>> +	[RST_DE_FE0]		= { 0x10c, BIT(30) },
> >>> +	[RST_DE_FE1]		= { 0x110, BIT(30) },
> >>> +	[RST_DE_MP]		= { 0x114, BIT(30) },
> >>> +	[RST_TCON0]		= { 0x118, BIT(30) },
> >>> +	[RST_TCON1]		= { 0x11c, BIT(30) },
> >> You are missing the TV encoder reset:
> >> +      [RST_TVE0]              = { 0x118, BIT(29) },
> >> +      [RST_TVE1]              = { 0x11c, BIT(29) },
> >>
> >> (to match your table i did not use defines :p)
> > Where did you get this information?
> > This is not present in any datasheets I have:
> >   * A10 - 1.50
> >   * A20 - 1.4
> It is actually from the A13. In the A13 all the other bits match up. We
> know from both that TCON0 is at 0x118 with its reset at BIT(30) and
> TCON1 has its reset 0x11c. From the A13 datasheet we gather that TCON(0)
> and TV(0) are at 0x118 with RST_TV on BIT(31) and thus it is only
> logical that that for the TVE1 we have the rest at 0x11c.
> 
> But this is writing from the top of my head, I think we can also find it
> in the 3.4 sources if I recall correctly.

Thanks, added the reset bits for TVE0/1.

P?ikest,
Priit :)

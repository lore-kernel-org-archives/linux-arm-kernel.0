From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Aug 2015 10:59:36 +0200
Subject: [PATCH v6 5/9] clk: mediatek: Fix rate and dependency of MT8173
 clocks
In-Reply-To: <1438850132.27884.17.camel@mtksdaap41>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438676218-11310-6-git-send-email-jamesjj.liao@mediatek.com>
 <20150805065341.GA18700@pengutronix.de>
 <1438850132.27884.17.camel@mtksdaap41>
Message-ID: <20150806085936.GO18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 04:35:32PM +0800, James Liao wrote:
> Hi Sascha,
> 
> On Wed, 2015-08-05 at 08:53 +0200, Sascha Hauer wrote:
> > On Tue, Aug 04, 2015 at 04:16:54PM +0800, James Liao wrote:
> > > -static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> > > -	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> > > -	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> > > -	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> > > +static const struct mtk_fixed_clk fixed_clks[] __initconst = {
> > > +	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
> > > +	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
> > 
> > Hm, it seems you hide PLLs in fixed factor clock. Are you sure that
> > there is a PLL in the system generating 125MHz from 26MHz which is in no
> > way configurable? Or is this really some clock derived from the syspll
> > as the clock name suggests?
> 
> According to the datasheet from our clock designer, usb_syspll_125m is
> the output clock of an analog macro which is named SSUSB_PHY, and its
> input clock is AD_CLK26M_CK.
> 
> SSUSB_PHY is not the same as general PLLs such as MAINPLL. So I don't
> treat it as a configurable PLL but a fixed clock with the typical rate
> 125 MHz.

Ok then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

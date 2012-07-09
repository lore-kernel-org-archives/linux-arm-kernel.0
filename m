From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 15:27:43 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207090910.55032.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-4-git-send-email-shawn.guo@linaro.org>
 <201207090910.55032.marex@denx.de>
Message-ID: <20120709072741.GD11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 09:10:54AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > From: Marek Vasut <marex@denx.de>
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx28.dtsi |   21 ++++
> >  arch/arm/boot/dts/m28evk.dts |  241
> > ++++++++++++++++++++++++++++++++++++++++++ arch/arm/mach-mxs/mach-mxs.c | 
> >  30 +++++
> >  3 files changed, 292 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/m28evk.dts
> [...]
> 
> > +static void __init m28evk_init(void)
> > +{
> > +	update_fec_mac_prop(OUI_DENX);
> 
> You need to start the FEC clock here too, otherwise ethernet won't work. Same 

Which clock? "enet_out"?  We enabled it for imx28-evk, but
I do not know m28evk also needs it, as I haven't seen mach-m28evk.c
enabling any fec clock.  Instead, I saw the following in the old clock
code.

        /*
         * Extra fec clock setting
         * The DENX M28 uses an external clock source
         * and the clock output must not be enabled
         */
        if (!machine_is_m28evk()) {
                reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
                reg &= ~BM_CLKCTRL_ENET_SLEEP;
                reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
                __raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
        }

Or you meant other fec clock?

> thing as on mx28evk. And I noticed that on other platforms too, so maybe that 
> should be somehow the other way around -- turn on the ethernet clock by default.
> 
> The rest seems OK. I'll update the .dts file once we get the rest of the stuff 
> in (SPI and i2c).
> 
> btw. is someone converting the mxs-lcd ?
> 
The lcd should be working right now, with the auxdata used.

-- 
Regards,
Shawn

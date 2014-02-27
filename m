From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Feb 2014 15:47:45 +0100
Subject: [PATCH] ARM: i.MX6: clk: Remove usbphy clock hacks
In-Reply-To: <20140227120616.GA27749@shlinux1.ap.freescale.net>
References: <1393489138-24406-1-git-send-email-s.hauer@pengutronix.de>
 <20140227120616.GA27749@shlinux1.ap.freescale.net>
Message-ID: <20140227144744.GN17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 08:06:18PM +0800, Peter Chen wrote:
> On Thu, Feb 27, 2014 at 09:18:58AM +0100, Sascha Hauer wrote:
> > Recently the chipidea got broken on i.MX6 when the phy_mode property
> > is given in the devicetree. Since this commit:
> > 
> > | commit cd0b42c2a6d2a74244f0053f8960f5dad5842278
> > | Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > | Date:   Fri Jan 10 13:51:30 2014 +0800
> > |
> > |     usb: chipidea: put hw_phymode_configure before ci_usb_phy_init
> > |
> > |     hw_phymode_configure configures the PORTSC registers and allow the
> > |     following phy_inits to operate on the right parameters. This fix a problem
> > |     where the UPLI (ISP1504) could not be detected, because the Viewport was not
> > |     available and read the viewport return 0's only.
> > |
> > |     Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > |     Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > |     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > the portsc register is configured before the phy clock is enabled. The CPU
> > immediately hangs once the portsc register is written to with disabled phy
> > clocks.
> > 
> > The following patch added a hack to the i.MX6 clock support. Its purpose
> > was to keep the usbphy clock gates enabled:
> > 
> > | commit a5120e89e7e187a91852896f586876c7a2030804
> > | Author: Peter Chen <peter.chen@freescale.com>
> > | Date:   Fri Jan 18 10:38:05 2013 +0800
> > |
> > |     ARM i.MX6: change mxs usbphy clock usage
> > |
> > |     This mxs usbphy is only needs to be on after system boots
> > |     up, and software never needs to control it anymore.
> > |     Meanwhile, usbphy's parent needs to be notified if usb
> > |     is suspend or not. So we design below mxs usbphy usage:
> > |
> > |     - usbphy1_gate and usbphy2_gate:
> > |     Their parents are dummy clock, we only needs to enable
> > |     it after system boots up.
> > |     - usbphy1 and usbphy2
> > |     Usage reserved bit for this clock, in that case, the refcount
> > |     will be updated, but without hardware changing.
> > |
> > |     Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > |     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Now this patch indeed keeps the gates enabled, but it doesn't keep the parents
> > enabled, so the whole patch becomes a no-op once the parents get disabled. This
> > nowadays happens with more aggressive clock disabling for example in the UART
> > driver (which uses the same PLL as usbphy1).
> > 
> > This patch reverts the reserved register bit hackery and instead enables
> > the usbphy clocks when support for the mxsphy is enabled.
> 
> It will cause pll3 is still on when no user has used it.
> 
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > 
> > The above are my current state of observations. I think I still haven't fully
> > understood the purpose of the clock hacks introduced with a5120e89e7e187.
> 
> usbphy1/usbphy2 are used to mark usbphy as pll3/pll7's child, once the
> usbphy is enabled, the pll should be enabled, if no other user for pll3,
> the pll3 should still be on since the usbphy is using.
> 
> usbphy1_gate/usbphy2_gate are used to control usb gate for pll, due to
> special requirement from IC guys, these two bits are needed to open
> before any usb operations, and there two bits are never needed to change
> on the fly.

Can you explain why the gates have to be turned on when the parent PLL
is disabled?

> 
> The reason why we meet such issue?
> For internal phy(like UTMI), the phy clock is from internal pll,
> it is on/off on the fly, the access PORTSC.PTS will hang without
> phy clock. So, usb_phy_init needs to be called before
> hw_phymode_configure.
> 
> For external PHY (like ulpi), the phy clock is from board, access
> PORTSC.PTS may not need clock or we need to enhance ulpi driver to
> support open and close external phy on the fly. It needs to config
> PORTSC.PTS prior to visit view-port which is needed at its phy_init.
> So, hw_phymode_configure is needed to be called before usb_phy_init.
> 

[...]

> -static void hw_phymode_configure(struct ci_hdrc *ci)
> +static int ci_usb_phy_init(struct ci_hdrc *ci)
>  {
>  	u32 portsc, lpm, sts = 0;
> +	int ret = -ENODEV;
>  
>  	switch (ci->platdata->phy_mode) {
>  	case USBPHY_INTERFACE_MODE_UTMI:
> +		ret = usb_phy_init(ci->transceiver);
> +		if (ret)
> +			return ret;
>  		portsc = PORTSC_PTS(PTS_UTMI);
>  		lpm = DEVLC_PTS(PTS_UTMI);
>  		break;
>  	case USBPHY_INTERFACE_MODE_UTMIW:
> +		ret = usb_phy_init(ci->transceiver);
> +		if (ret)
> +			return ret;
>  		portsc = PORTSC_PTS(PTS_UTMI) | PORTSC_PTW;
>  		lpm = DEVLC_PTS(PTS_UTMI) | DEVLC_PTW;
>  		break;
>  	case USBPHY_INTERFACE_MODE_ULPI:
>  		portsc = PORTSC_PTS(PTS_ULPI);
>  		lpm = DEVLC_PTS(PTS_ULPI);
> +		ret = usb_phy_init(ci->transceiver);
> +		if (ret)
> +			return ret;
>  		break;
>  	case USBPHY_INTERFACE_MODE_SERIAL:
>  		portsc = PORTSC_PTS(PTS_SERIAL);
>  		lpm = DEVLC_PTS(PTS_SERIAL);
>  		sts = 1;
> +		ret = usb_phy_init(ci->transceiver);
> +		if (ret)
> +			return ret;
>  		break;
>  	case USBPHY_INTERFACE_MODE_HSIC:
> +		ret = usb_phy_init(ci->transceiver);
> +		if (ret)
> +			return ret;
>  		portsc = PORTSC_PTS(PTS_HSIC);
>  		lpm = DEVLC_PTS(PTS_HSIC);

It seems you try to adjust the order in which PORTSC is configured and
the phy is initialized. Instead of ordering the phy setup and register
writes you just reorder some variable initializations.

We discussed this back and forth here and think that the phy clock
should be enabled/disabled via runtime pm ops as needed by the chipidea
driver. Hacking the init order depending on the phy type like you did above
doesn't sound like a good plan.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

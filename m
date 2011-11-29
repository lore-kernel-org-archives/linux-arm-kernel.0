From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Nov 2011 09:12:51 +0100
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
 <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111129081251.GN17668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 29, 2011 at 08:02:53AM +0000, Chen Peter-B29397 wrote:
>  
> > Peter Chen writes:
> > > The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
> > > platform_device_id to distinguish the ehci differences among SoCs.
> > > It can be useful to imx ehci submission and device tree support later.
> > >
> > >
> > As the EHCI core is equivalent on all SoCs but only require different
> > clocks on each platform I think it's overkill to use platform_ids to
> > distinguish the SoCs. Indeed there is actually no need to make any
> > distinction in the driver, as you could simply provide the same set of
> > clocks on all platforms with some of them being dummy clocks on
> > certain platforms:
> > clock-imx25.c and clock-imx35.c:
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> > clock-imx27.c:
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> > clock-imx31.c:
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_clk2)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_clk2)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_clk2)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> > clock-mx51-mx53.c:
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_ahb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", usb_phy1_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_ahb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_ahb_clk)
> > 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> > 
> > 
> > In the driver you would then do a clk_get() for those three clocks
> > independent of the platform.
> > 
> The reason why I add this patch is not for clk things, it is for:
> 1. Coming device driver
> 2. Handle things difference between SoC's. not only clk, others
> like low power, wakeup, hsic, or other will comes in future.
Then are they really different per SoC (in a way not yet handled in the
driver)? If not, up to now these devices were named after the first SoC
introducing them, so i.MX25 has imx21-uart.0 and imx35-cspi.0.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

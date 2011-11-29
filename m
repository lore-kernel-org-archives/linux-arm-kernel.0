From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 29 Nov 2011 08:02:53 +0000
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20180.36084.962507.946237@ipc1.ka-ro>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
Message-ID: <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Peter Chen writes:
> > The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
> > platform_device_id to distinguish the ehci differences among SoCs.
> > It can be useful to imx ehci submission and device tree support later.
> >
> >
> As the EHCI core is equivalent on all SoCs but only require different
> clocks on each platform I think it's overkill to use platform_ids to
> distinguish the SoCs. Indeed there is actually no need to make any
> distinction in the driver, as you could simply provide the same set of
> clocks on all platforms with some of them being dummy clocks on
> certain platforms:
> clock-imx25.c and clock-imx35.c:
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
> 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> clock-imx27.c:
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> clock-imx31.c:
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_clk2)
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_clk2)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
> 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_clk2)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> clock-mx51-mx53.c:
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
> 	_REGISTER_CLOCK("mxc-ehci.0", "system_bus", usb_ahb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", usb_phy1_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "system_bus", usb_ahb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.1", "usb_phy", dummy_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "system_bus", usb_ahb_clk)
> 	_REGISTER_CLOCK("mxc-ehci.2", "usb_phy", dummy_clk)
> 
> 
> In the driver you would then do a clk_get() for those three clocks
> independent of the platform.
> 
The reason why I add this patch is not for clk things, it is for:
1. Coming device driver
2. Handle things difference between SoC's. not only clk, others
like low power, wakeup, hsic, or other will comes in future.
> 
> Lothar Wa?mann
> --
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________

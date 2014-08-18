From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 19:48:53 +0800
Subject: [RFC] usb issue on imx27: 3 clocks are needed
In-Reply-To: <782c806acb464f5781deb32e94548882@BN1PR0301MB0772.namprd03.prod.outlook.com>
References: <53EF7AF6.2000405@gmail.com> <20140818090056.GA29393@peterchendt>
 <20140818092635.GI2114@dragon>
 <782c806acb464f5781deb32e94548882@BN1PR0301MB0772.namprd03.prod.outlook.com>
Message-ID: <20140818114850.GJ2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 06:35:53PM +0800, Chen Peter-B29397 wrote:
>  
> > On Mon, Aug 18, 2014 at 05:00:59PM +0800, Peter Chen wrote:
> > > On Sat, Aug 16, 2014 at 05:38:30PM +0200, Philippe Reynes wrote:
> > > > Hi all,
> > > >
> > > > i.MX27's usb needs three clocks (usb_ipg_gate, usb_ahb_gate and
> > > > usb_div) but the current chipidea driver implementation, and
> > > > devicetree, provides only ipg and ahb. Consequently, if the
> > > > bootloader don't enable the last one, the kernel will crash.
> > > >
> > > > Our approach/idea is to add a second, optionnal, clock in
> > > > ci_hdrc_imx.c with 'per' name in devicetree  and to add  clock name
> > 'main_clk' for mandatory clock.
> > > > This approach it correct? Or an other approach seems better?
> > > > Thank you very much for your point of view.
> > > >
> > >
> > > It is ok for me to have ipg, ahb and per clocks at driver, but how can
> > > you maintain DT consistent?
> > 
> > Adding new clock as optional one will just maintain the DT compatibility.
> > 
> 
> How to handle node_usb_soc1's clock which is without clk name to consistent with three
> clocks for node_usb_soc2 at driver? Except for adding some platform judge code at
> driver, do you have other solutions?
> 
> node_usb_soc1: {
> 	clocks = <&clks IMX6_CLK_USBOH3>;
> };
> 
> node_usb_soc2: {
> 	clocks = <&clks IMX27_CLK_USBIPG>, <&clks IMX27_CLK_USBOH3>, <&clks IMX27_CLK_USBPER>;
> 	clock-names = "ipg", "ahb", "per";
> };

Oh, what I was talking about is we need to ensure the new kernel
(handling additional clocks) doesn't break old/existing DTB.  That's
what we call DT compatibility.

There is no DT consistency to maintain.  If there is only one clock for
USB on i.MX6 while 3 clocks on i.MX27, that's something USB driver needs
to handle, as clearly these two SoCs have different programming model on
USB device.

Shawn

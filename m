From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Aug 2010 11:05:22 +0200
Subject: i.MX353: mxc-ehci.0
In-Reply-To: <0D753D10438DA54287A00B0270842697643E840B23@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697643E840AE6@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697643E840B23@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100824090522.GB32104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 07:28:09PM -0500, H Hartley Sweeten wrote:
> On Monday, August 23, 2010 4:45 PM, H Hartley Sweeten wrote:
> > Hello all,
> > 
> > What "magic" setup do I need to enable mxc-ehci.0 as a host controller?
> > 
> > I pulled git://git.pengutronix.de/git/imx/linux-2.6.git and have the
> > imx-for-2.6.37 branch compiled and booting, but I get this:
> > 
> > ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
> > mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
> > mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
> > mxc-ehci mxc-ehci.1: irq 35, io mem 0x53ff4400
> > mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 1 port detected
> > 
> > It appears mxc-ehci.1 is working but I don't have that port on my board.
> > 
> > This is using the mach-mx35_3ds.c board configuration.
> 
> Well, I think I'm closer...
> 
> I removed the OTG platform data and the register of the mxc_otg_udc_device
> from mach-mx35_3ds.c.  I replaced them with the following:
> 
> static struct mxc_usbh_platform_data usb_otg_host_pdata = {
> 	.portsc		= MXC_EHCI_MODE_SERIAL,
> 	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
> 			  MXC_EHCI_INTERNAL_PHY,
> };

This must match your hardware. The i.MX35 has a UTMI phy connected to
the otg core, INTERFACE_SINGLE_UNI seems wrong here. I don't know your
hardware, it may also be that you have an external ULPI phy connected.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

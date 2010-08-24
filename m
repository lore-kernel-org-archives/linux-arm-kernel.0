From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 23 Aug 2010 19:28:09 -0500
Subject: i.MX353: mxc-ehci.0
In-Reply-To: <0D753D10438DA54287A00B0270842697643E840AE6@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697643E840AE6@AUSP01VMBX24.collaborationhost.net>
Message-ID: <0D753D10438DA54287A00B0270842697643E840B23@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 23, 2010 4:45 PM, H Hartley Sweeten wrote:
> Hello all,
> 
> What "magic" setup do I need to enable mxc-ehci.0 as a host controller?
> 
> I pulled git://git.pengutronix.de/git/imx/linux-2.6.git and have the
> imx-for-2.6.37 branch compiled and booting, but I get this:
> 
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
> mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
> mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
> mxc-ehci mxc-ehci.1: irq 35, io mem 0x53ff4400
> mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> 
> It appears mxc-ehci.1 is working but I don't have that port on my board.
> 
> This is using the mach-mx35_3ds.c board configuration.

Well, I think I'm closer...

I removed the OTG platform data and the register of the mxc_otg_udc_device
from mach-mx35_3ds.c.  I replaced them with the following:

static struct mxc_usbh_platform_data usb_otg_host_pdata = {
	.portsc		= MXC_EHCI_MODE_SERIAL,
	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
			  MXC_EHCI_INTERNAL_PHY,
};

	mxc_register_device(&mxc_otg_host, &usb_otg_host_pdata);

Now when the board boots I get:

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
mxc-ehci mxc-ehci.0: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.0: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.0: irq 37, io mem 0x53ff4000
mxc-ehci mxc-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 2
mxc-ehci mxc-ehci.1: irq 35, io mem 0x53ff4400
mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected

But then later I get:

usb 1-1: new full speed USB device using mxc-ehci and address 2
usb 1-1: device descriptor read/64, error -71
usb 1-1: device descriptor read/64, error -71
usb 1-1: new full speed USB device using mxc-ehci and address 3
usb 1-1: device descriptor read/64, error -71
usb 1-1: device descriptor read/64, error -71
usb 1-1: new full speed USB device using mxc-ehci and address 4
usb 1-1: device not accepting address 4, error -71
usb 1-1: new full speed USB device using mxc-ehci and address 5
usb 1-1: device not accepting address 5, error -71
hub 1-0:1.0: unable to enumerate USB device on port 1

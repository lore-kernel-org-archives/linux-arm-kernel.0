From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 14 Apr 2014 10:35:43 -0400 (EDT)
Subject: [PATCH/RFC 0/3] Allow OHCI drivers to override hub control
 operations
In-Reply-To: <1397478359-22541-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1404141016470.874-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Apr 2014, Laurent Pinchart wrote:

> Hello,
> 
> The PXA27x OHCI implementation doesn't perform automatic control of port power
> supplies for all ports. While the PPS and LSDA bits of the HcRhPortStatus
> register are implemented, only a subset of ports have an external power enable
> pin controlled by the port status register. Other ports need their power supply
> to be controlled manually.
> 
> In order to do so I've implemented manual regulator control in the ohci-pxa27x
> driver. This requires overriding the default behaviour of the CLEAR_FEATURE
> and SET_FEATURE requests for USB_PORT_FEAT_POWER with a custom hub control
> operation. In turn this requires calling the currently static ohci_hub_control
> function from the ohci-pxa27x driver.
> 
> The ohci-s3c2410 driver already implements a similar feature, and accesses the
> ohci_hub_control function by saving the struct hc_driver hub_control value to
> a global variable right after calling ohci_init_driver. This is a bit of a
> hack, and as I need to call that function as well I've decided to export it
> instead.

It only seems like a hack if you don't think about it the right way.  :-)

The intention was to imitate an object-oriented style, by allowing a
child class to override member functions in the parent class.  The
vtable mechanism in C++, for example, does essentially the same thing
as ohci-s3c2410 (except that C++ doesn't save the original function
pointer in a global variable; instead it reads the function pointer
from the parent's vtable as needed -- ohci-s3c2410 can't do that 
because ohci_hc_driver isn't exported).

I'm open to the idea of exporting the hub functions.  In the end, it
doesn't make all that much difference (it would save a little object
code).

> Another option would have been to handle the regulators directly inside the
> ohci-hub implementation, but I'm not sure whether it's worth it yet. Comments
> (or acks :-)) will be appreciated.
> 
> Please not that I haven't been able to test the third patch due to lack of
> hardware. I've however tested a similar implementation on an out of tree
> PXA270 board.
> 
> Laurent Pinchart (3):
>   USB: OHCI: Export the ohci_hub_control function
>   USB: ohci-pxa27x: Add support for external vbus regulators
>   ARM: pxa: zeus: Replace OHCI init/exit functions with a regulator
> 
>  arch/arm/mach-pxa/zeus.c        | 89 ++++++++++++++++++++++-------------------
>  drivers/usb/host/ohci-hub.c     |  4 +-
>  drivers/usb/host/ohci-pxa27x.c  | 67 +++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-s3c2410.c |  7 +---
>  drivers/usb/host/ohci.h         |  2 +
>  5 files changed, 121 insertions(+), 48 deletions(-)

You missed ohci-at91.c.  And ehci-tegra.c plays similar games.  I'd 
prefer to do the same thing for both ehci-hcd and ohci-hcd.

Alan Stern

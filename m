From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 23 Apr 2012 12:20:14 +0000
Subject: [PATCH 09/11] MXS: Add USB PHY driver
In-Reply-To: <201204230417.13182.marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-10-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B793D9@039-SN2MPN1-023.039d.mgd.msft.net>
 <201204230417.13182.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B79918@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > > +
> > > +static int mxs_usb_set_host(struct usb_otg *otg, struct usb_bus
> *host)
> >
> > should be at imx-otg.c
> 
> I don't understand why. This is clearly specific to this PHY driver.
>
Please take a look the definition of struct usb_otg and struct usb_phy
at include/linux/usb/otg.h. You may need to implement individual
struct at individual driver (usb_otg->otg driver, usb_phy->phy driver)
 
 
> >
> > It is OTG switch routine, and should be put imx-otg.c. Sascha also
> > suggested before.
> 
> Fine by me, but until someone can clearly explain to me why PHY specific
> code
> should be in a shared file (even if it's completely unrelated to it), I
> see no
> point moving this.
>
Can you explain what kinds of things are PHY specific from your point?

 
 
> >
> > Have you tested several connect/disconnect operation with high speed
> > device? - where you clear BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ?
> > - This code will always run at every usb interrupt, in fact, high speed
> > detector only needs to be set/clear with connect/disconnect.
> 
> I have yet to figure out how to actually detect host connect/disconnect
> in OTG
> mode while also detect Device connect/disconnect. Can you elaborate on
> what
> needs to be set in the CTRL register to generate these interrupts?
At i.mx28, there are two USB related controller, one is USB core controller,
another is USB PHY controller. Each has individual interrupt line.
You only need to set USB_PHY_CTRL for wakeup interrupt case.
Host connect/disconnect: PCD interrupt at EHCI register
Device connect/disconnect: vbus (B_SESSION_VALID) interrupt at otgsc.

For register usage, you can refer freescale git:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_2.6.35_10.12.01
Although the code structure is not good, you can refer some hardware operation.

 

From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Jan 2014 08:47:25 -0600
Subject: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library
 returns -ENODEV/-ENXIO
In-Reply-To: <1390299099-14764-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1390299099-14764-1-git-send-email-kishon@ti.com>
Message-ID: <20140121144725.GF30451@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 03:41:38PM +0530, Kishon Vijay Abraham I wrote:
> Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
> do not return from probe if the USB PHY library returns -ENODEV as that

this isn't correct, they all have PHYs, some of them might not be
controllable.

> indicates the platform does not have PHY.

not really, that indicates the current platform tried to grab a PHY and
the PHY doesn't exist. If there's anybody with a non-controllable PHY
and someone gives me a really good reason for not using the generic
no-op PHY, then we should add a flag and we could:

	if (!likely(dwc->flags & DWC3_USB2PHY_DRIVER_NOT_NEEDED))
		dwc3_grab_phys(dwc);

But I really want to see the argument against using no-op. As far as I
could see, everybody needs a PHY driver one way or another, some
platforms just haven't sent any PHY driver upstream and have their own
hacked up solution to avoid using the PHY layer.

Your commit log really needs quite some extra work. What are you trying
to achieve ? Is this related to AM437x which doesn't have a USB3 PHY due
to the way the HW was wired up ? If so, please mention it. Explain how
AM437x HW was wired up, why it lacks a USB3 PHY and why we should
support it the way you want.

That sort of detail needs to be clear in the commit log, specially
considering the peculiar nature of AM43xx which uses a USB3 IP in
USB2-only mode, that needs to be documented in the commit log :-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/f38c6525/attachment.sig>

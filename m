From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Aug 2015 17:57:22 -0500
Subject: [PATCH] musb: sunxi: Ignore VBus errors in host-only mode
In-Reply-To: <55C1370E.1000805@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <20150804213553.GI9623@saruman.tx.rr.com>
 <55C1370E.1000805@redhat.com>
Message-ID: <20150804225722.GA6802@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 05, 2015 at 12:05:02AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/04/2015 11:35 PM, Felipe Balbi wrote:
> >On Tue, Aug 04, 2015 at 11:25:53PM +0200, Hans de Goede wrote:
> >>For some unclear reason sometimes we get VBus errors in host-only mode,
> >>even though we do not have any vbus-detection then. Ignore these.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  drivers/usb/musb/sunxi.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >>diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> >>index f9f6304..34ce5df 100644
> >>--- a/drivers/usb/musb/sunxi.c
> >>+++ b/drivers/usb/musb/sunxi.c
> >>@@ -194,6 +194,10 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
> >>  		musb_writeb(musb->mregs, MUSB_FADDR, 0);
> >>  	}
> >>
> >>+	/*  Ignore Vbus errors when in host only mode */
> >>+	if (musb->port_mode == MUSB_PORT_MODE_HOST)
> >>+		musb->int_usb &= ~MUSB_INTR_VBUSERROR;
> >
> >check with a scope if VBUS is really dropping. Host does VBUS detection
> >indeed, at a minimum, for overcurrent protection. You might have
> >something causing VBUS to drop and that something needs to be found,
> >rather than masked.
> 
> The boards in question do not have any vbus detection, the usb-phy on
> allwinner boards do not have a vbus sense pin, instead a gpio is used
> in designs which use otg. Designs which use host-only mode typically
> do not have any form of vbus detection at all. In this case we always
> report vbus as being valid to the musb core, so I've no idea why
> the musb core is still generating vbus errors.

PHY must tell MUSB about VBUS level using either ULPI or UTMI+. I'd
check to see if the PHY is at fault, at least.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/573864e2/attachment.sig>

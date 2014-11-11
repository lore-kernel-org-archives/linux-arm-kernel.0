From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Nov 2014 08:53:01 -0600
Subject: [PATCH] usb: phy: fix twl4030 build regression
In-Reply-To: <20141111145217.GB25615@saruman>
References: <7831012.jlbEUURqIo@wuerfel>
 <20141111145217.GB25615@saruman>
Message-ID: <20141111145301.GC25615@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 08:52:17AM -0600, Felipe Balbi wrote:
> On Tue, Nov 11, 2014 at 10:36:09AM +0100, Arnd Bergmann wrote:
> > Recent changes to the common OTG handling broke building the twl4030
> > OTG driver as found during an allmodconfig build of linux-next:
> > 
> > drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
> > drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member named 'state'
> > drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
> > drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompatible pointer type
> > 
> > This applies the same changes that were done to the other phy drivers
> > to get it to build cleanly.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
> > Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OTG structure")
> 
> on my testing/next already:
> 
> commit 7e1bbeb4292783dcc079156b8fa08d66d17219e0
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Fri Nov 7 19:43:45 2014 -0600
> 
>     usb: host: ohci: omap: fix build breakage

wrong commit, here's the correct one:

commit 8b9ca2767b2d1ea405287e530da3a7b234120b95
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Nov 7 09:06:04 2014 -0600

    phy: twl4030: Fix build breakage
    
    commit e47d925 (usb: move the OTG state
    from the USB PHY to the OTG structure) moved
    the OTG state field from struct usb_phy to
    struct usb_otg but, even though I fixed many
    other build breakages, I still missed one
    on phy-twl4030-usb.c.
    
    Fix the build breakage now.
    
    While at that, also a build warning introduced
    by the same commit.
    
    Cc: Kishon Vijay Abraham I <kishon@ti.com>
    Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 7b04bef..e2698d29 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -606,7 +606,7 @@ static int twl4030_set_peripheral(struct usb_otg *otg,
 
 	otg->gadget = gadget;
 	if (!gadget)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -618,7 +618,7 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 
 	otg->host = host;
 	if (!host)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -676,7 +676,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
 
-	otg->phy		= &twl->phy;
+	otg->usb_phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;
 	otg->set_peripheral	= twl4030_set_peripheral;
 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/2b0a110d/attachment.sig>

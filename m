From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Nov 2014 08:52:17 -0600
Subject: [PATCH] usb: phy: fix twl4030 build regression
In-Reply-To: <7831012.jlbEUURqIo@wuerfel>
References: <7831012.jlbEUURqIo@wuerfel>
Message-ID: <20141111145217.GB25615@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 10:36:09AM +0100, Arnd Bergmann wrote:
> Recent changes to the common OTG handling broke building the twl4030
> OTG driver as found during an allmodconfig build of linux-next:
> 
> drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
> drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member named 'state'
> drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
> drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompatible pointer type
> 
> This applies the same changes that were done to the other phy drivers
> to get it to build cleanly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
> Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OTG structure")

on my testing/next already:

commit 7e1bbeb4292783dcc079156b8fa08d66d17219e0
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Nov 7 19:43:45 2014 -0600

    usb: host: ohci: omap: fix build breakage
    
    commit e47d925 (usb: move the OTG state
    from the USB PHY to the OTG structure) moved
    the OTG state field from struct usb_phy to
    struct usb_otg but, even though I fixed many
    other build breakages, I still missed one
    on ohci-omap.c.
    
    Fix the build breakage now.
    
    drivers/usb/host/ohci-omap.c: In function ?start_hnp?:
    drivers/usb/host/ohci-omap.c:186:19: error: request for member ?state? in something not a structure or union
      hcd->usb_phy->otg.state = OTG_STATE_A_SUSPEND;
    
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index cf89b4b1..3e5df5a 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -183,7 +183,7 @@ static void start_hnp(struct ohci_hcd *ohci)
 	otg_start_hnp(hcd->usb_phy->otg);
 
 	local_irq_save(flags);
-	hcd->usb_phy->otg.state = OTG_STATE_A_SUSPEND;
+	hcd->usb_phy->otg->state = OTG_STATE_A_SUSPEND;
 	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
 	l = omap_readl(OTG_CTRL);
 	l &= ~OTG_A_BUSREQ;

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/afd1d30b/attachment.sig>

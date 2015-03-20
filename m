From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 20:11:14 +0100
Subject: [PATCH v2 05/13] musb: Fix platform code being unable to override ep
 access ops
In-Reply-To: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426878682-14521-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

musb-core was setting the ops to the default indexed or flat handlers after
checking for platform overrides. Reverse the order of this so that platform
overrides actually work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/musb_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 016b5b9..6e9b839 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2021,13 +2021,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (musb->ops->quirks)
 		musb->io.quirks = musb->ops->quirks;
 
-	/* At least tusb6010 has it's own offsets.. */
-	if (musb->ops->ep_offset)
-		musb->io.ep_offset = musb->ops->ep_offset;
-	if (musb->ops->ep_select)
-		musb->io.ep_select = musb->ops->ep_select;
-
-	/* ..and some devices use indexed offset or flat offset */
+	/* Set default ep access to indexed offset or flat offset ops */
 	if (musb->io.quirks & MUSB_INDEXED_EP) {
 		musb->io.ep_offset = musb_indexed_ep_offset;
 		musb->io.ep_select = musb_indexed_ep_select;
@@ -2035,6 +2029,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->io.ep_offset = musb_flat_ep_offset;
 		musb->io.ep_select = musb_flat_ep_select;
 	}
+	/* And override them with platform specific ops if specified. */
+	if (musb->ops->ep_offset)
+		musb->io.ep_offset = musb->ops->ep_offset;
+	if (musb->ops->ep_select)
+		musb->io.ep_select = musb->ops->ep_select;
 
 	if (musb->ops->fifo_mode)
 		fifo_mode = musb->ops->fifo_mode;
-- 
2.3.3

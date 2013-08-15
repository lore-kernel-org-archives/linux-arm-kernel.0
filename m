From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 16:15:09 +0300
Subject: [PATCH v2 5/8] usb: musb: omap2430: Don't use omap_get_control_dev()
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Message-ID: <1376572512-9561-6-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/musb/omap2430.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ebb46ec..1db9588 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -547,12 +548,25 @@ static int omap2430_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->has_mailbox) {
-		glue->control_otghs = omap_get_control_dev();
-		if (IS_ERR(glue->control_otghs)) {
-			dev_vdbg(&pdev->dev, "Failed to get control device\n");
-			ret = PTR_ERR(glue->control_otghs);
+		struct device_node *control_node;
+		struct platform_device *control_pdev;
+
+		control_node = of_parse_phandle(np, "ctrl-module", 0);
+		if (!control_node) {
+			dev_err(&pdev->dev, "Failed to get control device phandle\n");
+			ret = -ENODEV;
+			goto err2;
+		}
+
+		control_pdev = of_find_device_by_node(control_node);
+		if (!control_pdev) {
+			dev_err(&pdev->dev, "Failed to get control device\n");
+			ret = -ENODEV;
 			goto err2;
 		}
+
+		glue->control_otghs = &control_pdev->dev;
+
 	} else {
 		glue->control_otghs = ERR_PTR(-ENODEV);
 	}
-- 
1.7.4.1

From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:38:43 -0600
Subject: [PATCH 5/7] usb: dwc3: omap: fix order of pm_runtime vs child removal
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Message-ID: <1386884325-11440-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pm_runtime_put_sync() will kill dwc3's clocks and,
since dwc3 core accesses registers during removal,
we must make sure to unregister core before
disabling clocks and pm_runtime.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 076bb28..a9090a1 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -580,9 +580,9 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 	if (omap->extcon_id_dev.edev)
 		extcon_unregister_interest(&omap->extcon_id_dev);
 	dwc3_omap_disable_irqs(omap);
+	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
 
 	return 0;
 }
-- 
1.8.4.GIT

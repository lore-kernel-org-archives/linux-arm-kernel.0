From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 13:30:15 +0200
Subject: [PATCH v7 06/22] mfd: omap-usb-tll: Check for missing platform data
 in probe
In-Reply-To: <1358422231-24736-1-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
Message-ID: <1358422231-24736-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to check for missing platform data in runtime_suspend/resume
as it makes more sense to do it in the probe function.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 6a43391..0e68c8a 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -225,6 +225,11 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!pdata) {
+		dev_err(dev, "Platform data missing\n");
+		return -ENODEV;
+	}
+
 	spin_lock_init(&tll->lock);
 
 	tll->pdata = pdata;
@@ -370,11 +375,6 @@ static int usbtll_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
@@ -406,11 +406,6 @@ static int usbtll_runtime_suspend(struct device *dev)
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-- 
1.7.4.1

From: rogerq@ti.com (Roger Quadros)
Date: Mon, 10 Dec 2012 12:20:17 +0200
Subject: [PATCH v4 07/23] mfd: omap-usb-tll: Check for missing platform data
 in probe
In-Reply-To: <1355134833-5199-1-git-send-email-rogerq@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
Message-ID: <1355134833-5199-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to check for missing platform data in runtime_suspend/resume
as it makes more sense to do it in the probe function.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 07370a3..8b596e0 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -225,6 +225,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!pdata) {
+		dev_err(dev, "Platform data missing\n");
+		return -ENODEV;
+	}
+
 	spin_lock_init(&tll->lock);
 
 	tll->pdata = pdata;
@@ -367,11 +372,6 @@ static int usbtll_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
@@ -403,11 +403,6 @@ static int usbtll_runtime_suspend(struct device *dev)
 
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

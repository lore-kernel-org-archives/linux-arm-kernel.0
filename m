From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:17 +0200
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows boards to leave the irq_base field unitialized and
prevents them having to reserve irqs in the platform.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mfd/wm8350-irq.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8350-irq.c b/drivers/mfd/wm8350-irq.c
index ed4b22a..04408a5 100644
--- a/drivers/mfd/wm8350-irq.c
+++ b/drivers/mfd/wm8350-irq.c
@@ -479,8 +479,8 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,
 		return 0;
 	}
 
-	if (!pdata || !pdata->irq_base) {
-		dev_warn(wm8350->dev, "No interrupt support, no IRQ base\n");
+	if (!pdata) {
+		dev_warn(wm8350->dev, "No interrupt support, no platform data\n");
 		return 0;
 	}
 
@@ -500,7 +500,17 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,
 
 	mutex_init(&wm8350->irq_lock);
 	wm8350->chip_irq = irq;
-	wm8350->irq_base = pdata->irq_base;
+
+	if (!pdata->irq_base) {
+		wm8350->irq_base = irq_alloc_descs(-1, 0, ARRAY_SIZE(wm8350_irqs), 0);
+		if (wm8350->irq_base < 0) {
+			dev_warn(wm8350->dev, "Allocating irqs failed with %d\n",
+				wm8350->irq_base);
+			return 0;
+		}
+	} else {
+		wm8350->irq_base = pdata->irq_base;
+	}
 
 	if (pdata->irq_high) {
 		flags |= IRQF_TRIGGER_HIGH;
-- 
1.7.4.1

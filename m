From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 15:18:39 +0200
Subject: [PATCH v4 3/9] rtc: at91sam9: replace devm_ioremap by
 devm_ioremap_resource
In-Reply-To: <1410441525-25258-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410441525-25258-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410441525-25258-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace devm_ioremap calls by devm_ioremap_resource which already check
resource consistency (resource != NULL) and print an error in case of
failure.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 74a9ca0..38a2693 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -306,18 +306,11 @@ static const struct rtc_class_ops at91_rtc_ops = {
  */
 static int at91_rtc_probe(struct platform_device *pdev)
 {
-	struct resource	*r, *r_gpbr;
+	struct resource	*r;
 	struct sam9_rtc	*rtc;
 	int		ret, irq;
 	u32		mr;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	r_gpbr = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!r || !r_gpbr) {
-		dev_err(&pdev->dev, "need 2 ressources\n");
-		return -ENODEV;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource\n");
@@ -335,18 +328,16 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtt = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!rtc->rtt) {
-		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
-		return -ENOMEM;
-	}
 
-	rtc->gpbr = devm_ioremap(&pdev->dev, r_gpbr->start,
-				resource_size(r_gpbr));
-	if (!rtc->gpbr) {
-		dev_err(&pdev->dev, "failed to map gpbr registers, aborting.\n");
-		return -ENOMEM;
-	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtc->rtt = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rtc->rtt))
+		return PTR_ERR(rtc->rtt);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	rtc->gpbr = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rtc->gpbr))
+		return PTR_ERR(rtc->rtt);
 
 	mr = rtt_readl(rtc, MR);
 
-- 
1.9.1

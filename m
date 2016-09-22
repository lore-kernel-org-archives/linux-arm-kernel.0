From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Sep 2016 00:53:21 +0200
Subject: [PATCH 1/2] power/reset: at91-reset: add samx7 support
Message-ID: <20160922225322.31677-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Szemz? Andr?s <sza@esh.hu>

Add samx7 support. It is lacking a few bits and needs a new reset function.

Signed-off-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-reset.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 1b5d450586d1..563722e64d7b 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -134,6 +134,15 @@ static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
+static int samx7_restart(struct notifier_block *this, unsigned long mode,
+			 void *cmd)
+{
+	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
+	       at91_rstc_base);
+
+	return NOTIFY_DONE;
+}
+
 static void __init at91_reset_status(struct platform_device *pdev)
 {
 	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
@@ -173,6 +182,7 @@ static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
+	{ .compatible = "atmel,samx7-rstc", .data = samx7_restart },
 	{ /* sentinel */ }
 };
 
-- 
2.9.3

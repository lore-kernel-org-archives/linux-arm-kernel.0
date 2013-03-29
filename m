From: jhovold@gmail.com (Johan Hovold)
Date: Fri, 29 Mar 2013 17:03:45 +0100
Subject: [RFC 1/5] rtc-at91rm9200: add configuration support
Message-ID: <1364573029-19346-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration support which can be used to implement SoC-specific
workarounds for broken hardware.
---
 drivers/rtc/rtc-at91rm9200.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 434ebc3..5bae0a1 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -40,6 +40,10 @@
 
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
 
+struct at91_rtc_config {
+};
+
+static const struct at91_rtc_config *at91_rtc_config;
 static DECLARE_COMPLETION(at91_rtc_updated);
 static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
 static void __iomem *at91_rtc_regs;
@@ -248,6 +252,15 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;		/* not handled */
 }
 
+static const struct at91_rtc_config at91rm9200_config = {
+};
+
+static const struct at91_rtc_config *
+at91_rtc_get_config(struct platform_device *pdev)
+{
+	return &at91rm9200_config;
+}
+
 static const struct rtc_class_ops at91_rtc_ops = {
 	.read_time	= at91_rtc_readtime,
 	.set_time	= at91_rtc_settime,
@@ -266,6 +279,10 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	int ret = 0;
 
+	at91_rtc_config = at91_rtc_get_config(pdev);
+	if (!at91_rtc_config)
+		return -ENODEV;
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
 		dev_err(&pdev->dev, "no mmio resource defined\n");
-- 
1.8.1.5

From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Feb 2013 11:30:53 +0100
Subject: [PATCH] rtc: rtc-mv: Add support for clk to avoid lockups
Message-ID: <1359887453-17189-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell RTC on Kirkwood makes use of the runit clock. Ensure the
driver clk_prepare_enable() this clock, otherwise there is a danger
the SoC will lockup when accessing RTC registers with the clock
disabled.

Reported-by: Simon Baatz gmbnomis at gmail.com
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi |    1 +
 drivers/rtc/rtc-mv.c            |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 6c5d75f..c57b9c6 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -77,6 +77,7 @@
 			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
 			reg = <0x10300 0x20>;
 			interrupts = <53>;
+			clocks = <&gate_clk 7>;
 		};
 
 		spi at 10600 {
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 57233c8..365bc83 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
 
@@ -41,6 +42,7 @@ struct rtc_plat_data {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;
 	int		irq;
+	struct clk	*clk;
 };
 
 static int mv_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -260,6 +262,11 @@ static int mv_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	pdata->clk = devm_clk_get(&pdev->dev, NULL);
+	/* Not all SoCs require a clock.*/
+	if (!IS_ERR(pdata->clk))
+		clk_prepare_enable(pdata->clk);
+
 	if (pdata->irq >= 0) {
 		device_init_wakeup(&pdev->dev, 1);
 		pdata->rtc = rtc_device_register(pdev->name, &pdev->dev,
@@ -268,8 +275,11 @@ static int mv_rtc_probe(struct platform_device *pdev)
 	} else
 		pdata->rtc = rtc_device_register(pdev->name, &pdev->dev,
 						 &mv_rtc_ops, THIS_MODULE);
-	if (IS_ERR(pdata->rtc))
+	if (IS_ERR(pdata->rtc)) {
+		if (!IS_ERR(pdata->clk))
+			clk_disable_unprepare(pdata->clk);
 		return PTR_ERR(pdata->rtc);
+	}
 
 	if (pdata->irq >= 0) {
 		writel(0, pdata->ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
@@ -292,6 +302,9 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 0);
 
 	rtc_device_unregister(pdata->rtc);
+	if (!IS_ERR(pdata->clk))
+		clk_disable_unprepare(pdata->clk);
+
 	return 0;
 }
 
-- 
1.7.10.4

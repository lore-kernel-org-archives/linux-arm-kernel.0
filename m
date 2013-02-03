From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Feb 2013 12:32:06 +0100
Subject: [PATCH v2] rtc: rtc-mv: Add support for clk to avoid lockups
Message-ID: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell RTC on Kirkwood makes use of the runit clock. Ensure the
driver clk_prepare_enable() this clock, otherwise there is a danger
the SoC will lockup when accessing RTC registers with the clock
disabled.

Reported-by: Simon Baatz gmbnomis at gmail.com
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

Since v1:
Enable clock before accessing RTC registers.

 arch/arm/boot/dts/kirkwood.dtsi |    1 +
 drivers/rtc/rtc-mv.c            |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

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
index 57233c8..8f87fec 100644
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
@@ -221,6 +223,7 @@ static int mv_rtc_probe(struct platform_device *pdev)
 	struct rtc_plat_data *pdata;
 	resource_size_t size;
 	u32 rtc_time;
+	int ret = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -239,11 +242,17 @@ static int mv_rtc_probe(struct platform_device *pdev)
 	if (!pdata->ioaddr)
 		return -ENOMEM;
 
+	pdata->clk = devm_clk_get(&pdev->dev, NULL);
+	/* Not all SoCs require a clock.*/
+	if (!IS_ERR(pdata->clk))
+		clk_prepare_enable(pdata->clk);
+
 	/* make sure the 24 hours mode is enabled */
 	rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 	if (rtc_time & RTC_HOURS_12H_MODE) {
 		dev_err(&pdev->dev, "24 Hours mode not supported.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* make sure it is actually functional */
@@ -252,7 +261,8 @@ static int mv_rtc_probe(struct platform_device *pdev)
 		rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 		if (rtc_time == 0x01000000) {
 			dev_err(&pdev->dev, "internal RTC not ticking\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto out;
 		}
 	}
 
@@ -268,8 +278,10 @@ static int mv_rtc_probe(struct platform_device *pdev)
 	} else
 		pdata->rtc = rtc_device_register(pdev->name, &pdev->dev,
 						 &mv_rtc_ops, THIS_MODULE);
-	if (IS_ERR(pdata->rtc))
-		return PTR_ERR(pdata->rtc);
+	if (IS_ERR(pdata->rtc)) {
+		ret = PTR_ERR(pdata->rtc);
+		goto out;
+	}
 
 	if (pdata->irq >= 0) {
 		writel(0, pdata->ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
@@ -282,6 +294,11 @@ static int mv_rtc_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+out:
+	if (!IS_ERR(pdata->clk))
+		clk_disable_unprepare(pdata->clk);
+
+	return ret;
 }
 
 static int __exit mv_rtc_remove(struct platform_device *pdev)
@@ -292,6 +309,9 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 0);
 
 	rtc_device_unregister(pdata->rtc);
+	if (!IS_ERR(pdata->clk))
+		clk_disable_unprepare(pdata->clk);
+
 	return 0;
 }
 
-- 
1.7.10.4

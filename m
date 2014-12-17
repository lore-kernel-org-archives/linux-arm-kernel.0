From: yvo@apm.com (Y Vo)
Date: Wed, 17 Dec 2014 10:55:49 +0700
Subject: [PATCH v2 3/3] arm64:dts: Add APM X-Gene standby GPIO controller DTS
 entries
In-Reply-To: <1418788549-27108-1-git-send-email-yvo@apm.com>
References: <1418788549-27108-1-git-send-email-yvo@apm.com>
Message-ID: <1418788549-27108-4-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add standby domain gpio controller for APM X-Gene SoC platform.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 13 +++++++++++++
 drivers/gpio/gpio-xgene-sb.c       | 18 +++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 295c72d..e2454a2 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -587,6 +587,19 @@
 			phy-names = "sata-phy";
 		};
 
+		sbgpio: sbgpio at 17001000{
+			compatible = "apm,xgene-gpio-sb";
+			reg = <0x0 0x17001000 0x0 0x400>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = 	<0x0 0x28 0x1>,
+					<0x0 0x29 0x1>,
+					<0x0 0x2a 0x1>,
+					<0x0 0x2b 0x1>,
+					<0x0 0x2c 0x1>,
+					<0x0 0x2d 0x1>;
+		};
+
 		rtc: rtc at 10510000 {
 			compatible = "apm,xgene-rtc";
 			reg = <0x0 0x10510000 0x0 0x400>;
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 7668626..425234b 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -44,14 +44,10 @@
 #define MPA_GPIO_SEL_LO			0x0294
 #define MPA_GPIO_SEL_HIGH		0x029c
 
-#define GICD_SPI_BASE			0x78010000
-#define GICD_SPIR1			0x00000d08
-
 struct xgene_gpio_sb {
 	struct of_mm_gpio_chip mm;
 	u32 *irq;
 	u32 nirq;
-	void __iomem *gic_regs;
 	spinlock_t lock; /* mutual exclusion */
 };
 
@@ -75,14 +71,9 @@ static void xgene_gpio_set_bit(void __iomem *reg, u32 gpio, int val)
 static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
 	u32 data;
 
-	if (chip->irq[gpio]) {
-		data = ioread32(chip->gic_regs + GICD_SPIR1);
-	} else {
-		data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
-	}
+	data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
 
 	return (data &  GPIO_MASK(gpio)) ? 1 : 0;
 }
@@ -167,10 +158,6 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	mm->gc.ngpio = XGENE_MAX_GPIO_DS;
 	apm_gc->nirq = XGENE_MAX_GPIO_DS_IRQ;
 
-	apm_gc->gic_regs = ioremap(GICD_SPI_BASE, 16);
-	if (!apm_gc->gic_regs)
-		return -ENOMEM;
-
 	apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
 				   GFP_KERNEL);
 	if (!apm_gc->irq)
@@ -202,7 +189,8 @@ static int xgene_gpio_sb_remove(struct platform_device *pdev)
 {
 	struct of_mm_gpio_chip *mm = platform_get_drvdata(pdev);
 
-	return gpiochip_remove(&mm->gc);
+	gpiochip_remove(&mm->gc);
+	return 0;
 }
 
 static const struct of_device_id xgene_gpio_sb_of_match[] = {
-- 
2.2.0

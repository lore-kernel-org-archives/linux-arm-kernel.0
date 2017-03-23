From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Mar 2017 09:03:25 +0100
Subject: [PATCH v4 4/6] mfd: exynos-lpass: Add support for clocks
In-Reply-To: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080349eucas1p11187befd30ab70554373fb6d818cd851@eucas1p1.samsung.com>
Message-ID: <1490256207-10061-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos LPASS requires some clocks to be enabled to make any access to its
registers. This patch adds code for handling such clocks. For current set
of registers it is enough to keep sfr0_ctrl clock enabled. Till now it
worked only because those clocks were enabled by bootloader and driver
probe() happened before they were disabled by clock core because of lack
of users. Handling those clocks is also needed to make it possible to
enable support for audio power domain.

This patch requires adding sfr0_ctrl clock to device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/samsung,exynos5433-lpass.txt       |  6 ++++++
 drivers/mfd/exynos-lpass.c                                     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
index a8deaee82c44..df664018c148 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
@@ -5,6 +5,10 @@ Required properties:
  - compatible		: "samsung,exynos5433-lpass"
  - reg			: should contain the LPASS top SFR region location
 			  and size
+ - clock-names		: should contain following required clocks: "sfr0_ctrl"
+ - clocks		: should contain clock specifiers of all clocks, which
+			  input names have been specified in clock-names
+			  property, in same order.
  - #address-cells	: should be 1
  - #size-cells		: should be 1
  - ranges		: must be present
@@ -24,6 +28,8 @@ Example:
 audio-subsystem {
 	compatible = "samsung,exynos5433-lpass";
 	reg = <0x11400000 0x100>, <0x11500000 0x08>;
+	clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
+	clock-names = "sfr0_ctrl";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges;
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 17915daa2e80..be264988bdc9 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -14,6 +14,7 @@
  * only version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -52,6 +53,7 @@
 struct exynos_lpass {
 	/* pointer to the LPASS TOP regmap */
 	struct regmap *top;
+	struct clk *sfr0_clk;
 };
 
 static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
@@ -71,6 +73,8 @@ static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
 
 static void exynos_lpass_enable(struct exynos_lpass *lpass)
 {
+	clk_prepare_enable(lpass->sfr0_clk);
+
 	/* Unmask SFR, DMA and I2S interrupt */
 	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK,
 		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
@@ -88,6 +92,8 @@ static void exynos_lpass_disable(struct exynos_lpass *lpass)
 	/* Mask any unmasked IP interrupt sources */
 	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK, 0);
 	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK, 0);
+
+	clk_disable_unprepare(lpass->sfr0_clk);
 }
 
 static const struct regmap_config exynos_lpass_reg_conf = {
@@ -114,6 +120,10 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	if (IS_ERR(base_top))
 		return PTR_ERR(base_top);
 
+	lpass->sfr0_clk = devm_clk_get(dev, "sfr0_ctrl");
+	if (IS_ERR(lpass->sfr0_clk))
+		return PTR_ERR(lpass->sfr0_clk);
+
 	lpass->top = regmap_init_mmio(dev, base_top,
 					&exynos_lpass_reg_conf);
 	if (IS_ERR(lpass->top)) {
-- 
1.9.1

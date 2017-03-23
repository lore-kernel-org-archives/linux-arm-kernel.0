From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Mar 2017 09:03:24 +0100
Subject: [PATCH v4 3/6] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080348eucas1p29d1fb4eb06e4785d20341be7a374bfb3@eucas1p2.samsung.com>
Message-ID: <1490256207-10061-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pad retention should be controlled from pin control driver, so remove it
from Exynos LPASS driver. After this change, no more access to PMU regmap
is needed, so remove also the code for handling PMU regmap.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/mfd/samsung,exynos5433-lpass.txt           |  2 --
 drivers/mfd/exynos-lpass.c                              | 17 -----------------
 include/linux/mfd/syscon/exynos5-pmu.h                  |  3 ---
 3 files changed, 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
index c110e118b79f..a8deaee82c44 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
@@ -5,7 +5,6 @@ Required properties:
  - compatible		: "samsung,exynos5433-lpass"
  - reg			: should contain the LPASS top SFR region location
 			  and size
- - samsung,pmu-syscon	: the phandle to the Power Management Unit node
  - #address-cells	: should be 1
  - #size-cells		: should be 1
  - ranges		: must be present
@@ -25,7 +24,6 @@ Example:
 audio-subsystem {
 	compatible = "samsung,exynos5433-lpass";
 	reg = <0x11400000 0x100>, <0x11500000 0x08>;
-	samsung,pmu-syscon = <&pmu_system_controller>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges;
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 2e064fb8826f..17915daa2e80 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
-#include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -51,8 +50,6 @@
 #define  LPASS_INTR_SFR			BIT(0)
 
 struct exynos_lpass {
-	/* pointer to the Power Management Unit regmap */
-	struct regmap *pmu;
 	/* pointer to the LPASS TOP regmap */
 	struct regmap *top;
 };
@@ -81,10 +78,6 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
 	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
 		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
 
-	/* Activate related PADs from retention state */
-	regmap_write(lpass->pmu, EXYNOS5433_PAD_RETENTION_AUD_OPTION,
-		     EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR);
-
 	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
@@ -95,9 +88,6 @@ static void exynos_lpass_disable(struct exynos_lpass *lpass)
 	/* Mask any unmasked IP interrupt sources */
 	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK, 0);
 	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK, 0);
-
-	/* Deactivate related PADs from retention state */
-	regmap_write(lpass->pmu, EXYNOS5433_PAD_RETENTION_AUD_OPTION, 0);
 }
 
 static const struct regmap_config exynos_lpass_reg_conf = {
@@ -131,13 +121,6 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 		return PTR_ERR(lpass->top);
 	}
 
-	lpass->pmu = syscon_regmap_lookup_by_phandle(dev->of_node,
-						"samsung,pmu-syscon");
-	if (IS_ERR(lpass->pmu)) {
-		dev_err(dev, "Failed to lookup PMU regmap\n");
-		return PTR_ERR(lpass->pmu);
-	}
-
 	platform_set_drvdata(pdev, lpass);
 	exynos_lpass_enable(lpass);
 
diff --git a/include/linux/mfd/syscon/exynos5-pmu.h b/include/linux/mfd/syscon/exynos5-pmu.h
index c28ff21ca4d2..0622ae86f9db 100644
--- a/include/linux/mfd/syscon/exynos5-pmu.h
+++ b/include/linux/mfd/syscon/exynos5-pmu.h
@@ -46,7 +46,4 @@
 #define EXYNOS5_MIPI_PHY_S_RESETN		BIT(1)
 #define EXYNOS5_MIPI_PHY_M_RESETN		BIT(2)
 
-#define EXYNOS5433_PAD_RETENTION_AUD_OPTION		(0x3028)
-#define EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR	BIT(28)
-
 #endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_ */
-- 
1.9.1

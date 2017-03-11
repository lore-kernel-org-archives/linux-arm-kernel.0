From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:00:18 +0200
Subject: [PATCH v3 2/5] phy: exynos5: Remove duplicated defines of PHY
 register defines
In-Reply-To: <20170311200021.5827-1-krzk@kernel.org>
References: <20170311200021.5827-1-krzk@kernel.org>
Message-ID: <20170311200021.5827-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phy drivers access PMU region through regmap provided by exynos-pmu
driver.   However there is no need to duplicate defines for PMU
registers.  Instead just use whatever is defined in exynos-regs-pmu.h.

This reduces number of defines and allows removal of one header.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/phy/phy-exynos-dp-video.c           |  1 +
 drivers/phy/phy-exynos5-usbdrd.c            |  1 +
 include/linux/mfd/syscon/exynos5-pmu.h      | 27 ---------------------------
 include/linux/soc/samsung/exynos-regs-pmu.h |  8 ++++++++
 4 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/phy/phy-exynos-dp-video.c b/drivers/phy/phy-exynos-dp-video.c
index 34b06154e5d9..d72193188980 100644
--- a/drivers/phy/phy-exynos-dp-video.c
+++ b/drivers/phy/phy-exynos-dp-video.c
@@ -20,6 +20,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 struct exynos_dp_video_phy_drvdata {
 	u32 phy_ctrl_offset;
diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
index 07ed608905ac..7c896d0cda18 100644
--- a/drivers/phy/phy-exynos5-usbdrd.c
+++ b/drivers/phy/phy-exynos5-usbdrd.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 /* Exynos USB PHY registers */
 #define EXYNOS5_FSEL_9MHZ6		0x0
diff --git a/include/linux/mfd/syscon/exynos5-pmu.h b/include/linux/mfd/syscon/exynos5-pmu.h
index 77c93551ee58..0a4ddabc395e 100644
--- a/include/linux/mfd/syscon/exynos5-pmu.h
+++ b/include/linux/mfd/syscon/exynos5-pmu.h
@@ -12,33 +12,6 @@
 #ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
 #define _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
 
-/* Exynos5 PMU register definitions */
-#define EXYNOS5_HDMI_PHY_CONTROL		(0x700)
-#define EXYNOS5_USBDRD_PHY_CONTROL		(0x704)
-
-/* Exynos5250 specific register definitions */
-#define EXYNOS5_USBHOST_PHY_CONTROL		(0x708)
-#define EXYNOS5_EFNAND_PHY_CONTROL		(0x70c)
-#define EXYNOS5_MIPI_PHY0_CONTROL		(0x710)
-#define EXYNOS5_MIPI_PHY1_CONTROL		(0x714)
-#define EXYNOS5_ADC_PHY_CONTROL			(0x718)
-#define EXYNOS5_MTCADC_PHY_CONTROL		(0x71c)
-#define EXYNOS5_DPTX_PHY_CONTROL		(0x720)
-#define EXYNOS5_SATA_PHY_CONTROL		(0x724)
-
-/* Exynos5420 specific register definitions */
-#define EXYNOS5420_USBDRD1_PHY_CONTROL		(0x708)
-#define EXYNOS5420_USBHOST_PHY_CONTROL		(0x70c)
-#define EXYNOS5420_MIPI_PHY0_CONTROL		(0x714)
-#define EXYNOS5420_MIPI_PHY1_CONTROL		(0x718)
-#define EXYNOS5420_MIPI_PHY2_CONTROL		(0x71c)
-#define EXYNOS5420_ADC_PHY_CONTROL		(0x720)
-#define EXYNOS5420_MTCADC_PHY_CONTROL		(0x724)
-#define EXYNOS5420_DPTX_PHY_CONTROL		(0x728)
-
-/* Exynos5433 specific register definitions */
-#define EXYNOS5433_USBHOST30_PHY_CONTROL	(0x728)
-
 #define EXYNOS5_PHY_ENABLE			BIT(0)
 #define EXYNOS5_MIPI_PHY_S_RESETN		BIT(1)
 #define EXYNOS5_MIPI_PHY_M_RESETN		BIT(2)
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index e57d75889a09..4ee54b3fcd57 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -349,6 +349,8 @@
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				0x0408
 #define EXYNOS5_MASK_WDTRESET_REQUEST				0x040C
+#define EXYNOS5_USBDRD_PHY_CONTROL				0x0704
+#define EXYNOS5_DPTX_PHY_CONTROL				0x0720
 
 #define EXYNOS5_USE_RETENTION			BIT(4)
 #define EXYNOS5_SYS_WDTRESET					(1 << 20)
@@ -502,6 +504,11 @@
 #define EXYNOS5420_KFC_CORE_RESET(_nr)				\
 	((EXYNOS5420_KFC_CORE_RESET0 | EXYNOS5420_KFC_ETM_RESET0) << (_nr))
 
+#define EXYNOS5420_USBDRD1_PHY_CONTROL				0x0708
+#define EXYNOS5420_MIPI_PHY0_CONTROL				0x0714
+#define EXYNOS5420_MIPI_PHY1_CONTROL				0x0718
+#define EXYNOS5420_MIPI_PHY2_CONTROL				0x071C
+#define EXYNOS5420_DPTX_PHY_CONTROL				0x0728
 #define EXYNOS5420_ARM_CORE2_SYS_PWR_REG			0x1020
 #define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG		0x1024
 #define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG	0x1028
@@ -639,6 +646,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
 /* For EXYNOS5433 */
+#define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
 #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
 #define EXYNOS5433_PAD_RETENTION_TOP_OPTION			(0x3108)
-- 
2.9.3

From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 12:07:32 +0200
Subject: [PATCH 3/3] ARM: EXYNOS: Add support for FIMC cam port B GPIO setup on
 Exynos4x12
In-Reply-To: <4648723.rWnut7F0uJ@amdc1227>
References: <4648723.rWnut7F0uJ@amdc1227>
Message-ID: <2273077.MFzyvUNijr@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4x12 SoCs use different GPIO pins for FIMC cam port B and this patch
modifies the setup code to take it into account.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/setup-fimc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-exynos/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
index d74843e..4b0cce5 100644
--- a/arch/arm/mach-exynos/setup-fimc.c
+++ b/arch/arm/mach-exynos/setup-fimc.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
 #include <plat/camport.h>
+#include <plat/cpu.h>
 
 int exynos4_fimc_setup_gpio(enum s5p_camport_id id)
 {
@@ -26,6 +27,22 @@ int exynos4_fimc_setup_gpio(enum s5p_camport_id id)
 		break;
 
 	case S5P_CAMPORT_B:
+		if (soc_is_exynos4212() || soc_is_exynos4412()) {
+			sfn = S3C_GPIO_SFN(3);
+
+			/* PCLK, DATA[0-6] */
+			ret = s3c_gpio_cfgrange_nopull(EXYNOS4X12_GPM0(0), 8, sfn);
+			/* FIELD, DATA[7]*/
+			if (!ret)
+				ret = s3c_gpio_cfgrange_nopull(EXYNOS4X12_GPM1(0),
+							       2, sfn);
+			/* VSYNC, HREF, CLKOUT*/
+			if (!ret)
+				ret = s3c_gpio_cfgrange_nopull(EXYNOS4X12_GPM2(0),
+							       3, sfn);
+			return ret;
+		}
+
 		gpio8 = EXYNOS4210_GPE0(0); /* DATA[0:7] */
 		gpio5 = EXYNOS4210_GPE1(0); /* PCLK, VSYNC, HREF, CLKOUT, FIELD */
 		sfn = S3C_GPIO_SFN(3);
-- 
1.7.12

From: B38611@freescale.com (Fugang Duan)
Date: Thu, 22 Aug 2013 18:56:31 +0800
Subject: [PATCH] ARM: imx6sl: config iomux-gpr1 to select clock for fec
Message-ID: <1377168991-8824-1-git-send-email-B38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Config iomux-gpr1 to select clock source for fec system clock.
Clear gpr1[14], gpr1[18-17] bit to select the fec clock source
from internal anatop PLL.

Signed-off-by: Fugang Duan  <B38611@freescale.com>
---
 arch/arm/mach-imx/mach-imx6sl.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 132db26..e0a8c12 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -11,17 +11,37 @@
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
 
+static void __init imx6sl_fec_init(void)
+{
+	struct regmap *gpr;
+
+	/* set FEC clock from internal PLL clock source */
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6sl-iomuxc-gpr");
+	if (!IS_ERR(gpr)) {
+		regmap_update_bits(gpr, IOMUXC_GPR1,
+			IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK, 0);
+		regmap_update_bits(gpr, IOMUXC_GPR1,
+			IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK, 0);
+	} else
+		pr_err("failed to find fsl,imx6sl-iomux-gpr regmap\n");
+}
+
 static void __init imx6sl_init_machine(void)
 {
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	imx6sl_fec_init();
 }
 
 static void __init imx6sl_init_irq(void)
-- 
1.7.1

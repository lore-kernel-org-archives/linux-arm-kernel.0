From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 15:09:59 +0200
Subject: [PATCH 2/2] ARM: imx6q: Mark VPU and IPU AXI transfers as cacheable,
 increase IPU priority
In-Reply-To: <1369919399-24370-1-git-send-email-mpa@pengutronix.de>
References: <1369919399-24370-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369919399-24370-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This is needed so that the IPU framebuffer scanout cannot be starved
by VPU or GPU activity.
The Freescale SabreLite and SabreSD boards seem to set this in the boot
rom already, but the documented register reset values do not contain
the necessary settings.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx6q.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5536fd8..7bef242 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -29,6 +29,7 @@
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -161,6 +162,36 @@ static void __init imx6q_usb_init(void)
 	imx_anatop_usb_chrg_detect_disable();
 }
 
+static void __init imx6q_gpr_init(void)
+{
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		pr_warn("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
+		return;
+	}
+
+	/* Enable the cacheable attribute of VPU and IPU AXI transactions */
+	regmap_update_bits(gpr, IOMUXC_GPR4, 0,
+			IMX6Q_GPR4_VPU_WR_CACHE_SEL |
+			IMX6Q_GPR4_VPU_RD_CACHE_SEL |
+			IMX6Q_GPR4_VPU_P_WR_CACHE_VAL |
+			IMX6Q_GPR4_VPU_P_RD_CACHE_VAL_MASK |
+			IMX6Q_GPR4_IPU_WR_CACHE_CTL |
+			IMX6Q_GPR4_IPU_RD_CACHE_CTL);
+
+	/* Increase IPU read QoS priority */
+	regmap_update_bits(gpr, IOMUXC_GPR6,
+			IMX6Q_GPR6_IPU1_ID00_RD_QOS_MASK |
+			IMX6Q_GPR6_IPU1_ID01_RD_QOS_MASK,
+			(0xf << 16) | (0x7 << 20));
+	regmap_update_bits(gpr, IOMUXC_GPR7,
+			IMX6Q_GPR7_IPU2_ID00_RD_QOS_MASK |
+			IMX6Q_GPR7_IPU2_ID01_RD_QOS_MASK,
+			(0xf << 16) | (0x7 << 20));
+}
+
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
@@ -172,6 +203,7 @@ static void __init imx6q_init_machine(void)
 	imx6q_pm_init();
 	imx6q_usb_init();
 	imx6q_1588_init();
+	imx6q_gpr_init();
 }
 
 #define OCOTP_CFG3			0x440
-- 
1.8.2.1

From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 14:51:50 +0100
Subject: [PATCH v3 2/2] ARM i.MX6q: Mark VPU and IPU AXI transfers as
 cacheable, increase IPU priority
In-Reply-To: <1393249910-11723-1-git-send-email-p.zabel@pengutronix.de>
References: <1393249910-11723-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393249910-11723-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed so that the IPU framebuffer scanout cannot be
starved by VPU or GPU activity.
Some boards like the SabreLite and SabreSD seem to set this in
the DCD already, but the documented register reset values do not
contain the necessary settings.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Limited to 80 char lines
 - Rebased onto Shawn's for-next
---
 arch/arm/mach-imx/mach-imx6q.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 1e12685..e60456d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -228,6 +228,39 @@ put_node:
 	of_node_put(np);
 }
 
+static void __init imx6q_axi_init(void)
+{
+	struct regmap *gpr;
+	unsigned int mask;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (!IS_ERR(gpr)) {
+		/*
+		 * Enable the cacheable attribute of VPU and IPU
+		 * AXI transactions.
+		 */
+		mask = IMX6Q_GPR4_VPU_WR_CACHE_SEL |
+			IMX6Q_GPR4_VPU_RD_CACHE_SEL |
+			IMX6Q_GPR4_VPU_P_WR_CACHE_VAL |
+			IMX6Q_GPR4_VPU_P_RD_CACHE_VAL_MASK |
+			IMX6Q_GPR4_IPU_WR_CACHE_CTL |
+			IMX6Q_GPR4_IPU_RD_CACHE_CTL;
+		regmap_update_bits(gpr, IOMUXC_GPR4, mask, mask);
+
+		/* Increase IPU read QoS priority */
+		regmap_update_bits(gpr, IOMUXC_GPR6,
+				IMX6Q_GPR6_IPU1_ID00_RD_QOS_MASK |
+				IMX6Q_GPR6_IPU1_ID01_RD_QOS_MASK,
+				(0xf << 16) | (0x7 << 20));
+		regmap_update_bits(gpr, IOMUXC_GPR7,
+				IMX6Q_GPR7_IPU2_ID00_RD_QOS_MASK |
+				IMX6Q_GPR7_IPU2_ID01_RD_QOS_MASK,
+				(0xf << 16) | (0x7 << 20));
+	} else {
+		pr_warn("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
+	}
+}
+
 static void __init imx6q_init_machine(void)
 {
 	struct device *parent;
@@ -248,6 +281,7 @@ static void __init imx6q_init_machine(void)
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
+	imx6q_axi_init();
 }
 
 #define OCOTP_CFG3			0x440
-- 
1.8.5.3

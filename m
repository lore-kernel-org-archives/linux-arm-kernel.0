From: b38611@freescale.com (Fugang Duan)
Date: Wed, 24 Sep 2014 10:11:19 +0800
Subject: [PATCH v1 2/3] ARM: imx: add enet init for i.mx6sx
In-Reply-To: <1411524680-12863-1-git-send-email-b38611@freescale.com>
References: <1411524680-12863-1-git-send-email-b38611@freescale.com>
Message-ID: <1411524680-12863-3-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add enet init for i.mx6sx:
- Add phy ar8031 fixup
- Set enet clock source from internal PLL

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/mach-imx/mach-imx6sx.c |   51 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 3de3b73..9822249 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -8,12 +8,62 @@
 
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
 #include "cpuidle.h"
 
+static int ar8031_phy_fixup(struct phy_device *dev)
+{
+	u16 val;
+
+	/* Set RGMII IO voltage to 1.8V */
+	phy_write(dev, 0x1d, 0x1f);
+	phy_write(dev, 0x1e, 0x8);
+
+	/* introduce tx clock delay */
+	phy_write(dev, 0x1d, 0x5);
+	val = phy_read(dev, 0x1e);
+	val |= 0x0100;
+	phy_write(dev, 0x1e, val);
+
+	return 0;
+}
+
+#define PHY_ID_AR8031   0x004dd074
+static void __init imx6sx_enet_phy_init(void)
+{
+	if (IS_BUILTIN(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
+					   ar8031_phy_fixup);
+}
+
+static void __init imx6sx_enet_clk_sel(void)
+{
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6sx-iomuxc-gpr");
+	if (!IS_ERR(gpr)) {
+		regmap_update_bits(gpr, IOMUXC_GPR1,
+				   IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK, 0);
+		regmap_update_bits(gpr, IOMUXC_GPR1,
+				   IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK, 0);
+	} else {
+		pr_err("failed to find fsl,imx6sx-iomux-gpr regmap\n");
+	}
+}
+
+static inline void imx6sx_enet_init(void)
+{
+	imx6sx_enet_phy_init();
+	imx6sx_enet_clk_sel();
+}
+
 static void __init imx6sx_init_machine(void)
 {
 	struct device *parent;
@@ -26,6 +76,7 @@ static void __init imx6sx_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
+	imx6sx_enet_init();
 	imx_anatop_init();
 	imx6sx_pm_init();
 }
-- 
1.7.8

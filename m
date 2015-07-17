From: b38611@freescale.com (Fugang Duan)
Date: Fri, 17 Jul 2015 16:38:22 +0800
Subject: [PATCH v1 2/4] ARM: imx6ul: add fec MAC refrence clock and phy fixup
 init
In-Reply-To: <1437122304-20598-1-git-send-email-b38611@freescale.com>
References: <1437122304-20598-1-git-send-email-b38611@freescale.com>
Message-ID: <1437122304-20598-3-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FEC MAC refrence clock init.
Add phy fixup init for i.MX6ul 14x14 evk board that installs KSZ8081 phy.
For the phy, there needs extra phy fixup for MII and RMII mode.

Signed-off-by: Fugang Duan <b38611@freescale.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index f206506..d4f8b6c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -9,9 +9,51 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "common.h"
 
+static void __init imx6ul_enet_clk_init(void)
+{
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
+	if (!IS_ERR(gpr))
+		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_ENET_CLK_DIR,
+				   IMX6UL_GPR1_ENET_CLK_OUTPUT);
+	else
+		pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
+
+}
+
+static int ksz8081_phy_fixup(struct phy_device *dev)
+{
+	if (dev && dev->interface == PHY_INTERFACE_MODE_MII) {
+		phy_write(dev, 0x1f, 0x8110);
+		phy_write(dev, 0x16, 0x201);
+	} else if (dev && dev->interface == PHY_INTERFACE_MODE_RMII) {
+		phy_write(dev, 0x1f, 0x8190);
+		phy_write(dev, 0x16, 0x202);
+	}
+
+	return 0;
+}
+
+#define PHY_ID_KSZ8081	0x00221560
+static void __init imx6ul_enet_phy_init(void)
+{
+	phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff, ksz8081_phy_fixup);
+}
+
+static inline void imx6ul_enet_init(void)
+{
+	imx6ul_enet_clk_init();
+	imx6ul_enet_phy_init();
+}
+
 static void __init imx6ul_init_machine(void)
 {
 	struct device *parent;
@@ -21,6 +63,7 @@ static void __init imx6ul_init_machine(void)
 		pr_warn("failed to initialize soc device\n");
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	imx6ul_enet_init();
 	imx_anatop_init();
 }
 
-- 
1.9.1

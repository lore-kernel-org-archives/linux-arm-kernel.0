From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 17 Jul 2013 18:10:21 -0500
Subject: [PATCH 2/4] arm: socfpga: Add platform initialization for ethernet
In-Reply-To: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
Message-ID: <1374102623-4154-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Use the PHYLIB to set the correct clock and skew values to the Micrel PHY. Add
platform specific intilization to put the STMMAC ethernet controller into the
correct PHY mode.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>
---
 arch/arm/mach-socfpga/core.h    |    8 ++++
 arch/arm/mach-socfpga/socfpga.c |   85 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..505b8fe5 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -28,6 +28,14 @@
 #define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
 #define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
 
+#define SYSMGR_EMACGRP_CTRL_OFFSET 0x60
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_WIDTH 2
+
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_MASK 0x00000003
+
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bfce964..abbde76 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -16,10 +16,14 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/irqchip.h>
+#include <linux/micrel_phy.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/reboot.h>
+#include <linux/stmmac.h>
+#include <linux/phy.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
@@ -33,6 +37,22 @@ void __iomem *rst_manager_base_addr;
 void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
+static int stmmac_plat_init(struct platform_device *pdev);
+
+static struct plat_stmmacenet_data stmmacenet0_data = {
+	.init = &stmmac_plat_init,
+};
+
+static struct plat_stmmacenet_data stmmacenet1_data = {
+	.init = &stmmac_plat_init,
+};
+
+static const struct of_dev_auxdata socfpga_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff700000, NULL, &stmmacenet0_data),
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff702000, NULL, &stmmacenet1_data),
+	{/* sentinel */}
+};
+
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
 	.pfn		= 0, /* run-time */
@@ -58,6 +78,65 @@ static void __init socfpga_scu_map_io(void)
 	iotable_init(&scu_io_desc, 1);
 }
 
+static int ksz9021rlrn_phy_fixup(struct phy_device *phydev)
+{
+	if (IS_BUILTIN(CONFIG_PHYLIB)) {
+		/* min rx data delay */
+		phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
+			MICREL_KSZ9021_RGMII_RX_DATA_PAD_SCEW | 0x8000);
+		phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0x0000);
+
+		/* max rx/tx clock delay, min rx/tx control delay */
+		phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
+			MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SCEW | 0x8000);
+		phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0xa0d0);
+		phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL, 0x104);
+	}
+
+	return 0;
+}
+
+static int stmmac_plat_init(struct platform_device *pdev)
+{
+	u32 ctrl, val, shift;
+	int phymode;
+
+	if (of_machine_is_compatible("altr,socfpga-vt"))
+		return 0;
+
+	phymode = of_get_phy_mode(pdev->dev.of_node);
+
+	switch (phymode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
+		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
+		break;
+	default:
+		pr_err("%s bad phy mode %d", __func__, phymode);
+		return -EINVAL;
+	}
+
+	if (&stmmacenet1_data == pdev->dev.platform_data)
+		shift = SYSMGR_EMACGRP_CTRL_PHYSEL_WIDTH;
+	else if (&stmmacenet0_data == pdev->dev.platform_data)
+		shift = 0;
+	else {
+		pr_err("%s unexpected platform data pointer\n", __func__);
+		return -EINVAL;
+	}
+
+	ctrl = readl(sys_manager_base_addr + SYSMGR_EMACGRP_CTRL_OFFSET);
+	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << shift);
+	ctrl |= (val << shift);
+
+	writel(ctrl, (sys_manager_base_addr + SYSMGR_EMACGRP_CTRL_OFFSET));
+
+	return 0;
+}
+
 static void __init socfpga_map_io(void)
 {
 	socfpga_scu_map_io();
@@ -106,9 +185,13 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 static void __init socfpga_cyclone5_init(void)
 {
 	l2x0_of_init(0, ~0UL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+		socfpga_auxdata_lookup, NULL);
 	of_clk_init(NULL);
 	socfpga_init_clocks();
+	if (IS_BUILTIN(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_KSZ9021RLRN,
+			MICREL_PHY_ID_MASK, ksz9021rlrn_phy_fixup);
 }
 
 static const char *altera_dt_match[] = {
-- 
1.7.9.5

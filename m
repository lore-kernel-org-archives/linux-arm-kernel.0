From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 24 Sep 2013 16:12:00 -0500
Subject: [PATCH 2/2] arm: socfpga: Add platform initialization for ethernet
In-Reply-To: <1380057120-27108-1-git-send-email-dinguyen@altera.com>
References: <1380057120-27108-1-git-send-email-dinguyen@altera.com>
Message-ID: <1380057120-27108-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

In order to correctly enable ethernet support on SOCFGPA, a couple of
platform specific initializations steps must be done.

1) Use the phy-mode DTS property to set the appropriate bits in a system
manager register.

2) The ethernet IP should only be brought out of reset when initialized.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-socfpga/core.h    |    9 +++++
 arch/arm/mach-socfpga/socfpga.c |   72 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index b05fa6a..474582b 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -28,6 +28,15 @@
 #define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
 #define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
 
+/* Peripheral Module Reset Register bits */
+#define RSTMGR_PERMODRST_EMAC0  0x1
+#define RSTMGR_PERMODRST_EMAC1  0x2
+
+#define SYSMGR_EMACGRP_CTRL_OFFSET 0x60
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
+#define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
+
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bfce964..fe97423 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -19,7 +19,10 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
 #include <linux/reboot.h>
+#include <linux/stmmac.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
@@ -33,6 +36,24 @@ void __iomem *rst_manager_base_addr;
 void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
+static int stmmac_plat_init(struct platform_device *pdev);
+
+static struct plat_stmmacenet_data stmmacenet0_data = {
+	.init = &stmmac_plat_init,
+	.bus_id = 0,
+};
+
+static struct plat_stmmacenet_data stmmacenet1_data = {
+	.init = &stmmac_plat_init,
+	.bus_id = 1,
+};
+
+static const struct of_dev_auxdata socfpga_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff700000, NULL, &stmmacenet0_data),
+	OF_DEV_AUXDATA("snps,dwmac-3.70a", 0xff702000, NULL, &stmmacenet1_data),
+	{ /* sentinel */ }
+};
+
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
 	.pfn		= 0, /* run-time */
@@ -47,6 +68,54 @@ static struct map_desc uart_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
+static int stmmac_plat_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 ctrl, val;
+	u32 rstmask, sysmgr_phymask;
+	int phymode;
+
+	if (of_machine_is_compatible("altr,socfpga-vt"))
+		return 0;
+
+	phymode = of_get_phy_mode(np);
+	if (of_property_read_u32(np, "altr,sysmgr-phy-mask", &sysmgr_phymask))
+		pr_err("GMAC: No altr,sysmgr-phy-mask property found!\n");
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
+	if (sysmgr_phymask == 0xC) {
+		/* gmac1 */
+		val |= (val << 2);
+		rstmask = RSTMGR_PERMODRST_EMAC1;
+	} else
+		rstmask = RSTMGR_PERMODRST_EMAC0;
+
+	/* Set the PHY mode in the system manager.*/
+	ctrl = readl(sys_manager_base_addr + SYSMGR_EMACGRP_CTRL_OFFSET);
+	ctrl &= ~sysmgr_phymask;
+	ctrl |= val;
+	writel(ctrl, (sys_manager_base_addr + SYSMGR_EMACGRP_CTRL_OFFSET));
+
+	/* Bring the appropriate ethernet ip out of reset.*/
+	ctrl = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_MODPERRST);
+	ctrl &= ~rstmask;
+	writel(ctrl, rst_manager_base_addr + SOCFPGA_RSTMGR_MODPERRST);
+
+	return 0;
+}
+
 static void __init socfpga_scu_map_io(void)
 {
 	unsigned long base;
@@ -106,7 +175,8 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 static void __init socfpga_cyclone5_init(void)
 {
 	l2x0_of_init(0, ~0UL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+		socfpga_auxdata_lookup, NULL);
 	of_clk_init(NULL);
 	socfpga_init_clocks();
 }
-- 
1.7.9.5

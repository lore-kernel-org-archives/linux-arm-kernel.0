From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:06 -0600
Subject: [PATCHv2 10/11] ARM: socfpga: Enable Arria10 L2 cache ECC on startup
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-11-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Enable ECC for Arria10 L2 cache on machine startup. The ECC has to be
enabled before data is stored in memory otherwise the ECC will fail
on reads.
Use DT_MACHINE to select Arria10 L2 cache function.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split into 2 separate functions selected with DT_MACHINE.
---
 arch/arm/mach-socfpga/core.h     |    1 +
 arch/arm/mach-socfpga/l2_cache.c |   49 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c  |   10 +++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 575195b..bfbc78d 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -38,6 +38,7 @@ extern void socfpga_init_clocks(void);
 extern void socfpga_sysmgr_init(void);
 void socfpga_init_l2_ecc(void);
 void socfpga_init_ocram_ecc(void);
+void socfpga_init_arria10_l2_ecc(void);
 
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
index e3907ab..4267c95f 100644
--- a/arch/arm/mach-socfpga/l2_cache.c
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -17,6 +17,20 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 
+#include "core.h"
+
+/* A10 System Manager L2 ECC Control register */
+#define A10_MPU_CTRL_L2_ECC_OFST          0x0
+#define A10_MPU_CTRL_L2_ECC_EN            BIT(0)
+
+/* A10 System Manager Global IRQ Mask register */
+#define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
+#define A10_SYSMGR_ECC_INTMASK_CLR_L2     BIT(0)
+
+/* A10 System Manager L2 ECC IRQ Clear register */
+#define A10_SYSMGR_MPU_CLEAR_L2_ECC_OFST  0xA8
+#define A10_SYSMGR_MPU_CLEAR_L2_ECC       (BIT(31) | BIT(15))
+
 void socfpga_init_l2_ecc(void)
 {
 	struct device_node *np;
@@ -39,3 +53,38 @@ void socfpga_init_l2_ecc(void)
 	writel(0x01, mapped_l2_edac_addr);
 	iounmap(mapped_l2_edac_addr);
 }
+
+void socfpga_init_arria10_l2_ecc(void)
+{
+	struct device_node *np;
+	void __iomem *mapped_l2_edac_addr;
+
+	/* Find the L2 EDAC device tree node */
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-a10-l2-ecc");
+	if (!np) {
+		pr_err("Unable to find socfpga-a10-l2-ecc in dtb\n");
+		return;
+	}
+
+	mapped_l2_edac_addr = of_iomap(np, 0);
+	of_node_put(np);
+	if (!mapped_l2_edac_addr) {
+		pr_err("Unable to find L2 ECC mapping in dtb\n");
+		return;
+	}
+
+	if (!sys_manager_base_addr) {
+		pr_err("System Mananger not mapped for L2 ECC\n");
+		goto exit;
+	}
+	/* Clear any pending IRQs */
+	writel(A10_SYSMGR_MPU_CLEAR_L2_ECC, (sys_manager_base_addr +
+	       A10_SYSMGR_MPU_CLEAR_L2_ECC_OFST));
+	/* Enable ECC */
+	writel(A10_SYSMGR_ECC_INTMASK_CLR_L2, sys_manager_base_addr +
+	       A10_SYSMGR_ECC_INTMASK_CLR_OFST);
+	writel(A10_MPU_CTRL_L2_ECC_EN, mapped_l2_edac_addr +
+	       A10_MPU_CTRL_L2_ECC_OFST);
+exit:
+	iounmap(mapped_l2_edac_addr);
+}
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 7e0aad2..e9b5b60 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -66,6 +66,14 @@ static void __init socfpga_init_irq(void)
 		socfpga_init_ocram_ecc();
 }
 
+static void __init socfpga_arria10_init_irq(void)
+{
+	irqchip_init();
+	socfpga_sysmgr_init();
+	if (IS_ENABLED(CONFIG_EDAC_ALTERA_L2C))
+		socfpga_init_arria10_l2_ecc();
+}
+
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 temp;
@@ -113,7 +121,7 @@ static const char *altera_a10_dt_match[] = {
 DT_MACHINE_START(SOCFPGA_A10, "Altera SOCFPGA Arria10")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.init_irq	= socfpga_init_irq,
+	.init_irq	= socfpga_arria10_init_irq,
 	.restart	= socfpga_arria10_restart,
 	.dt_compat	= altera_a10_dt_match,
 MACHINE_END
-- 
1.7.9.5

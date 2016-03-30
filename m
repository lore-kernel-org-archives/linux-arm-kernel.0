From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 30 Mar 2016 10:27:47 -0500
Subject: [PATCH 6/7] ARM: socfpga: Enable Arria10 OCRAM ECC on startup
In-Reply-To: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
References: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1459351668-14622-7-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Enable ECC for Arria10 On-Chip RAM on machine startup. The ECC has to be
enabled before data is stored in memory otherwise the ECC will fail
on reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/mach-socfpga/core.h    |    1 +
 arch/arm/mach-socfpga/ocram.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c |    2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index bfbc78d..65e1817 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -39,6 +39,7 @@ extern void socfpga_sysmgr_init(void);
 void socfpga_init_l2_ecc(void);
 void socfpga_init_ocram_ecc(void);
 void socfpga_init_arria10_l2_ecc(void);
+void socfpga_init_arria10_ocram_ecc(void);
 
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
index 60ec643..e9d0982 100644
--- a/arch/arm/mach-socfpga/ocram.c
+++ b/arch/arm/mach-socfpga/ocram.c
@@ -19,6 +19,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
+#include "../drivers/edac/altera_edac.h"
+
 #define ALTR_OCRAM_CLEAR_ECC          0x00000018
 #define ALTR_OCRAM_ECC_EN             0x00000019
 
@@ -47,3 +49,23 @@ void socfpga_init_ocram_ecc(void)
 
 	iounmap(mapped_ocr_edac_addr);
 }
+
+void socfpga_init_arria10_ocram_ecc(void)
+{
+	struct device_node *np;
+	int ret;
+
+	/* Find the OCRAM EDAC device tree node */
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-a10-ocram-ecc");
+	if (!np) {
+		pr_err("Unable to find socfpga-a10-ocram-ecc\n");
+		return;
+	}
+
+	ret = altr_init_a10_ecc_block(np, A10_SYSMGR_ECC_INTSTAT_OCRAM,
+				      ALTR_A10_OCRAM_ECC_EN_CTL, 0);
+	if (ret)
+		pr_err("Unable to initialize OCRAM\n");
+
+	of_node_put(np);
+}
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index e9b5b60..dde14f7 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -72,6 +72,8 @@ static void __init socfpga_arria10_init_irq(void)
 	socfpga_sysmgr_init();
 	if (IS_ENABLED(CONFIG_EDAC_ALTERA_L2C))
 		socfpga_init_arria10_l2_ecc();
+	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
+		socfpga_init_arria10_ocram_ecc();
 }
 
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.9.5

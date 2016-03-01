From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 1 Mar 2016 10:38:20 -0600
Subject: [PATCH 4/5] ARM: socfpga: Enable Arria10 L2 cache ECC on startup
In-Reply-To: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
References: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1456850301-22066-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Enable ECC for Arria10 L2 cache on machine startup. The ECC has to be
enabled before data is stored in memory otherwise the ECC will fail
on reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/mach-socfpga/l2_cache.c |   42 ++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
index e3907ab..b197218 100644
--- a/arch/arm/mach-socfpga/l2_cache.c
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -17,14 +17,31 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 
+#include "core.h"
+
+/* A10 System Manager ECC interrupt mask control registers */
+#define A10_L2_ECC_CTRL_OFST            0x0
+
+#define A10_SYSMGR_ECC_INTMASK_CLR_OFST 0x98
+#define A10_L2_ECC_INT_CLR_OFST         0xA8
+
+#define A10_MPU_CTRL_L2_ECC_EN          BIT(0)
+#define A10_ECC_INTMASK_CLR_EN          BIT(0)
+#define A10_ECC_INT_CLR                 (BIT(31) | BIT(15))
+
 void socfpga_init_l2_ecc(void)
 {
 	struct device_node *np;
 	void __iomem *mapped_l2_edac_addr;
+	const char *compat = "altr,socfpga-l2-ecc";
 
-	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-l2-ecc");
+	if (of_machine_is_compatible("altr,socfpga-arria10"))
+		compat = "altr,socfpga-a10-l2-ecc";
+
+	/* Find the L2 EDAC device tree node */
+	np = of_find_compatible_node(NULL, NULL, compat);
 	if (!np) {
-		pr_err("Unable to find socfpga-l2-ecc in dtb\n");
+		pr_err("Unable to find %s in dtb\n", compat);
 		return;
 	}
 
@@ -35,7 +52,24 @@ void socfpga_init_l2_ecc(void)
 		return;
 	}
 
-	/* Enable ECC */
-	writel(0x01, mapped_l2_edac_addr);
+	if (of_machine_is_compatible("altr,socfpga-arria10")) {
+		if (!sys_manager_base_addr) {
+			pr_err("System Mananger not mapped for L2 ECC\n");
+			goto exit;
+		}
+		/* Clear any pending IRQs */
+		writel(A10_ECC_INT_CLR, (sys_manager_base_addr +
+					 A10_L2_ECC_INT_CLR_OFST));
+		/* Enable ECC */
+		writel(A10_ECC_INTMASK_CLR_EN, sys_manager_base_addr +
+		       A10_SYSMGR_ECC_INTMASK_CLR_OFST);
+		writel(A10_MPU_CTRL_L2_ECC_EN, mapped_l2_edac_addr +
+		       A10_L2_ECC_CTRL_OFST);
+	} else {
+		/* Enable ECC */
+		writel(0x01, mapped_l2_edac_addr);
+	}
+
+exit:
 	iounmap(mapped_l2_edac_addr);
 }
-- 
1.7.9.5

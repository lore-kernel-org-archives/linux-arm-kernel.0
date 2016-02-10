From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 10 Feb 2016 13:26:24 -0600
Subject: [PATCHv10 4/4] ARM: socfpga: Enable OCRAM ECC on startup
In-Reply-To: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
References: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1455132384-17108-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch enables the ECC for On-Chip RAM on machine startup. The ECC
has to be enabled before data is stored in memory otherwise the ECC will
fail on reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v10: No change
v9:  Improve node release handling.
v8:  Address community comments on strings. Fix match strings based
     on maintainer feedback. Update year in header.
v7:  enable OCRAM ECC during platform init
v6:  Implement OCRAM discovery changes from community. Add
     of_node_put(). Remove be32_to_cpup(). Use __init() which
     allows removal of .init_machine(). Update year in header.
---
 arch/arm/mach-socfpga/Makefile  |    1 +
 arch/arm/mach-socfpga/core.h    |    1 +
 arch/arm/mach-socfpga/ocram.c   |   49 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c |    3 +++
 4 files changed, 54 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/ocram.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index e9ab7c9..ed15db1 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -6,3 +6,4 @@ obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
 obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
 obj-$(CONFIG_EDAC_ALTERA_L2C)	+= l2_cache.o
+obj-$(CONFIG_EDAC_ALTERA_OCRAM)	+= ocram.o
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index eb55d66..575195b 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -37,6 +37,7 @@
 extern void socfpga_init_clocks(void);
 extern void socfpga_sysmgr_init(void);
 void socfpga_init_l2_ecc(void);
+void socfpga_init_ocram_ecc(void);
 
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
new file mode 100644
index 0000000..60ec643
--- /dev/null
+++ b/arch/arm/mach-socfpga/ocram.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright Altera Corporation (C) 2016. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/io.h>
+#include <linux/genalloc.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#define ALTR_OCRAM_CLEAR_ECC          0x00000018
+#define ALTR_OCRAM_ECC_EN             0x00000019
+
+void socfpga_init_ocram_ecc(void)
+{
+	struct device_node *np;
+	void __iomem *mapped_ocr_edac_addr;
+
+	/* Find the OCRAM EDAC device tree node */
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-ocram-ecc");
+	if (!np) {
+		pr_err("Unable to find socfpga-ocram-ecc\n");
+		return;
+	}
+
+	mapped_ocr_edac_addr = of_iomap(np, 0);
+	of_node_put(np);
+	if (!mapped_ocr_edac_addr) {
+		pr_err("Unable to map OCRAM ecc regs.\n");
+		return;
+	}
+
+	/* Clear any pending OCRAM ECC interrupts, then enable ECC */
+	writel(ALTR_OCRAM_CLEAR_ECC, mapped_ocr_edac_addr);
+	writel(ALTR_OCRAM_ECC_EN, mapped_ocr_edac_addr);
+
+	iounmap(mapped_ocr_edac_addr);
+}
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dd1ff07..7e0aad2 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -61,6 +61,9 @@ static void __init socfpga_init_irq(void)
 	socfpga_sysmgr_init();
 	if (IS_ENABLED(CONFIG_EDAC_ALTERA_L2C))
 		socfpga_init_l2_ecc();
+
+	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
+		socfpga_init_ocram_ecc();
 }
 
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.9.5

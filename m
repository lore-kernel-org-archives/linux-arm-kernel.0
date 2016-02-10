From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 10 Feb 2016 13:26:23 -0600
Subject: [PATCHv10 3/4] ARM: socfpga: enable L2 cache ECC on startup
In-Reply-To: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
References: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1455132384-17108-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch enables the ECC for L2 cache on machine startup. The ECC has to
be enabled before data is stored in memory otherwise the ECC will fail on
reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v10: No change
v9:  Improve node put handling.
v8:  Address community suggestions for strings. Fix string based on
     maintainer feedback. Update year in header.
v7:  unmap locally scoped mapped_l2_edac_addr and add of_node_put(np)
v6:  Remove pr_debug() & update year in header.
---
 arch/arm/mach-socfpga/Makefile   |    1 +
 arch/arm/mach-socfpga/core.h     |    1 +
 arch/arm/mach-socfpga/l2_cache.c |   41 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c  |    2 ++
 4 files changed, 45 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/l2_cache.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index b8f9e23..e9ab7c9 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -5,3 +5,4 @@
 obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
 obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
+obj-$(CONFIG_EDAC_ALTERA_L2C)	+= l2_cache.o
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 5bc6ea8..eb55d66 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -36,6 +36,7 @@
 
 extern void socfpga_init_clocks(void);
 extern void socfpga_sysmgr_init(void);
+void socfpga_init_l2_ecc(void);
 
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
new file mode 100644
index 0000000..e3907ab
--- /dev/null
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -0,0 +1,41 @@
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
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+void socfpga_init_l2_ecc(void)
+{
+	struct device_node *np;
+	void __iomem *mapped_l2_edac_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-l2-ecc");
+	if (!np) {
+		pr_err("Unable to find socfpga-l2-ecc in dtb\n");
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
+	/* Enable ECC */
+	writel(0x01, mapped_l2_edac_addr);
+	iounmap(mapped_l2_edac_addr);
+}
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index a1c0efa..dd1ff07 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -59,6 +59,8 @@ static void __init socfpga_init_irq(void)
 {
 	irqchip_init();
 	socfpga_sysmgr_init();
+	if (IS_ENABLED(CONFIG_EDAC_ALTERA_L2C))
+		socfpga_init_l2_ecc();
 }
 
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.9.5

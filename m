From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 11 Nov 2014 18:14:20 -0600
Subject: [PATCHv5 2/5] arm: socfpga: Enable OCRAM ECC on startup.
In-Reply-To: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
References: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1415751263-1830-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch enables the ECC for On-Chip RAM on machine
startup.  The ECC has to be enabled before data is
is stored in memory otherwise the ECC will fail on
reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split OCRAM ECC portion separately. Addition of iounmap()
and reorganization of gen_pool_free. Remove defconfig from patch.

v3/4: No change

v5: Remove ocram.h, use io.h instead of clk-provider.h
    Check prop in correct place. Add ECC EN defines.
---
 arch/arm/mach-socfpga/Makefile  |    1 +
 arch/arm/mach-socfpga/core.h    |    1 +
 arch/arm/mach-socfpga/ocram.c   |   90 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c |    9 ++++
 4 files changed, 101 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/ocram.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 142609e..1552ca5 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -5,3 +5,4 @@
 obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
 obj-$(CONFIG_EDAC_ALTERA_L2C) += l2_cache.o
+obj-$(CONFIG_EDAC_ALTERA_OCRAM) += ocram.o
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 385baba..f3eee32 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -45,5 +45,6 @@ extern unsigned long cpu1start_addr;
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
 void socfpga_init_l2_ecc(void);
+void socfpga_init_ocram_ecc(void);
 
 #endif
diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
new file mode 100644
index 0000000..a83b34f
--- /dev/null
+++ b/arch/arm/mach-socfpga/ocram.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright Altera Corporation (C) 2014. All rights reserved.
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
+#include <linux/of_platform.h>
+
+#define ALTR_OCRAM_CLEAR_ECC          0x00000018
+#define ALTR_OCRAM_ECC_EN             0x00000019
+
+void socfpga_init_ocram_ecc(void)
+{
+	struct device_node *np;
+	const __be32 *prop;
+	u32 ocr_edac_addr, iram_addr, len;
+	void __iomem  *mapped_ocr_edac_addr;
+	size_t size;
+	struct gen_pool *gp;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,ocram-edac");
+	if (!np) {
+		pr_err("SOCFPGA: Unable to find altr,ocram-edac in dtb\n");
+		return;
+	}
+
+	prop = of_get_property(np, "reg", &size);
+	if (!prop || size < sizeof(*prop)) {
+		pr_err("SOCFPGA: Unable to find OCRAM ECC mapping in dtb\n");
+		return;
+	}
+	ocr_edac_addr = be32_to_cpup(prop++);
+	len = be32_to_cpup(prop);
+
+	gp = of_get_named_gen_pool(np, "iram", 0);
+	if (!gp) {
+		pr_err("SOCFPGA: OCRAM cannot find gen pool\n");
+		return;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "mmio-sram");
+	if (!np) {
+		pr_err("SOCFPGA: Unable to find mmio-sram in dtb\n");
+		return;
+	}
+
+	/* Determine the OCRAM address and size */
+	prop = of_get_property(np, "reg", &size);
+	if (!prop || size < sizeof(*prop)) {
+		pr_err("SOCFPGA: Unable to find OCRAM mapping in dtb\n");
+		return;
+	}
+	iram_addr = be32_to_cpup(prop++);
+	len = be32_to_cpup(prop);
+
+	iram_addr = gen_pool_alloc(gp, len);
+	if (iram_addr == 0) {
+		pr_err("SOCFPGA: cannot alloc from gen pool\n");
+		return;
+	}
+
+	memset((void *)iram_addr, 0, len);
+
+	gen_pool_free(gp, iram_addr, len);
+
+	mapped_ocr_edac_addr = ioremap(ocr_edac_addr, 4);
+	if (!mapped_ocr_edac_addr) {
+		pr_err("SOCFPGA: Unable to map OCRAM ecc regs.\n");
+		return;
+	}
+
+	/* Clear any pending OCRAM ECC interrupts, then enable ECC */
+	writel(ALTR_OCRAM_CLEAR_ECC, mapped_ocr_edac_addr);
+	writel(ALTR_OCRAM_ECC_EN, mapped_ocr_edac_addr);
+
+	iounmap(mapped_ocr_edac_addr);
+
+	pr_debug("SOCFPGA: Success Initializing OCRAM\n");
+}
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 0954011..065d80d 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -100,6 +100,14 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
+static void __init socfpga_cyclone5_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     NULL, NULL);
+	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
+		socfpga_init_ocram_ecc();
+}
+
 static const char *altera_dt_match[] = {
 	"altr,socfpga",
 	NULL
@@ -111,6 +119,7 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
 	.init_irq	= socfpga_init_irq,
+	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
 MACHINE_END
-- 
1.7.9.5

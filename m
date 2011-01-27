From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 12:48:10 +0100
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
Message-ID: <1296128890-18765-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a small piece of code that displays some basic FPGA
characteristics for the Integrator, Versatile, RealView and
Versatile Express reference platforms. Tested on RealView
variants.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-versatile/Makefile  |    2 +-
 arch/arm/plat-versatile/fpga-id.c |  173 +++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-versatile/fpga-id.c

diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 16dde08..2d4f8aa 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-obj-y	:= clock.o
+obj-y	:= clock.o fpga-id.o
 ifneq ($(CONFIG_ARCH_INTEGRATOR),y)
 obj-y	+= sched-clock.o
 endif
diff --git a/arch/arm/plat-versatile/fpga-id.c b/arch/arm/plat-versatile/fpga-id.c
new file mode 100644
index 0000000..e541715
--- /dev/null
+++ b/arch/arm/plat-versatile/fpga-id.c
@@ -0,0 +1,173 @@
+/*
+ * Some simple code to read out the FPGA ID of the Integrator,
+ * Versatile, RealView or RealView Express systems during boot
+ * and print it to the console.
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+struct versatile_fpga_id {
+	u8 man:4;
+	u8 rev:4;
+	u16 board:12;
+	u8 var:4;
+	u8 arch:4;
+	u8 fpga_build;
+};
+
+static struct versatile_fpga_id fpga_id;
+
+static inline bool machine_is_versatile(void)
+{
+	return machine_is_versatile_pb() ||
+		machine_is_versatile_ab();
+
+}
+
+static inline bool machine_is_realview(void)
+{
+	return machine_is_realview_eb() ||
+		machine_is_realview_pb11mp() ||
+		machine_is_realview_pb1176() ||
+		machine_is_realview_pba8() ||
+		machine_is_realview_pbx();
+}
+
+static inline bool integrator_or_versatile(void)
+{
+	return machine_is_integrator() ||
+		machine_is_versatile();
+}
+
+void __init versatile_fpga_probe(void)
+{
+	u32 val;
+	void __iomem *sysid_reg;
+
+	/*
+	 * The #ifdef statements here are for supporting multiarch
+	 * builds gracefully.
+	 */
+	if (machine_is_integrator())
+#ifdef CONFIG_ARCH_INTEGRATOR
+		sysid_reg = __io_address(INTEGRATOR_SC_ID);
+#else
+		return;
+#endif
+	else if (machine_is_versatile())
+#ifdef CONFIG_ARCH_VERSATILE
+		sysid_reg = __io_address(VERSATILE_SYS_ID);
+#else
+		return;
+#endif
+	else if (machine_is_realview())
+#ifdef CONFIG_ARCH_REALVIEW
+		sysid_reg = __io_address(REALVIEW_SYS_ID);
+#else
+		return;
+#endif
+	else if (machine_is_vexpress())
+#ifdef CONFIG_ARCH_VEXPRESS
+		sysid_reg = MMIO_P2V(V2M_SYS_ID);
+#else
+		return;
+#endif
+	else
+		return;
+
+	val = readl(sysid_reg);
+	/* The Integrator and Versatile have an older register layout */
+	if (machine_is_integrator()) {
+		fpga_id.man = (val >> 24) & 0x0FU;
+		fpga_id.board = (val >> 12) & 0x0FU;
+		fpga_id.arch = (val >> 16) & 0x0FF;
+		fpga_id.fpga_build = (val >> 4) & 0xFFU;
+		fpga_id.rev = val & 0x0FU;
+	} else if (machine_is_versatile()) {
+		/* Versatile PB is for example 0x41007004 */
+		fpga_id.man = (val >> 24) & 0x0FU;
+		fpga_id.board = (val >> 12) & 0x0FU;
+		fpga_id.arch = val & 0x0FU;
+		fpga_id.fpga_build = (val >> 4) & 0xFFU;
+	} else {
+		/* RealView or Versatile Express */
+		fpga_id.rev = (val >> 28) & 0x0FU;
+		fpga_id.board = (val >> 16) & 0xFFFU;
+		fpga_id.var = (val >> 12) & 0x0FU;
+		fpga_id.arch = (val >> 8) & 0x0FU;
+		fpga_id.fpga_build = val & 0xFFU;
+	}
+
+	pr_info("RealView system FPGA\n");
+
+	/* Manufacturer */
+	if (integrator_or_versatile())
+		pr_info("    manufacturer: %02x\n", fpga_id.man);
+
+	/* Single letter revision */
+	if (fpga_id.rev == 0x0F)
+		pr_info("    revision: ALL\n");
+	else
+		pr_info("    revision: %c\n", 'A' + fpga_id.rev);
+
+	switch (fpga_id.board) {
+	case 1:
+		/* Integrator */
+		pr_info("    board: XC4062\n");
+		break;
+	case 2:
+		/* Integrator */
+		pr_info("    board: XC4085\n");
+		break;
+	case 7:
+		/* Versatile */
+		pr_info("    board: XC2V2000\n");
+		break;
+	default:
+		/*
+		 * This is BCD-coded according to the PBX-A9 manual
+		 * and examples, IDs used in RealView and Versatile
+		 * Express.
+		 */
+		pr_info("    board: HBI-%03x\n", fpga_id.board);
+		break;
+	}
+
+	/* Single letter variant */
+	if (!integrator_or_versatile()) {
+		if (fpga_id.var == 0x0F)
+			pr_info("    variant: ALL\n");
+		else
+			pr_info("    variant: %c\n", 'A' + fpga_id.rev);
+	}
+
+	switch (fpga_id.arch) {
+	case 0:
+		pr_info("    architecture: ASB LE\n");
+		break;
+	case 1:
+		pr_info("    architecture: AHB LE\n");
+		break;
+	case 4:
+		pr_info("    architecture: AHB\n");
+		break;
+	case 5:
+		pr_info("    architecture: AXI\n");
+		break;
+	default:
+		pr_info("    architecture: %01x (unknown)\n", fpga_id.arch);
+		break;
+	}
+
+	/* This is BCD-coded according to the PBX-A9 manual */
+	pr_info("    FPGA build %02x\n", fpga_id.fpga_build);
+}
+
+arch_initcall(versatile_fpga_probe);
-- 
1.7.3.2

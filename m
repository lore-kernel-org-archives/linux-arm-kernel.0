From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 18 Jun 2015 15:09:49 -0400
Subject: [PATCH] ARM: keystone: ecc: add ddr3 ecc interrupt handling
Message-ID: <1434654589-28157-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM L1/L2 ECC handler support and DDR3 ECC interrupt
handling for Keystone II devices, the kernel will reboot if the error
is 2-bit error for DDR ECC or L1/L2 ECC error.

Signed-off-by: Hao Zhang <hzhang@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mach-keystone/Makefile       |  2 +-
 arch/arm/mach-keystone/keystone.c     | 63 ++++++++++++++++++++++++--
 arch/arm/mach-keystone/keystone.h     |  1 +
 arch/arm/mach-keystone/keystone_ecc.c | 85 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-keystone/platsmp.c      |  3 +-
 5 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-keystone/keystone_ecc.c

diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index 25d9239..ea3b9a2 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1,4 +1,4 @@
-obj-y					:= keystone.o smc.o
+obj-y					:= keystone.o smc.o keystone_ecc.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 0662087..e501a78 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -9,19 +9,24 @@
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
  */
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 #include <linux/of.h>
-#include <linux/init.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/memblock.h>
+#include <linux/reboot.h>
 
-#include <asm/setup.h>
+#include <asm/dma-mapping.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/smp_plat.h>
 #include <asm/memory.h>
+#include <asm/setup.h>
+#include <asm/smp_plat.h>
 
 #include "memory.h"
 
@@ -49,6 +54,56 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#define L2_INTERN_ASYNC_ERROR  BIT(30)
+
+static irqreturn_t arm_l1l2_ecc_err_irq_handler(int irq, void *reg_virt)
+{
+	int ret = IRQ_NONE;
+	u32 status, fault;
+
+	/* read and clear L2ECTLR CP15 register for L2 ECC error */
+	asm("mrc p15, 1, %0, c9, c0, 3" : "=r"(status));
+
+	if (status & L2_INTERN_ASYNC_ERROR) {
+		status &= ~L2_INTERN_ASYNC_ERROR;
+		asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));
+		asm("mcr p15, 0, %0, c5, c1, 0" : "=r" (fault));
+		/*
+		 * Do a machine restart as this is double bit ECC error
+		 * that can't be corrected
+		 */
+		pr_err("ARM Cortex A15 L1/L2 ECC error, CP15 ADFSR 0x%x\n",
+		       fault);
+		machine_restart(NULL);
+		ret = IRQ_HANDLED;
+	}
+	return ret;
+}
+
+static int __init keystone_init_misc(void)
+{
+	struct device_node *node = NULL;
+	int error_irq = 0;
+	int ret;
+
+	/* add ARM ECC L1/L2 cache error handler */
+	node = of_find_compatible_node(NULL, NULL, "ti,keystone-sys");
+	if (node)
+		error_irq = irq_of_parse_and_map(node, 0);
+	if (!error_irq) {
+		pr_warn("Warning!! arm L1/L2 ECC irq number not defined\n");
+		return 0;
+	}
+	if (request_irq(error_irq, arm_l1l2_ecc_err_irq_handler, 0,
+		"a15-l1l2-ecc-err-irq", 0) < 0) {
+		WARN_ON("request_irq fail for arm L1/L2 ECC error irq\n");
+	}
+
+	ret = keystone_init_ddr3_ecc(node);
+	return ret;
+}
+subsys_initcall(keystone_init_misc);
+
 static void __init keystone_init(void)
 {
 	keystone_pm_runtime_init();
diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
index cd04a1c..ff52243 100644
--- a/arch/arm/mach-keystone/keystone.h
+++ b/arch/arm/mach-keystone/keystone.h
@@ -19,6 +19,7 @@ extern struct smp_operations keystone_smp_ops;
 extern void secondary_startup(void);
 extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
 extern int keystone_pm_runtime_init(void);
+extern int keystone_init_ddr3_ecc(struct device_node *node);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __KEYSTONE_H__ */
diff --git a/arch/arm/mach-keystone/keystone_ecc.c b/arch/arm/mach-keystone/keystone_ecc.c
new file mode 100644
index 0000000..a42fadb
--- /dev/null
+++ b/arch/arm/mach-keystone/keystone_ecc.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright 2014 Texas Instruments, Inc.
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
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/reboot.h>
+#include "keystone.h"
+
+/* DDR3 controller registers */
+#define DDR3_EOI			0x0A0
+#define DDR3_IRQ_STATUS_RAW_SYS		0x0A4
+#define DDR3_IRQ_STATUS_SYS		0x0AC
+#define DDR3_IRQ_ENABLE_SET_SYS		0x0B4
+#define DDR3_IRQ_ENABLE_CLR_SYS		0x0BC
+#define DDR3_ECC_CTRL			0x110
+#define DDR3_ONE_BIT_ECC_ERR_CNT	0x130
+
+#define DDR3_1B_ECC_ERR			BIT(5)
+#define DDR3_2B_ECC_ERR			BIT(4)
+#define DDR3_WR_ECC_ERR			BIT(3)
+
+static irqreturn_t ddr3_ecc_err_irq_handler(int irq, void *reg_virt)
+{
+	int ret = IRQ_NONE;
+	u32 irq_status;
+	void __iomem *ddr_reg = (void __iomem *)reg_virt;
+
+	irq_status = readl(ddr_reg + DDR3_IRQ_STATUS_SYS);
+	if ((irq_status & DDR3_2B_ECC_ERR) ||
+	    (irq_status & DDR3_WR_ECC_ERR)) {
+		pr_err("Unrecoverable DDR3 ECC error, irq status 0x%x, rebooting kernel ..\n",
+		       irq_status);
+		machine_restart(NULL);
+		ret = IRQ_HANDLED;
+	}
+	return ret;
+}
+
+int keystone_init_ddr3_ecc(struct device_node *node)
+{
+	void __iomem *ddr_reg;
+	int error_irq = 0;
+	int ret;
+
+	/* ddr3 controller reg is configured in the sysctrl node at index 0 */
+	ddr_reg = of_iomap(node, 0);
+	if (!ddr_reg) {
+		pr_warn("Warning!! DDR3 controller regs not defined\n");
+		return -ENODEV;
+	}
+
+	/* add DDR3 ECC error handler */
+	error_irq = irq_of_parse_and_map(node, 1);
+	if (!error_irq) {
+		/* No GIC interrupt, need to map CIC2 interrupt to GIC */
+		pr_warn("Warning!! DDR3 ECC irq number not defined\n");
+		return -ENODEV;
+	}
+
+	ret = request_irq(error_irq, ddr3_ecc_err_irq_handler, 0,
+		"ddr3-ecc-err-irq", (void *)ddr_reg);
+	if (ret) {
+		WARN_ON("request_irq fail for DDR3 ECC error irq\n");
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5f46a7c..07402b9 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -13,8 +13,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
 
 #include <asm/smp_plat.h>
 #include <asm/prom.h>
-- 
1.9.1

From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 10:31:50 -0400
Subject: [PATCH v2 3/3] ARM: keystone: ecc: add DDR3 ecc interrupt handling
In-Reply-To: <1435242710-31346-1-git-send-email-vitalya@ti.com>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
Message-ID: <1435242710-31346-4-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DDR3 ECC handler support interrupt handling
for Keystone II devices, the kernel will reboot if the error
is 2-bit error for DDR3 ECC error.

Signed-off-by: Hao Zhang <hzhang@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 .../devicetree/bindings/arm/keystone/keystone.txt  |  17 +++
 arch/arm/mach-keystone/Makefile                    |   2 +-
 arch/arm/mach-keystone/keystone.c                  |   3 +-
 arch/arm/mach-keystone/keystone.h                  |   1 +
 arch/arm/mach-keystone/keystone_ecc.c              | 117 +++++++++++++++++++++
 5 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-keystone/keystone_ecc.c

diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
index 59d7a46..7d09cc5 100644
--- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
@@ -18,3 +18,20 @@ Boards:
 
 -  Keystone 2 Edison EVM
    compatible = "ti,k2e-evm","ti,keystone"
+
+TI Keystone SoC specific Device Tree Bindings
+---------------------------------------------
+
+DDR3 ECC error interrupt handling
+---------------------------------
+
+Boards that has DDR3 ECC enabled will have a device node with following
+compatibility string to to allow handle double bit ECC error interrupts:-
+
+   compatible = "ti,keystone-ddr3-ecc"
+
+Required properties:
+
+- reg:  index 0 - base address of ECC specific register region
+
+- interrupts: DDR3 ECC error interrupt line
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
index 0b28fca..87f9bf1 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -97,7 +97,7 @@ static int __init keystone_init_misc(void)
 	check_ecc_error();
 
 	/* add ARM ECC L1/L2 cache error handler */
-	node = of_find_compatible_node(NULL, NULL, "ti,keystone-sys");
+	node = of_find_compatible_node(NULL, NULL, "ti,keystone-ddr3-ecc");
 	if (node)
 		error_irq = irq_of_parse_and_map(node, 0);
 
@@ -111,6 +111,7 @@ static int __init keystone_init_misc(void)
 		WARN_ON("request_irq fail for arm L1/L2 ECC error irq\n");
 	}
 
+	ret = keystone_init_ddr3_ecc(node);
 	return ret;
 }
 subsys_initcall(keystone_init_misc);
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
index 0000000..cab3013
--- /dev/null
+++ b/arch/arm/mach-keystone/keystone_ecc.c
@@ -0,0 +1,117 @@
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
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
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
+#define DDR3_SYS_ERR			BIT(0)
+
+static void check_ecc_error(void __iomem *ddr_reg)
+{
+	u32 irq_status;
+
+	irq_status = readl(ddr_reg + DDR3_IRQ_STATUS_SYS);
+	if ((irq_status & DDR3_2B_ECC_ERR) ||
+	    (irq_status & DDR3_WR_ECC_ERR)) {
+		pr_err("Unrecoverable DDR3 ECC error, irq status 0x%x, rebooting kernel ..\n",
+		       irq_status);
+		machine_restart(NULL);
+		/* we shouldn't return after that */
+	}
+}
+
+static irqreturn_t ddr3_ecc_err_irq_handler(int irq, void *reg_virt)
+{
+	void __iomem *ddr_reg = (void __iomem *)reg_virt;
+
+	check_ecc_error(ddr_reg);
+
+	/*
+	 * Other errors should be handled by hardware
+	 * So, nothing to do here
+	 */
+
+	return IRQ_HANDLED;
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
+	/* disable and clear unused ECC interrupts */
+	writel(DDR3_1B_ECC_ERR | DDR3_SYS_ERR,
+	       ddr_reg + DDR3_IRQ_ENABLE_CLR_SYS);
+
+	writel(DDR3_1B_ECC_ERR | DDR3_SYS_ERR,
+	       ddr_reg + DDR3_IRQ_STATUS_SYS);
+
+	/*
+	 * check if we already have unrecoverable errors
+	 * reboot in that case
+	 */
+	check_ecc_error(ddr_reg);
+
+	writel(DDR3_2B_ECC_ERR | DDR3_WR_ECC_ERR,
+	       ddr_reg + DDR3_IRQ_ENABLE_CLR_SYS);
+
+	/* add DDR3 ECC error handler */
+	error_irq = irq_of_parse_and_map(node, 1);
+	if (!error_irq) {
+		/* No GIC interrupt, need to map CIC2 interrupt to GIC */
+		pr_warn("Warning!! DDR3 ECC irq number not defined\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = request_irq(error_irq, ddr3_ecc_err_irq_handler, 0,
+		"ddr3-ecc-err-irq", (void *)ddr_reg);
+	if (ret) {
+		WARN_ON("request_irq fail for DDR3 ECC error irq\n");
+		goto err;
+	}
+
+	writel(DDR3_2B_ECC_ERR | DDR3_WR_ECC_ERR,
+	       ddr_reg + DDR3_IRQ_ENABLE_SET_SYS);
+
+	return 0;
+err:
+	iounmap(ddr_reg);
+	return ret;
+}
-- 
1.9.1

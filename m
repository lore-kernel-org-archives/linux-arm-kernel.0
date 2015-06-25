From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 10:31:49 -0400
Subject: [PATCH v2 2/3] ARM: keystone: ecc: add ARM L1/L2 ecc interrupt
 handling
In-Reply-To: <1435242710-31346-1-git-send-email-vitalya@ti.com>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
Message-ID: <1435242710-31346-3-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM L1/L2 ECC handler support interrupt handling
for Keystone II devices, the kernel will reboot if the error
is 2-bit error for L1/L2 ECC error.

Signed-off-by: Hao Zhang <hzhang@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 4534c7d..0b28fca 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -9,9 +9,12 @@
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
  */
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/reboot.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -46,6 +49,72 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#define L2_INTERN_ASYNC_ERROR  BIT(30)
+#define AXI_ASYNC_ERROR BIT(29)
+
+static void check_ecc_error(void)
+{
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
+		/* we should never cone here*/
+	}
+
+	if (status & AXI_ASYNC_ERROR)
+		pr_err("ARM Cortex A15 AXI async error shouldn't cause an nterrupt\n");
+}
+
+static irqreturn_t arm_l1l2_ecc_err_irq_handler(int irq, void *reg_virt)
+{
+	check_ecc_error();
+
+	return IRQ_HANDLED;
+}
+
+static int __init keystone_init_misc(void)
+{
+	struct device_node *node = NULL;
+	int error_irq = 0;
+	int ret;
+
+	/*
+	 * check if we already have ecc error. Reboot if it is double bit
+	 * error.
+	 */
+	check_ecc_error();
+
+	/* add ARM ECC L1/L2 cache error handler */
+	node = of_find_compatible_node(NULL, NULL, "ti,keystone-sys");
+	if (node)
+		error_irq = irq_of_parse_and_map(node, 0);
+
+	if (!error_irq) {
+		pr_warn("Warning!! arm L1/L2 ECC irq number not defined\n");
+		return 0;
+	}
+
+	if (request_irq(error_irq, arm_l1l2_ecc_err_irq_handler, 0,
+		"a15-l1l2-ecc-err-irq", 0) < 0) {
+		WARN_ON("request_irq fail for arm L1/L2 ECC error irq\n");
+	}
+
+	return ret;
+}
+subsys_initcall(keystone_init_misc);
+
 static void __init keystone_init(void)
 {
 	keystone_pm_runtime_init();
-- 
1.9.1

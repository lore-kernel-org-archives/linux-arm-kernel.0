From: york.sun@nxp.com (York Sun)
Date: Thu, 4 Aug 2016 15:58:35 -0700
Subject: [Patch v3 10/11] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
In-Reply-To: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
Message-ID: <1470351518-22404-11-git-send-email-york.sun@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DDR EDAC for ARM-based compatible controllers. Both big-endian
and little-endian are supported.

Signed-off-by: York Sun <york.sun@nxp.com>

---
Change log
  v3: no change
  v2: Create new driver using shared DDR object

 arch/arm64/Kconfig.platforms           |  1 +
 arch/{arm => arm64}/include/asm/edac.h | 21 +++++------
 arch/arm64/include/asm/irq.h           |  4 ++
 drivers/edac/Kconfig                   |  7 ++++
 drivers/edac/Makefile                  |  3 ++
 drivers/edac/fsl_ddr_edac.c            |  1 +
 drivers/edac/layerscape_edac.c         | 67 ++++++++++++++++++++++++++++++++++
 7 files changed, 92 insertions(+), 12 deletions(-)
 copy arch/{arm => arm64}/include/asm/edac.h (79%)
 create mode 100644 drivers/edac/layerscape_edac.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05..185a215 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -41,6 +41,7 @@ config ARCH_EXYNOS
 
 config ARCH_LAYERSCAPE
 	bool "ARMv8 based Freescale Layerscape SoC family"
+	select EDAC_SUPPORT
 	help
 	  This enables support for the Freescale Layerscape SoC family.
 
diff --git a/arch/arm/include/asm/edac.h b/arch/arm64/include/asm/edac.h
similarity index 79%
copy from arch/arm/include/asm/edac.h
copy to arch/arm64/include/asm/edac.h
index 5189fa8..36a226c 100644
--- a/arch/arm/include/asm/edac.h
+++ b/arch/arm64/include/asm/edac.h
@@ -18,16 +18,15 @@
 #define ASM_EDAC_H
 /*
  * ECC atomic, DMA, SMP and interrupt safe scrub function.
- * Implements the per arch edac_atomic_scrub() that EDAC use for software
+ * Implements the per arch atomic_scrub() that EDAC use for software
  * ECC scrubbing.  It reads memory and then writes back the original
  * value, allowing the hardware to detect and correct memory errors.
  */
-
-static inline void edac_atomic_scrub(void *va, u32 size)
+static inline void atomic_scrub(void *va, u32 size)
 {
-#if __LINUX_ARM_ARCH__ >= 6
-	unsigned int *virt_addr = va;
-	unsigned int temp, temp2;
+	unsigned long *virt_addr = va;
+	unsigned long temp;
+	unsigned int temp2;
 	unsigned int i;
 
 	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
@@ -35,15 +34,13 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 		 * so we are interrupt, DMA and SMP safe.
 		 */
 		__asm__ __volatile__("\n"
-			"1:	ldrex	%0, [%2]\n"
-			"	strex	%1, %0, [%2]\n"
-			"	teq	%1, #0\n"
-			"	bne	1b\n"
+			"1:	ldxr	%0, [%2]\n"
+			"	stxr	%w1, %0, [%2]\n"
+			"	cbnz	%w1, 1b\n"
 			: "=&r"(temp), "=&r"(temp2)
 			: "r"(virt_addr)
-			: "cc");
+			: "memory");
 	}
-#endif
 }
 
 #endif
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b77197d..d09c008 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -11,6 +11,10 @@
 #include <asm-generic/irq.h>
 #include <asm/thread_info.h>
 
+#ifndef NO_IRQ
+#define NO_IRQ	((unsigned int)(-1))
+#endif
+
 struct pt_regs;
 
 DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 6ca7474..f1ac4e2 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -258,6 +258,13 @@ config EDAC_MPC85XX
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
 
+config EDAC_LAYERSCAPE
+	tristate "Freescale Layerscape DDR"
+	depends on EDAC_MM_EDAC && ARCH_LAYERSCAPE
+	help
+	  Support for error detection and correction on Freescale memory
+	  controllers on Layerscape SoCs.
+
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
 	depends on EDAC_MM_EDAC && MV64X60
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index ee047a4..910dc83 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -54,6 +54,9 @@ obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 mpc85xx_edac_mod-y			:= fsl_ddr_edac.o mpc85xx_edac.o
 obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
 
+layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
+obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
+
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
 obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index a3fc8fe..d4b910d 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -22,6 +22,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include "edac_module.h"
 #include "edac_core.h"
 #include "fsl_ddr_edac.h"
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
new file mode 100644
index 0000000..6935e22
--- /dev/null
+++ b/drivers/edac/layerscape_edac.c
@@ -0,0 +1,67 @@
+/*
+ * Freescale Memory Controller kernel module
+ *
+ * Derived from mpc85xx_edac.c
+ * Author: Dave Jiang <djiang@mvista.com>
+ *
+ * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include "edac_core.h"
+#include "fsl_ddr_edac.h"
+
+static const struct of_device_id fsl_ddr_mc_err_of_match[] = {
+	{ .compatible = "fsl,qoriq-memory-controller", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);
+
+static struct platform_driver fsl_ddr_mc_err_driver = {
+	.probe = fsl_ddr_mc_err_probe,
+	.remove = fsl_ddr_mc_err_remove,
+	.driver = {
+		.name = "fsl_ddr_mc_err",
+		.of_match_table = fsl_ddr_mc_err_of_match,
+	},
+};
+
+static int __init fsl_ddr_mc_init(void)
+{
+	int res = 0;
+
+	/* make sure error reporting method is sane */
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
+	res = platform_driver_register(&fsl_ddr_mc_err_driver);
+	if (res) {
+		pr_err("Layerscape EDAC: MC fails to register\n");
+		return res;
+	}
+
+	return 0;
+}
+
+module_init(fsl_ddr_mc_init);
+
+static void __exit fsl_ddr_mc_exit(void)
+{
+	platform_driver_unregister(&fsl_ddr_mc_err_driver);
+}
+
+module_exit(fsl_ddr_mc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Montavista Software, Inc.");
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state,
+		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
-- 
2.7.4

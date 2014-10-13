From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 13 Oct 2014 17:36:03 +0800
Subject: [PATCHv5 6/6] ARM: imx: Add Freescale LS1021A SMP support
In-Reply-To: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1413192963-11153-7-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

Freescale LS1021A SoCs deploy two cortex-A7 processors,
this adds bring-up support for the secondary core.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/mach-imx/Makefile       |  2 +-
 arch/arm/mach-imx/common.h       |  1 +
 arch/arm/mach-imx/mach-ls1021a.c |  1 +
 arch/arm/mach-imx/platsmp.c      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ce137bc..38d75e2 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
-ifdef CONFIG_SOC_IMX6
+ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
 AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1dabf43..c473ca5 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -157,5 +157,6 @@ static inline void imx_init_l2cache(void) {}
 #endif
 
 extern struct smp_operations imx_smp_ops;
+extern struct smp_operations ls1021a_smp_ops;
 
 #endif
diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
index 9d2034b..b89c858 100644
--- a/arch/arm/mach-imx/mach-ls1021a.c
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -17,5 +17,6 @@ static const char * const ls1021a_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(LS1021A, "Freescale LS1021A")
+	.smp		= smp_ops(ls1021a_smp_ops),
 	.dt_compat	= ls1021a_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 771bd25..69b87ca 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -16,6 +16,8 @@
 #include <asm/page.h>
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
 
 #include "common.h"
 #include "hardware.h"
@@ -94,3 +96,33 @@ struct smp_operations  imx_smp_ops __initdata = {
 	.cpu_kill		= imx_cpu_kill,
 #endif
 };
+
+#define DCFG_CCSR_SCRATCHRW1	0x200
+
+static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return 0;
+}
+
+static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	void __iomem *dcfg_base;
+	unsigned long paddr;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
+	dcfg_base = of_iomap(np, 0);
+	BUG_ON(!dcfg_base);
+
+	paddr = virt_to_phys(secondary_startup);
+	writel_relaxed(cpu_to_be32(paddr), dcfg_base + DCFG_CCSR_SCRATCHRW1);
+
+	iounmap(dcfg_base);
+}
+
+struct smp_operations  ls1021a_smp_ops __initdata = {
+	.smp_prepare_cpus	= ls1021a_smp_prepare_cpus,
+	.smp_boot_secondary	= ls1021a_boot_secondary,
+};
-- 
1.8.0

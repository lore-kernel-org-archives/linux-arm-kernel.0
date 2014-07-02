From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 2 Jul 2014 17:02:52 +0800
Subject: [PATCH 5/5] ARM: imx: Add Freescale LS1021A SMP support
In-Reply-To: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1404291772-2644-6-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

Freescale LS1021A SoC deploys two cortex-A7 processors,
this adds bring-up support for the secondary core.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/mach-imx/common.h       |  2 ++
 arch/arm/mach-imx/headsmp.S      | 11 ++++++++++
 arch/arm/mach-imx/mach-ls1021a.c |  1 +
 arch/arm/mach-imx/platsmp.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index e0632d1..8cdd498 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -98,6 +98,7 @@ void v7_secondary_startup(void);
 void imx_scu_map_io(void);
 void imx_smp_prepare(void);
 void imx_scu_standby_enable(void);
+void ls1021a_secondary_startup(void);
 #else
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
@@ -158,5 +159,6 @@ static inline void imx_init_l2cache(void) {}
 #endif
 
 extern struct smp_operations imx_smp_ops;
+extern struct smp_operations ls1021a_smp_ops;
 
 #endif
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index de5047c..fdd93d9 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -29,3 +29,14 @@ ENTRY(v7_secondary_startup)
 	set_diag_reg
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
+
+ENTRY(ls1021a_secondary_startup)
+	/* set CNTFREQ of secondary core */
+	ldr	r0, =12500000
+	mcr 	p15, 0, r0, c14, c0, 0
+	/* disable Physical and Virtural Timer */
+	mov	r0, #0x0
+	mcr	p15, 0, r0, c14, c2, 1
+	mcr	p15, 0, r0, c14, c3, 1
+	b	secondary_startup
+ENDPROC(ls1021a_secondary_startup)
diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
index d1a9bb9..9931c5b 100644
--- a/arch/arm/mach-imx/mach-ls1021a.c
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -43,6 +43,7 @@ DT_MACHINE_START(LS1021A, "Freescale LS1021A")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_128M,
 #endif
+	.smp		= smp_ops(ls1021a_smp_ops),
 	.init_machine   = ls1021a_init_machine,
 	.dt_compat	= ls1021a_dt_compat,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 5b57c17..8e1bcce 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -16,6 +16,8 @@
 #include <asm/page.h>
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "common.h"
 #include "hardware.h"
@@ -104,3 +106,45 @@ struct smp_operations  imx_smp_ops __initdata = {
 	.cpu_kill		= imx_cpu_kill,
 #endif
 };
+
+static void __iomem *dcfg_base;
+#define DCFG_CCSR_BRR		0xE4
+#define DCFG_CCSR_SCRATCHRW1	0x200
+
+static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long paddr;
+
+	paddr = virt_to_phys(ls1021a_secondary_startup);
+	writel_relaxed(cpu_to_be32(paddr), dcfg_base + DCFG_CCSR_SCRATCHRW1);
+	/* release core for booting */
+	writel_relaxed(cpu_to_be32(0x1 << cpu), dcfg_base + DCFG_CCSR_BRR);
+
+	return 0;
+}
+
+static void __init ls1021a_smp_init_cpus(void)
+{
+	int i, ncores;
+	/* get number of cores from CP15 L2 controller register(L2CTLR)*/
+	asm volatile ("mrc p15, 1, %0, c9, c0, 2" : "=r" (ncores));
+
+	ncores = ((ncores >> 24) & 0x3) + 1;
+	for (i = ncores; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+}
+
+static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
+	dcfg_base = of_iomap(np, 0);
+	WARN_ON(!dcfg_base);
+}
+
+struct smp_operations  ls1021a_smp_ops __initdata = {
+	.smp_init_cpus		= ls1021a_smp_init_cpus,
+	.smp_prepare_cpus	= ls1021a_smp_prepare_cpus,
+	.smp_boot_secondary	= ls1021a_boot_secondary,
+};
-- 
1.8.0

From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 2 Dec 2016 14:39:24 +0800
Subject: [PATCH 01/11] ARM: imx: Add basic msl support for imx6sll
In-Reply-To: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480660774-25055-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic MSL support for i.MX6SLL.

The i.MX 6SoloLiteLite application processors are NXP's latest
additions to a growing family of multimedia-focused products
offering high-performance processing optimized for lowest power
consumption. The i.MX 6SoloLiteLite processors feature NXP's advanced
implementation of the ARM Cortex-A9 core, which can be interfaced
with LPDDR3 and LPDDR2 DRAM memory devices.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/mach-imx/Kconfig          |  7 +++++++
 arch/arm/mach-imx/Makefile         |  1 +
 arch/arm/mach-imx/cpu.c            |  3 +++
 arch/arm/mach-imx/cpuidle-imx6sl.c |  7 +++++--
 arch/arm/mach-imx/gpc.c            |  8 ++++++++
 arch/arm/mach-imx/mach-imx6sl.c    | 10 ++++++++--
 arch/arm/mach-imx/mxc.h            |  6 ++++++
 7 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 936c59d..33bcfda 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -512,6 +512,13 @@ config SOC_IMX6SL
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
 
+config SOC_IMX6SLL
+	bool "i.MX6 SoloLiteLite support"
+	select SOC_IMX6
+
+	help
+	  This enables support for Freescale i.MX6 SoloLiteLite processor.
+
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
 	select PINCTRL_IMX6SX
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index cab1289..f2bf650 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 endif
 obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d3..62e8c0f 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -131,6 +131,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6UL:
 		soc_id = "i.MX6UL";
 		break;
+	case MXC_CPU_IMX6SLL:
+		soc_id = "i.MX6SLL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index 8d866fb..124f982 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -11,6 +11,7 @@
 #include <asm/cpuidle.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "cpuidle.h"
 
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
@@ -21,9 +22,11 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	 * Software workaround for ERR005311, see function
 	 * description for details.
 	 */
-	imx6sl_set_wait_clk(true);
+	if (cpu_is_imx6sl())
+		imx6sl_set_wait_clk(true);
 	cpu_do_idle();
-	imx6sl_set_wait_clk(false);
+	if (cpu_is_imx6sl())
+		imx6sl_set_wait_clk(false);
 	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1dc2a34..4ed8a63 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -26,6 +26,7 @@
 #include "hardware.h"
 
 #define GPC_CNTR		0x000
+#define GPC_CNTR_L2_PGE		22
 #define GPC_IMR1		0x008
 #define GPC_PGC_GPU_PDN		0x260
 #define GPC_PGC_GPU_PUPSCR	0x264
@@ -243,6 +244,7 @@ static int __init imx_gpc_init(struct device_node *node,
 {
 	struct irq_domain *parent_domain, *domain;
 	int i;
+	u32 val;
 
 	if (!parent) {
 		pr_err("%s: no parent, giving up\n", node->full_name);
@@ -271,6 +273,12 @@ static int __init imx_gpc_init(struct device_node *node,
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
 
+	/* clear the L2_PGE bit on i.MX6SLL */
+	if (cpu_is_imx6sll()) {
+		val = readl_relaxed(gpc_base + GPC_CNTR);
+		val &= ~(1 << GPC_CNTR_L2_PGE);
+		writel_relaxed(val, gpc_base + GPC_CNTR);
+	}
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
 	 * later the GPC power domain driver will not be skipped.
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0408490..462ed9c 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "hardware.h"
 #include "cpuidle.h"
 
 static void __init imx6sl_fec_init(void)
@@ -54,7 +55,8 @@ static void __init imx6sl_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
-	imx6sl_fec_init();
+	if (cpu_is_imx6sl())
+		imx6sl_fec_init();
 	imx_anatop_init();
 	imx6sl_pm_init();
 }
@@ -66,11 +68,15 @@ static void __init imx6sl_init_irq(void)
 	imx_init_l2cache();
 	imx_src_init();
 	irqchip_init();
-	imx6_pm_ccm_init("fsl,imx6sl-ccm");
+	if (cpu_is_imx6sl())
+		imx6_pm_ccm_init("fsl,imx6sl-ccm");
+	else
+		imx6_pm_ccm_init("fsl,imx6sll-ccm");
 }
 
 static const char * const imx6sl_dt_compat[] __initconst = {
 	"fsl,imx6sl",
+	"fsl,imx6sll",
 	NULL,
 };
 
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff6..e047611 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -73,6 +74,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6UL;
 }
 
+static inline bool cpu_is_imx6sll(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
-- 
1.9.1

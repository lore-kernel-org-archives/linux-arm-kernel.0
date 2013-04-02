From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:31:16 +0800
Subject: [PATCH 3/6] ARM: imx: add initial imx6dl support
In-Reply-To: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364913079-26039-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 DualLite/Solo is another i.MX6 family SoC, which is highly
compatible with i.MX6 Quad/Dual.  And that's why we choose to support
it using imx6q code with cpu_is_imx6dl() check when necessary.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug         |    4 ++--
 arch/arm/mach-imx/Kconfig      |    2 +-
 arch/arm/mach-imx/clk-imx6q.c  |    2 +-
 arch/arm/mach-imx/mach-imx6q.c |   30 +++++++++++++++++++++---------
 arch/arm/mach-imx/mxc.h        |   11 +++++++++++
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9b31f43..7e911fd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -234,11 +234,11 @@ choice
 		  on i.MX53.
 
 	config DEBUG_IMX6Q_UART
-		bool "i.MX6Q Debug UART"
+		bool "i.MX6Q/DL Debug UART"
 		depends on SOC_IMX6Q
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on i.MX6Q.
+		  on i.MX6Q/DL.
 
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ca24f2c..355d55c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -810,7 +810,7 @@ config	SOC_IMX53
 	  This enables support for Freescale i.MX53 processor.
 
 config SOC_IMX6Q
-	bool "i.MX6 Quad support"
+	bool "i.MX6 Quad/DualLite support"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 92b2aa5..65319d5 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -296,7 +296,7 @@ int __init mx6q_clocks_init(void)
 	WARN_ON(!base);
 
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
-	if (imx6q_revision() == IMX_CHIP_REVISION_1_0) {
+	if (cpu_is_imx6q() && imx6q_revision() == IMX_CHIP_REVISION_1_0) {
 		post_div_table[1].div = 1;
 		post_div_table[2].div = 1;
 		video_div_table[1].div = 1;
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 221f319..8aa9d90 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -39,23 +39,32 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
+static u32 chip_revision;
+
 int imx6q_revision(void)
 {
-	static u32 rev;
+	return chip_revision;
+}
 
-	if (!rev)
-		rev = imx_anatop_get_digprog();
+static void __init imx6q_init_revision(void)
+{
+	u32 rev = imx_anatop_get_digprog();
 
 	switch (rev & 0xff) {
 	case 0:
-		return IMX_CHIP_REVISION_1_0;
+		chip_revision = IMX_CHIP_REVISION_1_0;
+		break;
 	case 1:
-		return IMX_CHIP_REVISION_1_1;
+		chip_revision = IMX_CHIP_REVISION_1_1;
+		break;
 	case 2:
-		return IMX_CHIP_REVISION_1_2;
+		chip_revision = IMX_CHIP_REVISION_1_2;
+		break;
 	default:
-		return IMX_CHIP_REVISION_UNKNOWN;
+		chip_revision = IMX_CHIP_REVISION_UNKNOWN;
 	}
+
+	mxc_set_cpu_type(rev >> 16 & 0xff);
 }
 
 void imx6q_restart(char mode, const char *cmd)
@@ -247,6 +256,7 @@ static void __init imx6q_map_io(void)
 
 static void __init imx6q_init_irq(void)
 {
+	imx6q_init_revision();
 	l2x0_of_init(0, ~0UL);
 	imx_src_init();
 	imx_gpc_init();
@@ -257,15 +267,17 @@ static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
 	twd_local_timer_of_register();
-	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
+	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
+			      imx6q_revision());
 }
 
 static const char *imx6q_dt_compat[] __initdata = {
+	"fsl,imx6dl",
 	"fsl,imx6q",
 	NULL,
 };
 
-DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
+DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
 	.smp		= smp_ops(imx_smp_ops),
 	.map_io		= imx6q_map_io,
 	.init_irq	= imx6q_init_irq,
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 7dce17a..8629e5b 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -34,6 +34,8 @@
 #define MXC_CPU_MX35		35
 #define MXC_CPU_MX51		51
 #define MXC_CPU_MX53		53
+#define MXC_CPU_IMX6DL		0x61
+#define MXC_CPU_IMX6Q		0x63
 
 #define IMX_CHIP_REVISION_1_0		0x10
 #define IMX_CHIP_REVISION_1_1		0x11
@@ -150,6 +152,15 @@ extern unsigned int __mxc_cpu_type;
 #endif
 
 #ifndef __ASSEMBLY__
+static inline bool cpu_is_imx6dl(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6DL;
+}
+
+static inline bool cpu_is_imx6q(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6Q;
+}
 
 struct cpu_op {
 	u32 cpu_rate;
-- 
1.7.9.5

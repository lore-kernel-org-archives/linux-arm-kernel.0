From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:50:01 -0400
Subject: [PATCH 12/12] ARM: imx: move special idle code to proper out-of-line
	pm_idle hooks
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-13-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-imx/Makefile              |    4 +-
 arch/arm/mach-imx/idle-mx3.c            |   31 +++++++++++++++++++++++++++++
 arch/arm/mach-imx/mm-imx31.c            |    1 +
 arch/arm/mach-imx/mm-imx35.c            |    1 +
 arch/arm/mach-mx5/clock-mx51-mx53.c     |    7 ++++++
 arch/arm/plat-mxc/include/mach/system.h |   33 +------------------------------
 6 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-imx/idle-mx3.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e9eb36dad8..8caa83be15 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o idle-mx3.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o idle-mx3.o
 obj-$(CONFIG_CACHE_L2X0) += cache-l2x0.o
 
 # Support for CMOS sensor interface
diff --git a/arch/arm/mach-imx/idle-mx3.c b/arch/arm/mach-imx/idle-mx3.c
new file mode 100644
index 0000000000..580b4075fd
--- /dev/null
+++ b/arch/arm/mach-imx/idle-mx3.c
@@ -0,0 +1,31 @@
+#include <mach/hardware.h>
+#include <mach/common.h>
+
+void mx3_idle(void)
+{
+	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
+	unsigned long reg = 0;
+	__asm__ __volatile__(
+	/* disable I and D cache */
+	"mrc p15, 0, %0, c1, c0, 0\n"
+	"bic %0, %0, #0x00001000\n"
+	"bic %0, %0, #0x00000004\n"
+	"mcr p15, 0, %0, c1, c0, 0\n"
+	/* invalidate I cache */
+	"mov %0, #0\n"
+	"mcr p15, 0, %0, c7, c5, 0\n"
+	/* clear and invalidate D cache */
+	"mov %0, #0\n"
+	"mcr p15, 0, %0, c7, c14, 0\n"
+	/* WFI */
+	"mov %0, #0\n"
+	"mcr p15, 0, %0, c7, c0, 4\n"
+	"nop\n" "nop\n" "nop\n" "nop\n"
+	"nop\n" "nop\n" "nop\n"
+	/* enable I and D cache */
+	"mrc p15, 0, %0, c1, c0, 0\n"
+	"orr %0, %0, #0x00001000\n"
+	"orr %0, %0, #0x00000004\n"
+	"mcr p15, 0, %0, c1, c0, 0\n"
+	: "=r" (reg));
+}
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index b7c55e7db0..4855e99b2c 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -51,6 +51,7 @@ void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+	pm_idle = mx3_idle;
 }
 
 void __init mx31_init_irq(void)
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index f49bac7a1e..f20fed6954 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -48,6 +48,7 @@ void __init imx35_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
+	pm_idle = mx3_idle;
 }
 
 void __init mx35_init_irq(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index f7bf996f46..c57bd92764 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1529,6 +1529,11 @@ static void clk_tree_init(void)
 	__raw_writel(reg, MXC_CCM_CBCDR);
 }
 
+static void mx51_idle(void)
+{
+	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+}
+
 int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2)
 {
@@ -1569,6 +1574,8 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
 		MX51_MXC_INT_GPT);
+
+	pm_idle = mx51_idle;
 	return 0;
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 51f02a9d41..89d08c51ca 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -20,40 +20,9 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
-extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
-
 static inline void arch_idle(void)
 {
-	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
-	if (cpu_is_mx31() || cpu_is_mx35()) {
-		unsigned long reg = 0;
-		__asm__ __volatile__(
-			/* disable I and D cache */
-			"mrc p15, 0, %0, c1, c0, 0\n"
-			"bic %0, %0, #0x00001000\n"
-			"bic %0, %0, #0x00000004\n"
-			"mcr p15, 0, %0, c1, c0, 0\n"
-			/* invalidate I cache */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c5, 0\n"
-			/* clear and invalidate D cache */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c14, 0\n"
-			/* WFI */
-			"mov %0, #0\n"
-			"mcr p15, 0, %0, c7, c0, 4\n"
-			"nop\n" "nop\n" "nop\n" "nop\n"
-			"nop\n" "nop\n" "nop\n"
-			/* enable I and D cache */
-			"mrc p15, 0, %0, c1, c0, 0\n"
-			"orr %0, %0, #0x00001000\n"
-			"orr %0, %0, #0x00000004\n"
-			"mcr p15, 0, %0, c1, c0, 0\n"
-			: "=r" (reg));
-	} else if (cpu_is_mx51())
-		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
-	else
-		cpu_do_idle();
+	cpu_do_idle();
 }
 
 void arch_reset(char mode, const char *cmd);
-- 
1.7.7.1.431.g10b2a

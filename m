From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 25 Apr 2013 23:18:35 +0800
Subject: [PATCH v2] ARM: imx: replicate the diagnostic register of boot cpu
 into secondary cores
Message-ID: <1366903115-11195-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The diagnostic register holds the errata bits.  Mostly bootloader
does not bring up secondary cores, so that when errata bits are set
in bootloader, they are set only for boot cpu.  But on a SMP
configuration, it should be equally done on every single core.
Set up the diagnostic register for secondary cores by replicating
the register from boot cpu.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
 * Move get_diag_reg() and set_diag_reg() into IMX file, as Will has
   concern to have it be globally available.

 arch/arm/mach-imx/platsmp.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7061bde..b13458f 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -23,6 +23,7 @@
 #define SCU_STANDBY_ENABLE	(1 << 5)
 
 static void __iomem *scu_base;
+static u32 diag_reg;
 
 static struct map_desc scu_io_desc __initdata = {
 	/* .virtual and .pfn are run-time assigned */
@@ -52,6 +53,19 @@ void imx_scu_standby_enable(void)
 	writel_relaxed(val, scu_base);
 }
 
+static inline unsigned int get_diag_reg(void)
+{
+	unsigned int val;
+	asm("mrc p15, 0, %0, c15, c0, 1" : "=r" (val) : : "cc");
+	return val;
+}
+
+static inline void set_diag_reg(unsigned int val)
+{
+	asm volatile("mcr p15, 0, %0, c15, c0, 1" : : "r" (val) : "cc");
+	isb();
+}
+
 static void __cpuinit imx_secondary_init(unsigned int cpu)
 {
 	/*
@@ -60,6 +74,9 @@ static void __cpuinit imx_secondary_init(unsigned int cpu)
 	 * for us: do so
 	 */
 	gic_secondary_init(0);
+
+	/* Replicate the diagnostic register of boot cpu */
+	set_diag_reg(diag_reg);
 }
 
 static int __cpuinit imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -91,6 +108,16 @@ void imx_smp_prepare(void)
 static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 {
 	imx_smp_prepare();
+
+	/*
+	 * The diagnostic register holds the errata bits.  Mostly bootloader
+	 * does not bring up secondary cores, so that when errata bits are set
+	 * in bootloader, they are set only for boot cpu.  But on a SMP
+	 * configuration, it should be equally done on every single core.
+	 * Read the register from boot cpu here, and will replicate it into
+	 * secondary cores when booting them.
+	 */
+	diag_reg = get_diag_reg();
 }
 
 struct smp_operations  imx_smp_ops __initdata = {
-- 
1.7.9.5

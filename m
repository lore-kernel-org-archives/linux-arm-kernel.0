From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Apr 2013 22:30:43 +0800
Subject: [PATCH 2/2] ARM: imx: replicate the diagnostic register of boot cpu
 into secondary cores
In-Reply-To: <1366122643-1961-1-git-send-email-shawn.guo@linaro.org>
References: <1366122643-1961-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1366122643-1961-2-git-send-email-shawn.guo@linaro.org>
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
 arch/arm/mach-imx/platsmp.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7c0b03f..93854f9 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/irqchip/arm-gic.h>
+#include <asm/cp15.h>
 #include <asm/page.h>
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
@@ -23,6 +24,7 @@
 #define SCU_STANDBY_ENABLE	(1 << 5)
 
 static void __iomem *scu_base;
+static u32 diag_reg;
 
 static struct map_desc scu_io_desc __initdata = {
 	/* .virtual and .pfn are run-time assigned */
@@ -60,6 +62,9 @@ static void __cpuinit imx_secondary_init(unsigned int cpu)
 	 * for us: do so
 	 */
 	gic_secondary_init(0);
+
+	/* Replicate the diagnostic register of boot cpu */
+	set_diag_reg(diag_reg);
 }
 
 static int __cpuinit imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -91,6 +96,16 @@ void imx_smp_prepare(void)
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

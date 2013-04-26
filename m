From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 26 Apr 2013 11:57:25 +0800
Subject: [PATCH v3] ARM: imx: replicate the diagnostic register of boot cpu
 into secondary cores
Message-ID: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
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
Changes since v2:
 * Setting secondary cores' diagnostic register before MMU is enabled.

 arch/arm/mach-imx/headsmp.S |   12 ++++++++++++
 arch/arm/mach-imx/platsmp.c |   14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index a58c8b0..cd87970 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -18,8 +18,20 @@
 	.section ".text.head", "ax"
 
 #ifdef CONFIG_SMP
+diag_reg_offset:
+	.word	g_diag_reg - .
+
+	.macro	set_diag_reg
+	adr	r0, diag_reg_offset
+	ldr	r1, [r0]
+	add	r1, r1, r0		@ r1 = physical &g_diag_reg
+	ldr	r0, [r1]
+	mcr	p15, 0, r0, c15, c0, 1	@ write diagnostic register
+	.endm
+
 ENTRY(v7_secondary_startup)
 	bl	v7_invalidate_l1
+	set_diag_reg
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
 #endif
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7061bde..abe9d95 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/irqchip/arm-gic.h>
+#include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/smp_scu.h>
 #include <asm/mach/map.h>
@@ -22,6 +23,7 @@
 
 #define SCU_STANDBY_ENABLE	(1 << 5)
 
+u32 g_diag_reg;
 static void __iomem *scu_base;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -91,6 +93,18 @@ void imx_smp_prepare(void)
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
+	asm("mrc p15, 0, %0, c15, c0, 1" : "=r" (g_diag_reg) : : "cc");
+	__cpuc_flush_dcache_area(&g_diag_reg, sizeof(g_diag_reg));
+	outer_clean_range(__pa(&g_diag_reg), __pa(&g_diag_reg + 1));
 }
 
 struct smp_operations  imx_smp_ops __initdata = {
-- 
1.7.9.5

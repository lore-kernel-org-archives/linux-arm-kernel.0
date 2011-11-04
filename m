From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:43 +0000
Subject: [PATCH v3 09/17] ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Exynos4 platforms to be using the gic_handle_irq
function as their primary interrupt handler.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-exynos4/cpu.c                      |    1 +
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   74 ----------------------
 arch/arm/mach-exynos4/mach-armlex4210.c          |    2 +
 arch/arm/mach-exynos4/mach-nuri.c                |    2 +
 arch/arm/mach-exynos4/mach-origen.c              |    2 +
 arch/arm/mach-exynos4/mach-smdk4x12.c            |    3 +
 arch/arm/mach-exynos4/mach-smdkv310.c            |    3 +
 arch/arm/mach-exynos4/mach-universal_c210.c      |    2 +
 9 files changed, 16 insertions(+), 74 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index af6e59d..605e897 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -855,6 +855,7 @@ config ARCH_EXYNOS4
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select NEED_MACH_MEMORY_H
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung EXYNOS4 series based systems
 
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index b57b905..567a4c1 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -17,6 +17,7 @@
 #include <asm/mach/irq.h>
 
 #include <asm/proc-fns.h>
+#include <asm/exception.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index d7dfcd7..3ba4f54 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -9,82 +9,8 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <asm/hardware/gic.h>
-
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\tmp, #0
-
-		mrc	p15, 0, \base, c0, c0, 5
-		and	\base, \base, #3
-		cmp	\base, #0
-		beq	1f
-
-		ldr	\tmp, =gic_bank_offset
-		ldr	\tmp, [\tmp]
-		cmp	\base, #1
-		beq	1f
-
-		cmp	\base, #2
-		addeq	\tmp, \tmp, \tmp
-		addne	\tmp, \tmp, \tmp, LSL #1
-
-1:		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		add	\base, \base, \tmp
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		/*
-		 * The interrupt numbering scheme is defined in the
-		 * interrupt controller spec.  To wit:
-		 *
-		 * Interrupts 0-15 are IPI
-		 * 16-28 are reserved
-		 * 29-31 are local.  We allow 30 to be used for the watchdog.
-		 * 32-1020 are global
-		 * 1021-1022 are reserved
-		 * 1023 is "spurious" (no interrupt)
-		 *
-		 * For now, we ignore all local interrupts so only return an interrupt if it's
-		 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
-		 *
-		 * A simple read from the controller will tell us the number of the highest
-                 * priority enabled interrupt.  We then just need to check whether it is in the
-		 * valid range for an IRQ (30-1020 inclusive).
-		 */
-
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
-
-		ldr	\tmp, =1021
-
-		bic     \irqnr, \irqstat, #0x1c00
-
-		cmp     \irqnr, #15
-		cmpcc	\irqnr, \irqnr
-		cmpne	\irqnr, \tmp
-		cmpcs	\irqnr, \irqnr
-
-		.endm
-
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt on the
-		 * controller, since this requires the original irqstat value which
-		 * we won't easily be able to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		cmpcs	\irqnr, \irqnr
-		.endm
diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index 8c82c6b..2fdcc9d 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -16,6 +16,7 @@
 #include <linux/smsc911x.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/cpu.h>
@@ -213,6 +214,7 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index f6eb7a4..6fddafa 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -32,6 +32,7 @@
 #include <media/v4l2-mediabus.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/adc.h>
@@ -1336,6 +1337,7 @@ MACHINE_START(NURI, "NURI")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &nuri_reserve,
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index b643584..192bffd 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -22,6 +22,7 @@
 #include <linux/lcd.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -697,6 +698,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &origen_reserve,
diff --git a/arch/arm/mach-exynos4/mach-smdk4x12.c b/arch/arm/mach-exynos4/mach-smdk4x12.c
index 052b2cb..9e7e8a2 100644
--- a/arch/arm/mach-exynos4/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos4/mach-smdk4x12.c
@@ -21,6 +21,7 @@
 #include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/backlight.h>
@@ -290,6 +291,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
@@ -302,5 +304,6 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
 	.init_machine	= smdk4x12_machine_init,
+	.handle_irq	= gic_handle_irq,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 525b042..6b49dbe 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -21,6 +21,7 @@
 #include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -378,6 +379,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &smdkv310_reserve,
@@ -389,6 +391,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 1bdb4c2..4e50b13 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -24,6 +24,7 @@
 #include <linux/i2c/atmel_mxt_ts.h>
 
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
@@ -1061,6 +1062,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &universal_reserve,
-- 
1.7.0.4

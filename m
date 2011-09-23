From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:24 +0100
Subject: [RFC PATCH 06/14] ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Exynos4 platforms to be using the gic_handle_irq_offset()
function as their primary interrupt handler.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   62 ----------------------
 arch/arm/mach-exynos4/mach-armlex4210.c          |    2 +
 arch/arm/mach-exynos4/mach-nuri.c                |    2 +
 arch/arm/mach-exynos4/mach-origen.c              |    2 +
 arch/arm/mach-exynos4/mach-smdk4212.c            |    2 +
 arch/arm/mach-exynos4/mach-smdkv310.c            |    2 +
 arch/arm/mach-exynos4/mach-universal_c210.c      |    2 +
 8 files changed, 13 insertions(+), 62 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d3e246c..e32a4d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -787,6 +787,7 @@ config ARCH_EXYNOS4
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung EXYNOS4 series based systems
 
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index 807d05d..efe9a00 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -9,71 +9,9 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <asm/hardware/gic.h>
-
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		mrc     p15, 0, \tmp, c0, c0, 5
-		and     \tmp, \tmp, #3
-		cmp     \tmp, #1
-		addeq   \base, \base, #EXYNOS4_GIC_BANK_OFFSET
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
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
-		addne	\irqnr, \irqnr, #32
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
-
diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index 8c82c6b..969e04c 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -15,6 +15,7 @@
 #include <linux/serial_core.h>
 #include <linux/smsc911x.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -213,6 +214,7 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= armlex4210_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 5780ee3..5e133ae 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -28,6 +28,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -1192,6 +1193,7 @@ MACHINE_START(NURI, "NURI")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= nuri_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &nuri_reserve,
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index 06250fc..7ede5fc 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -17,6 +17,7 @@
 #include <linux/pwm_backlight.h>
 #include <linux/gpio_keys.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -215,6 +216,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= origen_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdk4212.c b/arch/arm/mach-exynos4/mach-smdk4212.c
index cf92514..84a0446 100644
--- a/arch/arm/mach-exynos4/mach-smdk4212.c
+++ b/arch/arm/mach-exynos4/mach-smdk4212.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/serial_core.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -290,6 +291,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4212_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= smdk4212_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 088644e..8e11eaa 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -20,6 +20,7 @@
 #include <linux/input.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -351,6 +352,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 39c34a1..43f156d 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -23,6 +23,7 @@
 #include <linux/i2c/mcs.h>
 #include <linux/i2c/atmel_mxt_ts.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -876,6 +877,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
+	.handle_irq	= gic_handle_irq_offset,
 	.init_machine	= universal_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &universal_reserve,
-- 
1.7.0.4

From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:08 +0000
Subject: [PATCHv4 11/13] ARM: samsung: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-12-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for samsung to help building multi platform kernels.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                 |    3 ++
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S |    7 ++--
 arch/arm/mach-s5p64x0/mach-smdk6440.c            |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c            |    2 +
 arch/arm/mach-s5pc100/include/mach/entry-macro.S |   25 ---------------
 arch/arm/mach-s5pc100/mach-smdkc100.c            |    2 +
 arch/arm/mach-s5pv210/include/mach/entry-macro.S |   37 ----------------------
 arch/arm/mach-s5pv210/mach-aquila.c              |    2 +
 arch/arm/mach-s5pv210/mach-goni.c                |    2 +
 arch/arm/mach-s5pv210/mach-smdkc110.c            |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c            |    2 +
 arch/arm/mach-s5pv210/mach-torbreck.c            |    2 +
 12 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d1caaba..76a379c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -804,6 +804,7 @@ config ARCH_S5P64X0
 	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -819,6 +820,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5PC100 series based systems
 
@@ -839,6 +841,7 @@ config ARCH_S5PV210
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select NEED_MACH_MEMORY_H
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
diff --git a/arch/arm/mach-s5p64x0/include/mach/entry-macro.S b/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
index 10b62b4..fbb246d 100644
--- a/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
@@ -10,7 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#include <mach/map.h>
-#include <plat/irqs.h>
+		.macro  disable_fiq
+		.endm
 
-#include <asm/entry-macro-vic2.S>
+		.macro  arch_ret_to_user, tmp1, tmp2
+		.endm
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 88857f5..a69a5de 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
@@ -168,6 +169,7 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6440_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index e1b277b..40ee26f 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
@@ -187,6 +188,7 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6450_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6450_map_io,
 	.init_machine	= smdk6450_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
index ba76af0..b8c242e 100644
--- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
@@ -12,39 +12,14 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <asm/hardware/vic.h>
-#include <mach/map.h>
-#include <plat/irqs.h>
-
 	.macro	disable_fiq
 	.endm
 
 	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =VA_VIC0
 	.endm
 
 	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	@ check the vic0
-	mov	\irqnr, # S5P_IRQ_OFFSET + 31
-	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
-	teq	\irqstat, #0
-
-	@ otherwise try vic1
-	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	@ otherwise try vic2
-	addeq	\tmp, \base, #(VA_VIC2 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
 	.endm
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 26f5c91..93ebe3a 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -25,6 +25,7 @@
 #include <linux/input.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -250,6 +251,7 @@ MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pc100_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkc100_map_io,
 	.init_machine	= smdkc100_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s5pv210/include/mach/entry-macro.S b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
index 3aa41ac..bebca1b 100644
--- a/arch/arm/mach-s5pv210/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
@@ -10,45 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#include <asm/hardware/vic.h>
-#include <mach/map.h>
-#include <plat/irqs.h>
-
 	.macro	disable_fiq
 	.endm
 
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =VA_VIC0
-	.endm
-
 	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	@ check the vic0
-	mov	\irqnr, # S5P_IRQ_OFFSET + 31
-	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
-	teq	\irqstat, #0
-
-	@ otherwise try vic1
-	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	@ otherwise try vic2
-	addeq	\tmp, \base, #(VA_VIC2 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	@ otherwise try vic3
-	addeq	\tmp, \base, #(VA_VIC3 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 5811a96..71ca956 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -22,6 +22,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -680,6 +681,7 @@ MACHINE_START(AQUILA, "Aquila")
 	   Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 061cc7e..b22ad69 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -899,6 +900,7 @@ MACHINE_START(GONI, "GONI")
 	/* Maintainers: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index f7266bb..c2531ff 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/sysdev.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -138,6 +139,7 @@ MACHINE_START(SMDKC110, "SMDKC110")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a9106c3..4ca77c4 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -315,6 +316,7 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 97cc066..df70fcb 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -127,6 +128,7 @@ MACHINE_START(TORBRECK, "TORBRECK")
 	/* Maintainer: Hyunchul Ko <ghcstop@gmail.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
 	.timer		= &s5p_timer,
-- 
1.7.5.4

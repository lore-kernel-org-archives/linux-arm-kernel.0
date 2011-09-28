From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:47 +0100
Subject: [PATCHv2 10/10] ARM: samsung: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317206507-18867-11-git-send-email-jamie@jamieiles.com>
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
index 5e6c744..5d9b70f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -751,6 +751,7 @@ config ARCH_S5P64X0
 	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -766,6 +767,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5PC100 series based systems
 
@@ -785,6 +787,7 @@ config ARCH_S5PV210
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
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
index 346f8df..5d482c3 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
@@ -174,6 +175,7 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.boot_params	= S5P64X0_PA_SDRAM + 0x100,
 
 	.init_irq	= s5p6440_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 33f2adf..805f2a9 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/irq.h>
@@ -193,6 +194,7 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.boot_params	= S5P64X0_PA_SDRAM + 0x100,
 
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
index 227d890..49c0b51 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -25,6 +25,7 @@
 #include <linux/input.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -256,6 +257,7 @@ MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
 	.boot_params	= S5P_PA_SDRAM + 0x100,
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
index 509627f..858aa0f 100644
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
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 85c2d51..cb1277b 100644
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
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 6c412c8..f1f7f9a 100644
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
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 5e011fc..3d0211f 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/pwm_backlight.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
@@ -321,6 +322,7 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 925fc0d..53623e8 100644
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
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
 	.timer		= &s5p_timer,
-- 
1.7.4.1

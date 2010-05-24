From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:47 +0800
Subject: [PATCH 4/6] [ARM] pxa/ezx: encode IRQ number into .nr_irqs
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Stefan Schmidt <stefan@openezx.org>
Cc: Harald Welte <laforge@openezx.org>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig             |    1 -
 arch/arm/mach-pxa/ezx.c               |    8 ++++++++
 arch/arm/mach-pxa/include/mach/irqs.h |    5 -----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 32b1fd2..60b3c17 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -291,7 +291,6 @@ config PXA_EZX
 	select PXA27x
 	select IWMMXT
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_EZX_A780
 	bool "Motorola EZX A780"
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 626c82b..3d9cf20 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -47,6 +47,8 @@
 #define GPIO19_GEN1_CAM_RST		19
 #define GPIO28_GEN2_CAM_RST		28
 
+#define EZX_NR_IRQS			(IRQ_BOARD_START + 23)
+
 static struct platform_pwm_backlight_data ezx_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 1023,
@@ -800,6 +802,7 @@ MACHINE_START(EZX_A780, "Motorola EZX A780")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a780_init,
@@ -866,6 +869,7 @@ MACHINE_START(EZX_E680, "Motorola EZX E680")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e680_init,
@@ -932,6 +936,7 @@ MACHINE_START(EZX_A1200, "Motorola EZX A1200")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a1200_init,
@@ -1124,6 +1129,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a910_init,
@@ -1190,6 +1196,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e6_init,
@@ -1230,6 +1237,7 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e2_init,
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 169567c..145fe1d 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -124,12 +124,7 @@
  * used.
  */
 #define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM)
-
-#if defined(CONFIG_PXA_EZX)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
-#else
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
-#endif
 
 /*
  * Figure out the MAX IRQ number.
-- 
1.7.0.4

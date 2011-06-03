From: manabian@gmail.com (manabian at gmail.com)
Date: Fri,  3 Jun 2011 15:48:30 +0200
Subject: [PATCH RFC] at91: remove custom interrupt priority setting
Message-ID: <1307108910-9227-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <joachim.eastwood@jotron.com>

This removes the ability for board setup to define its own
interrupt priority setting. There are 36 at91 boards none of them
use this feature. So let's remove it.

This shaves quite a few lines from mach-at91. Conversion was
scripted and is compile tested on at91rm9200.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---
 arch/arm/mach-at91/at91cap9.c           |    7 ++-----
 arch/arm/mach-at91/at91rm9200.c         |    7 ++-----
 arch/arm/mach-at91/at91sam9260.c        |    7 ++-----
 arch/arm/mach-at91/at91sam9261.c        |    7 ++-----
 arch/arm/mach-at91/at91sam9263.c        |    7 ++-----
 arch/arm/mach-at91/at91sam9g45.c        |    7 ++-----
 arch/arm/mach-at91/at91sam9rl.c         |    7 ++-----
 arch/arm/mach-at91/at91x40.c            |    7 ++-----
 arch/arm/mach-at91/board-1arm.c         |    7 +------
 arch/arm/mach-at91/board-afeb-9260v1.c  |    7 +------
 arch/arm/mach-at91/board-cam60.c        |    7 +------
 arch/arm/mach-at91/board-cap9adk.c      |    7 +------
 arch/arm/mach-at91/board-carmeva.c      |    7 +------
 arch/arm/mach-at91/board-cpu9krea.c     |    7 +------
 arch/arm/mach-at91/board-cpuat91.c      |    7 +------
 arch/arm/mach-at91/board-csb337.c       |    7 +------
 arch/arm/mach-at91/board-csb637.c       |    7 +------
 arch/arm/mach-at91/board-eb01.c         |    7 +------
 arch/arm/mach-at91/board-eb9200.c       |    7 +------
 arch/arm/mach-at91/board-ecbat91.c      |    7 +------
 arch/arm/mach-at91/board-eco920.c       |    7 +------
 arch/arm/mach-at91/board-flexibity.c    |    7 +------
 arch/arm/mach-at91/board-foxg20.c       |    7 +------
 arch/arm/mach-at91/board-gsia18s.c      |    7 +------
 arch/arm/mach-at91/board-kafa.c         |    7 +------
 arch/arm/mach-at91/board-kb9202.c       |    7 +------
 arch/arm/mach-at91/board-neocore926.c   |    7 +------
 arch/arm/mach-at91/board-pcontrol-g20.c |    7 +------
 arch/arm/mach-at91/board-picotux200.c   |    7 +------
 arch/arm/mach-at91/board-qil-a9260.c    |    7 +------
 arch/arm/mach-at91/board-rm9200dk.c     |    7 +------
 arch/arm/mach-at91/board-rm9200ek.c     |    7 +------
 arch/arm/mach-at91/board-sam9-l9260.c   |    7 +------
 arch/arm/mach-at91/board-sam9260ek.c    |    7 +------
 arch/arm/mach-at91/board-sam9261ek.c    |    7 +------
 arch/arm/mach-at91/board-sam9263ek.c    |    7 +------
 arch/arm/mach-at91/board-sam9g20ek.c    |    9 ++-------
 arch/arm/mach-at91/board-sam9m10g45ek.c |    7 +------
 arch/arm/mach-at91/board-sam9rlek.c     |    7 +------
 arch/arm/mach-at91/board-snapper9260.c  |    7 +------
 arch/arm/mach-at91/board-stamp9g20.c    |    9 ++-------
 arch/arm/mach-at91/board-usb-a9260.c    |    7 +------
 arch/arm/mach-at91/board-usb-a9263.c    |    7 +------
 arch/arm/mach-at91/board-yl-9200.c      |    7 +------
 arch/arm/mach-at91/generic.h            |   16 ++++++++--------
 45 files changed, 62 insertions(+), 266 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 17fae4a..0b98c23 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -409,13 +409,10 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91cap9_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91cap9_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91cap9_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index b228ce9..a140b5e 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -383,13 +383,10 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0	/* Advanced Interrupt Controller (IRQ6) */
 };
 
-void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91rm9200_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91rm9200_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91rm9200_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 7d606b0..a9c6bff 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -421,13 +421,10 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91sam9260_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91sam9260_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91sam9260_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index c148316..5f762c6 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -372,13 +372,10 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91sam9261_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91sam9261_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91sam9261_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index dc28477..c177d3a 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -377,13 +377,10 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91sam9263_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91sam9263_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91sam9263_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 2bb6ff9..7c80334 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -393,13 +393,10 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
-void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91sam9g45_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91sam9g45_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91sam9g45_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 1a40f16..ea10d35 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -370,13 +370,10 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91sam9rl_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91sam9rl_default_irq_priority;
-
 	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
+	at91_aic_init(at91sam9rl_default_irq_priority);
 
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 56ba3bd..ccb6d9e 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -68,11 +68,8 @@ static unsigned int at91x40_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* External IRQ2 */
 };
 
-void __init at91x40_init_interrupts(unsigned int priority[NR_AIC_IRQS])
+void __init at91x40_init_interrupts(void)
 {
-	if (!priority)
-		priority = at91x40_default_irq_priority;
-
-	at91_aic_init(priority);
+	at91_aic_init(at91x40_default_irq_priority);
 }
 
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index ab1d463..1144902 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -63,11 +63,6 @@ static void __init onearm_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init onearm_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata onearm_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -99,6 +94,6 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= onearm_init_early,
-	.init_irq	= onearm_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= onearm_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index a4924de..bb72036 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -70,11 +70,6 @@ static void __init afeb9260_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init afeb9260_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -221,7 +216,7 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= afeb9260_init_early,
-	.init_irq	= afeb9260_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= afeb9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 148fccb..66e1668 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -57,11 +57,6 @@ static void __init cam60_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cam60_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host
@@ -201,6 +196,6 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= cam60_init_early,
-	.init_irq	= cam60_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= cam60_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 1904fdf..f9a4b40 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -65,11 +65,6 @@ static void __init cap9adk_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cap9adk_init_irq(void)
-{
-	at91cap9_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -399,6 +394,6 @@ MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91cap9_map_io,
 	.init_early	= cap9adk_init_early,
-	.init_irq	= cap9adk_init_irq,
+	.init_irq	= at91cap9_init_interrupts,
 	.init_machine	= cap9adk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index f36b186..3c4271d 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -57,11 +57,6 @@ static void __init carmeva_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init carmeva_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata carmeva_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -165,6 +160,6 @@ MACHINE_START(CARMEVA, "Carmeva")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= carmeva_init_early,
-	.init_irq	= carmeva_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= carmeva_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 9805110..39c0da8 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -81,11 +81,6 @@ static void __init cpu9krea_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cpu9krea_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 /*
  * USB Host port
  */
@@ -378,6 +373,6 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= cpu9krea_init_early,
-	.init_irq	= cpu9krea_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= cpu9krea_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 6daabe3..90a6b53 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -82,11 +82,6 @@ static void __init cpuat91_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cpuat91_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata cpuat91_eth_data = {
 	.is_rmii	= 1,
 };
@@ -182,6 +177,6 @@ MACHINE_START(CPUAT91, "Eukrea")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= cpuat91_init_early,
-	.init_irq	= cpuat91_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= cpuat91_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index d98bcec..2e38de4 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -58,11 +58,6 @@ static void __init csb337_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init csb337_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata csb337_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC2,
 	.is_rmii	= 0,
@@ -260,6 +255,6 @@ MACHINE_START(CSB337, "Cogent CSB337")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= csb337_init_early,
-	.init_irq	= csb337_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= csb337_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 019aab4..2bff5d6 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -52,11 +52,6 @@ static void __init csb637_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init csb637_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata csb637_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC0,
 	.is_rmii	= 0,
@@ -141,6 +136,6 @@ MACHINE_START(CSB637, "Cogent CSB637")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= csb637_init_early,
-	.init_irq	= csb637_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= csb637_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index d2023f2..2f32996 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -30,11 +30,6 @@
 #include <mach/board.h>
 #include "generic.h"
 
-static void __init at91eb01_init_irq(void)
-{
-	at91x40_init_interrupts(NULL);
-}
-
 static void __init at91eb01_init_early(void)
 {
 	at91x40_initialize(40000000);
@@ -44,6 +39,6 @@ MACHINE_START(AT91EB01, "Atmel AT91 EB01")
 	/* Maintainer: Greg Ungerer <gerg@snapgear.com> */
 	.timer		= &at91x40_timer,
 	.init_early	= at91eb01_init_early,
-	.init_irq	= at91eb01_init_irq,
+	.init_irq	= at91x40_init_interrupts,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index e948453..336f84e 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -60,11 +60,6 @@ static void __init eb9200_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init eb9200_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata eb9200_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -123,6 +118,6 @@ MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= eb9200_init_early,
-	.init_irq	= eb9200_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= eb9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index a6f57fa..476b4b0 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -64,11 +64,6 @@ static void __init ecb_at91init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ecb_at91init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata ecb_at91eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 0,
@@ -175,6 +170,6 @@ MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= ecb_at91init_early,
-	.init_irq	= ecb_at91init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= ecb_at91board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index bfc0062..83a640c 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -47,11 +47,6 @@ static void __init eco920_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init eco920_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata eco920_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC2,
 	.is_rmii	= 1,
@@ -137,6 +132,6 @@ MACHINE_START(ECO920, "eco920")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= eco920_init_early,
-	.init_irq	= eco920_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= eco920_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 466c063..b7b1ff4 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -49,11 +49,6 @@ static void __init flexibity_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init flexibity_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 /* USB Host port */
 static struct at91_usbh_data __initdata flexibity_usbh_data = {
 	.ports		= 2,
@@ -157,6 +152,6 @@ MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= flexibity_init_early,
-	.init_irq	= flexibity_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= flexibity_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index e2d1dc9..da6f533 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -101,11 +101,6 @@ static void __init foxg20_init_early(void)
 
 }
 
-static void __init foxg20_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -269,6 +264,6 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= foxg20_init_early,
-	.init_irq	= foxg20_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= foxg20_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 1d4f36b..3b40e60 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -75,11 +75,6 @@ static void __init gsia18s_init_early(void)
 	at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
 }
 
-static void __init init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 /*
  * Two USB Host ports
  */
@@ -579,6 +574,6 @@ MACHINE_START(GSIA18S, "GS_IA18_S")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= gsia18s_init_early,
-	.init_irq	= init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= gsia18s_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 9b003ff..2959fa7 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -61,11 +61,6 @@ static void __init kafa_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init kafa_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata kafa_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 0,
@@ -101,6 +96,6 @@ MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= kafa_init_early,
-	.init_irq	= kafa_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= kafa_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a813a74..30b0adf 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -69,11 +69,6 @@ static void __init kb9202_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init kb9202_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata kb9202_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PB29,
 	.is_rmii	= 0,
@@ -142,6 +137,6 @@ MACHINE_START(KB9200, "KB920x")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= kb9202_init_early,
-	.init_irq	= kb9202_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= kb9202_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 961e805..5619713 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -66,11 +66,6 @@ static void __init neocore926_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init neocore926_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -390,6 +385,6 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= neocore926_init_early,
-	.init_irq	= neocore926_init_irq,
+	.init_irq	= at91sam9263_init_interrupts,
 	.init_machine	= neocore926_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 21a21af..557fdbd 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -54,11 +54,6 @@ static void __init pcontrol_g20_init_early(void)
 }
 
 
-static void __init init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
 	.ncs_read_setup		= 16,
@@ -225,6 +220,6 @@ MACHINE_START(PCONTROL_G20, "PControl G20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= pcontrol_g20_init_early,
-	.init_irq	= init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= pcontrol_g20_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 756cc2a..b1cd04f 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -60,11 +60,6 @@ static void __init picotux200_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init picotux200_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata picotux200_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -126,6 +121,6 @@ MACHINE_START(PICOTUX2XX, "picotux 200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= picotux200_init_early,
-	.init_irq	= picotux200_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= picotux200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index d1a6001..f086f4f 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -72,11 +72,6 @@ static void __init ek_init_early(void)
 
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -271,6 +266,6 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index aef9627..8cf3e06 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -65,11 +65,6 @@ static void __init dk_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init dk_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata dk_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -230,6 +225,6 @@ MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= dk_init_early,
-	.init_irq	= dk_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= dk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 015a021..0c58225 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -65,11 +65,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 static struct at91_eth_data __initdata ek_eth_data = {
 	.phy_irq_pin	= AT91_PIN_PC4,
 	.is_rmii	= 1,
@@ -196,6 +191,6 @@ MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index aaf1bf0..619b6ec 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -67,11 +67,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -215,6 +210,6 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d600dc1..44a97d9 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -70,11 +70,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -356,6 +351,6 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index f897f84..b28d411 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -69,11 +69,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9261_init_interrupts(NULL);
-}
-
 
 /*
  * DM9000 ethernet device
@@ -623,6 +618,6 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9261_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9261_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 605b26f..74a298d 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -68,11 +68,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -454,6 +449,6 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9263_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 7624cf0..e6be7b1 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -81,11 +81,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -406,7 +401,7 @@ MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
 
@@ -415,6 +410,6 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 063c95d..67f0c34 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -63,11 +63,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9g45_init_interrupts(NULL);
-}
-
 
 /*
  * USB HS Host port (common to OHCI & EHCI)
@@ -424,6 +419,6 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9g45_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9g45_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index effb399..ec1f1cf 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -53,11 +53,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9rl_init_interrupts(NULL);
-}
-
 
 /*
  * USB HS Device port
@@ -332,6 +327,6 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9rl_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9rl_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 3eb0a11..4283454 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -55,11 +55,6 @@ static void __init snapper9260_init_early(void)
 	at91_register_uart(AT91SAM9260_ID_US2, 3, 0);
 }
 
-static void __init snapper9260_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 static struct at91_usbh_data __initdata snapper9260_usbh_data = {
 	.ports		= 2,
 };
@@ -181,7 +176,7 @@ MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= snapper9260_init_early,
-	.init_irq	= snapper9260_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= snapper9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 5e5c856..2826218 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -76,11 +76,6 @@ static void __init portuxg20_init_early(void)
 	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
 }
 
-static void __init init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * NAND flash
@@ -301,7 +296,7 @@ MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= portuxg20_init_early,
-	.init_irq	= init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= portuxg20_board_init,
 MACHINE_END
 
@@ -310,6 +305,6 @@ MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= stamp9g20evb_init_early,
-	.init_irq	= init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= stamp9g20evb_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 0e784e6..32137d9 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -60,11 +60,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -231,6 +226,6 @@ MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9260_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index cf626dd..d6ecc04 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -59,11 +59,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
 
 /*
  * USB Host port
@@ -247,6 +242,6 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91sam9263_init_interrupts,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index c208cc3..4f51cfd 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -79,11 +79,6 @@ static void __init yl9200_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init yl9200_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
 
 /*
  * LEDs
@@ -601,6 +596,6 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= yl9200_init_early,
-	.init_irq	= yl9200_init_irq,
+	.init_irq	= at91rm9200_init_interrupts,
 	.init_machine	= yl9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 8ff3418..473d6fe 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -32,14 +32,14 @@ extern void __init at91x40_initialize(unsigned long main_clock);
 extern void __init at91cap9_initialize(unsigned long main_clock);
 
  /* Interrupts */
-extern void __init at91rm9200_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9260_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9261_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9263_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9rl_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9g45_init_interrupts(unsigned int priority[]);
-extern void __init at91x40_init_interrupts(unsigned int priority[]);
-extern void __init at91cap9_init_interrupts(unsigned int priority[]);
+extern void __init at91rm9200_init_interrupts(void);
+extern void __init at91sam9260_init_interrupts(void);
+extern void __init at91sam9261_init_interrupts(void);
+extern void __init at91sam9263_init_interrupts(void);
+extern void __init at91sam9rl_init_interrupts(void);
+extern void __init at91sam9g45_init_interrupts(void);
+extern void __init at91x40_init_interrupts(void);
+extern void __init at91cap9_init_interrupts(void);
 extern void __init at91_aic_init(unsigned int priority[]);
 
  /* Timer */
-- 
1.7.5.4

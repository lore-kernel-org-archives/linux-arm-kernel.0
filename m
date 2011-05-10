From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:13 +0200
Subject: [PATCH 3/9] at91: factorize at91 interrupts init to soc
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

they are the same except the default priority

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c          |   13 +------------
 arch/arm/mach-at91/at91cap9.c             |   13 +------------
 arch/arm/mach-at91/at91rm9200.c           |   13 +------------
 arch/arm/mach-at91/at91sam9260.c          |   13 +------------
 arch/arm/mach-at91/at91sam9261.c          |   13 +------------
 arch/arm/mach-at91/at91sam9263.c          |   13 +------------
 arch/arm/mach-at91/at91sam9g45.c          |   13 +------------
 arch/arm/mach-at91/at91sam9rl.c           |   13 +------------
 arch/arm/mach-at91/board-1arm.c           |    7 +------
 arch/arm/mach-at91/board-afeb-9260v1.c    |    8 +-------
 arch/arm/mach-at91/board-at572d940hf_ek.c |    8 +-------
 arch/arm/mach-at91/board-cam60.c          |    8 +-------
 arch/arm/mach-at91/board-cap9adk.c        |    8 +-------
 arch/arm/mach-at91/board-carmeva.c        |    7 +------
 arch/arm/mach-at91/board-cpu9krea.c       |    7 +------
 arch/arm/mach-at91/board-cpuat91.c        |    7 +------
 arch/arm/mach-at91/board-csb337.c         |    7 +------
 arch/arm/mach-at91/board-csb637.c         |    7 +------
 arch/arm/mach-at91/board-eb9200.c         |    7 +------
 arch/arm/mach-at91/board-ecbat91.c        |    7 +------
 arch/arm/mach-at91/board-eco920.c         |    7 +------
 arch/arm/mach-at91/board-flexibity.c      |    7 +------
 arch/arm/mach-at91/board-foxg20.c         |    8 +-------
 arch/arm/mach-at91/board-gsia18s.c        |    5 -----
 arch/arm/mach-at91/board-kafa.c           |    7 +------
 arch/arm/mach-at91/board-kb9202.c         |    7 +------
 arch/arm/mach-at91/board-neocore926.c     |    8 +-------
 arch/arm/mach-at91/board-pcontrol-g20.c   |    7 -------
 arch/arm/mach-at91/board-picotux200.c     |    7 +------
 arch/arm/mach-at91/board-qil-a9260.c      |    8 +-------
 arch/arm/mach-at91/board-rm9200dk.c       |    7 +------
 arch/arm/mach-at91/board-rm9200ek.c       |    7 +------
 arch/arm/mach-at91/board-sam9-l9260.c     |    8 +-------
 arch/arm/mach-at91/board-sam9260ek.c      |    8 +-------
 arch/arm/mach-at91/board-sam9261ek.c      |    8 +-------
 arch/arm/mach-at91/board-sam9263ek.c      |    8 +-------
 arch/arm/mach-at91/board-sam9g20ek.c      |   10 ++--------
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    8 +-------
 arch/arm/mach-at91/board-sam9rlek.c       |    8 +-------
 arch/arm/mach-at91/board-snapper9260.c    |    7 +------
 arch/arm/mach-at91/board-stamp9g20.c      |    6 ------
 arch/arm/mach-at91/board-usb-a9260.c      |    8 +-------
 arch/arm/mach-at91/board-usb-a9263.c      |    8 +-------
 arch/arm/mach-at91/board-yl-9200.c        |    8 +-------
 arch/arm/mach-at91/generic.h              |   10 ++--------
 arch/arm/mach-at91/setup.c                |   14 ++++++++++++++
 arch/arm/mach-at91/soc.h                  |    1 +
 47 files changed, 59 insertions(+), 338 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 1b5b320..39827ebc 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -425,19 +425,8 @@ static unsigned int at572d940hf_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at572d940hf_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at572d940hf_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at572d940hf_soc = {
 	.map_io = at572d940hf_map_io,
+	.default_irq_priority = at572d940hf_default_irq_priority,
 	.init = at572d940hf_initialize,
 };
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index cc32ac8..238b6a0 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -425,19 +425,8 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91cap9_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91cap9_soc = {
 	.map_io = at91cap9_map_io,
+	.default_irq_priority = at91cap9_default_irq_priority,
 	.init = at91cap9_initialize,
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 382354f..89e4807 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -392,19 +392,8 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0	/* Advanced Interrupt Controller (IRQ6) */
 };
 
-void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91rm9200_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91rm9200_soc = {
 	.map_io = at91rm9200_map_io,
+	.default_irq_priority = at91rm9200_default_irq_priority,
 	.init = at91rm9200_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 11b73e0..1f3abb4 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -422,19 +422,8 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91sam9260_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
+	.default_irq_priority = at91sam9260_default_irq_priority,
 	.init = at91sam9260_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 42eca26..69bc26f 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -381,19 +381,8 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91sam9261_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91sam9261_soc = {
 	.map_io = at91sam9261_map_io,
+	.default_irq_priority = at91sam9261_default_irq_priority,
 	.init = at91sam9261_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 6515897..3da9103 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -392,19 +392,8 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91sam9263_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91sam9263_soc = {
 	.map_io = at91sam9263_map_io,
+	.default_irq_priority = at91sam9263_default_irq_priority,
 	.init = at91sam9263_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index a5f1473..ecca942 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -411,19 +411,8 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
-void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91sam9g45_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91sam9g45_soc = {
 	.map_io = at91sam9g45_map_io,
+	.default_irq_priority = at91sam9g45_default_irq_priority,
 	.init = at91sam9g45_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 77a20ef..c8de47f 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -375,19 +375,8 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91sam9rl_default_irq_priority;
-
-	/* Initialize the AIC interrupt controller */
-	at91_aic_init(priority);
-
-	/* Enable GPIO interrupts */
-	at91_gpio_irq_setup();
-}
-
 struct at91_soc __initdata at91sam9rl_soc = {
 	.map_io = at91sam9rl_map_io,
+	.default_irq_priority = at91sam9rl_default_irq_priority,
 	.init = at91sam9rl_initialize,
 };
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index e588a9e..5aa5885 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= onearm_init_early,
-	.init_irq	= onearm_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= onearm_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 7cd1cb2..b0c796d 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -70,12 +70,6 @@ static void __init afeb9260_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init afeb9260_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -221,7 +215,7 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= afeb9260_init_early,
-	.init_irq	= afeb9260_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= afeb9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index f263aa8..da79a6e 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -68,12 +68,6 @@ static void __init eb_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init eb_init_irq(void)
-{
-	at572d940hf_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host Port
  */
@@ -318,6 +312,6 @@ MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= eb_init_early,
-	.init_irq	= eb_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= eb_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index bdc52e6..d1abd58 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -57,12 +57,6 @@ static void __init cam60_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cam60_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host
  */
@@ -201,6 +195,6 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= cam60_init_early,
-	.init_irq	= cam60_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= cam60_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index dfafdf9..b78c4a3 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -65,12 +65,6 @@ static void __init cap9adk_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init cap9adk_init_irq(void)
-{
-	at91cap9_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -399,6 +393,6 @@ MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= cap9adk_init_early,
-	.init_irq	= cap9adk_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= cap9adk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 0a92b7a..c578c5d 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= carmeva_init_early,
-	.init_irq	= carmeva_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= carmeva_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 01128f9..f4da8a1 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= cpu9krea_init_early,
-	.init_irq	= cpu9krea_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= cpu9krea_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 0692606..2d919f5 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= cpuat91_init_early,
-	.init_irq	= cpuat91_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= cpuat91_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 923cccb..17654d5 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= csb337_init_early,
-	.init_irq	= csb337_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= csb337_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 51131ca..72b5567 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= csb637_init_early,
-	.init_irq	= csb637_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= csb637_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 705071c..01170a2 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= eb9200_init_early,
-	.init_irq	= eb9200_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= eb9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index a9f106a..7c0313c 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= ecb_at91init_early,
-	.init_irq	= ecb_at91init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ecb_at91board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 8639fbd..8252c72 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= eco920_init_early,
-	.init_irq	= eco920_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= eco920_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index f45583e..4c3f65d 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= flexibity_init_early,
-	.init_irq	= flexibity_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= flexibity_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index b78442b..f27d1a7 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -101,12 +101,6 @@ static void __init foxg20_init_early(void)
 
 }
 
-static void __init foxg20_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -269,6 +263,6 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= foxg20_init_early,
-	.init_irq	= foxg20_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= foxg20_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 6588143..34d2712 100644
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
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index d26b960..4a17089 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= kafa_init_early,
-	.init_irq	= kafa_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= kafa_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a4d8153..9dc8d49 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= kb9202_init_early,
-	.init_irq	= kb9202_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= kb9202_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 26a4c63..9bc6ab3 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -66,12 +66,6 @@ static void __init neocore926_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init neocore926_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -390,6 +384,6 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= neocore926_init_early,
-	.init_irq	= neocore926_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= neocore926_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 7651e7f..23785e2 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -53,13 +53,6 @@ static void __init pcontrol_g20_init_early(void)
 	at91_register_uart(AT91SAM9260_ID_US4, 3, 0);
 }
 
-
-static void __init init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
 	.ncs_read_setup		= 16,
 	.nrd_setup		= 18,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index c7294f8..b7b8390 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= picotux200_init_early,
-	.init_irq	= picotux200_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= picotux200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 68e31a9..81f9110 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -72,12 +72,6 @@ static void __init ek_init_early(void)
 
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -271,6 +265,6 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 97c6f21..6f08faa 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= dk_init_early,
-	.init_irq	= dk_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= dk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 72aa8bf..85bcccd 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 93c36bd..4d3a02f 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -67,12 +67,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -215,6 +209,6 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 0330db3..12f75a3 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -70,12 +70,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -356,6 +350,6 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 65ab1cd..785b484 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -69,12 +69,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9261_init_interrupts(NULL);
-}
-
-
 /*
  * DM9000 ethernet device
  */
@@ -623,6 +617,6 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 5b07981..70e5646 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -68,12 +68,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -454,6 +448,6 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 8e7327a..c08a1e7 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -81,12 +81,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -406,7 +400,7 @@ MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
 
@@ -415,6 +409,6 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index f112ad9..7851efd 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -63,12 +63,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9g45_init_interrupts(NULL);
-}
-
-
 /*
  * USB HS Host port (common to OHCI & EHCI)
  */
@@ -424,6 +418,6 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index defbca4..4f14b54 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -53,12 +53,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9rl_init_interrupts(NULL);
-}
-
-
 /*
  * USB HS Device port
  */
@@ -332,6 +326,6 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index c600b14..25cd3ff 100644
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
 	.map_io		= at91_map_io,
 	.init_early	= snapper9260_init_early,
-	.init_irq	= snapper9260_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= snapper9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index e65efda..9821be2 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -76,12 +76,6 @@ static void __init portuxg20_init_early(void)
 	at91_register_uart(AT91SAM9260_ID_US5, 6, 0);
 }
 
-static void __init init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * NAND flash
  */
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index afc3b04..8c4c1a0 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -60,12 +60,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9260_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -231,6 +225,6 @@ MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index 25357e0..25e7937 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -59,12 +59,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init ek_init_irq(void)
-{
-	at91sam9263_init_interrupts(NULL);
-}
-
-
 /*
  * USB Host port
  */
@@ -247,6 +241,6 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= ek_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e8a8ab9..95edcbd 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -79,12 +79,6 @@ static void __init yl9200_init_early(void)
 	at91_set_serial_console(0);
 }
 
-static void __init yl9200_init_irq(void)
-{
-	at91rm9200_init_interrupts(NULL);
-}
-
-
 /*
  * LEDs
  */
@@ -601,6 +595,6 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
 	.init_early	= yl9200_init_early,
-	.init_irq	= yl9200_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= yl9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 84e5b1d..e807520 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -19,15 +19,9 @@ extern void __init at91_initialize(unsigned long main_clock);
 extern void __init at91x40_initialize(unsigned long main_clock);
 
  /* Interrupts */
-extern void __init at91rm9200_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9260_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9261_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9263_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9rl_init_interrupts(unsigned int priority[]);
-extern void __init at91sam9g45_init_interrupts(unsigned int priority[]);
+extern void __init at91_init_irq_default(void);
+extern void __init at91_init_interrupts(unsigned int priority[]);
 extern void __init at91x40_init_interrupts(unsigned int priority[]);
-extern void __init at91cap9_init_interrupts(unsigned int priority[]);
-extern void __init at572d940hf_init_interrupts(unsigned int priority[]);
 extern void __init at91_aic_init(unsigned int priority[]);
 
  /* Timer */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index dd62c46..c8f23ae 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -18,6 +18,20 @@
 
 struct at91_soc __initdata at91_boot_soc;
 
+void __init at91_init_irq_default(void)
+{
+	at91_init_interrupts(current_soc.default_irq_priority);
+}
+
+void __init at91_init_interrupts(unsigned int *priority)
+{
+	/* Initialize the AIC interrupt controller */
+	at91_aic_init(priority);
+
+	/* Enable GPIO interrupts */
+	at91_gpio_irq_setup();
+}
+
 static struct map_desc at91_io_desc __initdata = {
 	.virtual	= AT91_VA_BASE_SYS,
 	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 917f610..d847565 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -5,6 +5,7 @@
  */
 
 struct at91_soc {
+	unsigned int *default_irq_priority;
 	void (*map_io)(void);
 	void (*init)(unsigned long main_clock);
 };
-- 
1.7.4.1

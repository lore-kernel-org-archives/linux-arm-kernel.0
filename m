From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 19:37:20 +0200
Subject: [PATCH] at91: fix map_io init usage
Message-ID: <1304012240-13571-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

switch early init to init_early and introduce soc map_io

with this Patch we will not do any more early device setup during the map io

tks to Russel to point the new call back

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-at91/at572d940hf.c            |    5 ++++-
 arch/arm/mach-at91/at91cap9.c               |    5 ++++-
 arch/arm/mach-at91/at91rm9200.c             |    5 ++++-
 arch/arm/mach-at91/at91sam9260.c            |    9 ++++++---
 arch/arm/mach-at91/at91sam9261.c            |    6 ++++--
 arch/arm/mach-at91/at91sam9263.c            |    5 ++++-
 arch/arm/mach-at91/at91sam9g45.c            |    5 ++++-
 arch/arm/mach-at91/at91sam9rl.c             |    5 ++++-
 arch/arm/mach-at91/board-1arm.c             |    5 +++--
 arch/arm/mach-at91/board-afeb-9260v1.c      |    5 +++--
 arch/arm/mach-at91/board-at572d940hf_ek.c   |    5 +++--
 arch/arm/mach-at91/board-cam60.c            |    5 +++--
 arch/arm/mach-at91/board-cap9adk.c          |    5 +++--
 arch/arm/mach-at91/board-carmeva.c          |    5 +++--
 arch/arm/mach-at91/board-cpu9krea.c         |    5 +++--
 arch/arm/mach-at91/board-cpuat91.c          |    5 +++--
 arch/arm/mach-at91/board-csb337.c           |    5 +++--
 arch/arm/mach-at91/board-csb637.c           |    5 +++--
 arch/arm/mach-at91/board-eb9200.c           |    5 +++--
 arch/arm/mach-at91/board-ecbat91.c          |    5 +++--
 arch/arm/mach-at91/board-eco920.c           |    5 +++--
 arch/arm/mach-at91/board-flexibity.c        |    5 +++--
 arch/arm/mach-at91/board-foxg20.c           |    5 +++--
 arch/arm/mach-at91/board-gsia18s.c          |    7 ++++---
 arch/arm/mach-at91/board-kafa.c             |    5 +++--
 arch/arm/mach-at91/board-kb9202.c           |    5 +++--
 arch/arm/mach-at91/board-neocore926.c       |    5 +++--
 arch/arm/mach-at91/board-pcontrol-g20.c     |    7 ++++---
 arch/arm/mach-at91/board-picotux200.c       |    5 +++--
 arch/arm/mach-at91/board-qil-a9260.c        |    5 +++--
 arch/arm/mach-at91/board-rm9200dk.c         |    5 +++--
 arch/arm/mach-at91/board-rm9200ek.c         |    5 +++--
 arch/arm/mach-at91/board-sam9-l9260.c       |    5 +++--
 arch/arm/mach-at91/board-sam9260ek.c        |    5 +++--
 arch/arm/mach-at91/board-sam9261ek.c        |    5 +++--
 arch/arm/mach-at91/board-sam9263ek.c        |    5 +++--
 arch/arm/mach-at91/board-sam9g20ek.c        |    8 +++++---
 arch/arm/mach-at91/board-sam9m10g45ek.c     |    5 +++--
 arch/arm/mach-at91/board-sam9rlek.c         |    5 +++--
 arch/arm/mach-at91/board-snapper9260.c      |    5 +++--
 arch/arm/mach-at91/board-stamp9g20.c        |   14 ++++++++------
 arch/arm/mach-at91/board-usb-a9260.c        |    5 +++--
 arch/arm/mach-at91/board-usb-a9263.c        |    5 +++--
 arch/arm/mach-at91/board-yl-9200.c          |    5 +++--
 arch/arm/mach-at91/generic.h                |   11 +++++++++++
 arch/arm/mach-at91/include/mach/stamp9g20.h |    2 +-
 46 files changed, 163 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index a6b9c68..bacd376 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -302,11 +302,14 @@ static void at572d940hf_reset(void)
  *  AT572D940HF processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at572d940hf_initialize(unsigned long main_clock)
+void __init at572d940hf_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
+}
 
+void __init at572d940hf_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7337617..69df2bb 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -303,11 +303,14 @@ static void at91cap9_poweroff(void)
  *  AT91CAP9 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91cap9_initialize(unsigned long main_clock)
+void __init at91cap9_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
+}
 
+void __init at91cap9_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2e9ecad..164a98e 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -270,11 +270,14 @@ static void at91rm9200_reset(void)
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
-void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks)
+void __init at91rm9200_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
+}
 
+void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks)
+{
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 195208b..5430669 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -289,7 +289,7 @@ static void at91sam9260_poweroff(void)
  *  AT91SAM9260 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9xe_initialize(void)
+static void __init at91sam9xe_map_io(void)
 {
 	unsigned long cidr, sram_size;
 
@@ -310,18 +310,21 @@ static void __init at91sam9xe_initialize(void)
 	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
 }
 
-void __init at91sam9260_initialize(unsigned long main_clock)
+void __init at91sam9260_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9260_io_desc, ARRAY_SIZE(at91sam9260_io_desc));
 
 	if (cpu_is_at91sam9xe())
-		at91sam9xe_initialize();
+		at91sam9xe_map_io();
 	else if (cpu_is_at91sam9g20())
 		iotable_init(at91sam9g20_sram_desc, ARRAY_SIZE(at91sam9g20_sram_desc));
 	else
 		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
+}
 
+void __init at91sam9260_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index fcad886..e3bafae 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -267,7 +267,7 @@ static void at91sam9261_poweroff(void)
  *  AT91SAM9261 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9261_initialize(unsigned long main_clock)
+void __init at91sam9261_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9261_io_desc, ARRAY_SIZE(at91sam9261_io_desc));
@@ -276,8 +276,10 @@ void __init at91sam9261_initialize(unsigned long main_clock)
 		iotable_init(at91sam9g10_sram_desc, ARRAY_SIZE(at91sam9g10_sram_desc));
 	else
 		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
+}
 
-
+void __init at91sam9261_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 249f900..6a085fe 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -279,11 +279,14 @@ static void at91sam9263_poweroff(void)
  *  AT91SAM9263 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9263_initialize(unsigned long main_clock)
+void __init at91sam9263_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
+}
 
+void __init at91sam9263_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..024e456 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -306,11 +306,14 @@ static void at91sam9g45_poweroff(void)
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9g45_initialize(unsigned long main_clock)
+void __init at91sam9g45_map_io(void)
 {
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
+}
 
+void __init at91sam9g45_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6a9d24e..67c8697 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -252,7 +252,7 @@ static void at91sam9rl_poweroff(void)
  *  AT91SAM9RL processor initialization
  * -------------------------------------------------------------------- */
 
-void __init at91sam9rl_initialize(unsigned long main_clock)
+void __init at91sam9rl_map_io(void)
 {
 	unsigned long cidr, sram_size;
 
@@ -275,7 +275,10 @@ void __init at91sam9rl_initialize(unsigned long main_clock)
 
 	/* Map SRAM */
 	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
+}
 
+void __init at91sam9rl_initialize(unsigned long main_clock)
+{
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 8a3fc84..ad34a32 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -39,7 +39,7 @@
 #include "generic.h"
 
 
-static void __init onearm_map_io(void)
+static void __init onearm_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
@@ -94,7 +94,8 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= onearm_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= onearm_init_irq,
+	.init_early	= onearm_init_early,
 	.init_machine	= onearm_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index cba7f77..6fa546c 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -48,7 +48,7 @@
 #include "generic.h"
 
 
-static void __init afeb9260_map_io(void)
+static void __init afeb9260_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -220,8 +220,9 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= afeb9260_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= afeb9260_init_irq,
+	.init_early	= afeb9260_init_early,
 	.init_machine	= afeb9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 8ad58bd..eb10cd2 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -47,7 +47,7 @@
 #include "generic.h"
 
 
-static void __init eb_map_io(void)
+static void __init eb_init_early(void)
 {
 	/* Initialize processor: 12.500 MHz crystal */
 	at572d940hf_initialize(12000000);
@@ -317,7 +317,8 @@ MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	/* Maintainer: Atmel <costa.antonior@gmail.com> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= eb_map_io,
+	.map_io		= at572d940hf_map_io,
 	.init_irq	= eb_init_irq,
+	.init_early	= eb_init_early,
 	.init_machine	= eb_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index b54e3e6..ad7ddf0 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -45,7 +45,7 @@
 #include "generic.h"
 
 
-static void __init cam60_map_io(void)
+static void __init cam60_init_early(void)
 {
 	/* Initialize processor: 10 MHz crystal */
 	at91sam9260_initialize(10000000);
@@ -200,7 +200,8 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= cam60_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= cam60_init_irq,
+	.init_early	= cam60_init_early,
 	.init_machine	= cam60_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 69aa349..8c5ced8 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -50,7 +50,7 @@
 #include "generic.h"
 
 
-static void __init cap9adk_map_io(void)
+static void __init cap9adk_init_early(void)
 {
 	/* Initialize processor: 12 MHz crystal */
 	at91cap9_initialize(12000000);
@@ -398,7 +398,8 @@ MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= cap9adk_map_io,
+	.map_io		= at91cap9_map_io,
 	.init_irq	= cap9adk_init_irq,
+	.init_early	= cap9adk_init_early,
 	.init_machine	= cap9adk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 295e1e7..fc1a310 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -40,7 +40,7 @@
 #include "generic.h"
 
 
-static void __init carmeva_map_io(void)
+static void __init carmeva_init_early(void)
 {
 	/* Initialize processor: 20.000 MHz crystal */
 	at91rm9200_initialize(20000000, AT91RM9200_BGA);
@@ -164,7 +164,8 @@ MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= carmeva_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= carmeva_init_irq,
+	.init_early	= carmeva_init_early,
 	.init_machine	= carmeva_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 3838594..a414c40 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -47,7 +47,7 @@
 #include "sam9_smc.h"
 #include "generic.h"
 
-static void __init cpu9krea_map_io(void)
+static void __init cpu9krea_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -377,7 +377,8 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= cpu9krea_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= cpu9krea_init_irq,
+	.init_early	= cpu9krea_init_early,
 	.init_machine	= cpu9krea_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2f4dd8c..7309fd0 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -50,7 +50,7 @@ static struct gpio_led cpuat91_leds[] = {
 	},
 };
 
-static void __init cpuat91_map_io(void)
+static void __init cpuat91_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
@@ -177,7 +177,8 @@ MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= cpuat91_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= cpuat91_init_irq,
+	.init_early	= cpuat91_init_early,
 	.init_machine	= cpuat91_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 464839d..ed7c7de 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -43,7 +43,7 @@
 #include "generic.h"
 
 
-static void __init csb337_map_io(void)
+static void __init csb337_init_early(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
 	at91rm9200_initialize(3686400, AT91RM9200_BGA);
@@ -259,7 +259,8 @@ MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= csb337_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= csb337_init_irq,
+	.init_early	= csb337_init_early,
 	.init_machine	= csb337_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 431688c..581429b 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -40,7 +40,7 @@
 #include "generic.h"
 
 
-static void __init csb637_map_io(void)
+static void __init csb637_init_early(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
 	at91rm9200_initialize(3686400, AT91RM9200_BGA);
@@ -140,7 +140,8 @@ MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= csb637_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= csb637_init_irq,
+	.init_early	= csb637_init_early,
 	.init_machine	= csb637_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 6cf6566..c51bd5e 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -40,7 +40,7 @@
 #include "generic.h"
 
 
-static void __init eb9200_map_io(void)
+static void __init eb9200_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_BGA);
@@ -122,7 +122,8 @@ static void __init eb9200_board_init(void)
 MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= eb9200_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= eb9200_init_irq,
+	.init_early	= eb9200_init_early,
 	.init_machine	= eb9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index de2fd04..74e5e11 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -42,7 +42,7 @@
 #include "generic.h"
 
 
-static void __init ecb_at91map_io(void)
+static void __init ecb_at91init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
@@ -170,7 +170,8 @@ MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= ecb_at91map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= ecb_at91init_irq,
+	.init_early	= ecb_at91init_early,
 	.init_machine	= ecb_at91board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 87f6f83..0ab4b66 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -28,7 +28,7 @@
 #include <mach/at91rm9200_mc.h>
 #include "generic.h"
 
-static void __init eco920_map_io(void)
+static void __init eco920_init_early(void)
 {
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
 
@@ -131,7 +131,8 @@ MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= eco920_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= eco920_init_irq,
+	.init_early	= eco920_init_early,
 	.init_machine	= eco920_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index c8a62dc..948ed7b 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -37,7 +37,7 @@
 
 #include "generic.h"
 
-static void __init flexibity_map_io(void)
+static void __init flexibity_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -156,7 +156,8 @@ MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= flexibity_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= flexibity_init_irq,
+	.init_early	= flexibity_init_early,
 	.init_machine	= flexibity_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index dfc7dfe..aede4f1 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -57,7 +57,7 @@
  */
 
 
-static void __init foxg20_map_io(void)
+static void __init foxg20_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -268,7 +268,8 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= foxg20_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= foxg20_init_irq,
+	.init_early	= foxg20_init_early,
 	.init_machine	= foxg20_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index bc28136..a4b742a 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -38,9 +38,9 @@
 #include "sam9_smc.h"
 #include "generic.h"
 
-static void __init gsia18s_map_io(void)
+static void __init gsia18s_init_early(void)
 {
-	stamp9g20_map_io();
+	stamp9g20_init_early();
 
 	/*
 	 * USART0 on ttyS1 (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI).
@@ -578,7 +578,8 @@ static void __init gsia18s_board_init(void)
 MACHINE_START(GSIA18S, "GS_IA18_S")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= gsia18s_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= init_irq,
+	.init_early	= gsia18s_init_early,
 	.init_machine	= gsia18s_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index d2e1f4e..de8e3fa 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -39,7 +39,7 @@
 #include "generic.h"
 
 
-static void __init kafa_map_io(void)
+static void __init kafa_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
@@ -96,7 +96,8 @@ MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= kafa_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= kafa_init_irq,
+	.init_early	= kafa_init_early,
 	.init_machine	= kafa_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a13d206..a479e79 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -42,7 +42,7 @@
 #include "generic.h"
 
 
-static void __init kb9202_map_io(void)
+static void __init kb9202_init_early(void)
 {
 	/* Initialize processor: 10 MHz crystal */
 	at91rm9200_initialize(10000000, AT91RM9200_PQFP);
@@ -138,7 +138,8 @@ MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= kb9202_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= kb9202_init_irq,
+	.init_early	= kb9202_init_early,
 	.init_machine	= kb9202_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index fe5f1d4..24f68a5 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -51,7 +51,7 @@
 #include "generic.h"
 
 
-static void __init neocore926_map_io(void)
+static void __init neocore926_init_early(void)
 {
 	/* Initialize processor: 20 MHz crystal */
 	at91sam9263_initialize(20000000);
@@ -389,7 +389,8 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= neocore926_map_io,
+	.map_io		= at91sam9263_map_io,
 	.init_irq	= neocore926_init_irq,
+	.init_early	= neocore926_init_early,
 	.init_machine	= neocore926_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index feb6578..757e81c 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -37,9 +37,9 @@
 #include "generic.h"
 
 
-static void __init pcontrol_g20_map_io(void)
+static void __init pcontrol_g20_init_early(void)
 {
-	stamp9g20_map_io();
+	stamp9g20_init_early();
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) piggyback  A2 */
 	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS
@@ -224,7 +224,8 @@ MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= pcontrol_g20_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= init_irq,
+	.init_early	= pcontrol_g20_init_early,
 	.init_machine	= pcontrol_g20_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 55dad3a..529590f 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -43,7 +43,7 @@
 #include "generic.h"
 
 
-static void __init picotux200_map_io(void)
+static void __init picotux200_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_BGA);
@@ -125,7 +125,8 @@ MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= picotux200_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= picotux200_init_irq,
+	.init_early	= picotux200_init_early,
 	.init_machine	= picotux200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 69d15a8..0ddd5f9 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -48,7 +48,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
 	at91sam9260_initialize(12000000);
@@ -270,7 +270,8 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 4c1047c..64af8a6 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -45,7 +45,7 @@
 #include "generic.h"
 
 
-static void __init dk_map_io(void)
+static void __init dk_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_BGA);
@@ -229,7 +229,8 @@ MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= dk_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= dk_init_irq,
+	.init_early	= dk_init_early,
 	.init_machine	= dk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 9df1be8..06d5a5a 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -45,7 +45,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_BGA);
@@ -195,7 +195,8 @@ MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 25a26be..b315424 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -44,7 +44,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -214,7 +214,8 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index fb05ec0..84ae2c4 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -50,7 +50,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -355,7 +355,8 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index a0b182e..b7f021e 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -54,7 +54,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9261_initialize(18432000);
@@ -622,7 +622,8 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9261_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 3c9cbd8..ddf20fd 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -53,7 +53,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 16.367 MHz crystal */
 	at91sam9263_initialize(16367660);
@@ -453,7 +453,8 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9263_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 2de10ca..2cdd358 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -61,7 +61,7 @@ static int inline ek_have_2mmc(void)
 }
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -405,8 +405,9 @@ MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
 
@@ -414,7 +415,8 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 200e155..cec2486 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -47,7 +47,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
 	at91sam9g45_initialize(12000000);
@@ -423,7 +423,8 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9g45_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 3bf3408..22264b5 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -38,7 +38,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
 	at91sam9rl_initialize(12000000);
@@ -331,7 +331,8 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9rl_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 17f7d9b..f310df3 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -40,7 +40,7 @@
 
 #define SNAPPER9260_IO_EXP_GPIO(x)	(NR_BUILTIN_GPIO + (x))
 
-static void __init snapper9260_map_io(void)
+static void __init snapper9260_init_early(void)
 {
 	at91sam9260_initialize(18432000);
 
@@ -180,8 +180,9 @@ static void __init snapper9260_board_init(void)
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= snapper9260_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= snapper9260_init_irq,
+	.init_early	= snapper9260_init_early,
 	.init_machine	= snapper9260_board_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index f8902b1..e07a81c 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -32,7 +32,7 @@
 #include "generic.h"
 
 
-void __init stamp9g20_map_io(void)
+void __init stamp9g20_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91sam9260_initialize(18432000);
@@ -44,9 +44,9 @@ void __init stamp9g20_map_io(void)
 	at91_set_serial_console(0);
 }
 
-static void __init stamp9g20evb_map_io(void)
+static void __init stamp9g20evb_init_early(void)
 {
-	stamp9g20_map_io();
+	stamp9g20_init_early();
 
 	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
 	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
@@ -54,7 +54,7 @@ static void __init stamp9g20evb_map_io(void)
 						| ATMEL_UART_DCD | ATMEL_UART_RI);
 }
 
-static void __init portuxg20_map_io(void)
+static void __init portuxg20_init_early(void)
 {
 	stamp9g20_map_io();
 
@@ -300,8 +300,9 @@ MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= portuxg20_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= init_irq,
+	.init_early	= portuxg20_init_early,
 	.init_machine	= portuxg20_board_init,
 MACHINE_END
 
@@ -309,7 +310,8 @@ MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= stamp9g20evb_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= init_irq,
+	.init_early	= stamp9g20evb_init_early,
 	.init_machine	= stamp9g20evb_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 07784ba..3f177e9 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -48,7 +48,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
 	at91sam9260_initialize(12000000);
@@ -230,7 +230,8 @@ MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9260_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index b6145089..c6d3100 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -47,7 +47,7 @@
 #include "generic.h"
 
 
-static void __init ek_map_io(void)
+static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.00 MHz crystal */
 	at91sam9263_initialize(12000000);
@@ -246,7 +246,8 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
-	.map_io		= ek_map_io,
+	.map_io		= at91sam9263_map_io,
 	.init_irq	= ek_init_irq,
+	.init_early	= ek_init_early,
 	.init_machine	= ek_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e0f0080..bc55bbf 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -49,7 +49,7 @@
 #include "generic.h"
 
 
-static void __init yl9200_map_io(void)
+static void __init yl9200_init_early(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
@@ -596,7 +596,8 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
-	.map_io		= yl9200_map_io,
+	.map_io		= at91rm9200_map_io,
 	.init_irq	= yl9200_init_irq,
+	.init_early	= yl9200_init_early,
 	.init_machine	= yl9200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c66deb..50d46fa 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -8,6 +8,17 @@
  * published by the Free Software Foundation.
  */
 
+ /* Map io */
+extern void __init at91rm9200_map_io(void);
+extern void __init at91sam9260_map_io(void);
+extern void __init at91sam9261_map_io(void);
+extern void __init at91sam9263_map_io(void);
+extern void __init at91sam9rl_map_io(void);
+extern void __init at91sam9g45_map_io(void);
+extern void __init at91x40_map_io(void);
+extern void __init at91cap9_map_io(void);
+extern void __init at572d940hf_map_io(void);
+
  /* Processors */
 extern void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks);
 extern void __init at91sam9260_initialize(unsigned long main_clock);
diff --git a/arch/arm/mach-at91/include/mach/stamp9g20.h b/arch/arm/mach-at91/include/mach/stamp9g20.h
index 6120f9c..f62c0ab 100644
--- a/arch/arm/mach-at91/include/mach/stamp9g20.h
+++ b/arch/arm/mach-at91/include/mach/stamp9g20.h
@@ -1,7 +1,7 @@
 #ifndef __MACH_STAMP9G20_H
 #define __MACH_STAMP9G20_H
 
-void stamp9g20_map_io(void);
+void stamp9g20_init_early(void);
 void stamp9g20_board_init(void);
 
 #endif
-- 
1.7.4.1

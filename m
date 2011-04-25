From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:11 +0200
Subject: [PATCH 01/14] at91rm9200: introduce at91rm9200_set_type to specficy
	cpu package
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as we can not detect it
by defaut the type will be bga
introduce cpu_is_at91rm9200_bga and cpu_is_at91rm9200_pqfp

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c       |   13 +++++++++++--
 arch/arm/mach-at91/board-1arm.c       |    6 +++++-
 arch/arm/mach-at91/board-carmeva.c    |    2 +-
 arch/arm/mach-at91/board-cpuat91.c    |    6 +++++-
 arch/arm/mach-at91/board-csb337.c     |    2 +-
 arch/arm/mach-at91/board-csb637.c     |    2 +-
 arch/arm/mach-at91/board-eb9200.c     |    2 +-
 arch/arm/mach-at91/board-ecbat91.c    |    6 +++++-
 arch/arm/mach-at91/board-eco920.c     |    7 ++++++-
 arch/arm/mach-at91/board-kafa.c       |    6 +++++-
 arch/arm/mach-at91/board-kb9202.c     |    7 +++++--
 arch/arm/mach-at91/board-picotux200.c |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c   |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c   |    2 +-
 arch/arm/mach-at91/board-yl-9200.c    |    6 +++++-
 arch/arm/mach-at91/generic.h          |    3 ++-
 arch/arm/mach-at91/include/mach/cpu.h |    7 +++++++
 17 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2e9ecad..7bdf566 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -18,6 +18,7 @@
 #include <mach/at91rm9200.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 #include "clock.h"
@@ -266,11 +267,18 @@ static void at91rm9200_reset(void)
 	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
 }
 
+int rm9200_type;
+EXPORT_SYMBOL(rm9200_type);
+
+void __init at91rm9200_set_type(int type)
+{
+	rm9200_type = type;
+}
 
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
-void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks)
+void __init at91rm9200_initialize(unsigned long main_clock)
 {
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
@@ -288,7 +296,8 @@ void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks
 	at91rm9200_register_clocks();
 
 	/* Initialize GPIO subsystem */
-	at91_gpio_init(at91rm9200_gpio, banks);
+	at91_gpio_init(at91rm9200_gpio,
+		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
 }
 
 
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 8a3fc84..d294293 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -35,14 +35,18 @@
 
 #include <mach/board.h>
 #include <mach/gpio.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 
 
 static void __init onearm_map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	at91rm9200_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 295e1e7..ac8f224 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -43,7 +43,7 @@
 static void __init carmeva_map_io(void)
 {
 	/* Initialize processor: 20.000 MHz crystal */
-	at91rm9200_initialize(20000000, AT91RM9200_BGA);
+	at91rm9200_initialize(20000000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2f4dd8c..c25db34 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -38,6 +38,7 @@
 #include <mach/board.h>
 #include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 
@@ -52,8 +53,11 @@ static struct gpio_led cpuat91_leds[] = {
 
 static void __init cpuat91_map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	at91rm9200_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 464839d..2a3f2f7 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -46,7 +46,7 @@
 static void __init csb337_map_io(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400, AT91RM9200_BGA);
+	at91rm9200_initialize(3686400);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 431688c..d42a7c3 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -43,7 +43,7 @@
 static void __init csb637_map_io(void)
 {
 	/* Initialize processor: 3.6864 MHz crystal */
-	at91rm9200_initialize(3686400, AT91RM9200_BGA);
+	at91rm9200_initialize(3686400);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 6cf6566..e732350 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -43,7 +43,7 @@
 static void __init eb9200_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_BGA);
+	at91rm9200_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index de2fd04..587ed99 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -38,14 +38,18 @@
 
 #include <mach/board.h>
 #include <mach/gpio.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 
 
 static void __init ecb_at91map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	at91rm9200_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PC7, AT91_PIN_PC7);
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 87f6f83..5cc591f 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -26,11 +26,16 @@
 
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
+#include <mach/cpu.h>
+
 #include "generic.h"
 
 static void __init eco920_map_io(void)
 {
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
+	at91rm9200_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index d2e1f4e..1def877 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -35,14 +35,18 @@
 
 #include <mach/board.h>
 #include <mach/gpio.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 
 
 static void __init kafa_map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	at91rm9200_initialize(18432000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PB4, AT91_PIN_PB4);
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a13d206..ad0fe91 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -36,7 +36,7 @@
 
 #include <mach/board.h>
 #include <mach/gpio.h>
-
+#include <mach/cpu.h>
 #include <mach/at91rm9200_mc.h>
 
 #include "generic.h"
@@ -44,8 +44,11 @@
 
 static void __init kb9202_map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 10 MHz crystal */
-	at91rm9200_initialize(10000000, AT91RM9200_PQFP);
+	at91rm9200_initialize(10000000);
 
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PC19, AT91_PIN_PC18);
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 55dad3a..c153863 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -46,7 +46,7 @@
 static void __init picotux200_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_BGA);
+	at91rm9200_initialize(18432000);
 
 	/* DBGU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 4c1047c..b8f3b3d 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -48,7 +48,7 @@
 static void __init dk_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_BGA);
+	at91rm9200_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB2, AT91_PIN_PB2);
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 9df1be8..b55edc6 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -48,7 +48,7 @@
 static void __init ek_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_BGA);
+	at91rm9200_initialize(18432000);
 
 	/* Setup the LEDs */
 	at91_init_leds(AT91_PIN_PB1, AT91_PIN_PB2);
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e0f0080..097328b 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -45,14 +45,18 @@
 #include <mach/board.h>
 #include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
+#include <mach/cpu.h>
 
 #include "generic.h"
 
 
 static void __init yl9200_map_io(void)
 {
+	/* Set cpu type: PQFP */
+	at91rm9200_set_type(ARCH_REVISON_9200_PQFP);
+
 	/* Initialize processor: 18.432 MHz crystal */
-	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
+	at91rm9200_initialize(18432000);
 
 	/* Setup the LEDs D2=PB17 (timer), D3=PB16 (cpu) */
 	at91_init_leds(AT91_PIN_PB16, AT91_PIN_PB17);
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c66deb..87ec31d 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -9,7 +9,8 @@
  */
 
  /* Processors */
-extern void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks);
+extern void __init at91rm9200_set_type(int type);
+extern void __init at91rm9200_initialize(unsigned long main_clock);
 extern void __init at91sam9260_initialize(unsigned long main_clock);
 extern void __init at91sam9261_initialize(unsigned long main_clock);
 extern void __init at91sam9263_initialize(unsigned long main_clock);
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 0700f21..ab00372 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -90,9 +90,16 @@ static inline unsigned long at91cap9_rev_identify(void)
 #endif
 
 #ifdef CONFIG_ARCH_AT91RM9200
+extern int rm9200_type;
+#define ARCH_REVISON_9200_BGA	(0 << 0)
+#define ARCH_REVISON_9200_PQFP	(1 << 0)
 #define cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
+#define cpu_is_at91rm9200_bga()	(!cpu_is_at91rm9200_pqfp())
+#define cpu_is_at91rm9200_pqfp() (cpu_is_at91rm9200() && rm9200_type & ARCH_REVISON_9200_PQFP)
 #else
 #define cpu_is_at91rm9200()	(0)
+#define cpu_is_at91rm9200_bga()	(0)
+#define cpu_is_at91rm9200_pqfp() (0)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9260
-- 
1.7.4.1

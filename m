From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Jan 2015 19:08:33 +0100
Subject: [PATCH v2] ARM: at91: at91rm9200: set idle and restart from
 rm9200_dt_device_init()
In-Reply-To: <1421359100-8930-12-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-12-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1422295713-26549-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Setup arm_pm_idle and arm_pm_restart function pointers from
rm9200_dt_device_init() function to simplify the at91rm9200 initialization
process.
This same move is already done for the sam9s.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
[nicolas.ferre at atmel.com: adapt patch to newer series]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c      | 14 --------------
 arch/arm/mach-at91/board-dt-rm9200.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 3be1963f5c56..ae0d5f0eb108 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -22,25 +22,11 @@
 #include "generic.h"
 
 
-static void at91rm9200_restart(enum reboot_mode reboot_mode, const char *cmd)
-{
-	/*
-	 * Perform a hardware reset with the use of the Watchdog timer.
-	 */
-	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
-	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
-}
 
 /* --------------------------------------------------------------------
  *  AT91RM9200 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91rm9200_initialize(void)
-{
-	arm_pm_idle = at91rm9200_idle;
-	arm_pm_restart = at91rm9200_restart;
-}
 
 AT91_SOC_START(at91rm9200)
-	.init = at91rm9200_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index d47c4433444d..5fcd1c73ece0 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -22,9 +22,21 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/system_misc.h>
+
+#include <mach/at91_st.h>
 
 #include "generic.h"
 
+static void at91rm9200_restart(enum reboot_mode reboot_mode, const char *cmd)
+{
+	/*
+	 * Perform a hardware reset with the use of the Watchdog timer.
+	 */
+	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
+	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
+}
+
 static void __init at91rm9200_dt_timer_init(void)
 {
 	of_clk_init(NULL);
@@ -35,6 +47,8 @@ static void __init rm9200_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	arm_pm_idle = at91rm9200_idle;
+	arm_pm_restart = at91rm9200_restart;
 	at91_rm9200_pm_init();
 }
 
-- 
2.1.3

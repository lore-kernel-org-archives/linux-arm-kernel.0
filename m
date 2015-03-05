From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 13:11:23 +0100
Subject: [PATCH v2 6/9] ARM: at91: at91rm9200 use SoC detection infrastructure
In-Reply-To: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425557486-3534-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the soc detection infrastructure for at91rm9200 initialization.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200.c | 34 ++++++++++++++++++++--------------
 arch/arm/mach-at91/soc.h        |  3 +++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 8fcfb70f7124..9f3f91daf9fe 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -8,25 +8,27 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/clk-provider.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/clk-provider.h>
 
-#include <asm/setup.h>
-#include <asm/irq.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
 #include <asm/system_misc.h>
 
 #include <mach/at91_st.h>
 
 #include "generic.h"
+#include "soc.h"
+
+static const struct at91_soc rm9200_socs[] = {
+	AT91_SOC(AT91RM9200_CIDR_MATCH, 0, "at91rm9200", "at91rm9200 BGA"),
+	{ /* sentinel */ },
+};
+
+static const struct at91_soc_family rm9200_families[] = {
+	AT91_SOC_FAMILY(ARCH_ID_AT91RM9200, "AT91RM9200", rm9200_socs),
+	{ /* sentinel */ },
+};
 
 static void at91rm9200_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
@@ -45,15 +47,20 @@ static void __init at91rm9200_dt_timer_init(void)
 
 static void __init at91rm9200_dt_device_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	struct soc_device *soc;
+	struct device *soc_dev = NULL;
+
+	soc = at91_soc_init(rm9200_families);
+	if (soc != NULL)
+		soc_dev = soc_device_to_device(soc);
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
 
 	arm_pm_idle = at91rm9200_idle;
 	arm_pm_restart = at91rm9200_restart;
 	at91rm9200_pm_init();
 }
 
-
-
 static const char *at91rm9200_dt_board_compat[] __initconst = {
 	"atmel,at91rm9200",
 	NULL
@@ -61,7 +68,6 @@ static const char *at91rm9200_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200")
 	.init_time      = at91rm9200_dt_timer_init,
-	.map_io		= at91_map_io,
 	.init_machine	= at91rm9200_dt_device_init,
 	.dt_compat	= at91rm9200_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 66dcd146601a..b330fcfe18a3 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -45,4 +45,7 @@ struct at91_soc_family {
 struct soc_device * __init
 at91_soc_init(const struct at91_soc_family *families);
 
+#define ARCH_ID_AT91RM9200		0x92
+#define AT91RM9200_CIDR_MATCH		0x09290780
+
 #endif /* __AT91_SOC_H */
-- 
2.1.0

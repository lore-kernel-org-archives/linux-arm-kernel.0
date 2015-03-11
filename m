From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Mar 2015 18:00:33 +0100
Subject: [PATCH v3 7/9] ARM: at91: at91sam9: use SoC detection infrastructure
In-Reply-To: <1426093235-11759-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426093235-11759-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1426093235-11759-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the soc detection infrastructure for at91sam9 initialization.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9.c | 86 ++++++++++++++++++++++++++++++++-----------
 arch/arm/mach-at91/soc.h      | 30 +++++++++++++++
 2 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 56e3ba73ec40..6aa0a5461be9 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -7,29 +7,78 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/clk-provider.h>
 
-#include <asm/system_misc.h>
-#include <asm/setup.h>
-#include <asm/irq.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
+#include <asm/system_misc.h>
 
 #include "generic.h"
+#include "soc.h"
 
-static void __init at91sam9_dt_device_init(void)
+static const struct at91_soc at91sam9_socs[] = {
+	AT91_SOC(AT91SAM9260_CIDR_MATCH, 0, "at91sam9260", NULL),
+	AT91_SOC(AT91SAM9261_CIDR_MATCH, 0, "at91sam9261", NULL),
+	AT91_SOC(AT91SAM9263_CIDR_MATCH, 0, "at91sam9263", NULL),
+	AT91_SOC(AT91SAM9G20_CIDR_MATCH, 0, "at91sam9g20", NULL),
+	AT91_SOC(AT91SAM9RL64_CIDR_MATCH, 0, "at91sam9rl64", NULL),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M11_EXID_MATCH,
+		 "at91sam9g45", "at91sam9m11"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M10_EXID_MATCH,
+		 "at91sam9g45", "at91sam9m10"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G46_EXID_MATCH,
+		 "at91sam9g45", "at91sam9g46"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G45_EXID_MATCH,
+		 "at91sam9g45", "at91sam9g45"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G15_EXID_MATCH,
+		 "at91sam9x5", "at91sam9g15"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G35_EXID_MATCH,
+		 "at91sam9x5", "at91sam9g35"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X35_EXID_MATCH,
+		 "at91sam9x5", "at91sam9x35"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G25_EXID_MATCH,
+		 "at91sam9x5", "at91sam9g25"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X25_EXID_MATCH,
+		 "at91sam9x5", "at91sam9x25"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN12_EXID_MATCH,
+		 "at91sam9n12", "at91sam9cn12"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9N12_EXID_MATCH,
+		 "at91sam9n12", "at91sam9n12"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN11_EXID_MATCH,
+		 "at91sam9n12", "at91sam9cn11"),
+	{ /* sentinel */ },
+};
+
+static const struct at91_soc at91sam9xe_socs[] = {
+	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe", "at91sam9xe128"),
+	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe", "at91sam9xe256"),
+	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe", "at91sam9xe512"),
+	{ /* sentinel */ },
+};
+
+static const struct at91_soc_family at91sam9_families[] = {
+	AT91_SOC_FAMILY(ARCH_ID_AT91SAM9, "AT91SAM9", at91sam9_socs),
+	AT91_SOC_FAMILY(ARCH_ID_AT91SAM9XE, "AT91SAM9XE", at91sam9xe_socs),
+	{ /* sentinel */ },
+};
+
+static void __init at91sam9_common_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	struct soc_device *soc;
+	struct device *soc_dev = NULL;
+
+	soc = at91_soc_init(at91sam9_families);
+	if (soc != NULL)
+		soc_dev = soc_device_to_device(soc);
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
 
 	arm_pm_idle = at91sam9_idle;
+}
+
+static void __init at91sam9_dt_device_init(void)
+{
+	at91sam9_common_init();
 	at91sam9260_pm_init();
 }
 
@@ -40,16 +89,13 @@ static const char *at91_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
 	.init_machine	= at91sam9_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
 
 static void __init at91sam9g45_dt_device_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	arm_pm_idle = at91sam9_idle;
+	at91sam9_common_init();
 	at91sam9g45_pm_init();
 }
 
@@ -60,16 +106,13 @@ static const char *at91sam9g45_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91sam9g45_dt, "Atmel AT91SAM9G45")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
 	.init_machine	= at91sam9g45_dt_device_init,
 	.dt_compat	= at91sam9g45_board_compat,
 MACHINE_END
 
 static void __init at91sam9x5_dt_device_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	arm_pm_idle = at91sam9_idle;
+	at91sam9_common_init();
 	at91sam9x5_pm_init();
 }
 
@@ -81,7 +124,6 @@ static const char *at91sam9x5_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91sam9x5_dt, "Atmel AT91SAM9")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
 	.init_machine	= at91sam9x5_dt_device_init,
 	.dt_compat	= at91sam9x5_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index b330fcfe18a3..4ed7e0bd7a62 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -48,4 +48,34 @@ at91_soc_init(const struct at91_soc_family *families);
 #define ARCH_ID_AT91RM9200		0x92
 #define AT91RM9200_CIDR_MATCH		0x09290780
 
+#define ARCH_ID_AT91SAM9		0x19
+#define AT91SAM9260_CIDR_MATCH		0x019803a0
+#define AT91SAM9261_CIDR_MATCH		0x019703a0
+#define AT91SAM9263_CIDR_MATCH		0x019607a0
+#define AT91SAM9G20_CIDR_MATCH		0x019905a0
+#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
+#define AT91SAM9G45_CIDR_MATCH		0x019b05a0
+#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
+#define AT91SAM9N12_CIDR_MATCH		0x019a07a0
+
+#define AT91SAM9M11_EXID_MATCH		0x00000001
+#define AT91SAM9M10_EXID_MATCH		0x00000002
+#define AT91SAM9G46_EXID_MATCH		0x00000003
+#define AT91SAM9G45_EXID_MATCH		0x00000004
+
+#define AT91SAM9G15_EXID_MATCH		0x00000000
+#define AT91SAM9G35_EXID_MATCH		0x00000001
+#define AT91SAM9X35_EXID_MATCH		0x00000002
+#define AT91SAM9G25_EXID_MATCH		0x00000003
+#define AT91SAM9X25_EXID_MATCH		0x00000004
+
+#define AT91SAM9CN12_EXID_MATCH		0x00000005
+#define AT91SAM9N12_EXID_MATCH		0x00000006
+#define AT91SAM9CN11_EXID_MATCH		0x00000009
+
+#define ARCH_ID_AT91SAM9XE		0x29
+#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
+#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
+#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
+
 #endif /* __AT91_SOC_H */
-- 
2.1.0

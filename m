From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 16 Oct 2013 16:24:57 +0200
Subject: [PATCH 2/2] ARM: AT91: DT: pm: select ram controller standby based on
 DT
In-Reply-To: <1381933497-20262-1-git-send-email-plagnioj@jcrosoft.com>
References: <1381830109-1398-1-git-send-email-daniel.lezcano@linaro.org>
 <1381933497-20262-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1381933497-20262-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move non-dt selection to ioremap_registers init which is only called not
non-dt board.

So we can support sam9n12/sam9x5/sama5d3 too.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c  |  3 +--
 arch/arm/mach-at91/at91sam9260.c |  3 +--
 arch/arm/mach-at91/at91sam9261.c |  3 +--
 arch/arm/mach-at91/at91sam9263.c |  3 +--
 arch/arm/mach-at91/at91sam9g45.c |  3 +--
 arch/arm/mach-at91/at91sam9rl.c  |  3 +--
 arch/arm/mach-at91/setup.c       | 14 +++++++++++---
 7 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 0d234f2..25805f2 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -328,6 +328,7 @@ static void __init at91rm9200_ioremap_registers(void)
 {
 	at91rm9200_ioremap_st(AT91RM9200_BASE_ST);
 	at91_ioremap_ramc(0, AT91RM9200_BASE_MC, 256);
+	at91_pm_set_standby(at91rm9200_standby);
 }
 
 static void __init at91rm9200_initialize(void)
@@ -338,8 +339,6 @@ static void __init at91rm9200_initialize(void)
 	/* Initialize GPIO subsystem */
 	at91_gpio_init(at91rm9200_gpio,
 		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
-
-	at91_pm_set_standby(at91rm9200_standby);
 }
 
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 3b43d56..f8629a3 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -343,6 +343,7 @@ static void __init at91sam9260_ioremap_registers(void)
 	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9260_BASE_MATRIX);
+	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 static void __init at91sam9260_initialize(void)
@@ -352,8 +353,6 @@ static void __init at91sam9260_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9260_gpio, 3);
-
-	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index a0857c3..1f3867a 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -285,6 +285,7 @@ static void __init at91sam9261_ioremap_registers(void)
 	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9261_BASE_MATRIX);
+	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 static void __init at91sam9261_initialize(void)
@@ -294,8 +295,6 @@ static void __init at91sam9261_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9261_gpio, 3);
-
-	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 103a95b..90d455d 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -322,6 +322,7 @@ static void __init at91sam9263_ioremap_registers(void)
 	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
 	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
 	at91_ioremap_matrix(AT91SAM9263_BASE_MATRIX);
+	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 static void __init at91sam9263_initialize(void)
@@ -331,8 +332,6 @@ static void __init at91sam9263_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9263_gpio, 5);
-
-	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f29731e..e9bf0b8 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -371,6 +371,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9G45_BASE_MATRIX);
+	at91_pm_set_standby(at91_ddr_standby);
 }
 
 static void __init at91sam9g45_initialize(void)
@@ -380,8 +381,6 @@ static void __init at91sam9g45_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9g45_gpio, 5);
-
-	at91_pm_set_standby(at91_ddr_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 9e28f41..88995af 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -288,6 +288,7 @@ static void __init at91sam9rl_ioremap_registers(void)
 	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9RL_BASE_MATRIX);
+	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 static void __init at91sam9rl_initialize(void)
@@ -297,8 +298,6 @@ static void __init at91sam9rl_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9rl_gpio, 4);
-
-	at91_pm_set_standby(at91sam9_sdram_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index b17fbcf..094b345 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -23,6 +23,7 @@
 #include "at91_shdwc.h"
 #include "soc.h"
 #include "generic.h"
+#include "pm.h"
 
 struct at91_init_soc __initdata at91_boot_soc;
 
@@ -376,15 +377,16 @@ static void at91_dt_rstc(void)
 }
 
 static struct of_device_id ramc_ids[] = {
-	{ .compatible = "atmel,at91rm9200-sdramc" },
-	{ .compatible = "atmel,at91sam9260-sdramc" },
-	{ .compatible = "atmel,at91sam9g45-ddramc" },
+	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
+	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
+	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
 	{ /*sentinel*/ }
 };
 
 static void at91_dt_ramc(void)
 {
 	struct device_node *np;
+	const struct of_device_id *of_id;
 
 	np = of_find_matching_node(NULL, ramc_ids);
 	if (!np)
@@ -396,6 +398,12 @@ static void at91_dt_ramc(void)
 	/* the controller may have 2 banks */
 	at91_ramc_base[1] = of_iomap(np, 1);
 
+	of_id = of_match_node(ramc_ids, np);
+	if (!of_id)
+		pr_warn("AT91: ramc no standby function available\n");
+	else
+		at91_pm_set_standby(of_id->data);
+
 	of_node_put(np);
 }
 
-- 
1.8.4.rc3

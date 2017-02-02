From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:18 +0100
Subject: [PATCH 08/13] ARM: at91: pm: tie the memory controller type to the
 ramc id
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-9-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of rely on the SoC type to select the memory controller type, use
the device tree ids as they are parsed anyway.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d4a444c4c38f..b6448043ee7a 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -313,11 +313,22 @@ static void at91sam9_sdram_standby(void)
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
+struct ramc_info {
+	void (*standby)(void);
+	unsigned int memctrl;
+};
+
+static const struct ramc_info ramc_infos[] __initconst = {
+	{ .standby = at91rm9200_standby, .memctrl = AT91_MEMCTRL_MC},
+	{ .standby = at91sam9_sdram_standby, .memctrl = AT91_MEMCTRL_SDRAMC},
+	{ .standby = at91_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
+};
+
 static const struct of_device_id const ramc_ids[] __initconst = {
-	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
-	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
-	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
-	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
+	{ .compatible = "atmel,at91rm9200-sdramc", .data = &ramc_infos[0] },
+	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
+	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
+	{ .compatible = "atmel,sama5d3-ddramc", .data = &ramc_infos[2] },
 	{ /*sentinel*/ }
 };
 
@@ -327,14 +338,17 @@ static __init void at91_dt_ramc(void)
 	const struct of_device_id *of_id;
 	int idx = 0;
 	const void *standby = NULL;
+	const struct ramc_info *ramc;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
 		pm_data.ramc[idx] = of_iomap(np, 0);
 		if (!pm_data.ramc[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
+		ramc = of_id->data;
 		if (!standby)
-			standby = of_id->data;
+			standby = ramc->standby;
+		pm_data.memctrl = ramc->memctrl;
 
 		idx++;
 	}
@@ -457,7 +471,6 @@ void __init at91rm9200_pm_init(void)
 	at91_ramc_write(0, AT91_MC_SDRAMC_LPR, 0);
 
 	pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_MC;
 
 	at91_pm_init(at91rm9200_idle);
 }
@@ -465,7 +478,6 @@ void __init at91rm9200_pm_init(void)
 void __init at91sam9260_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_init(at91sam9_idle);
 }
@@ -474,7 +486,6 @@ void __init at91sam9g45_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -482,7 +493,6 @@ void __init at91sam9x5_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -490,6 +500,5 @@ void __init sama5_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(NULL);
 }
-- 
2.11.0

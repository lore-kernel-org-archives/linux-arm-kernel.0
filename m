From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:34 +0200
Subject: [PATCH v2 07/11] ARM: at91: pm: Tie the memory controller type to the
 ramc id
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-8-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on the SoC type to select the memory controller type,
use the device tree ids as they are parsed anyway.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 488549bc2bed..ddf62a006635 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -329,11 +329,23 @@ static void at91sam9_sdram_standby(void)
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
+struct ramc_info {
+	void (*idle)(void);
+	unsigned int memctrl;
+};
+
+static const struct ramc_info ramc_infos[] __initconst = {
+	{ .idle = at91rm9200_standby, .memctrl = AT91_MEMCTRL_MC},
+	{ .idle = at91sam9_sdram_standby, .memctrl = AT91_MEMCTRL_SDRAMC},
+	{ .idle = at91_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
+	{ .idle = sama5d3_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
+};
+
 static const struct of_device_id const ramc_ids[] __initconst = {
-	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
-	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
-	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
-	{ .compatible = "atmel,sama5d3-ddramc", .data = sama5d3_ddr_standby },
+	{ .compatible = "atmel,at91rm9200-sdramc", .data = &ramc_infos[0] },
+	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
+	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
+	{ .compatible = "atmel,sama5d3-ddramc", .data = &ramc_infos[3] },
 	{ /*sentinel*/ }
 };
 
@@ -343,14 +355,17 @@ static __init void at91_dt_ramc(void)
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
+			standby = ramc->idle;
+		pm_data.memctrl = ramc->memctrl;
 
 		idx++;
 	}
@@ -473,7 +488,6 @@ void __init at91rm9200_pm_init(void)
 	at91_ramc_write(0, AT91_MC_SDRAMC_LPR, 0);
 
 	pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_MC;
 
 	at91_pm_init(at91rm9200_idle);
 }
@@ -481,7 +495,6 @@ void __init at91rm9200_pm_init(void)
 void __init at91sam9260_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_init(at91sam9_idle);
 }
@@ -490,7 +503,6 @@ void __init at91sam9g45_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -498,7 +510,6 @@ void __init at91sam9x5_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -506,6 +517,5 @@ void __init sama5_pm_init(void)
 {
 	at91_dt_ramc();
 	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(NULL);
 }
-- 
2.11.0

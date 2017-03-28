From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:35 +0200
Subject: [PATCH v2 08/11] ARM: at91: pm: Tie the USB clock mask to the pmc
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-9-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB clocks mask (uhp_udp_mask) depends on the pmc. Tie it to the pmc id
instead of the SoC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index ddf62a006635..a7c047f0d21f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -442,31 +442,46 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
+struct pmc_info {
+	unsigned long uhp_udp_mask;
+};
+
+static const struct pmc_info pmc_infos[] __initconst = {
+	{ .uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP },
+	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP },
+	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP },
+};
+
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
-	{ .compatible = "atmel,at91rm9200-pmc"  },
-	{ .compatible = "atmel,at91sam9260-pmc" },
-	{ .compatible = "atmel,at91sam9g45-pmc" },
-	{ .compatible = "atmel,at91sam9n12-pmc" },
-	{ .compatible = "atmel,at91sam9x5-pmc" },
-	{ .compatible = "atmel,sama5d3-pmc" },
-	{ .compatible = "atmel,sama5d2-pmc" },
+	{ .compatible = "atmel,at91rm9200-pmc", .data = &pmc_infos[0] },
+	{ .compatible = "atmel,at91sam9260-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9g45-pmc", .data = &pmc_infos[2] },
+	{ .compatible = "atmel,at91sam9n12-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9x5-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,sama5d3-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ /* sentinel */ },
 };
 
 static void __init at91_pm_init(void (*pm_idle)(void))
 {
 	struct device_node *pmc_np;
+	const struct of_device_id *of_id;
+	const struct pmc_info *pmc;
 
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
+	pmc_np = of_find_matching_node_and_match(NULL, atmel_pmc_ids, &of_id);
 	pm_data.pmc = of_iomap(pmc_np, 0);
 	if (!pm_data.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
 	}
 
+	pmc = of_id->data;
+	pm_data.uhp_udp_mask = pmc->uhp_udp_mask;
+
 	if (pm_idle)
 		arm_pm_idle = pm_idle;
 
@@ -487,35 +502,29 @@ void __init at91rm9200_pm_init(void)
 	 */
 	at91_ramc_write(0, AT91_MC_SDRAMC_LPR, 0);
 
-	pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
-
 	at91_pm_init(at91rm9200_idle);
 }
 
 void __init at91sam9260_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9g45_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9x5_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_init(at91sam9_idle);
 }
 
 void __init sama5_pm_init(void)
 {
 	at91_dt_ramc();
-	pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_init(NULL);
 }
-- 
2.11.0

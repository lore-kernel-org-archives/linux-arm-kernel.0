From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 27 Jan 2015 14:01:12 +0800
Subject: [PATCH v3 12/13] pm: at91: setup: remove the struct ramc_ids .data
 at91_xxx_standby members
In-Reply-To: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422338472-6177-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the at91_xxx_standby function is removed,
remove the struct ramc_ids .data members code.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/setup.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 4c18428..b8dba9f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -362,10 +362,10 @@ void __init at91_ioremap_matrix(u32 base_addr)
 }
 
 static struct of_device_id ramc_ids[] = {
-	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
-	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
-	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
-	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
+	{ .compatible = "atmel,at91rm9200-sdramc" },
+	{ .compatible = "atmel,at91sam9260-sdramc" },
+	{ .compatible = "atmel,at91sam9g45-ddramc" },
+	{ .compatible = "atmel,sama5d3-ddramc" },
 	{ /*sentinel*/ }
 };
 
@@ -374,28 +374,17 @@ static void at91_dt_ramc(void)
 	struct device_node *np;
 	const struct of_device_id *of_id;
 	int idx = 0;
-	const void *standby = NULL;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
 		at91_ramc_base[idx] = of_iomap(np, 0);
 		if (!at91_ramc_base[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
-		if (!standby)
-			standby = of_id->data;
-
 		idx++;
 	}
 
 	if (!idx)
 		panic(pr_fmt("unable to find compatible ram controller node in dtb\n"));
-
-	if (!standby) {
-		pr_warn("ramc no standby function available\n");
-		return;
-	}
-
-	at91_pm_set_standby(standby);
 }
 
 void __init at91_dt_initialize(void)
-- 
1.7.9.5

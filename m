From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Jul 2014 16:14:43 +0200
Subject: [PATCH 07/18] AT91: DT: Remove the old-style reset probing
In-Reply-To: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404396906-25194-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the reset code is a driver of its own, just let the usual DT probing
mecanism do its job, and remove the code entirely in this case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/setup.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index cc520596f23b..71003e40f01c 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -354,34 +354,6 @@ void __init at91_ioremap_matrix(u32 base_addr)
 }
 
 #if defined(CONFIG_OF) && !defined(CONFIG_ARCH_AT91X40)
-static struct of_device_id rstc_ids[] = {
-	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9_alt_restart },
-	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
-	{ /*sentinel*/ }
-};
-
-static void at91_dt_rstc(void)
-{
-	struct device_node *np;
-	const struct of_device_id *of_id;
-
-	np = of_find_matching_node(NULL, rstc_ids);
-	if (!np)
-		panic(pr_fmt("unable to find compatible rstc node in dtb\n"));
-
-	at91_rstc_base = of_iomap(np, 0);
-	if (!at91_rstc_base)
-		panic(pr_fmt("unable to map rstc cpu registers\n"));
-
-	of_id = of_match_node(rstc_ids, np);
-	if (!of_id)
-		panic(pr_fmt("rtsc no restart function available\n"));
-
-	arm_pm_restart = of_id->data;
-
-	of_node_put(np);
-}
-
 static struct of_device_id ramc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
@@ -507,7 +479,6 @@ void __init at91rm9200_dt_initialize(void)
 
 void __init at91_dt_initialize(void)
 {
-	at91_dt_rstc();
 	at91_dt_ramc();
 	at91_dt_shdwc();
 
-- 
2.0.1

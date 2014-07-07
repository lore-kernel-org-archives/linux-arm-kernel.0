From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  7 Jul 2014 16:25:26 +0200
Subject: [PATCH v2 13/18] AT91: DT: Remove poweroff DT probing
In-Reply-To: <1404743131-24569-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404743131-24569-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404743131-24569-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the poweroff code is a driver of its own, remove the DT probing in
mach-at91 and let the usual DT code do its job.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/setup.c | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index fe0601e0a3c0..ae269291d19d 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -387,82 +387,6 @@ static void at91_dt_ramc(void)
 	at91_pm_set_standby(of_id->data);
 }
 
-static struct of_device_id shdwc_ids[] = {
-	{ .compatible = "atmel,at91sam9260-shdwc", },
-	{ .compatible = "atmel,at91sam9rl-shdwc", },
-	{ .compatible = "atmel,at91sam9x5-shdwc", },
-	{ /*sentinel*/ }
-};
-
-static const char *shdwc_wakeup_modes[] = {
-	[AT91_SHDW_WKMODE0_NONE]	= "none",
-	[AT91_SHDW_WKMODE0_HIGH]	= "high",
-	[AT91_SHDW_WKMODE0_LOW]		= "low",
-	[AT91_SHDW_WKMODE0_ANYLEVEL]	= "any",
-};
-
-const int at91_dtget_shdwc_wakeup_mode(struct device_node *np)
-{
-	const char *pm;
-	int err, i;
-
-	err = of_property_read_string(np, "atmel,wakeup-mode", &pm);
-	if (err < 0)
-		return AT91_SHDW_WKMODE0_ANYLEVEL;
-
-	for (i = 0; i < ARRAY_SIZE(shdwc_wakeup_modes); i++)
-		if (!strcasecmp(pm, shdwc_wakeup_modes[i]))
-			return i;
-
-	return -ENODEV;
-}
-
-static void at91_dt_shdwc(void)
-{
-	struct device_node *np;
-	int wakeup_mode;
-	u32 reg;
-	u32 mode = 0;
-
-	np = of_find_matching_node(NULL, shdwc_ids);
-	if (!np) {
-		pr_debug("unable to find compatible shutdown (shdwc) controller node in dtb\n");
-		return;
-	}
-
-	at91_shdwc_base = of_iomap(np, 0);
-	if (!at91_shdwc_base)
-		panic(pr_fmt("unable to map shdwc cpu registers\n"));
-
-	wakeup_mode = at91_dtget_shdwc_wakeup_mode(np);
-	if (wakeup_mode < 0) {
-		pr_warn("shdwc unknown wakeup mode\n");
-		goto end;
-	}
-
-	if (!of_property_read_u32(np, "atmel,wakeup-counter", &reg)) {
-		if (reg > AT91_SHDW_CPTWK0_MAX) {
-			pr_warn("shdwc wakeup counter 0x%x > 0x%x reduce it to 0x%x\n",
-				reg, AT91_SHDW_CPTWK0_MAX, AT91_SHDW_CPTWK0_MAX);
-			reg = AT91_SHDW_CPTWK0_MAX;
-		}
-		mode |= AT91_SHDW_CPTWK0_(reg);
-	}
-
-	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
-			mode |= AT91_SHDW_RTCWKEN;
-
-	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
-			mode |= AT91_SHDW_RTTWKEN;
-
-	at91_shdwc_write(AT91_SHDW_MR, wakeup_mode | mode);
-
-end:
-	pm_power_off = at91sam9_poweroff;
-
-	of_node_put(np);
-}
-
 void __init at91rm9200_dt_initialize(void)
 {
 	at91_dt_ramc();
@@ -480,7 +404,6 @@ void __init at91rm9200_dt_initialize(void)
 void __init at91_dt_initialize(void)
 {
 	at91_dt_ramc();
-	at91_dt_shdwc();
 
 	/* Init clock subsystem */
 	at91_dt_clock_init();
-- 
2.0.1

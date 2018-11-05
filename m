From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Mon, 5 Nov 2018 11:14:23 +0000
Subject: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff function
 for at91-poweroff
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use only one poweroff function and adapt it to work for both scenarios
(with LPDDR or not). The assignement of pm_power_off was moved at the
end of probe after all initializations are OK. This patch adapt the idea
from commit 4e018c1e9b05 ("power: reset: at91-poweroff: use only one
poweroff function").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 49 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index fb2fc8f741a1..82533f4c72fc 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -76,11 +76,6 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 
 static void at91_poweroff(void)
 {
-	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
-}
-
-static void at91_lpddr_poweroff(void)
-{
 	asm volatile(
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -89,9 +84,11 @@ static void at91_lpddr_poweroff(void)
 		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
 
 		/* Power down SDRAM0 */
+		"	tst	%0, #0\n\t"
+		"	beq	1f\n\t"
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 		/* Shutdown CPU */
-		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+		"1:	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
 
 		"	b	.\n\t"
 		:
@@ -177,34 +174,42 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		at91_poweroff_dt_set_wakeup_mode(pdev);
 
-	pm_power_off = at91_poweroff;
-
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
-	if (!np)
-		return 0;
+	if (np) {
+		mpddrc_base = of_iomap(np, 0);
+		of_node_put(np);
 
-	mpddrc_base = of_iomap(np, 0);
-	of_node_put(np);
+		if (!mpddrc_base) {
+			ret = -ENOMEM;
+			goto clk_disable;
+		}
 
-	if (!mpddrc_base)
-		return 0;
+		ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+				 AT91_DDRSDRC_MD;
+		if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
+		    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
+			iounmap(mpddrc_base);
+			mpddrc_base = NULL;
+		}
+	}
 
-	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
-	if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
-	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
-		pm_power_off = at91_lpddr_poweroff;
-	else
-		iounmap(mpddrc_base);
+	pm_power_off = at91_poweroff;
 
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sclk);
+	return ret;
 }
 
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == at91_poweroff ||
-	    pm_power_off == at91_lpddr_poweroff)
+	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
 
+	if (mpddrc_base)
+		iounmap(mpddrc_base);
+
 	clk_disable_unprepare(sclk);
 
 	return 0;
-- 
2.7.4

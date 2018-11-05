From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Mon, 5 Nov 2018 11:14:26 +0000
Subject: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data to
 one structure
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move SHDWC realted data to only one structure to have them grouped.
Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
mpddrc_base part of struct shdwc").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 60 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 82533f4c72fc..48661e04a3de 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -51,14 +51,19 @@ static const char *shdwc_wakeup_modes[] = {
 	[AT91_SHDW_WKMODE0_ANYLEVEL]	= "any",
 };
 
-static void __iomem *at91_shdwc_base;
-static struct clk *sclk;
-static void __iomem *mpddrc_base;
+struct shdwc {
+	struct clk *sclk;
+	void __iomem *shdwc_base;
+	void __iomem *mpddrc_base;
+};
+
+static struct shdwc *at91_shdwc;
 
 static void __init at91_wakeup_status(struct platform_device *pdev)
 {
+	struct shdwc *shdwc = platform_get_drvdata(pdev);
 	const char *reason;
-	u32 reg = readl(at91_shdwc_base + AT91_SHDW_SR);
+	u32 reg = readl(shdwc->shdwc_base + AT91_SHDW_SR);
 
 	/* Simple power-on, just bail out */
 	if (!reg)
@@ -92,9 +97,9 @@ static void at91_poweroff(void)
 
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc_base),
+		  "r" (at91_shdwc->shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
 		: "r6");
 }
@@ -118,6 +123,7 @@ static int at91_poweroff_get_wakeup_mode(struct device_node *np)
 
 static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 {
+	struct shdwc *shdwc = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
 	int wakeup_mode;
 	u32 mode = 0, tmp;
@@ -144,7 +150,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
 			mode |= AT91_SHDW_RTTWKEN;
 
-	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
+	writel(wakeup_mode | mode, shdwc->shdwc_base + AT91_SHDW_MR);
 }
 
 static int __init at91_poweroff_probe(struct platform_device *pdev)
@@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 	u32 ddr_type;
 	int ret;
 
+	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
+	if (!at91_shdwc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, at91_shdwc);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc_base))
-		return PTR_ERR(at91_shdwc_base);
+	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc->shdwc_base))
+		return PTR_ERR(at91_shdwc->shdwc_base);
 
-	sclk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc->sclk))
+		return PTR_ERR(at91_shdwc->sclk);
 
-	ret = clk_prepare_enable(sclk);
+	ret = clk_prepare_enable(at91_shdwc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -176,20 +188,20 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
 	if (np) {
-		mpddrc_base = of_iomap(np, 0);
+		at91_shdwc->mpddrc_base = of_iomap(np, 0);
 		of_node_put(np);
 
-		if (!mpddrc_base) {
+		if (!at91_shdwc->mpddrc_base) {
 			ret = -ENOMEM;
 			goto clk_disable;
 		}
 
-		ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+		ddr_type = readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
 				 AT91_DDRSDRC_MD;
 		if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
 		    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
-			iounmap(mpddrc_base);
-			mpddrc_base = NULL;
+			iounmap(at91_shdwc->mpddrc_base);
+			at91_shdwc->mpddrc_base = NULL;
 		}
 	}
 
@@ -198,19 +210,21 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 	return 0;
 
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc->sclk);
 	return ret;
 }
 
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
+	struct shdwc *shdwc = platform_get_drvdata(pdev);
+
 	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
 
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (shdwc->mpddrc_base)
+		iounmap(shdwc->mpddrc_base);
 
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(shdwc->sclk);
 
 	return 0;
 }
-- 
2.7.4

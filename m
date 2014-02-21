From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Feb 2014 10:41:28 +0000
Subject: [PATCH 5/5] mmc: sdhci-spear: use generic card detection gpio support
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Message-ID: <E1WGnXs-0007Jw-0M@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci has support for using GPIOs for card detection.  If we have a
GPIO specified, we can use that directly, without needing our own
interrupt handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 78 +++++++++---------------------------------
 1 file changed, 16 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 00a73b1a6444..af3338fb0762 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -43,28 +43,6 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-/* gpio card detection interrupt handler */
-static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
-{
-	struct platform_device *pdev = dev_id;
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
-	unsigned long gpio_irq_type;
-	int val;
-
-	val = gpio_get_value(sdhci->data->card_int_gpio);
-
-	/* val == 1 -> card removed, val == 0 -> card inserted */
-	/* if card removed - set irq for low level, else vice versa */
-	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
-	irq_set_irq_type(irq, gpio_irq_type);
-
-	/* inform sdhci driver about card insertion/removal */
-	tasklet_schedule(&host->card_tasklet);
-
-	return IRQ_HANDLED;
-}
-
 #ifdef CONFIG_OF
 static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
 {
@@ -157,6 +135,22 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = dev_get_platdata(&pdev->dev);
 	}
 
+	/*
+	 * It is optional to use GPIOs for sdhci card detection. If
+	 * sdhci->data is NULL, then use original sdhci lines otherwise
+	 * GPIO lines. We use the built-in GPIO support for this.
+	 */
+	if (sdhci->data && sdhci->data->card_int_gpio >= 0) {
+		ret = mmc_gpio_request_cd(host->mmc,
+					  sdhci->data->card_int_gpio, 0);
+		if (ret < 0) {
+			dev_dbg(&pdev->dev,
+				"failed to request card-detect gpio%d\n",
+				sdhci->data->card_int_gpio);
+			goto disable_clk;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
@@ -165,48 +159,8 @@ static int sdhci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	/*
-	 * It is optional to use GPIOs for sdhci Power control & sdhci card
-	 * interrupt detection. If sdhci->data is NULL, then use original sdhci
-	 * lines otherwise GPIO lines.
-	 * If GPIO is selected for power control, then power should be disabled
-	 * after card removal and should be enabled when card insertion
-	 * interrupt occurs
-	 */
-	if (!sdhci->data)
-		return 0;
-
-	if (sdhci->data->card_int_gpio >= 0) {
-		ret = devm_gpio_request(&pdev->dev, sdhci->data->card_int_gpio,
-				"sdhci");
-		if (ret < 0) {
-			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-
-		ret = gpio_direction_input(sdhci->data->card_int_gpio);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-		ret = devm_request_irq(&pdev->dev,
-				gpio_to_irq(sdhci->data->card_int_gpio),
-				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
-				mmc_hostname(host->mmc), pdev);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-
-	}
-
 	return 0;
 
-set_drvdata:
-	sdhci_remove_host(host, 1);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
 err_host:
-- 
1.8.3.1

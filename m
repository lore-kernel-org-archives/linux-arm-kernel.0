From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 13:00:01 +0100
Subject: [PATCH 214/222] mmc: sdhci: move regulator handling into
 sdhci_set_power()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdenR-0007S5-PS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the regulator handling into sdhci_set_power() rather than being in
sdhci_do_set_ios().  This wraps all power control up into this function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 72 +++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0d55a5bca2aa..3ce81577b0c7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1216,7 +1216,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
+static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
 
@@ -1239,7 +1239,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	}
 
 	if (host->pwr == pwr)
-		return -1;
+		return;
 
 	host->pwr = pwr;
 
@@ -1247,38 +1247,43 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
-		return 0;
-	}
-
-	/*
-	 * Spec says that we should clear the power reg before setting
-	 * a new value. Some controllers don't seem to like this though.
-	 */
-	if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
-		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+		power = 0;
+	} else {
+		/*
+		 * Spec says that we should clear the power reg before setting
+		 * a new value. Some controllers don't seem to like this though.
+		 */
+		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
+			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 
-	/*
-	 * At least the Marvell CaFe chip gets confused if we set the voltage
-	 * and set turn on power at the same time, so set the voltage first.
-	 */
-	if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
-		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		/*
+		 * At least the Marvell CaFe chip gets confused if we set the
+		 * voltage and set turn on power at the same time, so set the
+		 * voltage first.
+		 */
+		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
+			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
-	pwr |= SDHCI_POWER_ON;
+		pwr |= SDHCI_POWER_ON;
 
-	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
 
-	if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
-		sdhci_runtime_pm_bus_on(host);
+		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
+			sdhci_runtime_pm_bus_on(host);
 
-	/*
-	 * Some controllers need an extra 10ms delay of 10ms before they
-	 * can apply clock after applying power
-	 */
-	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		/*
+		 * Some controllers need an extra 10ms delay of 10ms before
+		 * they can apply clock after applying power
+		 */
+		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
+			mdelay(10);
+	}
 
-	return power;
+	if (host->vmmc) {
+		spin_unlock_irq(&host->lock);
+		mmc_regulator_set_ocr(host->mmc, host->vmmc, power);
+		spin_lock_irq(&host->lock);
+	}
 }
 
 /*****************************************************************************\
@@ -1428,7 +1433,6 @@ EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
 	unsigned long flags;
-	int vdd_bit = -1;
 	u8 ctrl;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -1460,15 +1464,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	}
 
 	if (ios->power_mode == MMC_POWER_OFF)
-		vdd_bit = sdhci_set_power(host, -1);
+		sdhci_set_power(host, -1);
 	else
-		vdd_bit = sdhci_set_power(host, ios->vdd);
-
-	if (host->vmmc && vdd_bit != -1) {
-		spin_unlock_irqrestore(&host->lock, flags);
-		mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd_bit);
-		spin_lock_irqsave(&host->lock, flags);
-	}
+		sdhci_set_power(host, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
-- 
1.8.3.1

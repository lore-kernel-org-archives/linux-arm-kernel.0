From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 13:00:06 +0100
Subject: [PATCH 215/222] mmc: sdhci: move remaining power handling into
 sdhci_set_power()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdenW-0007S9-Sw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the remaining parts of the power handling in sdhci_do_set_ios()
into sdhci_set_power().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3ce81577b0c7..2bf4908c576e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1216,12 +1216,13 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
+static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			    unsigned short vdd)
 {
 	u8 pwr = 0;
 
-	if (power != (unsigned short)-1) {
-		switch (1 << power) {
+	if (mode != MMC_POWER_OFF) {
+		switch (1 << vdd) {
 		case MMC_VDD_165_195:
 			pwr = SDHCI_POWER_180;
 			break;
@@ -1247,7 +1248,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
-		power = 0;
+		vdd = 0;
 	} else {
 		/*
 		 * Spec says that we should clear the power reg before setting
@@ -1281,7 +1282,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 
 	if (host->vmmc) {
 		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(host->mmc, host->vmmc, power);
+		mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd);
 		spin_lock_irq(&host->lock);
 	}
 }
@@ -1463,10 +1464,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		host->clock = ios->clock;
 	}
 
-	if (ios->power_mode == MMC_POWER_OFF)
-		sdhci_set_power(host, -1);
-	else
-		sdhci_set_power(host, ios->vdd);
+	sdhci_set_power(host, ios->power_mode, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
-- 
1.8.3.1

From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 11:45:06 +0200
Subject: [PATCH V2 2/3] mmc: mmci: Adapt to register write restrictions
In-Reply-To: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369302307-28540-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

After a write to the MMCICLOCK register data cannot be written to this
register for three feedback clock cycles. Writes to the MMCIPOWER
register must be separated by three MCLK cycles. Previously no issues
has been observered, but using higher ARM clock frequencies on STE-
platforms has triggered this problem.

The MMCICLOCK register is written to in .set_ios and for some data
transmissions for SDIO. We do not need a delay at the data transmission
path, because sending and receiving data will require more than three
clock cycles. Then we use a simple logic to only delay in .set_ios and
thus we don't affect throughput performance.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
---

Changes in v2:
	None
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9fa8855..8f70e5b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -189,6 +189,21 @@ static int mmci_validate_data(struct mmci_host *host,
 	return 0;
 }
 
+static void mmci_reg_delay(struct mmci_host *host)
+{
+	/*
+	 * According to the spec, at least three feedback clock cycles
+	 * of max 52 MHz must pass between two writes to the MMCICLOCK reg.
+	 * Three MCLK clock cycles must pass between two MMCIPOWER reg writes.
+	 * Worst delay time during card init is at 100 kHz => 30 us.
+	 * Worst delay time when up and running is at 25 MHz => 120 ns.
+	 */
+	if (host->cclk < 20000000)
+		udelay(30);
+	else
+		ndelay(120);
+}
+
 /*
  * This must be called with host->lock held
  */
@@ -1264,6 +1279,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmci_set_clkreg(host, ios->clock);
 	mmci_write_pwrreg(host, pwr);
+	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.7.10

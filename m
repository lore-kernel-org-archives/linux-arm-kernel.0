From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Sep 2013 14:04:48 +0200
Subject: [PATCH V4 3/4] mmc: mmci: Adapt to register write restrictions
Message-ID: <1378209888-16874-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
---

Changes in v4:
	- Fixed typo of 25 MHz instead of 20 MHz

---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c550b3e..604e41d 100644
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
+	if (host->cclk < 25000000)
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
1.7.9.5

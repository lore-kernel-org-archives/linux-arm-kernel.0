From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 16 Jun 2014 10:09:07 +0200
Subject: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Message-ID: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "mmc: mmci: Handle CMD irq before DATA irq", caused an issue
when using the ARM model of the PL181 and running QEMU.

The bug was reported for the following QEMU version:
$ qemu-system-arm -version
QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.1), Copyright
(c) 2003-2008 Fabrice Bellard

To resolve the problem, let's restore the old behavior were the DATA
irq is handled prior the CMD irq, but only for the arm_variant, which
the problem was reported for.

Reported-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5d20bfba..e4d4707 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -74,6 +74,7 @@ static unsigned int fmax = 515633;
  * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
  * @explicit_mclk_control: enable explicit mclk control in driver.
  * @qcom_fifo: enables qcom specific fifo pio read logic.
+ * @reversed_irq_handling: handle data irq before cmd irq.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -97,6 +98,7 @@ struct variant_data {
 	bool			pwrreg_nopower;
 	bool			explicit_mclk_control;
 	bool			qcom_fifo;
+	bool			reversed_irq_handling;
 };
 
 static struct variant_data variant_arm = {
@@ -105,6 +107,7 @@ static struct variant_data variant_arm = {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.reversed_irq_handling	= true,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -1236,8 +1239,13 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
-		mmci_cmd_irq(host, host->cmd, status);
-		mmci_data_irq(host, host->data, status);
+		if (host->variant->reversed_irq_handling) {
+			mmci_data_irq(host, host->data, status);
+			mmci_cmd_irq(host, host->cmd, status);
+		} else {
+			mmci_cmd_irq(host, host->cmd, status);
+			mmci_data_irq(host, host->data, status);
+		}
 
 		/* Don't poll for busy completion in irq context. */
 		if (host->busy_status)
-- 
1.7.9.5

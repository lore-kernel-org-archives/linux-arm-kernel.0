From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:35:59 +0100
Subject: [PATCH 13/14] mmc: mmci: Implement PM runtime callbacks to save power
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323106560-5218-14-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the runtime_suspend callback we make use of mmci_save
to disable the VCORE regulator and the MCLK to decrease
current consumption. At runtime resume, we use mmci_restore
to re-enable the resourses again.

>From now on this will mean that especially the mmci_restore
function must be fast to execute since otherwise request
latency will be introduced.

For the ARM Primcell PL180, the MMCIPOWER register is used
to control an external power supply to the card. Thus we
need to prevent the runtime callbacks from doing save and
restore, otherwise the power to card will be cut. This is
done by adding a new flag to the variant data.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d29b7dc..c0d6026 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -55,6 +55,7 @@ static unsigned int fmax = 515633;
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
+ * @pwrreg_ctrl_power: bits in MMCIPOWER register controls ext. power supply
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -67,6 +68,7 @@ struct variant_data {
 	bool			blksz_datactrl16;
 	u32			pwrreg_powerup;
 	bool			signal_direction;
+	bool			pwrreg_ctrl_power;
 };
 
 static struct variant_data variant_arm = {
@@ -74,6 +76,7 @@ static struct variant_data variant_arm = {
 	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
+	.pwrreg_ctrl_power	= true,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -81,6 +84,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.fifohalfsize		= 64 * 4,
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
+	.pwrreg_ctrl_power	= true,
 };
 
 static struct variant_data variant_u300 = {
@@ -1482,7 +1486,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
 static int mmci_save(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
@@ -1536,7 +1540,9 @@ static int mmci_restore(struct amba_device *dev)
 
 	return 0;
 }
+#endif
 
+#ifdef CONFIG_SUSPEND
 static int mmci_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
@@ -1573,8 +1579,43 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int mmci_runtime_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
+		if (!variant->pwrreg_ctrl_power)
+			ret = mmci_save(adev);
+	}
+
+	return ret;
+}
+
+static int mmci_runtime_resume(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
+		if (!variant->pwrreg_ctrl_power)
+			ret = mmci_restore(adev);
+	}
+
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.5.4

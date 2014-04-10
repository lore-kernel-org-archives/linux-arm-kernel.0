From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:59 +0200
Subject: [PATCH V3 16/19] mmc: mmci: Enforce DT for signal direction and
 feedback clock
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-17-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the option to provide signal direction configuration and
feeback clock as platform data, enforce it through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c   |   34 ++++++++++++++--------------------
 drivers/mmc/host/mmci.h   |   11 +++++++++++
 include/linux/amba/mmci.h |   16 ----------------
 3 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 41bc054..cac5f28 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1287,7 +1287,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * indicating signal direction for the signals in
 		 * the SD/MMC bus and feedback-clock usage.
 		 */
-		pwr |= host->plat->sigdir;
+		pwr |= host->pwr_reg_add;
 
 		if (ios->bus_width == MMC_BUS_WIDTH_4)
 			pwr &= ~MCI_ST_DATA74DIREN;
@@ -1386,29 +1386,26 @@ static struct mmc_host_ops mmci_ops = {
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
 };
 
-static void mmci_dt_populate_generic_pdata(struct device_node *np,
-					struct mmci_platform_data *pdata)
+static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 {
+	struct mmci_host *host = mmc_priv(mmc);
+	int ret = mmc_of_parse(mmc);
+
+	if (ret)
+		return ret;
+
 	if (of_get_property(np, "st,sig-dir-dat0", NULL))
-		pdata->sigdir |= MCI_ST_DATA0DIREN;
+		host->pwr_reg_add |= MCI_ST_DATA0DIREN;
 	if (of_get_property(np, "st,sig-dir-dat2", NULL))
-		pdata->sigdir |= MCI_ST_DATA2DIREN;
+		host->pwr_reg_add |= MCI_ST_DATA2DIREN;
 	if (of_get_property(np, "st,sig-dir-dat31", NULL))
-		pdata->sigdir |= MCI_ST_DATA31DIREN;
+		host->pwr_reg_add |= MCI_ST_DATA31DIREN;
 	if (of_get_property(np, "st,sig-dir-dat74", NULL))
-		pdata->sigdir |= MCI_ST_DATA74DIREN;
+		host->pwr_reg_add |= MCI_ST_DATA74DIREN;
 	if (of_get_property(np, "st,sig-dir-cmd", NULL))
-		pdata->sigdir |= MCI_ST_CMDDIREN;
+		host->pwr_reg_add |= MCI_ST_CMDDIREN;
 	if (of_get_property(np, "st,sig-pin-fbclk", NULL))
-		pdata->sigdir |= MCI_ST_FBCLKEN;
-}
-
-static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
-{
-	int ret = mmc_of_parse(mmc);
-
-	if (ret)
-		return ret;
+		host->pwr_reg_add |= MCI_ST_FBCLKEN;
 
 	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
@@ -1440,9 +1437,6 @@ static int mmci_probe(struct amba_device *dev,
 			return -ENOMEM;
 	}
 
-	if (np)
-		mmci_dt_populate_generic_pdata(np, plat);
-
 	mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
 	if (!mmc)
 		return -ENOMEM;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8fc5814..347d942 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -13,6 +13,16 @@
 #define MCI_PWR_ON		0x03
 #define MCI_OD			(1 << 6)
 #define MCI_ROD			(1 << 7)
+/*
+ * The ST Micro version does not have ROD and reuse the voltage registers for
+ * direction settings.
+ */
+#define MCI_ST_DATA2DIREN	(1 << 2)
+#define MCI_ST_CMDDIREN		(1 << 3)
+#define MCI_ST_DATA0DIREN	(1 << 4)
+#define MCI_ST_DATA31DIREN	(1 << 5)
+#define MCI_ST_FBCLKEN		(1 << 7)
+#define MCI_ST_DATA74DIREN	(1 << 8)
 
 #define MMCICLOCK		0x004
 #define MCI_CLK_ENABLE		(1 << 8)
@@ -183,6 +193,7 @@ struct mmci_host {
 	unsigned int		mclk;
 	unsigned int		cclk;
 	u32			pwr_reg;
+	u32			pwr_reg_add;
 	u32			clk_reg;
 	u32			datactrl_reg;
 	u32			busy_status;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 32a89cf..0d3ff95 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,19 +6,6 @@
 
 #include <linux/mmc/host.h>
 
-
-/*
- * These defines is places here due to access is needed from machine
- * configuration files. The ST Micro version does not have ROD and
- * reuse the voltage registers for direction settings.
- */
-#define MCI_ST_DATA2DIREN	(1 << 2)
-#define MCI_ST_CMDDIREN		(1 << 3)
-#define MCI_ST_DATA0DIREN	(1 << 4)
-#define MCI_ST_DATA31DIREN	(1 << 5)
-#define MCI_ST_FBCLKEN		(1 << 7)
-#define MCI_ST_DATA74DIREN	(1 << 8)
-
 /* Just some dummy forwarding */
 struct dma_chan;
 
@@ -45,8 +32,6 @@ struct dma_chan;
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
  * @capabilities2: more capabilities, MMC_CAP2_* from mmc/host.h
- * @sigdir: a bit field indicating for what bits in the MMC bus the host
- * should enable signal direction indication.
  * @dma_filter: function used to select an appropriate RX and TX
  * DMA channel to be used for DMA, if and only if you're deploying the
  * generic DMA engine
@@ -69,7 +54,6 @@ struct mmci_platform_data {
 	bool	cd_invert;
 	unsigned long capabilities;
 	unsigned long capabilities2;
-	u32 sigdir;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-- 
1.7.9.5

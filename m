From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:14 +0100
Subject: [PATCH 17/20] mmc: mmci: Enforce DT for signal direction
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-18-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the option to provide signal direction configuration as platform
data, enforce it through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c   |   24 ++++++++----------------
 drivers/mmc/host/mmci.h   |    1 +
 include/linux/amba/mmci.h |    4 ----
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edf3cfd..bef3f85 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -34,6 +34,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/amba/mmci.h>
+#include <dt-bindings/mmc/mmci.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
@@ -1287,7 +1288,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * indicating signal direction for the signals in
 		 * the SD/MMC bus and feedback-clock usage.
 		 */
-		pwr |= host->plat->sigdir;
+		pwr |= host->sigdir;
 
 		if (ios->bus_width == MMC_BUS_WIDTH_4)
 			pwr &= ~MCI_ST_DATA74DIREN;
@@ -1386,24 +1387,18 @@ static struct mmc_host_ops mmci_ops = {
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
 };
 
-static void mmci_dt_populate_generic_pdata(struct device_node *np,
-					struct mmci_platform_data *pdata)
-{
-	u32 sigdir = 0;
-
-	if (!of_property_read_u32(np, "signal-direction", &sigdir)) {
-		sigdir &= MCI_ST_DATA2DIREN|MCI_ST_CMDDIREN|MCI_ST_DATA0DIREN|
-			MCI_ST_DATA31DIREN|MCI_ST_FBCLKEN|MCI_ST_DATA74DIREN;
-		pdata->sigdir = sigdir;
-	}
-}
-
 static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 {
+	struct mmci_host *host = mmc_priv(mmc);
 	int ret = mmc_of_parse(mmc);
 	if (ret)
 		return ret;
 
+	if (!of_property_read_u32(np, "signal-direction", &host->sigdir))
+		host->sigdir &= MCI_ST_DATA2DIREN | MCI_ST_CMDDIREN |
+			MCI_ST_DATA0DIREN | MCI_ST_DATA31DIREN |
+			MCI_ST_FBCLKEN | MCI_ST_DATA74DIREN;
+
 	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
@@ -1434,9 +1429,6 @@ static int mmci_probe(struct amba_device *dev,
 			return -ENOMEM;
 	}
 
-	if (np)
-		mmci_dt_populate_generic_pdata(np, plat);
-
 	if (!devm_request_mem_region(&dev->dev, dev->res.start,
 				resource_size(&dev->res), DRIVER_NAME))
 		return -ENOMEM;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8fc5814..6fdd11b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -188,6 +188,7 @@ struct mmci_host {
 	u32			busy_status;
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
+	u32			sigdir;
 	struct variant_data	*variant;
 
 	u8			hw_designer;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 47ff176..0d3ff95 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -5,7 +5,6 @@
 #define AMBA_MMCI_H
 
 #include <linux/mmc/host.h>
-#include <dt-bindings/mmc/mmci.h>
 
 /* Just some dummy forwarding */
 struct dma_chan;
@@ -33,8 +32,6 @@ struct dma_chan;
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
  * @capabilities2: more capabilities, MMC_CAP2_* from mmc/host.h
- * @sigdir: a bit field indicating for what bits in the MMC bus the host
- * should enable signal direction indication.
  * @dma_filter: function used to select an appropriate RX and TX
  * DMA channel to be used for DMA, if and only if you're deploying the
  * generic DMA engine
@@ -57,7 +54,6 @@ struct mmci_platform_data {
 	bool	cd_invert;
 	unsigned long capabilities;
 	unsigned long capabilities2;
-	u32 sigdir;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-- 
1.7.9.5

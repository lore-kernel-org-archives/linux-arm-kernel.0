From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 8 Oct 2018 14:08:49 +0200
Subject: [PATCH V6 17/23] mmc: mmci: add variant property to not read datacnt
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1539000535-13261-18-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a boolean property to not read datacnt register.
Needed to support the STM32 sdmmc variant. MMCIDATACNT
register should be read only after the data transfer is completed.
When reading after an error event the read data count value may be
different from the real number of data bytes transferred.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++++--
 drivers/mmc/host/mmci.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 66aa59f..7607599 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1123,8 +1123,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 * can be as much as a FIFO-worth of data ahead.  This
 		 * matters for FIFO overruns only.
 		 */
-		remain = readl(host->base + MMCIDATACNT);
-		success = data->blksz * data->blocks - remain;
+		if (!host->variant->datacnt_useless) {
+			remain = readl(host->base + MMCIDATACNT);
+			success = data->blksz * data->blocks - remain;
+		} else {
+			success = 0;
+		}
 
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
 			status_err, success);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index eef7dd5..cdcadd2 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -224,6 +224,8 @@ struct mmci_host;
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
  * @datactrl_first: true if data must be setup before send command
+ * @datacnt_useless: true if you could not use datacnt register to read
+ *		     remaining data
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -264,6 +266,7 @@ struct variant_data {
 	unsigned int		datactrl_blocksz;
 	unsigned int		datactrl_dpsm_enable;
 	u8			datactrl_first:1;
+	u8			datacnt_useless:1;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			blksz_datactrl16:1;
-- 
2.7.4

From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 12 Jun 2018 15:14:32 +0200
Subject: [PATCH 11/19] mmc: mmci: add variant property to check specific data
 constraint
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1528809280-31116-12-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a function pointer to check specific data constraint
follow hardware variant. Needed to support the STM32 sdmmc variant
which has alignment constraint.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 +++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index abddad7..9c00804 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -312,6 +312,8 @@ static int mmci_card_busy(struct mmc_host *mmc)
 static int mmci_validate_data(struct mmci_host *host,
 			      struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
+
 	if (!data)
 		return 0;
 
@@ -321,6 +323,9 @@ static int mmci_validate_data(struct mmci_host *host,
 		return -EINVAL;
 	}
 
+	if (variant->validate_data)
+		return variant->validate_data(host, data);
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 12ee2e6..30d3f53 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -284,6 +284,7 @@ struct mmci_host;
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @mmci_dma: Pointer to platform-specific DMA callbacks.
+ * @validate_data: if hardware block has specific constraint on validate data
  * @set_clk_ios: if clock procedure of variant is specific
  * @set_pwr_ios: if power procedure of variant is specific
  */
@@ -328,6 +329,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
 			   unsigned int pwr);
-- 
2.7.4

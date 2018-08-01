From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 1 Aug 2018 11:36:53 +0200
Subject: [PATCH 06/14] mmc: mmci: merge prepare data functions
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1533116221-380-7-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch merges the prepare data functions.
This allows to define a single access to prepare data service.
This prepares integration for mmci host ops.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5646c2e6..e4d80f1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -651,11 +651,16 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return -ENOMEM;
 }
 
-static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data)
+static inline int mmci_dma_prepare_data(struct mmci_host *host,
+					struct mmc_data *data,
+					bool next)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *nd = &dmae->next_data;
 
+	if (next)
+		return __mmci_dma_prep_data(host, data, &nd->dma_chan,
+					    &nd->dma_desc);
 	/* Check if next job is already prepared. */
 	if (dmae->dma_current && dmae->dma_desc_current)
 		return 0;
@@ -665,22 +670,13 @@ static inline int mmci_dma_prep_data(struct mmci_host *host,
 				    &dmae->dma_desc_current);
 }
 
-static inline int mmci_dma_prep_next(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	struct dmaengine_priv *dmae = host->dma_priv;
-	struct dmaengine_next *nd = &dmae->next_data;
-
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
-}
-
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 	int ret;
 
-	ret = mmci_dma_prep_data(host, host->data);
+	ret = mmci_dma_prepare_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -737,7 +733,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
+	if (!mmci_dma_prepare_data(host, data, true))
 		data->host_cookie = ++host->next_cookie < 0 ?
 			1 : host->next_cookie;
 }
-- 
2.7.4

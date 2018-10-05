From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 5 Oct 2018 15:22:42 +0200
Subject: [PATCH V5 04/24] mmc: mmci: merge prepare data functions
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1538745782-27446-5-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch merges the prepare data functions.
This allows to define a single access to prepare data service.
This prepares integration for mmci host ops.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 792de67..be22fa9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -677,10 +677,14 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 }
 
 static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data)
+				     struct mmc_data *data,
+				     bool next)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *nd = &dmae->next_data;
 
+	if (next)
+		return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
 	/* Check if next job is already prepared. */
 	if (dmae->cur && dmae->desc_current)
 		return 0;
@@ -690,15 +694,6 @@ static inline int mmci_dma_prep_data(struct mmci_host *host,
 				    &dmae->desc_current);
 }
 
-static inline int mmci_dma_prep_next(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	struct mmci_dmae_priv *dmae = host->dma_priv;
-	struct mmci_dmae_next *nd = &dmae->next_data;
-
-	return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
-}
-
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	int ret;
@@ -708,7 +703,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (!host->use_dma)
 		return -EINVAL;
 
-	ret = mmci_dma_prep_data(host, host->data);
+	ret = mmci_dma_prep_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -768,7 +763,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
+	if (!mmci_dma_prep_data(host, data, true))
 		data->host_cookie = ++host->next_cookie < 0 ?
 			1 : host->next_cookie;
 }
-- 
2.7.4

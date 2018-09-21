From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 21 Sep 2018 11:46:04 +0200
Subject: [PATCH V2 10/27] mmc: mmci: add dma_release callback
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1537523181-14578-11-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_release callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

# Conflicts:
#	drivers/mmc/host/mmci.h

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 13 ++++++++-----
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2a433ed..562b382 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -409,6 +409,12 @@ int mmci_dma_setup(struct mmci_host *host)
 	return host->ops->dma_setup(host);
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -546,7 +552,7 @@ int mmci_dmae_setup(struct mmci_host *host)
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 
@@ -799,13 +805,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
+	.dma_release = mmci_dmae_release,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
-
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
 {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 72fe02d..a05f9a2 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -279,6 +279,7 @@ struct mmci_host_ops {
 			    int err);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -335,4 +336,5 @@ void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 003c497..e3e195d 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -186,6 +186,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

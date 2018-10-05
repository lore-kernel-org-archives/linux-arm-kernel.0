From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 5 Oct 2018 15:22:48 +0200
Subject: [PATCH V5 10/24] mmc: mmci: add validate_data callback
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1538745782-27446-11-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds validate_data callback at mmci_host_ops
to check specific constraints of variant.
Move mmci_validate_data function to regroup mmci_host_ops interfaces.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 657ec84..0444aba 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -233,24 +233,6 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	return busy;
 }
 
-/*
- * Validate mmc prerequisites
- */
-static int mmci_validate_data(struct mmci_host *host,
-			      struct mmc_data *data)
-{
-	if (!data)
-		return 0;
-
-	if (!is_power_of_2(data->blksz)) {
-		dev_err(mmc_dev(host->mmc),
-			"unsupported block size (%d bytes)\n", data->blksz);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void mmci_reg_delay(struct mmci_host *host)
 {
 	/*
@@ -388,6 +370,27 @@ void mmci_dma_setup(struct mmci_host *host)
 	host->use_dma = true;
 }
 
+/*
+ * Validate mmc prerequisites
+ */
+static int mmci_validate_data(struct mmci_host *host,
+			      struct mmc_data *data)
+{
+	if (!data)
+		return 0;
+
+	if (!is_power_of_2(data->blksz)) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported block size (%d bytes)\n", data->blksz);
+		return -EINVAL;
+	}
+
+	if (host->ops && host->ops->validate_data)
+		return host->ops->validate_data(host, data);
+
+	return 0;
+}
+
 int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 45aad99..f103465 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*prep_data)(struct mmci_host *host, struct mmc_data *data,
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4

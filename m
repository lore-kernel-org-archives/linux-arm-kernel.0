From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 1 Aug 2018 11:37:01 +0200
Subject: [PATCH 14/14] mmc: mmci: add validate_data callback
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1533116221-380-15-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds validate_data callback at mmci_host_ops
to check specific constraints of variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d5ca93e..7ba2f61 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -234,24 +234,6 @@ static int mmci_card_busy(struct mmc_host *mmc)
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
@@ -365,6 +347,27 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
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
 int mmci_prepare_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 0a4811d..10b71bf 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*prepare_data)(struct mmci_host *host, struct mmc_data *data,
 			    bool next);
 	void (*unprepare_data)(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4

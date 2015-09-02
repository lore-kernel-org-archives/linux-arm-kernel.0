From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:46 -0700
Subject: [PATCH v2 3/8] soc: qcom: smd: Represent channel layout in structures
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rx and tx channel info are laid out in memory next to each
other, and there are two types of channel info structures, byte
based and word based. We have 4 pointers to these info
structures, when we really only need two to point to the
different types of structures. Encapsulate the byte based and
word based tx/rx structures in a "channel pair" structure that
describes the layout of memory and reduces the number of pointers
in the smd channel structure by two.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * Renamed structures smd_channel_info{_word}_pair

 drivers/soc/qcom/smd.c | 61 +++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index aa65c07f281e..15edef1dc58a 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -65,7 +65,9 @@
  */
 
 struct smd_channel_info;
+struct smd_channel_info_pair;
 struct smd_channel_info_word;
+struct smd_channel_info_word_pair;
 
 #define SMD_ALLOC_TBL_COUNT	2
 #define SMD_ALLOC_TBL_SIZE	64
@@ -151,10 +153,8 @@ enum smd_channel_state {
  * @name:		name of the channel
  * @state:		local state of the channel
  * @remote_state:	remote state of the channel
- * @tx_info:		byte aligned outgoing channel info
- * @rx_info:		byte aligned incoming channel info
- * @tx_info_word:	word aligned outgoing channel info
- * @rx_info_word:	word aligned incoming channel info
+ * @info:		byte aligned outgoing/incoming channel info
+ * @info_word:		word aligned outgoing/incoming channel info
  * @tx_lock:		lock to make writes to the channel mutually exclusive
  * @fblockread_event:	wakeup event tied to tx fBLOCKREADINTR
  * @tx_fifo:		pointer to the outgoing ring buffer
@@ -175,11 +175,8 @@ struct qcom_smd_channel {
 	enum smd_channel_state state;
 	enum smd_channel_state remote_state;
 
-	struct smd_channel_info *tx_info;
-	struct smd_channel_info *rx_info;
-
-	struct smd_channel_info_word *tx_info_word;
-	struct smd_channel_info_word *rx_info_word;
+	struct smd_channel_info_pair *info;
+	struct smd_channel_info_word_pair *info_word;
 
 	struct mutex tx_lock;
 	wait_queue_head_t fblockread_event;
@@ -228,6 +225,11 @@ struct smd_channel_info {
 	u32 head;
 };
 
+struct smd_channel_info_pair {
+	struct smd_channel_info tx;
+	struct smd_channel_info rx;
+};
+
 /*
  * Format of the smd_info smem items, for word aligned channels.
  */
@@ -245,25 +247,30 @@ struct smd_channel_info_word {
 	u32 head;
 };
 
+struct smd_channel_info_word_pair {
+	struct smd_channel_info_word tx;
+	struct smd_channel_info_word rx;
+};
+
 #define GET_RX_CHANNEL_INFO(channel, param) \
-	(channel->rx_info_word ? \
-		channel->rx_info_word->param : \
-		channel->rx_info->param)
+	(channel->info_word ? \
+		channel->info_word->rx.param : \
+		channel->info->rx.param)
 
 #define SET_RX_CHANNEL_INFO(channel, param, value) \
-	(channel->rx_info_word ? \
-		(channel->rx_info_word->param = value) : \
-		(channel->rx_info->param = value))
+	(channel->info_word ? \
+		(channel->info_word->rx.param = value) : \
+		(channel->info->rx.param = value))
 
 #define GET_TX_CHANNEL_INFO(channel, param) \
-	(channel->tx_info_word ? \
-		channel->tx_info_word->param : \
-		channel->tx_info->param)
+	(channel->info_word ? \
+		channel->info_word->tx.param : \
+		channel->info->tx.param)
 
 #define SET_TX_CHANNEL_INFO(channel, param, value) \
-	(channel->tx_info_word ? \
-		(channel->tx_info_word->param = value) : \
-		(channel->tx_info->param = value))
+	(channel->info_word ? \
+		(channel->info_word->tx.param = value) : \
+		(channel->info->tx.param = value))
 
 /**
  * struct qcom_smd_alloc_entry - channel allocation entry
@@ -412,7 +419,7 @@ static size_t qcom_smd_channel_peek(struct qcom_smd_channel *channel,
 	unsigned tail;
 	size_t len;
 
-	word_aligned = channel->rx_info_word != NULL;
+	word_aligned = channel->info_word;
 	tail = GET_RX_CHANNEL_INFO(channel, tail);
 
 	len = min_t(size_t, count, channel->fifo_size - tail);
@@ -627,7 +634,7 @@ static int qcom_smd_write_fifo(struct qcom_smd_channel *channel,
 	unsigned head;
 	size_t len;
 
-	word_aligned = channel->tx_info_word != NULL;
+	word_aligned = channel->info_word;
 	head = GET_TX_CHANNEL_INFO(channel, head);
 
 	len = min_t(size_t, count, channel->fifo_size - head);
@@ -670,7 +677,7 @@ int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len)
 	int ret;
 
 	/* Word aligned channels only accept word size aligned data */
-	if (channel->rx_info_word != NULL && len % 4)
+	if (channel->info_word && len % 4)
 		return -EINVAL;
 
 	ret = mutex_lock_interruptible(&channel->tx_lock);
@@ -989,11 +996,9 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	 * use.
 	 */
 	if (info_size == 2 * sizeof(struct smd_channel_info_word)) {
-		channel->tx_info_word = info;
-		channel->rx_info_word = info + sizeof(struct smd_channel_info_word);
+		channel->info_word = info;
 	} else if (info_size == 2 * sizeof(struct smd_channel_info)) {
-		channel->tx_info = info;
-		channel->rx_info = info + sizeof(struct smd_channel_info);
+		channel->info = info;
 	} else {
 		dev_err(smd->dev,
 			"channel info of size %zu not supported\n", info_size);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:49 -0700
Subject: [PATCH v2 6/8] soc: qcom: smd: Handle big endian CPUs
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smd structures are always in little endian, but the smd
driver is not capable of being used on big endian CPUs. Annotate
the little endian data members and update the code to do the
proper byte swapping.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * hdr and pkt_len marked as __le32
 * FLAG instead of INFO8

 drivers/soc/qcom/smd.c | 181 +++++++++++++++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 65 deletions(-)

diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index 069724b8189e..2b7bd698e78b 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -212,7 +212,7 @@ struct qcom_smd {
  * Format of the smd_info smem items, for byte aligned channels.
  */
 struct smd_channel_info {
-	u32 state;
+	__le32 state;
 	u8  fDSR;
 	u8  fCTS;
 	u8  fCD;
@@ -221,8 +221,8 @@ struct smd_channel_info {
 	u8  fTAIL;
 	u8  fSTATE;
 	u8  fBLOCKREADINTR;
-	u32 tail;
-	u32 head;
+	__le32 tail;
+	__le32 head;
 };
 
 struct smd_channel_info_pair {
@@ -234,17 +234,17 @@ struct smd_channel_info_pair {
  * Format of the smd_info smem items, for word aligned channels.
  */
 struct smd_channel_info_word {
-	u32 state;
-	u32 fDSR;
-	u32 fCTS;
-	u32 fCD;
-	u32 fRI;
-	u32 fHEAD;
-	u32 fTAIL;
-	u32 fSTATE;
-	u32 fBLOCKREADINTR;
-	u32 tail;
-	u32 head;
+	__le32 state;
+	__le32 fDSR;
+	__le32 fCTS;
+	__le32 fCD;
+	__le32 fRI;
+	__le32 fHEAD;
+	__le32 fTAIL;
+	__le32 fSTATE;
+	__le32 fBLOCKREADINTR;
+	__le32 tail;
+	__le32 head;
 };
 
 struct smd_channel_info_word_pair {
@@ -252,25 +252,73 @@ struct smd_channel_info_word_pair {
 	struct smd_channel_info_word rx;
 };
 
-#define GET_RX_CHANNEL_INFO(channel, param) \
-	(channel->info_word ? \
-		channel->info_word->rx.param : \
-		channel->info->rx.param)
-
-#define SET_RX_CHANNEL_INFO(channel, param, value) \
-	(channel->info_word ? \
-		(channel->info_word->rx.param = value) : \
-		(channel->info->rx.param = value))
-
-#define GET_TX_CHANNEL_INFO(channel, param) \
-	(channel->info_word ? \
-		channel->info_word->tx.param : \
-		channel->info->tx.param)
-
-#define SET_TX_CHANNEL_INFO(channel, param, value) \
-	(channel->info_word ? \
-		(channel->info_word->tx.param = value) : \
-		(channel->info->tx.param = value))
+#define GET_RX_CHANNEL_FLAG(channel, param)				     \
+	({								     \
+		BUILD_BUG_ON(sizeof(channel->info->rx.param) != sizeof(u8)); \
+		channel->info_word ?					     \
+			le32_to_cpu(channel->info_word->rx.param) :	     \
+			channel->info->rx.param;			     \
+	})
+
+#define GET_RX_CHANNEL_INFO(channel, param)				      \
+	({								      \
+		BUILD_BUG_ON(sizeof(channel->info->rx.param) != sizeof(u32)); \
+		le32_to_cpu(channel->info_word ?			      \
+			channel->info_word->rx.param :			      \
+			channel->info->rx.param);			      \
+	})
+
+#define SET_RX_CHANNEL_FLAG(channel, param, value)			     \
+	({								     \
+		BUILD_BUG_ON(sizeof(channel->info->rx.param) != sizeof(u8)); \
+		if (channel->info_word)					     \
+			channel->info_word->rx.param = cpu_to_le32(value);   \
+		else							     \
+			channel->info->rx.param = value;		     \
+	})
+
+#define SET_RX_CHANNEL_INFO(channel, param, value)			      \
+	({								      \
+		BUILD_BUG_ON(sizeof(channel->info->rx.param) != sizeof(u32)); \
+		if (channel->info_word)					      \
+			channel->info_word->rx.param = cpu_to_le32(value);    \
+		else							      \
+			channel->info->rx.param = cpu_to_le32(value);	      \
+	})
+
+#define GET_TX_CHANNEL_FLAG(channel, param)				     \
+	({								     \
+		BUILD_BUG_ON(sizeof(channel->info->tx.param) != sizeof(u8)); \
+		channel->info_word ?					     \
+			le32_to_cpu(channel->info_word->tx.param) :          \
+			channel->info->tx.param;			     \
+	})
+
+#define GET_TX_CHANNEL_INFO(channel, param)				      \
+	({								      \
+		BUILD_BUG_ON(sizeof(channel->info->tx.param) != sizeof(u32)); \
+		le32_to_cpu(channel->info_word ?			      \
+			channel->info_word->tx.param :			      \
+			channel->info->tx.param);			      \
+	})
+
+#define SET_TX_CHANNEL_FLAG(channel, param, value)			     \
+	({								     \
+		BUILD_BUG_ON(sizeof(channel->info->tx.param) != sizeof(u8)); \
+		if (channel->info_word)					     \
+			channel->info_word->tx.param = cpu_to_le32(value);   \
+		else							     \
+			channel->info->tx.param = value;		     \
+	})
+
+#define SET_TX_CHANNEL_INFO(channel, param, value)			      \
+	({								      \
+		BUILD_BUG_ON(sizeof(channel->info->tx.param) != sizeof(u32)); \
+		if (channel->info_word)					      \
+			channel->info_word->tx.param = cpu_to_le32(value);   \
+		else							      \
+			channel->info->tx.param = cpu_to_le32(value);	      \
+	})
 
 /**
  * struct qcom_smd_alloc_entry - channel allocation entry
@@ -281,9 +329,9 @@ struct smd_channel_info_word_pair {
  */
 struct qcom_smd_alloc_entry {
 	u8 name[20];
-	u32 cid;
-	u32 flags;
-	u32 ref_count;
+	__le32 cid;
+	__le32 flags;
+	__le32 ref_count;
 } __packed;
 
 #define SMD_CHANNEL_FLAGS_EDGE_MASK	0xff
@@ -312,14 +360,14 @@ static void qcom_smd_signal_channel(struct qcom_smd_channel *channel)
 static void qcom_smd_channel_reset(struct qcom_smd_channel *channel)
 {
 	SET_TX_CHANNEL_INFO(channel, state, SMD_CHANNEL_CLOSED);
-	SET_TX_CHANNEL_INFO(channel, fDSR, 0);
-	SET_TX_CHANNEL_INFO(channel, fCTS, 0);
-	SET_TX_CHANNEL_INFO(channel, fCD, 0);
-	SET_TX_CHANNEL_INFO(channel, fRI, 0);
-	SET_TX_CHANNEL_INFO(channel, fHEAD, 0);
-	SET_TX_CHANNEL_INFO(channel, fTAIL, 0);
-	SET_TX_CHANNEL_INFO(channel, fSTATE, 1);
-	SET_TX_CHANNEL_INFO(channel, fBLOCKREADINTR, 0);
+	SET_TX_CHANNEL_FLAG(channel, fDSR, 0);
+	SET_TX_CHANNEL_FLAG(channel, fCTS, 0);
+	SET_TX_CHANNEL_FLAG(channel, fCD, 0);
+	SET_TX_CHANNEL_FLAG(channel, fRI, 0);
+	SET_TX_CHANNEL_FLAG(channel, fHEAD, 0);
+	SET_TX_CHANNEL_FLAG(channel, fTAIL, 0);
+	SET_TX_CHANNEL_FLAG(channel, fSTATE, 1);
+	SET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR, 0);
 	SET_TX_CHANNEL_INFO(channel, head, 0);
 	SET_TX_CHANNEL_INFO(channel, tail, 0);
 
@@ -357,12 +405,12 @@ static void qcom_smd_channel_set_state(struct qcom_smd_channel *channel,
 
 	dev_dbg(edge->smd->dev, "set_state(%s, %d)\n", channel->name, state);
 
-	SET_TX_CHANNEL_INFO(channel, fDSR, is_open);
-	SET_TX_CHANNEL_INFO(channel, fCTS, is_open);
-	SET_TX_CHANNEL_INFO(channel, fCD, is_open);
+	SET_TX_CHANNEL_FLAG(channel, fDSR, is_open);
+	SET_TX_CHANNEL_FLAG(channel, fCTS, is_open);
+	SET_TX_CHANNEL_FLAG(channel, fCD, is_open);
 
 	SET_TX_CHANNEL_INFO(channel, state, state);
-	SET_TX_CHANNEL_INFO(channel, fSTATE, 1);
+	SET_TX_CHANNEL_FLAG(channel, fSTATE, 1);
 
 	channel->state = state;
 	qcom_smd_signal_channel(channel);
@@ -397,7 +445,7 @@ static void smd_copy_from_fifo(void *_dst,
 	if (word_aligned) {
 		count /= sizeof(u32);
 		while (count--)
-			*dst++ = readl_relaxed(src++);
+			*dst++ = __raw_readl(src++);
 	} else {
 		memcpy_fromio(_dst, _src, count);
 	}
@@ -493,7 +541,7 @@ static bool qcom_smd_channel_intr(struct qcom_smd_channel *channel)
 {
 	bool need_state_scan = false;
 	int remote_state;
-	u32 pktlen;
+	__le32 pktlen;
 	int avail;
 	int ret;
 
@@ -504,10 +552,10 @@ static bool qcom_smd_channel_intr(struct qcom_smd_channel *channel)
 		need_state_scan = true;
 	}
 	/* Indicate that we have seen any state change */
-	SET_RX_CHANNEL_INFO(channel, fSTATE, 0);
+	SET_RX_CHANNEL_FLAG(channel, fSTATE, 0);
 
 	/* Signal waiting qcom_smd_send() about the interrupt */
-	if (!GET_TX_CHANNEL_INFO(channel, fBLOCKREADINTR))
+	if (!GET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR))
 		wake_up_interruptible(&channel->fblockread_event);
 
 	/* Don't consume any data until we've opened the channel */
@@ -515,7 +563,7 @@ static bool qcom_smd_channel_intr(struct qcom_smd_channel *channel)
 		goto out;
 
 	/* Indicate that we've seen the new data */
-	SET_RX_CHANNEL_INFO(channel, fHEAD, 0);
+	SET_RX_CHANNEL_FLAG(channel, fHEAD, 0);
 
 	/* Consume data */
 	for (;;) {
@@ -524,7 +572,7 @@ static bool qcom_smd_channel_intr(struct qcom_smd_channel *channel)
 		if (!channel->pkt_size && avail >= SMD_PACKET_HEADER_LEN) {
 			qcom_smd_channel_peek(channel, &pktlen, sizeof(pktlen));
 			qcom_smd_channel_advance(channel, SMD_PACKET_HEADER_LEN);
-			channel->pkt_size = pktlen;
+			channel->pkt_size = le32_to_cpu(pktlen);
 		} else if (channel->pkt_size && avail >= channel->pkt_size) {
 			ret = qcom_smd_channel_recv_single(channel);
 			if (ret)
@@ -535,10 +583,10 @@ static bool qcom_smd_channel_intr(struct qcom_smd_channel *channel)
 	}
 
 	/* Indicate that we have seen and updated tail */
-	SET_RX_CHANNEL_INFO(channel, fTAIL, 1);
+	SET_RX_CHANNEL_FLAG(channel, fTAIL, 1);
 
 	/* Signal the remote that we've consumed the data (if requested) */
-	if (!GET_RX_CHANNEL_INFO(channel, fBLOCKREADINTR)) {
+	if (!GET_RX_CHANNEL_FLAG(channel, fBLOCKREADINTR)) {
 		/* Ensure ordering of channel info updates */
 		wmb();
 
@@ -667,7 +715,7 @@ static int qcom_smd_write_fifo(struct qcom_smd_channel *channel,
  */
 int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len)
 {
-	u32 hdr[5] = {len,};
+	__le32 hdr[5] = { cpu_to_le32(len), };
 	int tlen = sizeof(hdr) + len;
 	int ret;
 
@@ -685,7 +733,7 @@ int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len)
 			goto out;
 		}
 
-		SET_TX_CHANNEL_INFO(channel, fBLOCKREADINTR, 1);
+		SET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR, 1);
 
 		ret = wait_event_interruptible(channel->fblockread_event,
 				       qcom_smd_get_tx_avail(channel) >= tlen ||
@@ -693,15 +741,15 @@ int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len)
 		if (ret)
 			goto out;
 
-		SET_TX_CHANNEL_INFO(channel, fBLOCKREADINTR, 0);
+		SET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR, 0);
 	}
 
-	SET_TX_CHANNEL_INFO(channel, fTAIL, 0);
+	SET_TX_CHANNEL_FLAG(channel, fTAIL, 0);
 
 	qcom_smd_write_fifo(channel, hdr, sizeof(hdr));
 	qcom_smd_write_fifo(channel, data, len);
 
-	SET_TX_CHANNEL_INFO(channel, fHEAD, 1);
+	SET_TX_CHANNEL_FLAG(channel, fHEAD, 1);
 
 	/* Ensure ordering of channel info updates */
 	wmb();
@@ -1044,6 +1092,7 @@ static void qcom_discover_channels(struct qcom_smd_edge *edge)
 	unsigned info_id;
 	int tbl;
 	int i;
+	u32 eflags, cid;
 
 	for (tbl = 0; tbl < SMD_ALLOC_TBL_COUNT; tbl++) {
 		alloc_tbl = qcom_smem_get(edge->remote_pid,
@@ -1053,6 +1102,7 @@ static void qcom_discover_channels(struct qcom_smd_edge *edge)
 
 		for (i = 0; i < SMD_ALLOC_TBL_SIZE; i++) {
 			entry = &alloc_tbl[i];
+			eflags = le32_to_cpu(entry->flags);
 			if (test_bit(i, edge->allocated[tbl]))
 				continue;
 
@@ -1062,14 +1112,15 @@ static void qcom_discover_channels(struct qcom_smd_edge *edge)
 			if (!entry->name[0])
 				continue;
 
-			if (!(entry->flags & SMD_CHANNEL_FLAGS_PACKET))
+			if (!(eflags & SMD_CHANNEL_FLAGS_PACKET))
 				continue;
 
-			if ((entry->flags & SMD_CHANNEL_FLAGS_EDGE_MASK) != edge->edge_id)
+			if ((eflags & SMD_CHANNEL_FLAGS_EDGE_MASK) != edge->edge_id)
 				continue;
 
-			info_id = smem_items[tbl].info_base_id + entry->cid;
-			fifo_id = smem_items[tbl].fifo_base_id + entry->cid;
+			cid = le32_to_cpu(entry->cid);
+			info_id = smem_items[tbl].info_base_id + cid;
+			fifo_id = smem_items[tbl].fifo_base_id + cid;
 
 			channel = qcom_smd_create_channel(edge, info_id, fifo_id, entry->name);
 			if (IS_ERR(channel))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

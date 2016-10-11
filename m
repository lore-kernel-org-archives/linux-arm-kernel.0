From: austinwc@codeaurora.org (Austin Christ)
Date: Tue, 11 Oct 2016 10:27:57 -0600
Subject: [PATCH v6 2/2] i2c: qup: support SMBus block read
In-Reply-To: <1476203277-6893-1-git-send-email-austinwc@codeaurora.org>
References: <1476203277-6893-1-git-send-email-austinwc@codeaurora.org>
Message-ID: <1476203277-6893-3-git-send-email-austinwc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Kaje <nkaje@codeaurora.org>

I2C QUP driver relies on SMBus emulation support from the framework.
To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
flag and should read the first byte received as the message length.

The driver configures the QUP hardware to read one byte. Once the
message length is known from this byte, the QUP hardware is configured
to read the rest.

Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
Signed-off-by: Austin Christ <austinwc@codeaurora.org>
Reviewed-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 64 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index bf0957e..d34120a 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -517,6 +517,33 @@ static int qup_i2c_get_data_len(struct qup_i2c_dev *qup)
 	return data_len;
 }
 
+static bool qup_i2c_check_msg_len(struct i2c_msg *msg)
+{
+	return ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN));
+}
+
+static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
+			struct i2c_msg *msg)
+{
+	int len = 0;
+
+	if (msg->len > 1) {
+		tags[len++] = QUP_TAG_V2_DATARD_STOP;
+		tags[len++] = qup_i2c_get_data_len(qup) - 1;
+	} else {
+		tags[len++] = QUP_TAG_V2_START;
+		tags[len++] = addr & 0xff;
+
+		if (msg->flags & I2C_M_TEN)
+			tags[len++] = addr >> 8;
+
+		tags[len++] = QUP_TAG_V2_DATARD;
+		/* Read 1 byte indicating the length of the SMBus message */
+		tags[len++] = 1;
+	}
+	return len;
+}
+
 static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
 			    struct i2c_msg *msg,  int is_dma)
 {
@@ -526,6 +553,10 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
 
 	int last = (qup->blk.pos == (qup->blk.count - 1)) && (qup->is_last);
 
+	/* Handle tags for SMBus block read */
+	if (qup_i2c_check_msg_len(msg))
+		return qup_i2c_set_tags_smb(addr, tags, qup, msg);
+
 	if (qup->blk.pos == 0) {
 		tags[len++] = QUP_TAG_V2_START;
 		tags[len++] = addr & 0xff;
@@ -1065,9 +1096,17 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
 				struct i2c_msg *msg)
 {
 	u32 val;
-	int idx, pos = 0, ret = 0, total;
+	int idx, pos = 0, ret = 0, total, msg_offset = 0;
 
+	/*
+	 * If the message length is already read in
+	 * the first byte of the buffer, account for
+	 * that by setting the offset
+	 */
+	if (qup_i2c_check_msg_len(msg) && (msg->len > 1))
+		msg_offset = 1;
 	total = qup_i2c_get_data_len(qup);
+	total -= msg_offset;
 
 	/* 2 extra bytes for read tags */
 	while (pos < (total + 2)) {
@@ -1087,8 +1126,8 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
 
 			if (pos >= (total + 2))
 				goto out;
-
-			msg->buf[qup->pos++] = val & 0xff;
+			msg->buf[qup->pos + msg_offset] = val & 0xff;
+			qup->pos++;
 		}
 	}
 
@@ -1128,6 +1167,20 @@ static int qup_i2c_read_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 			goto err;
 
 		qup->blk.pos++;
+
+		/* Handle SMBus block read length */
+		if (qup_i2c_check_msg_len(msg) && (msg->len == 1)) {
+			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
+				ret = -EPROTO;
+				goto err;
+			}
+			msg->len += msg->buf[0];
+			qup->pos = 0;
+			qup_i2c_set_blk_data(qup, msg);
+			/* set tag length for block read */
+			qup->blk.tx_tag_len = 2;
+			qup_i2c_set_read_mode_v2(qup, msg->buf[0]);
+		}
 	} while (qup->blk.pos < qup->blk.count);
 
 err:
@@ -1210,6 +1263,11 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 		}
 
+		if (qup_i2c_check_msg_len(&msgs[idx])) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (msgs[idx].flags & I2C_M_RD)
 			ret = qup_i2c_read_one(qup, &msgs[idx]);
 		else
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

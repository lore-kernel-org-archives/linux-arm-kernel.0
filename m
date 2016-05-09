From: absahu@codeaurora.org (Abhishek Sahu)
Date: Mon,  9 May 2016 18:14:31 +0530
Subject: [PATCH 2/2] i2c: qup: Fixed the DMA segments length
In-Reply-To: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
Message-ID: <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. The current QCOM I2C driver code is failing for transfer length
greater than 255. This is happening due to improper segments length
as the I2C DMA segments can be maximum of 256 bytes.

2. The transfer length tlen was being initialized with 0 for 256
bytes, which is being passed for DMA mappings resulting in improper
DMA mapping length.

This patch fixes the above said problems by initializing the block
count with the values calculated in qup_i2c_set_blk_data and calculating
the remaining length for last DMA segment. Also, the block data length
need to be decremented after each transfer. Additionally, this patch
corrects the tlen assignment for DMA mapping.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 8c2f1bc..6d6b7dc 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -651,23 +651,24 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 	u8 *tags;
 
 	while (idx < num) {
-		blocks = (msg->len + limit) / limit;
-		rem = msg->len % limit;
 		tx_len = 0, len = 0, i = 0;
 
 		qup->is_last = (idx == (num - 1));
 
 		qup_i2c_set_blk_data(qup, msg);
 
+		blocks = qup->blk.count;
+		rem = msg->len - (blocks - 1) * limit;
+
 		if (msg->flags & I2C_M_RD) {
 			rx_nents += (blocks * 2) + 1;
 			tx_nents += 1;
 
 			while (qup->blk.pos < blocks) {
-				/* length set to '0' implies 256 bytes */
-				tlen = (i == (blocks - 1)) ? rem : 0;
+				tlen = (i == (blocks - 1)) ? rem : limit;
 				tags = &qup->start_tag.start[off + len];
 				len += qup_i2c_set_tags(tags, qup, msg, 1);
+				qup->blk.data_len -= tlen;
 
 				/* scratch buf to read the start and len tags */
 				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
@@ -706,9 +707,10 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 			tx_nents += (blocks * 2);
 
 			while (qup->blk.pos < blocks) {
-				tlen = (i == (blocks - 1)) ? rem : 0;
+				tlen = (i == (blocks - 1)) ? rem : limit;
 				tags = &qup->start_tag.start[off + tx_len];
 				len = qup_i2c_set_tags(tags, qup, msg, 1);
+				qup->blk.data_len -= tlen;
 
 				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
 						     tags,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

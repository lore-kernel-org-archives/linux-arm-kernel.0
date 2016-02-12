From: shaun.ren@linux.com (Shaun Ren)
Date: Thu, 11 Feb 2016 20:07:54 -0800
Subject: [PATCH v4 2/8] Staging: rts5208: rtsx_transport.c: Align to open
 parenthesis
In-Reply-To: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
References: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
 <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455250080-9897-3-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the alignment issue reported by checkpatch.pl:

CHECK: Alignment should match open parenthesis

Add a unsigned char *sgbuffer in rtsx_stor_access_xfer_buffer to make the
following memcpy logic easier to read.

Add a struct scatterlist *sg in the use_sg branch of
rtsx_transfer_data_partial to make the parameters of the
rtsx_transfer_sglist_adma_partial call fit in 80 character lines after
aligning them to the open parenthesis.

Refactor memcpy logic in rtsx_stor_access_xfer_buf to make it more legible.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
Changes since v3
  * Fixed misalignment of the last parameter of rtsx_stor_access_xfer_buf()
  * Refactored memcpy in rtsx_stor_access_xfer_buf() for legibility

 drivers/staging/rts5208/rtsx_transport.c | 68 +++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 91fdccf..1a4da89 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -42,8 +42,11 @@
  */
 
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
-	unsigned int *offset, enum xfer_buf_dir dir)
+				       unsigned int buflen,
+				       struct scsi_cmnd *srb,
+				       unsigned int *index,
+				       unsigned int *offset,
+				       enum xfer_buf_dir dir)
 {
 	unsigned int cnt;
 
@@ -52,12 +55,14 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		if (*offset >= scsi_bufflen(srb))
 			return 0;
 		cnt = min(buflen, scsi_bufflen(srb) - *offset);
+
+		unsigned char *sgbuffer = (unsigned char *)scsi_sglist(srb) +
+			*offset;
+
 		if (dir == TO_XFER_BUF)
-			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
-					buffer, cnt);
+			memcpy(sgbuffer, buffer, cnt);
 		else
-			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
-					*offset, cnt);
+			memcpy(buffer, sgbuffer, cnt);
 		*offset += cnt;
 
 	/*
@@ -126,7 +131,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
  * SCSI residue.
  */
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -137,7 +142,7 @@ void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 }
 
 void rtsx_stor_get_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -191,8 +196,8 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* set the result so the higher layers expect this data */
 		srb->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(srb->sense_buffer,
-			(unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
-			sizeof(struct sense_data_t));
+		       (unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       sizeof(struct sense_data_t));
 	}
 
 	return;
@@ -202,7 +207,7 @@ Handle_Errors:
 }
 
 void rtsx_add_cmd(struct rtsx_chip *chip,
-		u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
+		  u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
 {
 	u32 *cb = (u32 *)(chip->host_cmds_ptr);
 	u32 val = 0;
@@ -321,9 +326,11 @@ static inline void rtsx_add_sg_tbl(
 }
 
 static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
-		struct scatterlist *sg, int num_sg, unsigned int *index,
-		unsigned int *offset, int size,
-		enum dma_data_direction dma_dir, int timeout)
+					     struct scatterlist *sg, int num_sg,
+					     unsigned int *index,
+					     unsigned int *offset, int size,
+					     enum dma_data_direction dma_dir,
+					     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -486,8 +493,9 @@ out:
 }
 
 static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
-		struct scatterlist *sg, int num_sg,
-		enum dma_data_direction dma_dir, int timeout)
+				     struct scatterlist *sg, int num_sg,
+				     enum dma_data_direction dma_dir,
+				     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -633,7 +641,8 @@ out:
 }
 
 static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
-		size_t len, enum dma_data_direction dma_dir, int timeout)
+			     size_t len, enum dma_data_direction dma_dir,
+			     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -716,9 +725,9 @@ out:
 }
 
 int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
-		void *buf, size_t len, int use_sg, unsigned int *index,
-		unsigned int *offset, enum dma_data_direction dma_dir,
-		int timeout)
+			       void *buf, size_t len, int use_sg,
+			       unsigned int *index, unsigned int *offset,
+			       enum dma_data_direction dma_dir, int timeout)
 {
 	int err = 0;
 
@@ -726,13 +735,16 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT))
 		return -EIO;
 
-	if (use_sg)
-		err = rtsx_transfer_sglist_adma_partial(chip, card,
-				(struct scatterlist *)buf, use_sg,
-				index, offset, (int)len, dma_dir, timeout);
-	else
+	if (use_sg) {
+		struct scatterlist *sg = (struct scatterlist *)buf;
+
+		err = rtsx_transfer_sglist_adma_partial(chip, card, sg, use_sg,
+							index, offset, (int)len,
+							dma_dir, timeout);
+	} else {
 		err = rtsx_transfer_buf(chip, card,
 					buf, len, dma_dir, timeout);
+	}
 	if (err < 0) {
 		if (RTSX_TST_DELINK(chip)) {
 			RTSX_CLR_DELINK(chip);
@@ -745,7 +757,7 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 }
 
 int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
-		int use_sg, enum dma_data_direction dma_dir, int timeout)
+		       int use_sg, enum dma_data_direction dma_dir, int timeout)
 {
 	int err = 0;
 
@@ -757,8 +769,8 @@ int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
 
 	if (use_sg) {
 		err = rtsx_transfer_sglist_adma(chip, card,
-				(struct scatterlist *)buf,
-				use_sg, dma_dir, timeout);
+						(struct scatterlist *)buf,
+						use_sg, dma_dir, timeout);
 	} else {
 		err = rtsx_transfer_buf(chip, card, buf, len, dma_dir, timeout);
 	}
-- 
2.7.0

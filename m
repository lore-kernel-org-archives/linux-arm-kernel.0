From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 25 Jan 2016 18:27:27 -0800
Subject: [PATCH 1/2] Staging: rts5208: Cleanup rtsx_transport.c
In-Reply-To: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1453775248-15965-2-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes coding style issues in rtsx_transport.c.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 115 +++++++++++++++++--------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index f27491e..eff9a4b621 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -36,25 +36,30 @@
  * For non-scatter-gather transfers, srb->request_buffer points to the
  * transfer buffer itself and srb->request_bufflen is the buffer's length.)
  * Update the *index and *offset variables so that the next copy will
- * pick up from where this one left off. */
+ * pick up from where this one left off.
+ */
 
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
 
 	/* If not using scatter-gather, just transfer the data directly.
-	 * Make certain it will fit in the available buffer space. */
+	 * Make certain it will fit in the available buffer space.
+	 */
 	if (scsi_sg_count(srb) == 0) {
 		if (*offset >= scsi_bufflen(srb))
 			return 0;
 		cnt = min(buflen, scsi_bufflen(srb) - *offset);
 		if (dir == TO_XFER_BUF)
-			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
-					buffer, cnt);
+			memcpy((unsigned char *)scsi_sglist(srb) + *offset,
+			       buffer, cnt);
 		else
-			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
+			memcpy(buffer, (unsigned char *)scsi_sglist(srb) +
 					*offset, cnt);
 		*offset += cnt;
 
@@ -64,31 +69,31 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 * in kernel-addressable memory then kmap() will return its address.
 	 * If the page is not directly accessible -- such as a user buffer
 	 * located in high memory -- then kmap() will map it to a temporary
-	 * position in the kernel's virtual address space. */
+	 * position in the kernel's virtual address space.
+	 */
 	} else {
 		struct scatterlist *sg =
-				(struct scatterlist *) scsi_sglist(srb)
+				(struct scatterlist *)scsi_sglist(srb)
 				+ *index;
 
 		/* This loop handles a single s-g list entry, which may
 		 * include multiple pages.  Find the initial page structure
 		 * and the starting offset within the page, and update
-		 * the *offset and *index values for the next loop. */
+		 * the *offset and *index values for the next loop.
+		 */
 		cnt = 0;
 		while (cnt < buflen && *index < scsi_sg_count(srb)) {
 			struct page *page = sg_page(sg) +
 					((sg->offset + *offset) >> PAGE_SHIFT);
-			unsigned int poff =
-					(sg->offset + *offset) & (PAGE_SIZE-1);
+			unsigned int poff = (sg->offset + *offset) &
+				(PAGE_SIZE - 1);
 			unsigned int sglen = sg->length - *offset;
 
 			if (sglen > buflen - cnt) {
-
 				/* Transfer ends within this s-g entry */
 				sglen = buflen - cnt;
 				*offset += sglen;
 			} else {
-
 				/* Transfer continues to next s-g entry */
 				*offset = 0;
 				++*index;
@@ -97,7 +102,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 
 			/* Transfer the data for all the pages in this
 			 * s-g entry.  For each page: call kmap(), do the
-			 * transfer, and call kunmap() immediately after. */
+			 * transfer, and call kunmap() immediately after.
+			 */
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
@@ -123,9 +129,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 }
 
 /* Store the contents of buffer into srb's transfer buffer and set the
-* SCSI residue. */
+ * SCSI residue.
+ */
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -136,7 +143,7 @@ void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 }
 
 void rtsx_stor_get_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -146,7 +153,6 @@ void rtsx_stor_get_xfer_buf(unsigned char *buffer,
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
 }
 
-
 /***********************************************************************
  * Transport routines
  ***********************************************************************/
@@ -167,14 +173,14 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT)) {
 		dev_dbg(rtsx_dev(chip), "-- command was aborted\n");
 		srb->result = DID_ABORT << 16;
-		goto Handle_Errors;
+		goto handle_errors;
 	}
 
 	/* if there is a transport error, reset and don't auto-sense */
 	if (result == TRANSPORT_ERROR) {
 		dev_dbg(rtsx_dev(chip), "-- transport indicates error, resetting\n");
 		srb->result = DID_ERROR << 16;
-		goto Handle_Errors;
+		goto handle_errors;
 	}
 
 	srb->result = SAM_STAT_GOOD;
@@ -188,7 +194,7 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* set the result so the higher layers expect this data */
 		srb->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(srb->sense_buffer,
-			(unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       (unsigned char *)&chip->sense_buffer[SCSI_LUN(srb)],
 			sizeof(struct sense_data_t));
 	}
 
@@ -196,13 +202,14 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	/* Error and abort processing: try to resynchronize with the device
 	 * by issuing a port reset.  If that fails, try a class-specific
-	 * device reset. */
-Handle_Errors:
+	 * device reset.
+	 */
+handle_errors:
 	return;
 }
 
 void rtsx_add_cmd(struct rtsx_chip *chip,
-		u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
+		  u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
 {
 	u32 *cb = (u32 *)(chip->host_cmds_ptr);
 	u32 val = 0;
@@ -321,9 +328,11 @@ static inline void rtsx_add_sg_tbl(
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
@@ -334,7 +343,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	struct scatterlist *sg_ptr;
 	u32 val = TRIG_DMA;
 
-	if ((sg == NULL) || (num_sg <= 0) || !offset || !index)
+	if ((!sg) || (num_sg <= 0) || !offset || !index)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -363,7 +372,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	sg_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	sg_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	resid = size;
 	sg_ptr = sg;
@@ -476,7 +485,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -485,7 +494,7 @@ out:
 }
 
 static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
-		struct scatterlist *sg, int num_sg,
+				     struct scatterlist *sg, int num_sg,
 		enum dma_data_direction dma_dir, int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
@@ -496,7 +505,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	long timeleft;
 	struct scatterlist *sg_ptr;
 
-	if ((sg == NULL) || (num_sg <= 0))
+	if ((!sg) || (num_sg <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -525,7 +534,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	buf_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	buf_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	sg_ptr = sg;
 
@@ -623,7 +632,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -632,7 +641,8 @@ out:
 }
 
 static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
-		size_t len, enum dma_data_direction dma_dir, int timeout)
+			     size_t len, enum dma_data_direction dma_dir,
+			     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -642,7 +652,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	u32 val = 1 << 31;
 	long timeleft;
 
-	if ((buf == NULL) || (len <= 0))
+	if ((!buf) || (len <= 0))
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -652,7 +662,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	else
 		return -ENXIO;
 
-	addr = dma_map_single(&(rtsx->pci->dev), buf, len, dma_dir);
+	addr = dma_map_single(&rtsx->pci->dev, buf, len, dma_dir);
 	if (!addr)
 		return -ENOMEM;
 
@@ -706,7 +716,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_single(&(rtsx->pci->dev), addr, len, dma_dir);
+	dma_unmap_single(&rtsx->pci->dev, addr, len, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -715,9 +725,11 @@ out:
 }
 
 int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
-		void *buf, size_t len, int use_sg, unsigned int *index,
-		unsigned int *offset, enum dma_data_direction dma_dir,
-		int timeout)
+			       void *buf, size_t len, int use_sg,
+			       unsigned int *index,
+			       unsigned int *offset,
+			       enum dma_data_direction dma_dir,
+			       int timeout)
 {
 	int err = 0;
 
@@ -725,11 +737,15 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT))
 		return -EIO;
 
-	if (use_sg)
+	if (use_sg) {
+		struct scatterlist *sg = (struct scatterlist *)buf;
+
 		err = rtsx_transfer_sglist_adma_partial(chip, card,
-				(struct scatterlist *)buf, use_sg,
-				index, offset, (int)len, dma_dir, timeout);
-	else
+							sg,
+							use_sg,
+							index, offset, (int)len,
+							dma_dir, timeout);
+	} else
 		err = rtsx_transfer_buf(chip, card,
 					buf, len, dma_dir, timeout);
 	if (err < 0) {
@@ -744,7 +760,7 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 }
 
 int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
-		int use_sg, enum dma_data_direction dma_dir, int timeout)
+		       int use_sg, enum dma_data_direction dma_dir, int timeout)
 {
 	int err = 0;
 
@@ -756,8 +772,8 @@ int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
 
 	if (use_sg) {
 		err = rtsx_transfer_sglist_adma(chip, card,
-				(struct scatterlist *)buf,
-				use_sg, dma_dir, timeout);
+						(struct scatterlist *)buf,
+						use_sg, dma_dir, timeout);
 	} else {
 		err = rtsx_transfer_buf(chip, card, buf, len, dma_dir, timeout);
 	}
@@ -772,4 +788,3 @@ int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
 
 	return err;
 }
-
-- 
2.7.0

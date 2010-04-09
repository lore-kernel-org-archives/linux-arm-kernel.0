From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Apr 2010 08:57:42 +0200
Subject: [PATCH 1/5] drivers: mtd: onenand: add support for chips with 4KB page
	size
In-Reply-To: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
References: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270796266-8272-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch adds support for OneNAND chips that have 4KB page size.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mtd/onenand/onenand_base.c |   32 +++++++++++++++++++-------------
 include/linux/mtd/onenand.h        |    4 ++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 32f0ed3..1b26f50 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -397,7 +397,8 @@ static int onenand_command(struct mtd_info *mtd, int cmd, loff_t addr, size_t le
 		value = onenand_bufferram_address(this, block);
 		this->write_word(value, this->base + ONENAND_REG_START_ADDRESS2);
 
-		if (ONENAND_IS_MLC(this) || ONENAND_IS_2PLANE(this))
+		if (ONENAND_IS_MLC(this) || ONENAND_IS_2PLANE(this) ||
+		    ONENAND_IS_4KB_PAGE(this))
 			/* It is always BufferRAM0 */
 			ONENAND_SET_BUFFERRAM0(this);
 		else
@@ -426,7 +427,7 @@ static int onenand_command(struct mtd_info *mtd, int cmd, loff_t addr, size_t le
 		case FLEXONENAND_CMD_RECOVER_LSB:
 		case ONENAND_CMD_READ:
 		case ONENAND_CMD_READOOB:
-			if (ONENAND_IS_MLC(this))
+			if (ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this))
 				/* It is always BufferRAM0 */
 				dataram = ONENAND_SET_BUFFERRAM0(this);
 			else
@@ -466,11 +467,11 @@ static inline int onenand_read_ecc(struct onenand_chip *this)
 {
 	int ecc, i, result = 0;
 
-	if (!FLEXONENAND(this))
+	if (!FLEXONENAND(this) && !ONENAND_IS_4KB_PAGE(this))
 		return this->read_word(this->base + ONENAND_REG_ECC_STATUS);
 
 	for (i = 0; i < 4; i++) {
-		ecc = this->read_word(this->base + ONENAND_REG_ECC_STATUS + i);
+		ecc = this->read_word(this->base + ONENAND_REG_ECC_STATUS + i*2);
 		if (likely(!ecc))
 			continue;
 		if (ecc & FLEXONENAND_UNCORRECTABLE_ERROR)
@@ -1425,7 +1426,7 @@ static int onenand_read(struct mtd_info *mtd, loff_t from, size_t len,
 	int ret;
 
 	onenand_get_device(mtd, FL_READING);
-	ret = ONENAND_IS_MLC(this) ?
+	ret = ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this) ?
 		onenand_mlc_read_ops_nolock(mtd, from, &ops) :
 		onenand_read_ops_nolock(mtd, from, &ops);
 	onenand_release_device(mtd);
@@ -1460,7 +1461,7 @@ static int onenand_read_oob(struct mtd_info *mtd, loff_t from,
 
 	onenand_get_device(mtd, FL_READING);
 	if (ops->datbuf)
-		ret = ONENAND_IS_MLC(this) ?
+		ret = ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this) ?
 			onenand_mlc_read_ops_nolock(mtd, from, ops) :
 			onenand_read_ops_nolock(mtd, from, ops);
 	else
@@ -1926,7 +1927,7 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 		 * 2 PLANE, MLC, and Flex-OneNAND do not support
 		 * write-while-program feature.
 		 */
-		if (!ONENAND_IS_2PLANE(this) && !first) {
+		if (!ONENAND_IS_2PLANE(this) && !ONENAND_IS_4KB_PAGE(this) && !first) {
 			ONENAND_SET_PREV_BUFFERRAM(this);
 
 			ret = this->wait(mtd, FL_WRITING);
@@ -1957,7 +1958,7 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 		/*
 		 * 2 PLANE, MLC, and Flex-OneNAND wait here
 		 */
-		if (ONENAND_IS_2PLANE(this)) {
+		if (ONENAND_IS_2PLANE(this) || ONENAND_IS_4KB_PAGE(this)) {
 			ret = this->wait(mtd, FL_WRITING);
 
 			/* In partial page write we don't update bufferram */
@@ -2084,7 +2085,7 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 			memcpy(oobbuf + column, buf, thislen);
 		this->write_bufferram(mtd, ONENAND_SPARERAM, oobbuf, 0, mtd->oobsize);
 
-		if (ONENAND_IS_MLC(this)) {
+		if (ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this)) {
 			/* Set main area of DataRAM to 0xff*/
 			memset(this->page_buf, 0xff, mtd->writesize);
 			this->write_bufferram(mtd, ONENAND_DATARAM,
@@ -3027,7 +3028,7 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 	this->command(mtd, ONENAND_CMD_OTP_ACCESS, 0, 0);
 	this->wait(mtd, FL_OTPING);
 
-	ret = ONENAND_IS_MLC(this) ?
+	ret = ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this) ?
 		onenand_mlc_read_ops_nolock(mtd, from, &ops) :
 		onenand_read_ops_nolock(mtd, from, &ops);
 
@@ -3372,7 +3373,10 @@ static void onenand_check_features(struct mtd_info *mtd)
 	/* Lock scheme */
 	switch (density) {
 	case ONENAND_DEVICE_DENSITY_4Gb:
-		this->options |= ONENAND_HAS_2PLANE;
+		if (ONENAND_IS_DDP(this))
+			this->options |= ONENAND_HAS_2PLANE;
+		else
+			this->options |= ONENAND_HAS_4KB_PAGE;
 
 	case ONENAND_DEVICE_DENSITY_2Gb:
 		/* 2Gb DDP does not have 2 plane */
@@ -3393,7 +3397,7 @@ static void onenand_check_features(struct mtd_info *mtd)
 		break;
 	}
 
-	if (ONENAND_IS_MLC(this))
+	if (ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this))
 		this->options &= ~ONENAND_HAS_2PLANE;
 
 	if (FLEXONENAND(this)) {
@@ -3407,6 +3411,8 @@ static void onenand_check_features(struct mtd_info *mtd)
 		printk(KERN_DEBUG "Chip support all block unlock\n");
 	if (this->options & ONENAND_HAS_2PLANE)
 		printk(KERN_DEBUG "Chip has 2 plane\n");
+	if (this->options & ONENAND_HAS_4KB_PAGE)
+		printk(KERN_DEBUG "Chip has 4KiB pagesize\n");
 }
 
 /**
@@ -3799,7 +3805,7 @@ static int onenand_probe(struct mtd_info *mtd)
 	/* The data buffer size is equal to page size */
 	mtd->writesize = this->read_word(this->base + ONENAND_REG_DATA_BUFFER_SIZE);
 	/* We use the full BufferRAM */
-	if (ONENAND_IS_MLC(this))
+	if (ONENAND_IS_MLC(this) || ONENAND_IS_4KB_PAGE(this))
 		mtd->writesize <<= 1;
 
 	mtd->oobsize = mtd->writesize >> 5;
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 5509eb0..c9a3c35 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -175,10 +175,14 @@ struct onenand_chip {
 #define ONENAND_HAS_CONT_LOCK		(0x0001)
 #define ONENAND_HAS_UNLOCK_ALL		(0x0002)
 #define ONENAND_HAS_2PLANE		(0x0004)
+#define ONENAND_HAS_4KB_PAGE		(0x0008)
 #define ONENAND_SKIP_UNLOCK_CHECK	(0x0100)
 #define ONENAND_PAGEBUF_ALLOC		(0x1000)
 #define ONENAND_OOBBUF_ALLOC		(0x2000)
 
+#define ONENAND_IS_4KB_PAGE(this)					\
+	(this->options & ONENAND_HAS_4KB_PAGE)
+
 /*
  * OneNAND Flash Manufacturer ID Codes
  */
-- 
1.6.4

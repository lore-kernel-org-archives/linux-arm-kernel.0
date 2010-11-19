From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Nov 2010 22:12:01 +0100
Subject: [PATCH 2/4] mtd: FSMC NAND replace all use of uintNN_t with uN
Message-ID: <1290201121-15263-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The short kernel versions of the basic types makes the world more
readable.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mtd/nand/fsmc_nand.c |   84 +++++++++++++++++++++---------------------
 include/linux/mtd/fsmc.h     |   50 ++++++++++++------------
 2 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 5af4b3c..7405bf5 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -220,7 +220,7 @@ struct fsmc_nand_data {
 	void __iomem		*addr_va;
 	void __iomem		*regs_va;
 
-	void			(*select_chip)(uint32_t bank, uint32_t busw);
+	void			(*select_chip)(u32 bank, u32 busw);
 };
 
 /* Assert CS signal based on chipnr */
@@ -294,10 +294,10 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
  * This routine initializes timing parameters related to NAND memory access in
  * FSMC registers
  */
-static void __init fsmc_nand_setup(struct fsmc_regs *regs, uint32_t bank,
-				   uint32_t busw)
+static void __init fsmc_nand_setup(struct fsmc_regs *regs, u32 bank,
+				   u32 busw)
 {
-	uint32_t value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
+	u32 value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
 
 	if (busw)
 		writel(value | FSMC_DEVWID_16, &regs->bank_regs[bank].pc);
@@ -320,7 +320,7 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
 	struct fsmc_regs *regs = host->regs_va;
-	uint32_t bank = host->bank;
+	u32 bank = host->bank;
 
 	writel(readl(&regs->bank_regs[bank].pc) & ~FSMC_ECCPLEN_256,
 		       &regs->bank_regs[bank].pc);
@@ -335,14 +335,14 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
  * FSMC. ECC is 13 bytes for 512 bytes of data (supports error correction upto
  * max of 8-bits)
  */
-static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
-				uint8_t *ecc)
+static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const u8 *data,
+				u8 *ecc)
 {
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
 	struct fsmc_regs *regs = host->regs_va;
-	uint32_t bank = host->bank;
-	uint32_t ecc_tmp;
+	u32 bank = host->bank;
+	u32 ecc_tmp;
 	unsigned long deadline = jiffies + FSMC_BUSY_WAIT_TIMEOUT;
 
 	do {
@@ -353,25 +353,25 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 	} while (!time_after_eq(jiffies, deadline));
 
 	ecc_tmp = readl(&regs->bank_regs[bank].ecc1);
-	ecc[0] = (uint8_t) (ecc_tmp >> 0);
-	ecc[1] = (uint8_t) (ecc_tmp >> 8);
-	ecc[2] = (uint8_t) (ecc_tmp >> 16);
-	ecc[3] = (uint8_t) (ecc_tmp >> 24);
+	ecc[0] = (u8) (ecc_tmp >> 0);
+	ecc[1] = (u8) (ecc_tmp >> 8);
+	ecc[2] = (u8) (ecc_tmp >> 16);
+	ecc[3] = (u8) (ecc_tmp >> 24);
 
 	ecc_tmp = readl(&regs->bank_regs[bank].ecc2);
-	ecc[4] = (uint8_t) (ecc_tmp >> 0);
-	ecc[5] = (uint8_t) (ecc_tmp >> 8);
-	ecc[6] = (uint8_t) (ecc_tmp >> 16);
-	ecc[7] = (uint8_t) (ecc_tmp >> 24);
+	ecc[4] = (u8) (ecc_tmp >> 0);
+	ecc[5] = (u8) (ecc_tmp >> 8);
+	ecc[6] = (u8) (ecc_tmp >> 16);
+	ecc[7] = (u8) (ecc_tmp >> 24);
 
 	ecc_tmp = readl(&regs->bank_regs[bank].ecc3);
-	ecc[8] = (uint8_t) (ecc_tmp >> 0);
-	ecc[9] = (uint8_t) (ecc_tmp >> 8);
-	ecc[10] = (uint8_t) (ecc_tmp >> 16);
-	ecc[11] = (uint8_t) (ecc_tmp >> 24);
+	ecc[8] = (u8) (ecc_tmp >> 0);
+	ecc[9] = (u8) (ecc_tmp >> 8);
+	ecc[10] = (u8) (ecc_tmp >> 16);
+	ecc[11] = (u8) (ecc_tmp >> 24);
 
 	ecc_tmp = readl(&regs->bank_regs[bank].sts);
-	ecc[12] = (uint8_t) (ecc_tmp >> 16);
+	ecc[12] = (u8) (ecc_tmp >> 16);
 
 	return 0;
 }
@@ -381,19 +381,19 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
  * FSMC. ECC is 3 bytes for 512 bytes of data (supports error correction upto
  * max of 1-bit)
  */
-static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
-				uint8_t *ecc)
+static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const u8 *data,
+				u8 *ecc)
 {
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
 	struct fsmc_regs *regs = host->regs_va;
-	uint32_t bank = host->bank;
-	uint32_t ecc_tmp;
+	u32 bank = host->bank;
+	u32 ecc_tmp;
 
 	ecc_tmp = readl(&regs->bank_regs[bank].ecc1);
-	ecc[0] = (uint8_t) (ecc_tmp >> 0);
-	ecc[1] = (uint8_t) (ecc_tmp >> 8);
-	ecc[2] = (uint8_t) (ecc_tmp >> 16);
+	ecc[0] = (u8) (ecc_tmp >> 0);
+	ecc[1] = (u8) (ecc_tmp >> 8);
+	ecc[2] = (u8) (ecc_tmp >> 16);
 
 	return 0;
 }
@@ -412,7 +412,7 @@ static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
  * max of 8 bits)
  */
 static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				 uint8_t *buf, int page)
+				 u8 *buf, int page)
 {
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
@@ -420,17 +420,17 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int i, j, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
-	uint8_t *p = buf;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->buffers->ecccalc;
+	u8 *ecc_code = chip->buffers->ecccode;
 	int off, len, group = 0;
 	/*
-	 * ecc_oob is intentionally taken as uint16_t. In 16bit devices, we
+	 * ecc_oob is intentionally taken as u16. In 16bit devices, we
 	 * end up reading 14 bytes (7 words) from oob. The local array is
 	 * to maintain word alignment
 	 */
-	uint16_t ecc_oob[7];
-	uint8_t *oob = (uint8_t *)&ecc_oob[0];
+	u16 ecc_oob[7];
+	u8 *oob = (u8 *)&ecc_oob[0];
 
 	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, p += eccsize) {
 
@@ -477,16 +477,16 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * calc_ecc is a 104 bit information containing maximum of 8 error
  * offset informations of 13 bits each in 512 bytes of read data.
  */
-static int fsmc_correct_data(struct mtd_info *mtd, uint8_t *dat,
-			     uint8_t *read_ecc, uint8_t *calc_ecc)
+static int fsmc_correct_data(struct mtd_info *mtd, u8 *dat,
+			     u8 *read_ecc, u8 *calc_ecc)
 {
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
 	struct fsmc_regs *regs = host->regs_va;
 	unsigned int bank = host->bank;
-	uint16_t err_idx[8];
-	uint64_t ecc_data[2];
-	uint32_t num_err, i;
+	u16 err_idx[8];
+	u64 ecc_data[2];
+	u32 num_err, i;
 
 	/* The calculated ecc is actually the correction index in data */
 	memcpy(ecc_data, calc_ecc, 13);
@@ -497,7 +497,7 @@ static int fsmc_correct_data(struct mtd_info *mtd, uint8_t *dat,
 	 *
 	 * calc_ecc is a 104 bit information containing maximum of 8 error
 	 * offset informations of 13 bits each. calc_ecc is copied into a
-	 * uint64_t array and error offset indexes are populated in err_idx
+	 * u64 array and error offset indexes are populated in err_idx
 	 * array
 	 */
 	for (i = 0; i < 8; i++) {
diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index 5d25567..ed14564 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -45,8 +45,8 @@
 #define FSMC_FLASH_WIDTH16	2
 
 struct fsmc_nor_bank_regs {
-	uint32_t ctrl;
-	uint32_t ctrl_tim;
+	u32 ctrl;
+	u32 ctrl_tim;
 };
 
 /* ctrl register definitions */
@@ -63,31 +63,31 @@ struct fsmc_nor_bank_regs {
 /* ctrl_tim register definitions */
 
 struct fsms_nand_bank_regs {
-	uint32_t pc;
-	uint32_t sts;
-	uint32_t comm;
-	uint32_t attrib;
-	uint32_t ioata;
-	uint32_t ecc1;
-	uint32_t ecc2;
-	uint32_t ecc3;
+	u32 pc;
+	u32 sts;
+	u32 comm;
+	u32 attrib;
+	u32 ioata;
+	u32 ecc1;
+	u32 ecc2;
+	u32 ecc3;
 };
 
 #define FSMC_NOR_REG_SIZE	0x40
 
 struct fsmc_regs {
 	struct fsmc_nor_bank_regs nor_bank_regs[FSMC_MAX_NOR_BANKS];
-	uint8_t reserved_1[0x40 - 0x20];
+	u8 reserved_1[0x40 - 0x20];
 	struct fsms_nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
-	uint8_t reserved_2[0xfe0 - 0xc0];
-	uint32_t peripid0;			/* 0xfe0 */
-	uint32_t peripid1;			/* 0xfe4 */
-	uint32_t peripid2;			/* 0xfe8 */
-	uint32_t peripid3;			/* 0xfec */
-	uint32_t pcellid0;			/* 0xff0 */
-	uint32_t pcellid1;			/* 0xff4 */
-	uint32_t pcellid2;			/* 0xff8 */
-	uint32_t pcellid3;			/* 0xffc */
+	u8 reserved_2[0xfe0 - 0xc0];
+	u32 peripid0;			/* 0xfe0 */
+	u32 peripid1;			/* 0xfe4 */
+	u32 peripid2;			/* 0xfe8 */
+	u32 peripid3;			/* 0xfec */
+	u32 pcellid0;			/* 0xff0 */
+	u32 pcellid1;			/* 0xff4 */
+	u32 pcellid2;			/* 0xff8 */
+	u32 pcellid3;			/* 0xffc */
 };
 
 #define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
@@ -127,7 +127,7 @@ struct fsmc_regs {
 #define FSMC_VER7		7
 #define FSMC_VER8		8
 
-static inline uint32_t get_fsmc_version(struct fsmc_regs *regs)
+static inline u32 get_fsmc_version(struct fsmc_regs *regs)
 {
 	return (readl(&regs->peripid2) >> FSMC_REVISION_SHFT) &
 				FSMC_REVISION_MSK;
@@ -143,8 +143,8 @@ static inline uint32_t get_fsmc_version(struct fsmc_regs *regs)
 #define MAX_ECCPLACE_ENTRIES	32
 
 struct fsmc_nand_eccplace {
-	uint8_t offset;
-	uint8_t length;
+	u8 offset;
+	u8 length;
 };
 
 struct fsmc_eccplace {
@@ -169,11 +169,11 @@ struct fsmc_nand_platform_data {
 	unsigned int		options;
 	unsigned int		width;
 	unsigned int		bank;
-	void			(*select_bank)(uint32_t bank, uint32_t busw);
+	void			(*select_bank)(u32 bank, u32 busw);
 };
 
 extern int __init fsmc_nor_init(struct platform_device *pdev,
-		unsigned long base, uint32_t bank, uint32_t width);
+		unsigned long base, u32 bank, u32 width);
 extern void __init fsmc_init_board_info(struct platform_device *pdev,
 		struct mtd_partition *partitions, unsigned int nr_partitions,
 		unsigned int width);
-- 
1.7.3.2

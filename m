From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:50 +0530
Subject: [PATCH 08/11] fsmc/nand: Use relaxed variants of io accessors
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <88484dbae96f7db42ce615552a4c758844a5e6cc.1349778821.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use relaxed variants of readl/writel accessors. readl/writel io accessors use
explicit dsb instruction which causes stalls in the processor core resulting
several cycles of delay for each access

Use relaxed variants where ever possible. This also results in an improved
read/write performance.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 54 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 8de6dcf..f48ee60 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -400,13 +400,13 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 			pc |= FSMC_ENABLE;
 		else
 			pc &= ~FSMC_ENABLE;
-		writel(pc, FSMC_NAND_REG(regs, bank, PC));
+		writel_relaxed(pc, FSMC_NAND_REG(regs, bank, PC));
 	}
 
 	mb();
 
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, this->IO_ADDR_W);
+		writeb_relaxed(cmd, this->IO_ADDR_W);
 }
 
 /*
@@ -433,14 +433,18 @@ static void fsmc_nand_setup(void __iomem *regs, uint32_t bank, uint32_t busw,
 	tset = (timings->tset & FSMC_TSET_MASK) << FSMC_TSET_SHIFT;
 
 	if (busw)
-		writel(value | FSMC_DEVWID_16, FSMC_NAND_REG(regs, bank, PC));
+		writel_relaxed(value | FSMC_DEVWID_16,
+				FSMC_NAND_REG(regs, bank, PC));
 	else
-		writel(value | FSMC_DEVWID_8, FSMC_NAND_REG(regs, bank, PC));
+		writel_relaxed(value | FSMC_DEVWID_8,
+				FSMC_NAND_REG(regs, bank, PC));
 
-	writel(readl(FSMC_NAND_REG(regs, bank, PC)) | tclr | tar,
+	writel_relaxed(readl(FSMC_NAND_REG(regs, bank, PC)) | tclr | tar,
 			FSMC_NAND_REG(regs, bank, PC));
-	writel(thiz | thold | twait | tset, FSMC_NAND_REG(regs, bank, COMM));
-	writel(thiz | thold | twait | tset, FSMC_NAND_REG(regs, bank, ATTRIB));
+	writel_relaxed(thiz | thold | twait | tset,
+			FSMC_NAND_REG(regs, bank, COMM));
+	writel_relaxed(thiz | thold | twait | tset,
+			FSMC_NAND_REG(regs, bank, ATTRIB));
 }
 
 /*
@@ -453,11 +457,11 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 
-	writel(readl(FSMC_NAND_REG(regs, bank, PC)) & ~FSMC_ECCPLEN_256,
+	writel_relaxed(readl(FSMC_NAND_REG(regs, bank, PC)) & ~FSMC_ECCPLEN_256,
 			FSMC_NAND_REG(regs, bank, PC));
-	writel(readl(FSMC_NAND_REG(regs, bank, PC)) & ~FSMC_ECCEN,
+	writel_relaxed(readl(FSMC_NAND_REG(regs, bank, PC)) & ~FSMC_ECCEN,
 			FSMC_NAND_REG(regs, bank, PC));
-	writel(readl(FSMC_NAND_REG(regs, bank, PC)) | FSMC_ECCEN,
+	writel_relaxed(readl(FSMC_NAND_REG(regs, bank, PC)) | FSMC_ECCEN,
 			FSMC_NAND_REG(regs, bank, PC));
 }
 
@@ -477,7 +481,7 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 	unsigned long deadline = jiffies + FSMC_BUSY_WAIT_TIMEOUT;
 
 	do {
-		if (readl(FSMC_NAND_REG(regs, bank, STS)) & FSMC_CODE_RDY)
+		if (readl_relaxed(FSMC_NAND_REG(regs, bank, STS)) & FSMC_CODE_RDY)
 			break;
 		else
 			cond_resched();
@@ -488,25 +492,25 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 		return -ETIMEDOUT;
 	}
 
-	ecc_tmp = readl(FSMC_NAND_REG(regs, bank, ECC1));
+	ecc_tmp = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC1));
 	ecc[0] = (uint8_t) (ecc_tmp >> 0);
 	ecc[1] = (uint8_t) (ecc_tmp >> 8);
 	ecc[2] = (uint8_t) (ecc_tmp >> 16);
 	ecc[3] = (uint8_t) (ecc_tmp >> 24);
 
-	ecc_tmp = readl(FSMC_NAND_REG(regs, bank, ECC2));
+	ecc_tmp = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC2));
 	ecc[4] = (uint8_t) (ecc_tmp >> 0);
 	ecc[5] = (uint8_t) (ecc_tmp >> 8);
 	ecc[6] = (uint8_t) (ecc_tmp >> 16);
 	ecc[7] = (uint8_t) (ecc_tmp >> 24);
 
-	ecc_tmp = readl(FSMC_NAND_REG(regs, bank, ECC3));
+	ecc_tmp = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC3));
 	ecc[8] = (uint8_t) (ecc_tmp >> 0);
 	ecc[9] = (uint8_t) (ecc_tmp >> 8);
 	ecc[10] = (uint8_t) (ecc_tmp >> 16);
 	ecc[11] = (uint8_t) (ecc_tmp >> 24);
 
-	ecc_tmp = readl(FSMC_NAND_REG(regs, bank, STS));
+	ecc_tmp = readl_relaxed(FSMC_NAND_REG(regs, bank, STS));
 	ecc[12] = (uint8_t) (ecc_tmp >> 16);
 
 	return 0;
@@ -526,7 +530,7 @@ static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
 	uint32_t bank = host->bank;
 	uint32_t ecc_tmp;
 
-	ecc_tmp = readl(FSMC_NAND_REG(regs, bank, ECC1));
+	ecc_tmp = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC1));
 	ecc[0] = (uint8_t) (ecc_tmp >> 0);
 	ecc[1] = (uint8_t) (ecc_tmp >> 8);
 	ecc[2] = (uint8_t) (ecc_tmp >> 16);
@@ -635,10 +639,10 @@ static void fsmc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 		uint32_t *p = (uint32_t *)buf;
 		len = len >> 2;
 		for (i = 0; i < len; i++)
-			writel(p[i], chip->IO_ADDR_W);
+			writel_relaxed(p[i], chip->IO_ADDR_W);
 	} else {
 		for (i = 0; i < len; i++)
-			writeb(buf[i], chip->IO_ADDR_W);
+			writeb_relaxed(buf[i], chip->IO_ADDR_W);
 	}
 }
 
@@ -658,10 +662,10 @@ static void fsmc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 		uint32_t *p = (uint32_t *)buf;
 		len = len >> 2;
 		for (i = 0; i < len; i++)
-			p[i] = readl(chip->IO_ADDR_R);
+			p[i] = readl_relaxed(chip->IO_ADDR_R);
 	} else {
 		for (i = 0; i < len; i++)
-			buf[i] = readb(chip->IO_ADDR_R);
+			buf[i] = readb_relaxed(chip->IO_ADDR_R);
 	}
 }
 
@@ -792,7 +796,7 @@ static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
 	uint32_t num_err, i;
 	uint32_t ecc1, ecc2, ecc3, ecc4;
 
-	num_err = (readl(FSMC_NAND_REG(regs, bank, STS)) >> 10) & 0xF;
+	num_err = (readl_relaxed(FSMC_NAND_REG(regs, bank, STS)) >> 10) & 0xF;
 
 	/* no bit flipping */
 	if (likely(num_err == 0))
@@ -835,10 +839,10 @@ static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
 	 * uint64_t array and error offset indexes are populated in err_idx
 	 * array
 	 */
-	ecc1 = readl(FSMC_NAND_REG(regs, bank, ECC1));
-	ecc2 = readl(FSMC_NAND_REG(regs, bank, ECC2));
-	ecc3 = readl(FSMC_NAND_REG(regs, bank, ECC3));
-	ecc4 = readl(FSMC_NAND_REG(regs, bank, STS));
+	ecc1 = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC1));
+	ecc2 = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC2));
+	ecc3 = readl_relaxed(FSMC_NAND_REG(regs, bank, ECC3));
+	ecc4 = readl_relaxed(FSMC_NAND_REG(regs, bank, STS));
 
 	err_idx[0] = (ecc1 >> 0) & 0x1FFF;
 	err_idx[1] = (ecc1 >> 13) & 0x1FFF;
-- 
1.7.11.4

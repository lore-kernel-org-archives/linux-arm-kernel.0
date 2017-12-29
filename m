From: vigneshr@ti.com (Vignesh R)
Date: Fri, 29 Dec 2017 14:41:02 +0530
Subject: [PATCH v2 1/2] mtd: spi-nor: cadence-quadspi: Refactor indirect
 read/write sequence.
In-Reply-To: <20171229091103.14436-1-vigneshr@ti.com>
References: <20171229091103.14436-1-vigneshr@ti.com>
Message-ID: <20171229091103.14436-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move configuring of indirect read/write start address to
cqspi_indirect_*_execute() function and rename cqspi_indirect_*_setup()
function. This will help to reuse cqspi_indirect_*_setup() function for
supporting direct access mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: No changes.

 drivers/mtd/spi-nor/cadence-quadspi.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 75a2bc447a99..becc7d714ab8 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -450,8 +450,7 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
 	return cqspi_exec_flash_cmd(cqspi, reg);
 }
 
-static int cqspi_indirect_read_setup(struct spi_nor *nor,
-				     const unsigned int from_addr)
+static int cqspi_read_setup(struct spi_nor *nor)
 {
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
@@ -459,7 +458,6 @@ static int cqspi_indirect_read_setup(struct spi_nor *nor,
 	unsigned int dummy_clk = 0;
 	unsigned int reg;
 
-	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 
 	reg = nor->read_opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
 	reg |= cqspi_calc_rdreg(nor, nor->read_opcode);
@@ -493,8 +491,8 @@ static int cqspi_indirect_read_setup(struct spi_nor *nor,
 	return 0;
 }
 
-static int cqspi_indirect_read_execute(struct spi_nor *nor,
-				       u8 *rxbuf, const unsigned n_rx)
+static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
+				       loff_t from_addr, const size_t n_rx)
 {
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
@@ -504,6 +502,7 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor,
 	unsigned int bytes_to_read = 0;
 	int ret = 0;
 
+	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
 	/* Clear all interrupts. */
@@ -570,8 +569,7 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor,
 	return ret;
 }
 
-static int cqspi_indirect_write_setup(struct spi_nor *nor,
-				      const unsigned int to_addr)
+static int cqspi_write_setup(struct spi_nor *nor)
 {
 	unsigned int reg;
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
@@ -584,8 +582,6 @@ static int cqspi_indirect_write_setup(struct spi_nor *nor,
 	reg = cqspi_calc_rdreg(nor, nor->program_opcode);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
-	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
-
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
@@ -593,8 +589,8 @@ static int cqspi_indirect_write_setup(struct spi_nor *nor,
 	return 0;
 }
 
-static int cqspi_indirect_write_execute(struct spi_nor *nor,
-					const u8 *txbuf, const unsigned n_tx)
+static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
+					const u8 *txbuf, const size_t n_tx)
 {
 	const unsigned int page_size = nor->page_size;
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
@@ -604,6 +600,7 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor,
 	unsigned int write_bytes;
 	int ret;
 
+	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
 	/* Clear all interrupts. */
@@ -900,11 +897,11 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_write_setup(nor, to);
+	ret = cqspi_write_setup(nor);
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_write_execute(nor, buf, len);
+	ret = cqspi_indirect_write_execute(nor, to, buf, len);
 	if (ret)
 		return ret;
 
@@ -920,11 +917,11 @@ static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_read_setup(nor, from);
+	ret = cqspi_read_setup(nor);
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_read_execute(nor, buf, len);
+	ret = cqspi_indirect_read_execute(nor, buf, from, len);
 	if (ret)
 		return ret;
 
-- 
2.15.1

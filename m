From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 30 Nov 2017 18:01:32 +0100
Subject: [PATCH 5/5] mtd: nand: add ->exec_op() implementation
In-Reply-To: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
Message-ID: <20171130170132.27522-6-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new interface to instruct NAND controllers to send specific
NAND operations. The new interface takes the form of a single method
called ->exec_op(). This method is designed to replace ->cmd_ctrl(),
->cmdfunc() and ->read/write_byte/word/buf() hooks.

->exec_op() is passed a set of instructions describing the operation
to execute. Each instruction has a type (ADDR, CMD, DATA, WAITRDY)
and delay. The type is directly matching the description of NAND
operations in various NAND datasheet and standards (ONFI, JEDEC), the
delay is here to help simple controllers wait enough time between each
instruction. Advanced controllers with integrated timings control can
ignore these delays.

Advanced controllers (that are not limited to independent ADDR, CMD and
DATA cycles) may use the parser added by this commit to get the best
matching hook, if any. The instructions may be split by the parser in
order to comply with the controller constraints filled in an array of
supported patterns.

For instance, if a controller driver declares supporting up to 4 address
cycles and then writes up to 512 bytes within one pattern (both are
optional in this pattern):
        NAND_OP_PARSER_PAT_ADDR_ELEM(true, 4)
        NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, 512)
It means that if the matching operation is made of 5 address cycles
followed by 1024 bytes to write, then the controller will be asked to:
        - send 4 address cycles (the first four cycles),
        - send 1 address cycle (the last one) +
          write 512 bytes (the first half),
        - write 512 bytes again (the second half).

Various other helpers are also added to ease NAND controller drivers
writing.

This new interface should really ease the support of new vendor specific
operations, and at least report whether the command is supported or not
by a given controller, which was not possible before.

Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c  | 1037 +++++++++++++++++++++++++++++++++++++++--
 drivers/mtd/nand/nand_hynix.c |    9 +
 include/linux/mtd/rawnand.h   |  391 +++++++++++++++-
 3 files changed, 1397 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 52965a8aeb2c..46bf31aff909 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -689,6 +689,59 @@ static void nand_wait_status_ready(struct mtd_info *mtd, unsigned long timeo)
 };
 
 /**
+ * nand_soft_waitrdy - Read the status waiting for it to be ready
+ * @chip: NAND chip structure
+ * @timeout_ms: Timeout in ms
+ *
+ * Poll the status using ->exec_op() until it is ready unless it takes too
+ * much time.
+ *
+ * This helper is intended to be used by drivers without R/B pin available to
+ * poll for the chip status until ready and may be called at any time in the
+ * middle of any set of instruction. The READ_STATUS just need to ask a single
+ * time for it and then any read will return the status. Once the READ_STATUS
+ * cycles are done, the function will send a READ0 command to cancel the
+ * "READ_STATUS state" and let the normal flow of operation to continue.
+ *
+ * This helper *cannot* send a WAITRDY command or ->exec_op() implementations
+ * using it will enter an infinite loop.
+ *
+ * Return 0 if the NAND chip is ready, a negative error otherwise.
+ */
+int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
+{
+	u8 status = 0;
+	int ret;
+
+	if (!chip->exec_op)
+		return -ENOTSUPP;
+
+	ret = nand_status_op(chip, NULL);
+	if (ret)
+		return ret;
+
+	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		ret = nand_read_data_op(chip, &status, sizeof(status), true);
+		if (ret)
+			break;
+
+		if (status & NAND_STATUS_READY)
+			break;
+
+		udelay(100);
+	} while	(time_before(jiffies, timeout_ms));
+
+	nand_exit_status_op(chip);
+
+	if (ret)
+		return ret;
+
+	return status & NAND_STATUS_READY ? 0 : -ETIMEDOUT;
+};
+EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
+
+/**
  * nand_command - [DEFAULT] Send command to NAND device
  * @mtd: MTD device structure
  * @command: the command to be sent
@@ -1238,6 +1291,134 @@ static int nand_init_data_interface(struct nand_chip *chip)
 }
 
 /**
+ * nand_fill_column_cycles - fill the column fields on an address array
+ * @chip: The NAND chip
+ * @addrs: Array of address cycles to fill
+ * @offset_in_page: The offset in the page
+ *
+ * Fills the first or the two first bytes of the @addrs field depending
+ * on the NAND bus width and the page size.
+ */
+static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
+				   unsigned int offset_in_page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	/* Make sure the offset is less than the actual page size. */
+	if (offset_in_page > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	/*
+	 * On small page NANDs, there's a dedicated command to access the OOB
+	 * area, and the column address is relative to the start of the OOB
+	 * area, not the start of the page. Asjust the address accordingly.
+	 */
+	if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
+		offset_in_page -= mtd->writesize;
+
+	/*
+	 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
+	 * wide, then it must be divided by 2.
+	 */
+	if (chip->options & NAND_BUSWIDTH_16) {
+		if (WARN_ON(offset_in_page % 2))
+			return -EINVAL;
+
+		offset_in_page /= 2;
+	}
+
+	addrs[0] = offset_in_page;
+
+	/* Small pages use 1 cycle for the columns, while large page need 2 */
+	if (mtd->writesize <= 512)
+		return 1;
+
+	addrs[1] = offset_in_page >> 8;
+
+	return 2;
+}
+
+static int nand_sp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
+				     unsigned int offset_in_page, void *buf,
+				     unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_sdr_timings *sdr =
+		nand_get_sdr_timings(&chip->data_interface);
+	u8 addrs[4];
+	struct nand_op_instr instrs[] = {
+		NAND_OP_CMD(NAND_CMD_READ0, 0),
+		NAND_OP_ADDR(3, addrs, PSEC_TO_NSEC(sdr->tWB_max)),
+		NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tR_max),
+				 PSEC_TO_NSEC(sdr->tRR_min)),
+		NAND_OP_DATA_IN(len, buf, 0),
+	};
+	struct nand_operation op = NAND_OPERATION(instrs);
+	int ret;
+
+	/* Drop the DATA_OUT instruction if len is set to 0. */
+	if (!len)
+		op.ninstrs--;
+
+	if (offset_in_page >= mtd->writesize)
+		instrs[0].ctx.cmd.opcode = NAND_CMD_READOOB;
+	else if (offset_in_page >= 256 &&
+		 !(chip->options & NAND_BUSWIDTH_16))
+		instrs[0].ctx.cmd.opcode = NAND_CMD_READ1;
+
+	ret = nand_fill_column_cycles(chip, addrs, offset_in_page);
+	if (ret < 0)
+		return ret;
+
+	addrs[1] = page;
+	addrs[2] = page >> 8;
+
+	if (chip->options & NAND_ROW_ADDR_3) {
+		addrs[3] = page >> 16;
+		instrs[1].ctx.addr.naddrs++;
+	}
+
+	return nand_exec_op(chip, &op);
+}
+
+static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
+				     unsigned int offset_in_page, void *buf,
+				     unsigned int len)
+{
+	const struct nand_sdr_timings *sdr =
+		nand_get_sdr_timings(&chip->data_interface);
+	u8 addrs[5];
+	struct nand_op_instr instrs[] = {
+		NAND_OP_CMD(NAND_CMD_READ0, 0),
+		NAND_OP_ADDR(4, addrs, 0),
+		NAND_OP_CMD(NAND_CMD_READSTART, PSEC_TO_NSEC(sdr->tWB_max)),
+		NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tR_max),
+				 PSEC_TO_NSEC(sdr->tRR_min)),
+		NAND_OP_DATA_IN(len, buf, 0),
+	};
+	struct nand_operation op = NAND_OPERATION(instrs);
+	int ret;
+
+	/* Drop the DATA_IN instruction if len is set to 0. */
+	if (!len)
+		op.ninstrs--;
+
+	ret = nand_fill_column_cycles(chip, addrs, offset_in_page);
+	if (ret < 0)
+		return ret;
+
+	addrs[2] = page;
+	addrs[3] = page >> 8;
+
+	if (chip->options & NAND_ROW_ADDR_3) {
+		addrs[4] = page >> 16;
+		instrs[1].ctx.addr.naddrs++;
+	}
+
+	return nand_exec_op(chip, &op);
+}
+
+/**
  * nand_read_page_op - Do a READ PAGE operation
  * @chip: The NAND chip
  * @page: page to read
@@ -1261,6 +1442,16 @@ int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
 		return -EINVAL;
 
+	if (chip->exec_op) {
+		if (mtd->writesize > 512)
+			return nand_lp_exec_read_page_op(chip, page,
+							 offset_in_page, buf,
+							 len);
+
+		return nand_sp_exec_read_page_op(chip, page, offset_in_page,
+						 buf, len);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_READ0, offset_in_page, page);
 	if (len)
 		chip->read_buf(mtd, buf, len);
@@ -1291,6 +1482,25 @@ static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 	if (len && !buf)
 		return -EINVAL;
 
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_PARAM, 0),
+			NAND_OP_ADDR(1, &page, PSEC_TO_NSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tR_max),
+					 PSEC_TO_NSEC(sdr->tRR_min)),
+			NAND_OP_8BIT_DATA_IN(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		/* Drop the DATA_IN instruction if len is set to 0. */
+		if (!len)
+			op.ninstrs--;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_PARAM, page, -1);
 	for (i = 0; i < len; i++)
 		p[i] = chip->read_byte(mtd);
@@ -1323,6 +1533,37 @@ int nand_change_read_column_op(struct nand_chip *chip,
 	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
 		return -EINVAL;
 
+	/* Small page NANDs do not support column change. */
+	if (mtd->writesize <= 512)
+		return -ENOTSUPP;
+
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		u8 addrs[2] = {};
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_RNDOUT, 0),
+			NAND_OP_ADDR(2, addrs, 0),
+			NAND_OP_CMD(NAND_CMD_RNDOUTSTART,
+				    PSEC_TO_NSEC(sdr->tCCS_min)),
+			NAND_OP_DATA_IN(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+		int ret;
+
+		ret = nand_fill_column_cycles(chip, addrs, offset_in_page);
+		if (ret < 0)
+			return ret;
+
+		/* Drop the DATA_IN instruction if len is set to 0. */
+		if (!len)
+			op.ninstrs--;
+
+		instrs[3].ctx.data.force_8bit = force_8bit;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset_in_page, -1);
 	if (len)
 		chip->read_buf(mtd, buf, len);
@@ -1355,6 +1596,11 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 	if (offset_in_oob + len > mtd->oobsize)
 		return -EINVAL;
 
+	if (chip->exec_op)
+		return nand_read_page_op(chip, page,
+					 mtd->writesize + offset_in_oob,
+					 buf, len);
+
 	chip->cmdfunc(mtd, NAND_CMD_READOOB, offset_in_oob, page);
 	if (len)
 		chip->read_buf(mtd, buf, len);
@@ -1363,6 +1609,81 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 }
 EXPORT_SYMBOL_GPL(nand_read_oob_op);
 
+static int nand_exec_prog_page_op(struct nand_chip *chip, unsigned int page,
+				  unsigned int offset_in_page, const void *buf,
+				  unsigned int len, bool prog)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_sdr_timings *sdr =
+		nand_get_sdr_timings(&chip->data_interface);
+	u8 addrs[5] = {};
+	struct nand_op_instr instrs[] = {
+		/*
+		 * The first instruction will be dropped if we're dealing
+		 * with a large page NAND and adjusted if we're dealing
+		 * with a small page NAND and the page offset is > 255.
+		 */
+		NAND_OP_CMD(NAND_CMD_READ0, 0),
+		NAND_OP_CMD(NAND_CMD_SEQIN, 0),
+		NAND_OP_ADDR(0, addrs, PSEC_TO_NSEC(sdr->tADL_min)),
+		NAND_OP_DATA_OUT(len, buf, 0),
+		NAND_OP_CMD(NAND_CMD_PAGEPROG, PSEC_TO_NSEC(sdr->tWB_max)),
+		NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tPROG_max), 0),
+	};
+	struct nand_operation op = NAND_OPERATION(instrs);
+	int naddrs = nand_fill_column_cycles(chip, addrs, offset_in_page);
+	int ret;
+	u8 status;
+
+	if (naddrs < 0)
+		return naddrs;
+
+	addrs[naddrs++] = page;
+	addrs[naddrs++] = page >> 8;
+	if (chip->options & NAND_ROW_ADDR_3)
+		addrs[naddrs++] = page >> 16;
+
+	instrs[2].ctx.addr.naddrs = naddrs;
+
+	/* Drop the lasts instructions if we're not programming the page. */
+	if (!prog) {
+		op.ninstrs -= 2;
+		/* Also drop the DATA_OUT instruction if empty. */
+		if (!len)
+			op.ninstrs--;
+	}
+
+	if (mtd->writesize <= 512) {
+		/*
+		 * Small pages need some more tweaking: we have to adjust the
+		 * first instruction depending on the page offset we're trying
+		 * to access.
+		 */
+		if (offset_in_page >= mtd->writesize)
+			instrs[0].ctx.cmd.opcode = NAND_CMD_READOOB;
+		else if (offset_in_page >= 256 &&
+			 !(chip->options & NAND_BUSWIDTH_16))
+			instrs[0].ctx.cmd.opcode = NAND_CMD_READ1;
+	} else {
+		/*
+		 * Drop the first command if we're dealing with a large page
+		 * NAND.
+		 */
+		op.instrs++;
+		op.ninstrs--;
+	}
+
+	ret = nand_exec_op(chip, &op);
+	if (!prog || ret)
+		return ret;
+
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	return status;
+}
+
 /**
  * nand_prog_page_begin_op - starts a PROG PAGE operation
  * @chip: The NAND chip
@@ -1388,6 +1709,10 @@ int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
 	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
 		return -EINVAL;
 
+	if (chip->exec_op)
+		return nand_exec_prog_page_op(chip, page, offset_in_page, buf,
+					      len, false);
+
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
 
 	if (buf)
@@ -1409,11 +1734,35 @@ EXPORT_SYMBOL_GPL(nand_prog_page_begin_op);
 int nand_prog_page_end_op(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	int status;
+	int ret;
+	u8 status;
 
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_PAGEPROG,
+				    PSEC_TO_NSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tPROG_max), 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		ret = nand_exec_op(chip, &op);
+		if (ret)
+			return ret;
+
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			return ret;
+	} else {
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+		ret = chip->waitfunc(mtd, chip);
+		if (ret < 0)
+			return ret;
+
+		status = ret;
+	}
 
-	status = chip->waitfunc(mtd, chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
@@ -1447,11 +1796,16 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
 		return -EINVAL;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
-	chip->write_buf(mtd, buf, len);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+	if (chip->exec_op) {
+		status = nand_exec_prog_page_op(chip, page, offset_in_page, buf,
+						len, true);
+	} else {
+		chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
+		chip->write_buf(mtd, buf, len);
+		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+		status = chip->waitfunc(mtd, chip);
+	}
 
-	status = chip->waitfunc(mtd, chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
@@ -1485,6 +1839,35 @@ int nand_change_write_column_op(struct nand_chip *chip,
 	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
 		return -EINVAL;
 
+	/* Small page NANDs do not support column change. */
+	if (mtd->writesize <= 512)
+		return -ENOTSUPP;
+
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		u8 addrs[2];
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_RNDIN, 0),
+			NAND_OP_ADDR(2, addrs, PSEC_TO_NSEC(sdr->tCCS_min)),
+			NAND_OP_DATA_OUT(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+		int ret;
+
+		ret = nand_fill_column_cycles(chip, addrs, offset_in_page);
+		if (ret < 0)
+			return ret;
+
+		instrs[2].ctx.data.force_8bit = force_8bit;
+
+		/* Drop the DATA_OUT instruction if len is set to 0. */
+		if (!len)
+			op.ninstrs--;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset_in_page, -1);
 	if (len)
 		chip->write_buf(mtd, buf, len);
@@ -1506,8 +1889,8 @@ EXPORT_SYMBOL_GPL(nand_change_write_column_op);
  *
  * Returns 0 for success or negative error code otherwise
  */
-int nand_readid_op(struct nand_chip *chip, u8 addr,
-		   void *buf, unsigned int len)
+int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
+		   unsigned int len)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int i;
@@ -1516,6 +1899,23 @@ int nand_readid_op(struct nand_chip *chip, u8 addr,
 	if (!len || !buf)
 		return -EINVAL;
 
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_READID, 0),
+			NAND_OP_ADDR(1, &addr, PSEC_TO_NSEC(sdr->tADL_min)),
+			NAND_OP_8BIT_DATA_IN(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		/* Drop the DATA_IN instruction if len is set to 0. */
+		if (!len)
+			op.ninstrs--;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_READID, addr, -1);
 
 	for (i = 0; i < len; i++)
@@ -1540,6 +1940,22 @@ int nand_status_op(struct nand_chip *chip, u8 *status)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_STATUS,
+				    PSEC_TO_NSEC(sdr->tADL_min)),
+			NAND_OP_8BIT_DATA_IN(1, status, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		if (!status)
+			op.ninstrs--;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
 	if (status)
 		*status = chip->read_byte(mtd);
@@ -1563,6 +1979,15 @@ int nand_exit_status_op(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (chip->exec_op) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_READ0, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_READ0, -1, -1);
 
 	return 0;
@@ -1585,14 +2010,42 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int page = eraseblock <<
 			    (chip->phys_erase_shift - chip->page_shift);
-	int status;
+	int ret;
+	u8 status;
 
-	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
-	chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		u8 addrs[3] = {	page, page >> 8, page >> 16 };
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_ERASE1, 0),
+			NAND_OP_ADDR(2, addrs, 0),
+			NAND_OP_CMD(NAND_CMD_ERASE2,
+				    PSEC_TO_MSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tBERS_max), 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
 
-	status = chip->waitfunc(mtd, chip);
-	if (status < 0)
-		return status;
+		if (chip->options & NAND_ROW_ADDR_3)
+			instrs[1].ctx.addr.naddrs++;
+
+		ret = nand_exec_op(chip, &op);
+		if (ret)
+			return ret;
+
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			return ret;
+	} else {
+		chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+		chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+
+		ret = chip->waitfunc(mtd, chip);
+		if (ret < 0)
+			return ret;
+
+		status = ret;
+	}
 
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
@@ -1618,13 +2071,40 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const u8 *params = data;
-	int i, status;
+	int i, ret;
+	u8 status;
 
-	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
-	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(mtd, params[i]);
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_SET_FEATURES, 0),
+			NAND_OP_ADDR(1, &feature, PSEC_TO_NSEC(sdr->tADL_min)),
+			NAND_OP_8BIT_DATA_OUT(ONFI_SUBFEATURE_PARAM_LEN, data,
+					      PSEC_TO_NSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tFEAT_max), 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		ret = nand_exec_op(chip, &op);
+		if (ret)
+			return ret;
+
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			return ret;
+	} else {
+		chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
+		for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+			chip->write_byte(mtd, params[i]);
+
+		ret = chip->waitfunc(mtd, chip);
+		if (ret < 0)
+			return ret;
+
+		status = ret;
+	}
 
-	status = chip->waitfunc(mtd, chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
@@ -1650,6 +2130,22 @@ static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 	u8 *params = data;
 	int i;
 
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_GET_FEATURES, 0),
+			NAND_OP_ADDR(1, &feature, PSEC_TO_NSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tFEAT_max),
+					 PSEC_TO_NSEC(sdr->tRR_min)),
+			NAND_OP_8BIT_DATA_IN(ONFI_SUBFEATURE_PARAM_LEN,
+					     data, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		params[i] = chip->read_byte(mtd);
@@ -1671,6 +2167,18 @@ int nand_reset_op(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(NAND_CMD_RESET, PSEC_TO_NSEC(sdr->tWB_max)),
+			NAND_OP_WAIT_RDY(PSEC_TO_MSEC(sdr->tRST_max), 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
 
 	return 0;
@@ -1698,6 +2206,17 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 	if (!len || !buf)
 		return -EINVAL;
 
+	if (chip->exec_op) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_DATA_IN(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		instrs[0].ctx.data.force_8bit = force_8bit;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	if (force_8bit) {
 		u8 *p = buf;
 		unsigned int i;
@@ -1733,6 +2252,17 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
 	if (!len || !buf)
 		return -EINVAL;
 
+	if (chip->exec_op) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_DATA_OUT(len, buf, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		instrs[0].ctx.data.force_8bit = force_8bit;
+
+		return nand_exec_op(chip, &op);
+	}
+
 	if (force_8bit) {
 		const u8 *p = buf;
 		unsigned int i;
@@ -1748,6 +2278,451 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
 EXPORT_SYMBOL_GPL(nand_write_data_op);
 
 /**
+ * struct nand_op_parser_ctx - Context used by the parser
+ * @instrs: array of all the instructions that must be addressed
+ * @ninstrs: length of the @instrs array
+ * @instr_idx: index of the instruction in the @instrs array that matches the
+ *	       first instruction of the subop structure
+ * @instr_start_off: offset at which the first instruction of the subop
+ *		     structure must start if it is and address or a data
+ *		     instruction
+ *
+ * This structure is used by the core to handle splitting lengthy instructions
+ * into sub-operations.
+ */
+struct nand_op_parser_ctx {
+	const struct nand_op_instr *instrs;
+	unsigned int ninstrs;
+	unsigned int instr_idx;
+	unsigned int instr_start_off;
+	struct nand_subop subop;
+};
+
+/**
+ * nand_op_parser_must_split_instr - Checks if an instruction must be split
+ * @pat: the parser pattern that match
+ * @instr: the instruction array to check
+ * @start_offset: the offset from which to start in the first instruction of the
+ *		  @instr array
+ *
+ * Some NAND controllers are limited and cannot send X address cycles with a
+ * unique operation, or cannot read/write more than Y bytes at the same time.
+ * In this case, split the instruction that does not fit in a single
+ * controller-operation into two or more chunks.
+ *
+ * Returns true if the instruction must be split, false otherwise.
+ * The @start_offset parameter is also updated to the offset at which the next
+ * bundle of instruction must start (if an address or a data instruction).
+ */
+static bool
+nand_op_parser_must_split_instr(const struct nand_op_parser_pattern_elem *pat,
+				const struct nand_op_instr *instr,
+				unsigned int *start_offset)
+{
+	switch (pat->type) {
+	case NAND_OP_ADDR_INSTR:
+		if (!pat->addr.maxcycles)
+			break;
+
+		if (instr->ctx.addr.naddrs - *start_offset >
+		    pat->addr.maxcycles) {
+			*start_offset += pat->addr.maxcycles;
+			return true;
+		}
+		break;
+
+	case NAND_OP_DATA_IN_INSTR:
+	case NAND_OP_DATA_OUT_INSTR:
+		if (!pat->data.maxlen)
+			break;
+
+		if (instr->ctx.data.len - *start_offset > pat->data.maxlen) {
+			*start_offset += pat->data.maxlen;
+			return true;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/**
+ * nand_op_parser_match_pat - Checks a pattern
+ * @pat: the parser pattern to check if it matches
+ * @ctx: the context structure to match with the pattern @pat
+ *
+ * Check if *one* given pattern matches the given sequence of instructions
+ */
+static bool
+nand_op_parser_match_pat(const struct nand_op_parser_pattern *pat,
+			 struct nand_op_parser_ctx *ctx)
+{
+	unsigned int i, j, boundary_off = ctx->instr_start_off;
+
+	ctx->subop.ninstrs = 0;
+
+	for (i = ctx->instr_idx, j = 0; i < ctx->ninstrs && j < pat->nelems;) {
+		const struct nand_op_instr *instr = &ctx->instrs[i];
+
+		/*
+		 * The pattern instruction does not match the operation
+		 * instruction. If the instruction is marked optional in the
+		 * pattern definition, we skip the pattern element and continue
+		 * to the next one. If the element is mandatory, there's no
+		 * match and we can return false directly.
+		 */
+		if (instr->type != pat->elems[j].type) {
+			if (!pat->elems[j].optional)
+				return false;
+
+			j++;
+			continue;
+		}
+
+		/*
+		 * Now check the pattern element constraints. If the pattern is
+		 * not able to handle the whole instruction in a single step,
+		 * we'll have to break it down into several instructions.
+		 * The *boudary_off value comes back updated to point to the
+		 * limit between the split instruction (the end of the original
+		 * chunk, the start of new next one).
+		 */
+		if (nand_op_parser_must_split_instr(&pat->elems[j], instr,
+						    &boundary_off)) {
+			ctx->subop.ninstrs++;
+			j++;
+			break;
+		}
+
+		ctx->subop.ninstrs++;
+		i++;
+		j++;
+		boundary_off = 0;
+	}
+
+	/*
+	 * This can happen if all instructions of a pattern are optional.
+	 * Still, if there's not at least one instruction handled by this
+	 * pattern, this is not a match, and we should try the next one (if
+	 * any).
+	 */
+	if (!ctx->subop.ninstrs)
+		return false;
+
+	/*
+	 * We had a match on the pattern head, but the pattern may be longer
+	 * than the instructions we're asked to execute. We need to make sure
+	 * there's no mandatory elements in the pattern tail.
+	 *
+	 * The case where all the operations of a pattern have been checked but
+	 * the number of instructions is bigger is handled right after this by
+	 * returning true on the pattern match, which will order the execution
+	 * of the subset of instructions later defined, while updating the
+	 * context ids to the next chunk of instructions.
+	 */
+	for (; j < pat->nelems; j++) {
+		if (!pat->elems[j].optional)
+			return false;
+	}
+
+	/*
+	 * We have a match: update the ctx and return true. The subop structure
+	 * will be used by the pattern's ->exec() function.
+	 */
+	ctx->subop.instrs = &ctx->instrs[ctx->instr_idx];
+	ctx->subop.first_instr_start_off = ctx->instr_start_off;
+	ctx->subop.last_instr_end_off = boundary_off;
+
+	/*
+	 * Update the pointers so the calling function will be able to recall
+	 * this one with a new subset of instructions.
+	 *
+	 * In the case where the last operation of this set is split, point to
+	 * the last unfinished job, knowing the starting offset.
+	 */
+	ctx->instr_idx = i;
+	ctx->instr_start_off = boundary_off;
+
+	return true;
+}
+
+#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
+static void nand_op_parser_trace(const struct nand_op_parser_ctx *ctx)
+{
+	const struct nand_op_instr *instr;
+	char *prefix = "      ";
+	char *buf;
+	unsigned int len, off = 0;
+	int i, j;
+
+	pr_debug("executing subop:\n");
+
+	for (i = 0; i < ctx->ninstrs; i++) {
+		instr = &ctx->instrs[i];
+
+		/*
+		 * ctx->instr_idx is not reliable because it may already have
+		 * been updated by the parser. Use pointers comparison instead.
+		 */
+		if (instr == &ctx->subop.instrs[0])
+			prefix = "    ->";
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			pr_debug("%sCMD      [0x%02x]\n", prefix,
+				 instr->ctx.cmd.opcode);
+			break;
+		case NAND_OP_ADDR_INSTR:
+			/*
+			 * A log line is much less than 50 bytes, plus 5 bytes
+			 * per address cycle to display.
+			 */
+			len = 50 + 5 * instr->ctx.addr.naddrs;
+			buf = kzalloc(len, GFP_KERNEL);
+			if (!buf)
+				return;
+
+			off += snprintf(buf, len, "ADDR     [%d cyc:",
+					instr->ctx.addr.naddrs);
+			for (j = 0; j < instr->ctx.addr.naddrs; j++)
+				off += snprintf(&buf[off], len - off,
+						" 0x%02x",
+						instr->ctx.addr.addrs[j]);
+			pr_debug("%s%s]\n", prefix, buf);
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+			pr_debug("%sDATA_IN  [%d B%s]\n", prefix,
+				 instr->ctx.data.len,
+				 instr->ctx.data.force_8bit ?
+				 ", force 8-bit" : "");
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			pr_debug("%sDATA_OUT [%d B%s]\n", prefix,
+				 instr->ctx.data.len,
+				 instr->ctx.data.force_8bit ?
+				 ", force 8-bit" : "");
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			pr_debug("%sWAITRDY  [max %d ms]\n", prefix,
+				 instr->ctx.waitrdy.timeout_ms);
+			break;
+		}
+
+		if (instr == &ctx->subop.instrs[ctx->subop.ninstrs - 1])
+			prefix = "      ";
+	}
+}
+#else
+static void nand_op_parser_trace(const struct nand_op_parser_ctx *ctx)
+{
+	/* NOP */
+}
+#endif
+
+/**
+ * nand_op_parser_exec_op - exec_op parser
+ * @chip: the NAND chip
+ * @parser: the parser to use given by the controller driver
+ * @op: the NAND operation to address
+ * @check_only: flag asking if the entire operation could be handled
+ *
+ * Function that must be called by each driver that implement the "exec_op API"
+ * in their own ->exec_op() implementation.
+ *
+ * The function iterates on all the instructions asked and make use of internal
+ * parsers to find matches between the instruction list and the handled patterns
+ * filled by the controller drivers inside the @parser structure. If needed, the
+ * instructions could be split into sub-operations and be executed sequentially.
+ */
+int nand_op_parser_exec_op(struct nand_chip *chip,
+			   const struct nand_op_parser *parser,
+			   const struct nand_operation *op, bool check_only)
+{
+	struct nand_op_parser_ctx ctx = {
+		.instrs = op->instrs,
+		.ninstrs = op->ninstrs,
+	};
+	unsigned int i;
+
+	while (ctx.instr_idx < op->ninstrs) {
+		int ret;
+
+		for (i = 0; i < parser->npatterns; i++) {
+			const struct nand_op_parser_pattern *pattern;
+
+			pattern = &parser->patterns[i];
+			if (!nand_op_parser_match_pat(pattern, &ctx))
+				continue;
+
+			nand_op_parser_trace(&ctx);
+
+			if (check_only)
+				break;
+
+			ret = pattern->exec(chip, &ctx.subop);
+			if (ret)
+				return ret;
+
+			break;
+		}
+
+		if (i == parser->npatterns) {
+			pr_debug("->exec_op() parser: pattern not found!\n");
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_op_parser_exec_op);
+
+static bool nand_instr_is_data(const struct nand_op_instr *instr)
+{
+	return instr && (instr->type == NAND_OP_DATA_IN_INSTR ||
+			 instr->type == NAND_OP_DATA_OUT_INSTR);
+}
+
+static bool nand_subop_instr_is_valid(const struct nand_subop *subop,
+				      unsigned int instr_idx)
+{
+	return subop && instr_idx < subop->ninstrs;
+}
+
+static int nand_subop_get_start_off(const struct nand_subop *subop,
+				    unsigned int instr_idx)
+{
+	if (instr_idx)
+		return 0;
+
+	return subop->first_instr_start_off;
+}
+
+/**
+ * nand_subop_get_addr_start_off - Get the start offset in an address array
+ * @subop: The entire sub-operation
+ * @instr_idx: Index of the instruction inside the sub-operation
+ *
+ * Instructions arrays may be split by the parser between instructions,
+ * and also in the middle of an address instruction if the number of cycles
+ * to assert in one operation is not supported by the controller.
+ *
+ * For this, instead of using the first index of the ->addr.addrs field from the
+ * address instruction, the NAND controller driver must use this helper that
+ * will either return 0 if the index does not point to the first instruction of
+ * the sub-operation, or the offset of the next starting offset inside the
+ * address cycles.
+ *
+ * Returns the offset of the first address cycle to assert from the pointed
+ * address instruction.
+ */
+int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+				  unsigned int instr_idx)
+{
+	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
+	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
+		return -EINVAL;
+
+	return nand_subop_get_start_off(subop, instr_idx);
+}
+EXPORT_SYMBOL_GPL(nand_subop_get_addr_start_off);
+
+/**
+ * nand_subop_get_num_addr_cyc - Get the remaining address cycles to assert
+ * @subop: The entire sub-operation
+ * @instr_idx: Index of the instruction inside the sub-operation
+ *
+ * Instructions arrays may be split by the parser between instructions,
+ * and also in the middle of an address instruction if the number of cycles
+ * to assert in one operation is not supported by the controller.
+ *
+ * Returns the number of address cycles to assert from the pointed address
+ * instruction.
+ */
+int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+				unsigned int instr_idx)
+{
+	int start_off, end_off;
+
+	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
+	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
+		return -EINVAL;
+
+	start_off = nand_subop_get_addr_start_off(subop, instr_idx);
+
+	if (instr_idx == subop->ninstrs - 1 &&
+	    subop->last_instr_end_off)
+		end_off = subop->last_instr_end_off;
+	else
+		end_off = subop->instrs[instr_idx].ctx.addr.naddrs;
+
+	return end_off - start_off;
+}
+EXPORT_SYMBOL_GPL(nand_subop_get_num_addr_cyc);
+
+/**
+ * nand_subop_get_data_start_off - Get the start offset in a data array
+ * @subop: The entire sub-operation
+ * @instr_idx: Index of the instruction inside the sub-operation
+ *
+ * Instructions arrays may be split by the parser between instructions,
+ * and also in the middle of a data instruction if the number of bytes to access
+ * in one operation is greater that the controller limit.
+ *
+ * Returns the data offset inside the pointed data instruction buffer from which
+ * to start.
+ */
+int nand_subop_get_data_start_off(const struct nand_subop *subop,
+				  unsigned int instr_idx)
+{
+	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
+	    !nand_instr_is_data(&subop->instrs[instr_idx]))
+		return -EINVAL;
+
+	return nand_subop_get_start_off(subop, instr_idx);
+}
+EXPORT_SYMBOL_GPL(nand_subop_get_data_start_off);
+
+/**
+ * nand_subop_get_data_len - Get the number of bytes to retrieve
+ * @subop: The entire sub-operation
+ * @instr_idx: Index of the instruction inside the sub-operation
+ *
+ * Instructions arrays may be split by the parser between instructions,
+ * and also in the middle of a data instruction if the number of bytes to access
+ * in one operation is greater that the controller limit.
+ *
+ * For this, instead of using the ->data.len field from the data instruction,
+ * the NAND controller driver must use this helper that will return the actual
+ * length of data to move between the first and last offset asked for this
+ * particular instruction.
+ *
+ * Returns the length of the data to move from the pointed data instruction.
+ */
+int nand_subop_get_data_len(const struct nand_subop *subop,
+			    unsigned int instr_idx)
+{
+	int start_off = 0, end_off;
+
+	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
+	    !nand_instr_is_data(&subop->instrs[instr_idx]))
+		return -EINVAL;
+
+	start_off = nand_subop_get_data_start_off(subop, instr_idx);
+
+	if (instr_idx == subop->ninstrs - 1 &&
+	    subop->last_instr_end_off)
+		end_off = subop->last_instr_end_off;
+	else
+		end_off = subop->instrs[instr_idx].ctx.data.len;
+
+	return end_off - start_off;
+}
+EXPORT_SYMBOL_GPL(nand_subop_get_data_len);
+
+/**
  * nand_reset - Reset and initialize a NAND device
  * @chip: The NAND chip
  * @chipnr: Internal die id
@@ -4002,11 +4977,11 @@ static void nand_set_defaults(struct nand_chip *chip)
 		chip->chip_delay = 20;
 
 	/* check, if a user supplied command function given */
-	if (chip->cmdfunc == NULL)
+	if (!chip->cmdfunc && !chip->exec_op)
 		chip->cmdfunc = nand_command;
 
 	/* check, if a user supplied wait function given */
-	if (chip->waitfunc == NULL)
+	if (!chip->waitfunc)
 		chip->waitfunc = nand_wait;
 
 	if (!chip->select_chip)
@@ -4894,15 +5869,21 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	if (!mtd->name && mtd->dev.parent)
 		mtd->name = dev_name(mtd->dev.parent);
 
-	if ((!chip->cmdfunc || !chip->select_chip) && !chip->cmd_ctrl) {
+	/*
+	 * ->cmdfunc() is legacy and will only be used if ->exec_op() is not
+	 * populated.
+	 */
+	if (!chip->exec_op) {
 		/*
-		 * Default functions assigned for chip_select() and
-		 * cmdfunc() both expect cmd_ctrl() to be populated,
-		 * so we need to check that that's the case
+		 * Default functions assigned for ->cmdfunc() and
+		 * ->select_chip() both expect ->cmd_ctrl() to be populated.
 		 */
-		pr_err("chip.cmd_ctrl() callback is not provided");
-		return -EINVAL;
+		if ((!chip->cmdfunc || !chip->select_chip) && !chip->cmd_ctrl) {
+			pr_err("->cmd_ctrl() should be provided\n");
+			return -EINVAL;
+		}
 	}
+
 	/* Set the default functions */
 	nand_set_defaults(chip);
 
diff --git a/drivers/mtd/nand/nand_hynix.c b/drivers/mtd/nand/nand_hynix.c
index bae0da2aa2a8..d542908a0ebb 100644
--- a/drivers/mtd/nand/nand_hynix.c
+++ b/drivers/mtd/nand/nand_hynix.c
@@ -81,6 +81,15 @@ static int hynix_nand_cmd_op(struct nand_chip *chip, u8 cmd)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (chip->exec_op) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(cmd, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, cmd, -1, -1);
 
 	return 0;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 0be959a478db..053b506f4800 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -751,6 +751,349 @@ struct nand_manufacturer_ops {
 };
 
 /**
+ * struct nand_op_cmd_instr - Definition of a command instruction
+ * @opcode: the command to assert in one cycle
+ */
+struct nand_op_cmd_instr {
+	u8 opcode;
+};
+
+/**
+ * struct nand_op_addr_instr - Definition of an address instruction
+ * @naddrs: length of the @addrs array
+ * @addrs: array containing the address cycles to assert
+ */
+struct nand_op_addr_instr {
+	unsigned int naddrs;
+	const u8 *addrs;
+};
+
+/**
+ * struct nand_op_data_instr - Definition of a data instruction
+ * @len: number of data bytes to move
+ * @in: buffer to fill when reading from the NAND chip
+ * @out: buffer to read from when writing to the NAND chip
+ * @force_8bit: force 8-bit access
+ *
+ * Please note that "in" and "out" are inverted from the ONFI specification
+ * and are from the controller perspective, so a "in" is a read from the NAND
+ * chip while a "out" is a write to the NAND chip.
+ */
+struct nand_op_data_instr {
+	unsigned int len;
+	union {
+		void *in;
+		const void *out;
+	} buf;
+	bool force_8bit;
+};
+
+/**
+ * struct nand_op_waitrdy_instr - Definition of a wait ready instruction
+ * @timeout_ms: maximum delay while waiting for the ready/busy pin in ms
+ */
+struct nand_op_waitrdy_instr {
+	unsigned int timeout_ms;
+};
+
+/**
+ * enum nand_op_instr_type - Enumeration of all instruction types
+ * @NAND_OP_CMD_INSTR: command instruction
+ * @NAND_OP_ADDR_INSTR: address instruction
+ * @NAND_OP_DATA_IN_INSTR: data in instruction
+ * @NAND_OP_DATA_OUT_INSTR: data out instruction
+ * @NAND_OP_WAITRDY_INSTR: wait ready instruction
+ */
+enum nand_op_instr_type {
+	NAND_OP_CMD_INSTR,
+	NAND_OP_ADDR_INSTR,
+	NAND_OP_DATA_IN_INSTR,
+	NAND_OP_DATA_OUT_INSTR,
+	NAND_OP_WAITRDY_INSTR,
+};
+
+/**
+ * struct nand_op_instr - Generic definition of an instruction
+ * @type: an enumeration of the instruction type
+ * @cmd/@addr/@data/@waitrdy: extra data associated to the instruction.
+ *                            You'll have to use the appropriate element
+ *                            depending on @type
+ * @delay_ns: delay to apply by the controller after the instruction has been
+ *	      actually executed (most of them are directly handled by the
+ *	      controllers once the timings negociation has been done)
+ */
+struct nand_op_instr {
+	enum nand_op_instr_type type;
+	union {
+		struct nand_op_cmd_instr cmd;
+		struct nand_op_addr_instr addr;
+		struct nand_op_data_instr data;
+		struct nand_op_waitrdy_instr waitrdy;
+	} ctx;
+	unsigned int delay_ns;
+};
+
+/*
+ * Special handling must be done for the WAITRDY timeout parameter as it usually
+ * is either tPROG (after a prog), tR (before a read), tRST (during a reset) or
+ * tBERS (during an erase) which all of them are u64 values that cannot be
+ * divided by usual kernel macros and must be handled with the special
+ * DIV_ROUND_UP_ULL() macro.
+ */
+#define __DIVIDE(dividend, divisor) ({					\
+	sizeof(dividend) == sizeof(u32) ?				\
+		DIV_ROUND_UP(dividend, divisor) :			\
+		DIV_ROUND_UP_ULL(dividend, divisor);			\
+		})
+#define PSEC_TO_NSEC(x) __DIVIDE(x, 1000)
+#define PSEC_TO_MSEC(x) __DIVIDE(x, 1000000000)
+
+#define NAND_OP_CMD(id, ns)						\
+	{								\
+		.type = NAND_OP_CMD_INSTR,				\
+		.ctx.cmd.opcode = id,					\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_ADDR(ncycles, cycles, ns)				\
+	{								\
+		.type = NAND_OP_ADDR_INSTR,				\
+		.ctx.addr = {						\
+			.naddrs = ncycles,				\
+			.addrs = cycles,				\
+		},							\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_DATA_IN(l, buf, ns)					\
+	{								\
+		.type = NAND_OP_DATA_IN_INSTR,				\
+		.ctx.data = {						\
+			.len = l,					\
+			.buf.in = buf,					\
+			.force_8bit = false,				\
+		},							\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_DATA_OUT(l, buf, ns)					\
+	{								\
+		.type = NAND_OP_DATA_OUT_INSTR,				\
+		.ctx.data = {						\
+			.len = l,					\
+			.buf.out = buf,					\
+			.force_8bit = false,				\
+		},							\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_8BIT_DATA_IN(l, b, ns)					\
+	{								\
+		.type = NAND_OP_DATA_IN_INSTR,				\
+		.ctx.data = {						\
+			.len = l,					\
+			.buf.in = b,					\
+			.force_8bit = true,				\
+		},							\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_8BIT_DATA_OUT(l, b, ns)					\
+	{								\
+		.type = NAND_OP_DATA_OUT_INSTR,				\
+		.ctx.data = {						\
+			.len = l,					\
+			.buf.out = b,					\
+			.force_8bit = true,				\
+		},							\
+		.delay_ns = ns,						\
+	}
+
+#define NAND_OP_WAIT_RDY(tout_ms, ns)					\
+	{								\
+		.type = NAND_OP_WAITRDY_INSTR,				\
+		.ctx.waitrdy.timeout_ms = tout_ms,			\
+		.delay_ns = ns,						\
+	}
+
+/**
+ * struct nand_subop - a sub operation
+ * @instrs: array of instructions
+ * @ninstrs: length of the @instrs array
+ * @first_instr_start_off: offset to start from for the first instruction
+ *			   of the sub-operation
+ * @last_instr_end_off: offset to end at (excluded) for the last instruction
+ *			of the sub-operation
+ *
+ * Both parameters @first_instr_start_off and @last_instr_end_off apply for the
+ * address cycles in the case of address, or for data offset in the case of data
+ * transfers. Otherwise, it is irrelevant.
+ *
+ * When an operation cannot be handled as is by the NAND controller, it will
+ * be split by the parser and the remaining pieces will be handled as
+ * sub-operations.
+ */
+struct nand_subop {
+	const struct nand_op_instr *instrs;
+	unsigned int ninstrs;
+	unsigned int first_instr_start_off;
+	unsigned int last_instr_end_off;
+};
+
+int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+				  unsigned int op_id);
+int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+				unsigned int op_id);
+int nand_subop_get_data_start_off(const struct nand_subop *subop,
+				  unsigned int op_id);
+int nand_subop_get_data_len(const struct nand_subop *subop,
+			    unsigned int op_id);
+
+/**
+ * struct nand_op_parser_addr_constraints - Constraints for address instructions
+ * @maxcycles: maximum number of cycles that the controller can assert by
+ *	       instruction
+ */
+struct nand_op_parser_addr_constraints {
+	unsigned int maxcycles;
+};
+
+/**
+ * struct nand_op_parser_data_constraints - Constraints for data instructions
+ * @maxlen: maximum data length that the controller can handle with one
+ *	    instruction
+ */
+struct nand_op_parser_data_constraints {
+	unsigned int maxlen;
+};
+
+/**
+ * struct nand_op_parser_pattern_elem - One element of a pattern
+ * @type: the instructuction type
+ * @optional: if this element of the pattern is optional or mandatory
+ * @addr/@data: address or data constraint (number of cycles or data length)
+ */
+struct nand_op_parser_pattern_elem {
+	enum nand_op_instr_type type;
+	bool optional;
+	union {
+		struct nand_op_parser_addr_constraints addr;
+		struct nand_op_parser_data_constraints data;
+	};
+};
+
+#define NAND_OP_PARSER_PAT_CMD_ELEM(_opt)			\
+	{							\
+		.type = NAND_OP_CMD_INSTR,			\
+		.optional = _opt,				\
+	}
+
+#define NAND_OP_PARSER_PAT_ADDR_ELEM(_opt, _maxcycles)		\
+	{							\
+		.type = NAND_OP_ADDR_INSTR,			\
+		.optional = _opt,				\
+		.addr.maxcycles = _maxcycles,			\
+	}
+
+#define NAND_OP_PARSER_PAT_DATA_IN_ELEM(_opt, _maxlen)		\
+	{							\
+		.type = NAND_OP_DATA_IN_INSTR,			\
+		.optional = _opt,				\
+		.data.maxlen = _maxlen,				\
+	}
+
+#define NAND_OP_PARSER_PAT_DATA_OUT_ELEM(_opt, _maxlen)		\
+	{							\
+		.type = NAND_OP_DATA_OUT_INSTR,			\
+		.optional = _opt,				\
+		.data.maxlen = _maxlen,				\
+	}
+
+#define NAND_OP_PARSER_PAT_WAITRDY_ELEM(_opt)			\
+	{							\
+		.type = NAND_OP_WAITRDY_INSTR,			\
+		.optional = _opt,				\
+	}
+
+/**
+ * struct nand_op_parser_pattern - A complete pattern
+ * @elems: array of pattern elements
+ * @nelems: number of pattern elements in @elems array
+ * @exec: the function that will actually execute this pattern, written in the
+ *	  controller driver
+ *
+ * This is a complete pattern that is a list of elements, each one reprensenting
+ * one instruction with its constraints. Controller drivers must declare as much
+ * patterns as they support and give the list of the supported patterns (created
+ * with the help of the following macro) when calling nand_op_parser_exec_op()
+ * which is the preferred approach for advanced controllers as the main thing to
+ * do in the driver implementation of ->exec_op(). Once there is a match between
+ * the pattern and an operation, the either the core just wanted to know if the
+ * operation was supporter (through the use of the check_only boolean) or it
+ * calls the @exec function to actually do the operation.
+ */
+struct nand_op_parser_pattern {
+	const struct nand_op_parser_pattern_elem *elems;
+	unsigned int nelems;
+	int (*exec)(struct nand_chip *chip, const struct nand_subop *subop);
+};
+
+#define NAND_OP_PARSER_PATTERN(_exec, ...)							\
+	{											\
+		.exec = _exec,									\
+		.elems = (struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ },		\
+		.nelems = sizeof((struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ }) /	\
+			  sizeof(struct nand_op_parser_pattern_elem),				\
+	}
+
+/**
+ * struct nand_op_parser - The actual parser
+ * @patterns: array of patterns
+ * @npatterns: length of the @patterns array
+ *
+ * The actual parser structure wich is an array of supported patterns.
+ *
+ * It is worth mentioning that patterns will be tested in their declaration
+ * order, and the first match will be taken, so it's important to order patterns
+ * appropriately so that simple/inefficient patterns are placed at the end of
+ * the list. Usually, this is where you put single instruction patterns.
+ */
+struct nand_op_parser {
+	const struct nand_op_parser_pattern *patterns;
+	unsigned int npatterns;
+};
+
+#define NAND_OP_PARSER(...)									\
+	{											\
+		.patterns = (struct nand_op_parser_pattern[]) { __VA_ARGS__ },			\
+		.npatterns = sizeof((struct nand_op_parser_pattern[]) { __VA_ARGS__ }) /	\
+			     sizeof(struct nand_op_parser_pattern),				\
+	}
+
+/**
+ * struct nand_operation - The actual operation
+ * @instrs: array of instructions to execute
+ * @ninstrs: length of the @instrs array
+ *
+ * The actual operation structure that will be given to the parser and
+ * also to ->exec_op().
+ */
+struct nand_operation {
+	const struct nand_op_instr *instrs;
+	unsigned int ninstrs;
+};
+
+#define NAND_OPERATION(_instrs)					\
+	{							\
+		.instrs = _instrs,				\
+		.ninstrs = ARRAY_SIZE(_instrs),			\
+	}
+
+int nand_op_parser_exec_op(struct nand_chip *chip,
+			   const struct nand_op_parser *parser,
+			   const struct nand_operation *op, bool check_only);
+
+/**
  * struct nand_chip - NAND Private Flash Chip Data
  * @mtd:		MTD device registered to the MTD framework
  * @IO_ADDR_R:		[BOARDSPECIFIC] address to read the 8 I/O lines of the
@@ -776,6 +1119,10 @@ struct nand_manufacturer_ops {
  *			commands to the chip.
  * @waitfunc:		[REPLACEABLE] hardwarespecific function for wait on
  *			ready.
+ * @exec_op:		[REPLACEABLE] controller specific method to execute
+ *			NAND operations. This method replaces ->cmdfunc(),
+ *			->{read,write}_{buf,byte,word}(), ->dev_ready() and
+ *			->waifunc().
  * @setup_read_retry:	[FLASHSPECIFIC] flash (vendor) specific function for
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @ecc:		[BOARDSPECIFIC] ECC control structure
@@ -875,6 +1222,9 @@ struct nand_chip {
 	void (*cmdfunc)(struct mtd_info *mtd, unsigned command, int column,
 			int page_addr);
 	int(*waitfunc)(struct mtd_info *mtd, struct nand_chip *this);
+	int (*exec_op)(struct nand_chip *chip,
+		       const struct nand_operation *op,
+		       bool check_only);
 	int (*erase)(struct mtd_info *mtd, int page);
 	int (*scan_bbt)(struct mtd_info *mtd);
 	int (*onfi_set_features)(struct mtd_info *mtd, struct nand_chip *chip,
@@ -885,7 +1235,6 @@ struct nand_chip {
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
 
-
 	int chip_delay;
 	unsigned int options;
 	unsigned int bbt_options;
@@ -945,6 +1294,15 @@ struct nand_chip {
 	} manufacturer;
 };
 
+static inline int nand_exec_op(struct nand_chip *chip,
+			       const struct nand_operation *op)
+{
+	if (!chip->exec_op)
+		return -ENOTSUPP;
+
+	return chip->exec_op(chip, op, false);
+}
+
 extern const struct mtd_ooblayout_ops nand_ooblayout_sp_ops;
 extern const struct mtd_ooblayout_ops nand_ooblayout_lp_ops;
 
@@ -1310,28 +1668,37 @@ int nand_status_op(struct nand_chip *chip, u8 *status);
 int nand_exit_status_op(struct nand_chip *chip);
 int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock);
 int nand_read_page_op(struct nand_chip *chip, unsigned int page,
-		      unsigned int column, void *buf, unsigned int len);
-int nand_change_read_column_op(struct nand_chip *chip, unsigned int column,
-			       void *buf, unsigned int len, bool force_8bit);
+		      unsigned int offset_in_page, void *buf, unsigned int len);
+int nand_change_read_column_op(struct nand_chip *chip,
+			       unsigned int offset_in_page, void *buf,
+			       unsigned int len, bool force_8bit);
 int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
-		     unsigned int column, void *buf, unsigned int len);
+		     unsigned int offset_in_page, void *buf, unsigned int len);
 int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
-			    unsigned int column, const void *buf,
+			    unsigned int offset_in_page, const void *buf,
 			    unsigned int len);
 int nand_prog_page_end_op(struct nand_chip *chip);
 int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
-		      unsigned int column, const void *buf, unsigned int len);
-int nand_change_write_column_op(struct nand_chip *chip, unsigned int column,
-				const void *buf, unsigned int len,
-				bool force_8bit);
+		      unsigned int offset_in_page, const void *buf,
+		      unsigned int len);
+int nand_change_write_column_op(struct nand_chip *chip,
+				unsigned int offset_in_page, const void *buf,
+				unsigned int len, bool force_8bit);
 int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
-		      bool force_8bits);
+		      bool force_8bit);
 int nand_write_data_op(struct nand_chip *chip, const void *buf,
-		       unsigned int len, bool force_8bits);
+		       unsigned int len, bool force_8bit);
 
 /* Free resources held by the NAND device */
 void nand_cleanup(struct nand_chip *chip);
 
 /* Default extended ID decoding function */
 void nand_decode_ext_id(struct nand_chip *chip);
+
+/*
+ * External helper for controller drivers that have to implement the WAITRDY
+ * instruction and have no physical pin to check it.
+ */
+int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms);
+
 #endif /* __LINUX_MTD_RAWNAND_H */
-- 
2.11.0

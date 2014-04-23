From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Apr 2014 18:16:55 +0800
Subject: [PATCH v1 7/7] mtd: fsl-quadspi: add the DDR quad read support
In-Reply-To: <a>
References: <a>
Message-ID: <1398248215-26768-8-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DDR quad read support for the fsl-quadspi driver.

 (1) Test this patch with imx6sx-sdb board (Spansion s25fl128s)
     The clock rate is 66MHz.

 (2) The information of NOR flash:
     -----------------------------------------------
     root at imx6qdlsolo:~# mtdinfo /dev/mtd0
     mtd0
     Name:                           21e4000.qspi
     Type:                           nor
     Eraseblock size:                65536 bytes, 64.0 KiB
     Amount of eraseblocks:          256 (16777216 bytes, 16.0 MiB)
     Minimum input/output unit size: 1 byte
     Sub-page size:                  1 byte
     Character device major/minor:   90:0
     Bad blocks are allowed:         false
     Device is writable:             true
     -----------------------------------------------

 (3) Test this patch set with UBIFS & bonnie++:
     -----------------------------------------------
	ubiattach /dev/ubi_ctrl -m 0
	ubimkvol /dev/ubi0 -N test -m
	mount -t ubifs ubi0:test tmp
	bonnie++ -d tmp -u 0 -s 10 -r 5
     -----------------------------------------------

 (4) Test this patch with mtd_speedtest.ko

     root at imx6qdlsolo:~# insmod mtd_speedtest.ko dev=0
     =================================================
     mtd_speedtest: MTD device: 0
     mtd_speedtest: not NAND flash, assume page size is 512 bytes.
     mtd_speedtest: MTD device size 16777216, eraseblock size 65536, page size 512,
                    count of eraseblocks 256, pages per eraseblock 128, OOB size 0
     mtd_speedtest: testing eraseblock write speed
     mtd_speedtest: eraseblock write speed is 665 KiB/s
     mtd_speedtest: testing eraseblock read speed
     mtd_speedtest: eraseblock read speed is 49799 KiB/s
     mtd_speedtest: testing page write speed
     mtd_speedtest: page write speed is 662 KiB/s
     mtd_speedtest: testing page read speed
     mtd_speedtest: page read speed is 24236 KiB/s
     mtd_speedtest: testing 2 page write speed
     mtd_speedtest: 2 page write speed is 657 KiB/s
     mtd_speedtest: testing 2 page read speed
     mtd_speedtest: 2 page read speed is 32637 KiB/s
     mtd_speedtest: Testing erase speed
     mtd_speedtest: erase speed is 518 KiB/s
     mtd_speedtest: Testing 2x multi-block erase speed
     mtd_speedtest: 2x multi-block erase speed is 506 KiB/s
     mtd_speedtest: Testing 4x multi-block erase speed
     mtd_speedtest: 4x multi-block erase speed is 503 KiB/s
     mtd_speedtest: Testing 8x multi-block erase speed
     mtd_speedtest: 8x multi-block erase speed is 501 KiB/s
     mtd_speedtest: Testing 16x multi-block erase speed
     mtd_speedtest: 16x multi-block erase speed is 498 KiB/s
     mtd_speedtest: Testing 32x multi-block erase speed
     mtd_speedtest: 32x multi-block erase speed is 496 KiB/s
     mtd_speedtest: Testing 64x multi-block erase speed
     mtd_speedtest: 64x multi-block erase speed is 495 KiB/s
     mtd_speedtest: finished
     =================================================

  (5) Conclusion:
     The DDR quad read could be 49799 KiB/s.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c |   59 ++++++++++++++++++++++++++++++++++--
 1 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 0a2901e..fcb963f 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -29,6 +29,9 @@
 
 /* The registers */
 #define QUADSPI_MCR			0x00
+#define MX6SX_QUADSPI_MCR_TX_DDR_DELAY_EN_SHIFT	29
+#define MX6SX_QUADSPI_MCR_TX_DDR_DELAY_EN_MASK	\
+				(1 << MX6SX_QUADSPI_MCR_TX_DDR_DELAY_EN_SHIFT)
 #define QUADSPI_MCR_RESERVED_SHIFT	16
 #define QUADSPI_MCR_RESERVED_MASK	(0xF << QUADSPI_MCR_RESERVED_SHIFT)
 #define QUADSPI_MCR_MDIS_SHIFT		14
@@ -292,7 +295,7 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	for (i = 0; i < QUADSPI_LUT_NUM; i++)
 		writel(0, base + QUADSPI_LUT_BASE + i * 4);
 
-	/* Quad Read */
+	/* Quad Read and DDR Quad Read*/
 	lut_base = SEQID_QUAD_READ * 4;
 	op = nor->read_opcode;
 	dm = nor->read_dummy;
@@ -308,6 +311,24 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 			dev_err(nor->dev,
 				"Unsupported cmd:%.2x\n", nor->read_opcode);
 		}
+	} else if (nor->flash_read == SPI_NOR_DDR_QUAD) {
+		if (op == SPINOR_OP_READ_1_4_4_D ||
+			 op == SPINOR_OP_READ4_1_4_4_D) {
+			/* read mode : 1-4-4, such as Spansion s25fl128s. */
+			writel(LUT0(CMD, PAD1, op)
+				| LUT1(ADDR_DDR, PAD4, addrlen),
+				base + QUADSPI_LUT(lut_base));
+
+			writel(LUT0(MODE_DDR, PAD1, 4) | LUT1(DUMMY, PAD1, dm),
+				base + QUADSPI_LUT(lut_base + 1));
+
+			writel(LUT0(READ_DDR, PAD4, rxfifo)
+				| LUT1(JMP_ON_CS, PAD1, 0),
+				base + QUADSPI_LUT(lut_base + 2));
+		} else {
+			dev_err(nor->dev,
+				"Unsupported cmd:%.2x\n", nor->read_opcode);
+		}
 	}
 
 	/* Write enable */
@@ -369,6 +390,9 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
+	case SPINOR_OP_READ_1_4_4_D:
+	case SPINOR_OP_READ4_1_4_4_D:
+	case SPINOR_OP_READ4_1_1_4:
 	case SPINOR_OP_READ_1_1_4:
 		return SEQID_QUAD_READ;
 	case SPINOR_OP_WREN:
@@ -558,6 +582,8 @@ static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
 static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
+	struct spi_nor *nor = &q->nor[0];
+	u32 reg, reg2;
 	int seqid;
 
 	/* AHB configuration for access buffer 0/1/2 .*/
@@ -572,9 +598,30 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 	writel(0, base + QUADSPI_BUF2IND);
 
 	/* Set the default lut sequence for AHB Read. */
-	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
+	seqid = fsl_qspi_get_seqid(q, nor->read_opcode);
 	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
 		q->iobase + QUADSPI_BFGENCR);
+
+	/* enable the DDR quad read */
+	if (nor->flash_read == SPI_NOR_DDR_QUAD) {
+		reg = readl(q->iobase + QUADSPI_MCR);
+
+		/* Firstly, disable the module */
+		writel(reg | QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+
+		/* Set the Sampling Register for DDR */
+		reg2 = readl(q->iobase + QUADSPI_SMPR);
+		reg2 &= ~QUADSPI_SMPR_DDRSMP_MASK;
+		reg2 |= (2 << QUADSPI_SMPR_DDRSMP_SHIFT);
+		writel(reg2, q->iobase + QUADSPI_SMPR);
+
+		/* Enable the module again (enable the DDR too) */
+		reg |= QUADSPI_MCR_DDR_EN_MASK;
+		if (is_imx6sx_qspi(q))
+			reg |= MX6SX_QUADSPI_MCR_TX_DDR_DELAY_EN_MASK;
+
+		writel(reg, q->iobase + QUADSPI_MCR);
+	}
 }
 
 /* We use this function to do some basic init for spi_nor_scan(). */
@@ -863,6 +910,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
 		const struct spi_device_id *id;
+		enum read_mode mode = SPI_NOR_QUAD;
 		char modalias[40];
 		u32 dummy = 0;
 
@@ -903,13 +951,16 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* Set the dummy cycles for the DDR Quad Read */
 		ret = of_property_read_u32(np, "spi-nor,ddr-quad-read-dummy",
 				&dummy);
-		if (!ret && dummy > 0 && dummy < 8)
+		if (!ret && dummy > 0 && dummy < 8) {
 			nor->read_dummy = dummy;
+			mode = SPI_NOR_DDR_QUAD;
+			dev_dbg(dev, "The DDR quad read dummy is %d.\n", dummy);
+		}
 
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
-		ret = spi_nor_scan(nor, id, SPI_NOR_QUAD);
+		ret = spi_nor_scan(nor, id, mode);
 		if (ret)
 			goto map_failed;
 
-- 
1.7.2.rc3

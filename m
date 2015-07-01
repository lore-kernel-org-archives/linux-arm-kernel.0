From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  1 Jul 2015 16:20:08 -0400
Subject: [RFC PATCH 5/7] mtd: fsl-quadspi: Allow non-contiguous flash layouts.
In-Reply-To: <1435782010-9809-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1435782010-9809-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1435782010-9809-7-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current fsl-quadspi implementation assumes that the first NOR device
is always physically connected to QSPIn_A_CS0, and that all connected
devices are of the same type.

This commit separates the DT parsing and flash probe logic into two
passes, allowing devices of different sizes and types to be attached in
arbitrary order to the various chip selects associated with each QSPI
interface.

Tested on a custom VF610-based board with a single SPI NOR connected to
QSPI0_B_CS0, and also on a Rev. H TWR board with dual SPI NOR devices
connected to QSPI0_A_CS0 and QSPI0_B_CS0.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |  15 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 166 +++++++++++++--------
 2 files changed, 106 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
index 4461dc7..e392156 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -9,15 +9,6 @@ Required properties:
   - clocks : The clocks needed by the QuadSPI controller
   - clock-names : the name of the clocks
 
-Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-
 Example:
 
 qspi0: quadspi at 40044000 {
@@ -30,6 +21,12 @@ qspi0: quadspi at 40044000 {
 	clock-names = "qspi_en", "qspi";
 
 	flash0: s25fl128s at 0 {
+		reg = <0>;  /* QSPI0_A_CS0 */
+		....
+	};
+
+	flash1: s25fl128s at 3 {
+		reg = <3>;  /* QSPI0_B_CS1 */
 		....
 	};
 };
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index d0cf0b7..3c378f0 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -221,6 +221,7 @@ static struct fsl_qspi_devtype_data imx6sx_data = {
 };
 
 #define FSL_QSPI_MAX_CHIP	4
+#define MODALIAS_NBYTES		40
 struct fsl_qspi {
 	struct mtd_info mtd[FSL_QSPI_MAX_CHIP];
 	struct spi_nor nor[FSL_QSPI_MAX_CHIP];
@@ -231,11 +232,10 @@ struct fsl_qspi {
 	struct device *dev;
 	struct completion c;
 	struct fsl_qspi_devtype_data *devtype_data;
-	u32 nor_size;
-	u32 nor_num;
+	char modalias[FSL_QSPI_MAX_CHIP][MODALIAS_NBYTES];
+	u32 nor_size[FSL_QSPI_MAX_CHIP];
 	u32 clk_rate[FSL_QSPI_MAX_CHIP];
 	unsigned int chip_base_addr; /* We may support two chips. */
-	bool has_second_chip;
 };
 
 static inline int is_vybrid_qspi(struct fsl_qspi *q)
@@ -429,8 +429,9 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd, u8 addr_width)
 }
 
 static int
-fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned int addr, int len)
+fsl_qspi_runcmd(struct spi_nor *nor, u8 cmd, unsigned int addr, int len)
 {
+	struct fsl_qspi *q = nor->priv;
 	void __iomem *base = q->iobase;
 	int seqid;
 	u32 reg, reg2;
@@ -459,7 +460,7 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned int addr, int len)
 	} while (1);
 
 	/* trigger the LUT now */
-	seqid = fsl_qspi_get_seqid(q, cmd, q->nor[0].addr_width);
+	seqid = fsl_qspi_get_seqid(q, cmd, nor->addr_width);
 	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len, base + QUADSPI_IPCR);
 
 	/* Wait for the interrupt. */
@@ -550,7 +551,7 @@ static int fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
 	}
 
 	/* Trigger it */
-	ret = fsl_qspi_runcmd(q, opcode, to, count);
+	ret = fsl_qspi_runcmd(nor, opcode, to, count);
 
 	if (ret == 0 && retlen)
 		*retlen += count;
@@ -560,13 +561,17 @@ static int fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
 
 static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
 {
-	int nor_size = q->nor_size;
 	void __iomem *base = q->iobase;
-
-	writel(nor_size + q->memmap_phy, base + QUADSPI_SFA1AD);
-	writel(nor_size * 2 + q->memmap_phy, base + QUADSPI_SFA2AD);
-	writel(nor_size * 3 + q->memmap_phy, base + QUADSPI_SFB1AD);
-	writel(nor_size * 4 + q->memmap_phy, base + QUADSPI_SFB2AD);
+	int offset = 0;
+
+	offset += q->nor_size[0];
+	writel(q->memmap_phy + offset, base + QUADSPI_SFA1AD);
+	offset += q->nor_size[1];
+	writel(q->memmap_phy + offset, base + QUADSPI_SFA2AD);
+	offset += q->nor_size[2];
+	writel(q->memmap_phy + offset, base + QUADSPI_SFB1AD);
+	offset += q->nor_size[3];
+	writel(q->memmap_phy + offset, base + QUADSPI_SFB2AD);
 }
 
 /*
@@ -585,7 +590,6 @@ static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
 static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
-	int seqid;
 
 	/* AHB configuration for access buffer 0/1/2 .*/
 	writel(QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF0CR);
@@ -602,12 +606,6 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 	writel(0, base + QUADSPI_BUF0IND);
 	writel(0, base + QUADSPI_BUF1IND);
 	writel(0, base + QUADSPI_BUF2IND);
-
-	/* Set the default lut sequence for AHB Read. */
-	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode,
-			q->nor[0].addr_width);
-	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
-			q->iobase + QUADSPI_BFGENCR);
 }
 
 /* We use this function to do some basic init for spi_nor_scan(). */
@@ -639,6 +637,15 @@ static int fsl_qspi_nor_setup(struct fsl_qspi *q)
 	writel(QUADSPI_MCR_RESERVED_MASK | QUADSPI_MCR_END_CFG_MASK,
 			base + QUADSPI_MCR);
 
+	/*
+	 * Set up a "dummy" address mapping that can be used to access chips
+	 * at each CSn during probe.
+	 */
+	writel(q->memmap_phy + 1 * SZ_4K, base + QUADSPI_SFA1AD);
+	writel(q->memmap_phy + 2 * SZ_4K, base + QUADSPI_SFA2AD);
+	writel(q->memmap_phy + 3 * SZ_4K, base + QUADSPI_SFB1AD);
+	writel(q->memmap_phy + 4 * SZ_4K, base + QUADSPI_SFB2AD);
+
 	/* enable the interrupt */
 	writel(QUADSPI_RSER_TFIE, q->iobase + QUADSPI_RSER);
 
@@ -663,15 +670,22 @@ MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
 
 static void fsl_qspi_set_base_addr(struct fsl_qspi *q, struct spi_nor *nor)
 {
-	q->chip_base_addr = q->nor_size * (nor - q->nor);
+	int nor_idx = nor - q->nor;
+	int base_addr = 0;
+	int i;
+
+	for (i = 0; i < nor_idx; i++)
+		base_addr += q->nor_size[i];
+
+	q->chip_base_addr = base_addr;
 }
 
 static int fsl_qspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 {
-	int ret;
 	struct fsl_qspi *q = nor->priv;
+	int ret;
 
-	ret = fsl_qspi_runcmd(q, opcode, 0, len);
+	ret = fsl_qspi_runcmd(nor, opcode, 0, len);
 	if (ret)
 		return ret;
 
@@ -680,13 +694,13 @@ static int fsl_qspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 }
 
 static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
-			int write_enable)
+		int write_enable)
 {
 	struct fsl_qspi *q = nor->priv;
 	int ret;
 
 	if (!buf) {
-		ret = fsl_qspi_runcmd(q, opcode, 0, 1);
+		ret = fsl_qspi_runcmd(nor, opcode, 0, 1);
 		if (ret)
 			return ret;
 
@@ -704,8 +718,8 @@ static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 	return ret;
 }
 
-static void fsl_qspi_write(struct spi_nor *nor, loff_t to,
-		size_t len, size_t *retlen, const u_char *buf)
+static void fsl_qspi_write(struct spi_nor *nor, loff_t to, size_t len,
+		size_t *retlen, const u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
 
@@ -716,15 +730,24 @@ static void fsl_qspi_write(struct spi_nor *nor, loff_t to,
 	fsl_qspi_invalid(q);
 }
 
-static int fsl_qspi_read(struct spi_nor *nor, loff_t from,
-		size_t len, size_t *retlen, u_char *buf)
+static int fsl_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
+		size_t *retlen, u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
 	u8 cmd = nor->read_opcode;
+	int seqid;
 
 	dev_dbg(q->dev, "cmd [%x],read from (0x%p, 0x%.8x, 0x%.8x),len:%d\n",
 		cmd, q->ahb_base, q->chip_base_addr, (unsigned int)from, len);
 
+	/*
+	 * Set the appropriate LUT sequence for an "AHB Read" from this
+	 * particular NOR device.
+	 */
+	seqid = fsl_qspi_get_seqid(q, nor->read_opcode, nor->addr_width);
+	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
+			q->iobase + QUADSPI_BFGENCR);
+
 	/* Read out the data directly from the AHB buffer.*/
 	memcpy(buf, q->ahb_base + q->chip_base_addr + from, len);
 
@@ -740,7 +763,7 @@ static int fsl_qspi_erase(struct spi_nor *nor, loff_t offs)
 	dev_dbg(nor->dev, "%dKiB at 0x%08x:0x%08x\n",
 		nor->mtd->erasesize / 1024, q->chip_base_addr, (u32)offs);
 
-	ret = fsl_qspi_runcmd(q, nor->erase_opcode, offs, 0);
+	ret = fsl_qspi_runcmd(nor, nor->erase_opcode, offs, 0);
 	if (ret)
 		return ret;
 
@@ -804,10 +827,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (!q)
 		return -ENOMEM;
 
-	q->nor_num = of_get_child_count(dev->of_node);
-	if (!q->nor_num || q->nor_num > FSL_QSPI_MAX_CHIP)
-		return -ENODEV;
-
 	/* find the resources */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "QuadSPI");
 	q->iobase = devm_ioremap_resource(dev, res);
@@ -861,20 +880,11 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	q->devtype_data = (struct fsl_qspi_devtype_data *)of_id->data;
 	platform_set_drvdata(pdev, q);
 
-	ret = fsl_qspi_nor_setup(q);
-	if (ret)
-		goto irq_failed;
-
-	if (of_get_property(np, "fsl,qspi-has-second-chip", NULL))
-		q->has_second_chip = true;
-
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
-		char modalias[40];
-
-		/* skip the holes */
-		if (!q->has_second_chip)
-			i *= 2;
+		ret = of_property_read_u32(np, "reg", &i);
+		if (ret || i >= FSL_QSPI_MAX_CHIP)
+			goto irq_failed;
 
 		nor = &q->nor[i];
 		mtd = &q->mtd[i];
@@ -894,7 +904,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		nor->prepare = fsl_qspi_prep;
 		nor->unprepare = fsl_qspi_unprep;
 
-		ret = of_modalias_node(np, modalias, sizeof(modalias));
+		ret = of_modalias_node(np, q->modalias[i], MODALIAS_NBYTES);
 		if (ret < 0)
 			goto irq_failed;
 
@@ -902,26 +912,39 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 				&q->clk_rate[i]);
 		if (ret < 0)
 			goto irq_failed;
+	}
 
-		/* set the chip address for READID */
-		fsl_qspi_set_base_addr(q, nor);
+	/* Set up temporary 4 KiB mappings for use in second-pass probe. */
+	ret = fsl_qspi_nor_setup(q);
+	if (ret)
+		goto irq_failed;
+
+	for_each_available_child_of_node(dev->of_node, np) {
+		ret = of_property_read_u32(np, "reg", &i);
+		if (ret || i >= FSL_QSPI_MAX_CHIP)
+			goto pass2_failed;
+
+		nor = &q->nor[i];
+		mtd = &q->mtd[i];
 
-		ret = spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
+		/*
+		 * Set a chip address (based on temporary 4 KiB mappings) to
+		 * allow a READID operation to each CSn.
+		 */
+		q->chip_base_addr = i * SZ_4K;
+
+		ret = spi_nor_scan(nor, q->modalias[i], SPI_NOR_QUAD);
 		if (ret)
-			goto irq_failed;
+			goto pass2_failed;
 
 		ppdata.of_node = np;
 		ret = mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
 		if (ret)
-			goto irq_failed;
+			goto pass2_failed;
 
 		/* Set the correct NOR size now. */
-		if (q->nor_size == 0) {
-			q->nor_size = mtd->size;
-
-			/* Map the SPI NOR to accessiable address */
-			fsl_qspi_set_map_addr(q);
-		}
+		if (q->nor_size[i] == 0)
+			q->nor_size[i] = mtd->size;
 
 		/*
 		 * The TX FIFO is 64 bytes in the Vybrid, but the Page Program
@@ -934,10 +957,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		 */
 		if (nor->page_size > q->devtype_data->txfifo)
 			nor->page_size = q->devtype_data->txfifo;
-
-		i++;
 	}
 
+	/*
+	 * Now that all chips have been probed, map the SPI NOR(s) to
+	 * accessible addresses.
+	 */
+	fsl_qspi_set_map_addr(q);
+
 	/* finish the rest init. */
 	fsl_qspi_nor_setup_last(q);
 
@@ -945,6 +972,15 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	clk_disable(q->clk_en);
 	return 0;
 
+pass2_failed:
+	/* Ensure that hardware is disabled before purging MTD devices. */
+	writel(QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+	writel(0x0, q->iobase + QUADSPI_RSER);
+
+	for (i = 0; i < FSL_QSPI_MAX_CHIP; i++) {
+		if (q->mtd[i].type)
+			mtd_device_unregister(&q->mtd[i]);
+	}
 irq_failed:
 	clk_disable_unprepare(q->clk);
 clk_failed:
@@ -957,17 +993,15 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 	struct fsl_qspi *q = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < q->nor_num; i++) {
-		/* skip the holes */
-		if (!q->has_second_chip)
-			i *= 2;
-		mtd_device_unregister(&q->mtd[i]);
-	}
-
 	/* disable the hardware */
 	writel(QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
 	writel(0x0, q->iobase + QUADSPI_RSER);
 
+	for (i = 0; i < FSL_QSPI_MAX_CHIP; i++) {
+		if (q->mtd[i].type)
+			mtd_device_unregister(&q->mtd[i]);
+	}
+
 	clk_unprepare(q->clk);
 	clk_unprepare(q->clk_en);
 	return 0;
-- 
2.3.6

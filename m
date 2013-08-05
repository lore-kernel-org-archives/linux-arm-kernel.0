From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 5 Aug 2013 19:14:36 +0800
Subject: [PATCH 4/6] mtd: atmel_nand: enable Nand Flash Controller (NFC) read
 data via sram
In-Reply-To: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
References: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1375701279-11495-5-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFC has embedded sram which can use to transfer data. This patch enable reading
nand flash via NFC SRAM. It will minimize the CPU overhead.

This driver has been tested on SAMA5D3X-EK with JFFS2, YAFFS2, UBIFS and
mtd-utils.

Here puts the part of mtd_speedtest (read test) result as following:
Compare with non-NFC mtd_speedtest result, reading will reduce %45 cpu load
with increase %80 speed.

- commands use to test:
  # insmod /mnt/mtd_speedtest.ko dev=2 &
  # top -n 30 -d 1 | grep speedtest

- test result:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
mtd_speedtest: testing eraseblock read speed
  509   495 root     D     1164   0%  28% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  25% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  26% insmod /mnt/mtd_speedtest.ko dev=2
mtd_speedtest: eraseblock read speed is 9403 KiB/s
mtd_speedtest: testing page read speed
  509   495 root     R     1164   0%  31% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  57% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  53% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  71% insmod /mnt/mtd_speedtest.ko dev=2
mtd_speedtest: page read speed is 9258 KiB/s

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
v3 --> v4:
  - use BIT_POS definition not magical number.

v2 --> v3:
  - if NFC sram address and size is specified then enable NFC sram read.
    Otherwise disable NFC sram read.

 drivers/mtd/nand/atmel_nand.c |  163 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9e0f95d..1905aa6 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -93,9 +93,13 @@ struct atmel_nfc {
 	void __iomem		*hsmc_regs;
 	void __iomem		*sram_bank0;
 	dma_addr_t		sram_bank0_phys;
+	bool			use_nfc_sram;
 
 	bool			is_initialized;
 	struct completion	comp_nfc;
+
+	/* Point to the sram bank which include readed data via NFC */
+	void __iomem		*data_in_sram;
 };
 static struct atmel_nfc	nand_nfc;
 
@@ -247,21 +251,43 @@ static int atmel_nand_set_enable_ready_pins(struct mtd_info *mtd)
 	return res;
 }
 
+static void memcpy32_fromio(void *trg, const void __iomem  *src, size_t size)
+{
+	int i;
+	u32 *t = trg;
+	const __iomem u32 *s = src;
+
+	for (i = 0; i < (size >> 2); i++)
+		*t++ = readl_relaxed(s++);
+}
+
 /*
  * Minimal-overhead PIO for data access.
  */
 static void atmel_read_buf8(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host *host = nand_chip->priv;
 
-	__raw_readsb(nand_chip->IO_ADDR_R, buf, len);
+	if (host->nfc && host->nfc->use_nfc_sram && host->nfc->data_in_sram) {
+		memcpy32_fromio(buf, host->nfc->data_in_sram, len);
+		host->nfc->data_in_sram += len;
+	} else {
+		__raw_readsb(nand_chip->IO_ADDR_R, buf, len);
+	}
 }
 
 static void atmel_read_buf16(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host *host = nand_chip->priv;
 
-	__raw_readsw(nand_chip->IO_ADDR_R, buf, len / 2);
+	if (host->nfc && host->nfc->use_nfc_sram && host->nfc->data_in_sram) {
+		memcpy32_fromio(buf, host->nfc->data_in_sram, len);
+		host->nfc->data_in_sram += len;
+	} else {
+		__raw_readsw(nand_chip->IO_ADDR_R, buf, len / 2);
+	}
 }
 
 static void atmel_write_buf8(struct mtd_info *mtd, const u8 *buf, int len)
@@ -283,6 +309,40 @@ static void dma_complete_func(void *completion)
 	complete(completion);
 }
 
+static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
+{
+	/* NFC only has two banks. Must be 0 or 1 */
+	if (bank > 1)
+		return -EINVAL;
+
+	if (bank) {
+		/* Only for a 2k-page or lower flash, NFC can handle 2 banks */
+		if (host->mtd.writesize > 2048)
+			return -EINVAL;
+		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
+	} else {
+		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK0);
+	}
+
+	return 0;
+}
+
+static uint nfc_get_sram_off(struct atmel_nand_host *host)
+{
+	if (nfc_readl(host->nfc->hsmc_regs, BANK) & ATMEL_HSMC_NFC_BANK1)
+		return NFC_SRAM_BANK1_OFFSET;
+	else
+		return 0;
+}
+
+static dma_addr_t nfc_sram_phys(struct atmel_nand_host *host)
+{
+	if (nfc_readl(host->nfc->hsmc_regs, BANK) & ATMEL_HSMC_NFC_BANK1)
+		return host->nfc->sram_bank0_phys + NFC_SRAM_BANK1_OFFSET;
+	else
+		return host->nfc->sram_bank0_phys;
+}
+
 static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 			       int is_read)
 {
@@ -296,6 +356,7 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 	void *p = buf;
 	int err = -EIO;
 	enum dma_data_direction dir = is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	struct atmel_nfc *nfc = host->nfc;
 
 	if (buf >= high_memory)
 		goto err_buf;
@@ -312,7 +373,12 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 	}
 
 	if (is_read) {
-		dma_src_addr = host->io_phys;
+		if (nfc && nfc->data_in_sram)
+			dma_src_addr = nfc_sram_phys(host) + (nfc->data_in_sram
+				- (nfc->sram_bank0 + nfc_get_sram_off(host)));
+		else
+			dma_src_addr = host->io_phys;
+
 		dma_dst_addr = phys_addr;
 	} else {
 		dma_src_addr = phys_addr;
@@ -339,6 +405,10 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 	dma_async_issue_pending(host->dma_chan);
 	wait_for_completion(&host->comp);
 
+	if (is_read && nfc && nfc->data_in_sram)
+		/* After read data from SRAM, need to increase the position */
+		nfc->data_in_sram += len;
+
 	err = 0;
 
 err_dma:
@@ -850,7 +920,8 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	unsigned long end_time;
 	int bitflips = 0;
 
-	pmecc_enable(host, NAND_ECC_READ);
+	if (!host->nfc || !host->nfc->use_nfc_sram)
+		pmecc_enable(host, NAND_ECC_READ);
 
 	chip->read_buf(mtd, buf, eccsize);
 	chip->read_buf(mtd, oob, mtd->oobsize);
@@ -1666,6 +1737,7 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 	unsigned int addr1234 = 0;
 	unsigned int cycle0 = 0;
 	bool do_addr = true;
+	host->nfc->data_in_sram = NULL;
 
 	dev_dbg(host->dev, "%s: cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
 	     __func__, command, column, page_addr);
@@ -1707,6 +1779,16 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 			command = NAND_CMD_READ0; /* only READ0 is valid */
 			cmd1 = command << NFCADDR_CMD_CMD1_BIT_POS;
 		}
+		if (host->nfc->use_nfc_sram) {
+			/* Enable Data transfer to sram */
+			dataen = NFCADDR_CMD_DATAEN;
+
+			/* Need enable PMECC now, since NFC will transfer
+			 * data in bus after sending nfc read command.
+			 */
+			if (chip->ecc.mode == NAND_ECC_HW && host->has_pmecc)
+				pmecc_enable(host, NAND_ECC_READ);
+		}
 
 		cmd2 = NAND_CMD_READSTART << NFCADDR_CMD_CMD2_BIT_POS;
 		vcmd2 = NFCADDR_CMD_VCMD2;
@@ -1728,6 +1810,10 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 	nfc_addr_cmd = cmd1 | cmd2 | vcmd2 | acycle | csid | dataen | nfcwr;
 	nfc_send_command(host, nfc_addr_cmd, addr1234, cycle0);
 
+	if (dataen == NFCADDR_CMD_DATAEN)
+		if (nfc_wait_interrupt(host, NFC_SR_XFR_DONE))
+			dev_err(host->dev, "something wrong, No XFR_DONE interrupt comes.\n");
+
 	/*
 	 * Program and erase have their own busy handlers status, sequential
 	 * in, and deplete1 need no delay.
@@ -1745,12 +1831,66 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 		return;
 
 	case NAND_CMD_READ0:
+		if (dataen == NFCADDR_CMD_DATAEN) {
+			host->nfc->data_in_sram = host->nfc->sram_bank0 +
+				nfc_get_sram_off(host);
+			return;
+		}
 		/* fall through */
 	default:
 		nfc_wait_interrupt(host, NFC_SR_RB_EDGE);
 	}
 }
 
+static int nfc_sram_init(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct atmel_nand_host *host = chip->priv;
+	int res = 0;
+
+	/* Initialize the NFC CFG register */
+	unsigned int cfg_nfc = 0;
+
+	/* set page size and oob layout */
+	switch (mtd->writesize) {
+	case 512:
+		cfg_nfc = NFC_CFG_PAGESIZE_512;
+		break;
+	case 1024:
+		cfg_nfc = NFC_CFG_PAGESIZE_1024;
+		break;
+	case 2048:
+		cfg_nfc = NFC_CFG_PAGESIZE_2048;
+		break;
+	case 4096:
+		cfg_nfc = NFC_CFG_PAGESIZE_4096;
+		break;
+	case 8192:
+		cfg_nfc = NFC_CFG_PAGESIZE_8192;
+		break;
+	default:
+		dev_err(host->dev, "Unsupported page size for NFC.\n");
+		res = -ENXIO;
+		return res;
+	}
+
+	/* oob bytes size = (NFCSPARESIZE + 1) * 4
+	 * Max support spare size is 512 bytes. */
+	cfg_nfc |= (((mtd->oobsize / 4) - 1) << NFC_CFG_NFC_SPARESIZE_BIT_POS
+		& NFC_CFG_NFC_SPARESIZE);
+	/* default set a max timeout */
+	cfg_nfc |= NFC_CFG_RSPARE |
+			NFC_CFG_NFC_DTOCYC | NFC_CFG_NFC_DTOMUL;
+
+	nfc_writel(host->nfc->hsmc_regs, CFG, cfg_nfc);
+
+	nfc_set_sram_bank(host, 0);
+
+	dev_info(host->dev, "Using NFC Sram read\n");
+
+	return 0;
+}
+
 static struct platform_driver atmel_nand_nfc_driver;
 /*
  * Probe for the NAND device.
@@ -1912,6 +2052,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			goto err_hw_ecc;
 	}
 
+	/* initialize the nfc configuration register */
+	if (host->nfc && host->nfc->use_nfc_sram) {
+		res = nfc_sram_init(mtd);
+		if (res) {
+			host->nfc->use_nfc_sram = false;
+			dev_err(host->dev, "Disable use nfc sram for data transfer.\n");
+		}
+	}
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		res = -ENXIO;
@@ -1992,11 +2141,13 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 	nfc_sram = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	if (nfc_sram) {
 		nfc->sram_bank0 = devm_ioremap_resource(&pdev->dev, nfc_sram);
-		if (IS_ERR(nfc->sram_bank0))
+		if (IS_ERR(nfc->sram_bank0)) {
 			dev_warn(&pdev->dev, "Fail to ioremap the NFC sram with error: %ld. So disable NFC sram.\n",
 					PTR_ERR(nfc->sram_bank0));
-		else
+		} else {
+			nfc->use_nfc_sram = true;
 			nfc->sram_bank0_phys = (dma_addr_t)nfc_sram->start;
+		}
 	}
 
 	nfc->is_initialized = true;
-- 
1.7.9.5

From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 3 Jul 2013 17:50:33 +0800
Subject: [PATCH 5/6] mtd: atmel_nand: enable Nand Flash Controller (NFC) write
 via sram
In-Reply-To: <1372845034-5579-1-git-send-email-josh.wu@atmel.com>
References: <1372845034-5579-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1372845034-5579-6-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enable writing nand flash via NFC SRAM. It will minimize the CPU
overhead. The SRAM write only support ECC_NONE and ECC_HW with PMECC.

To enable this NFC write by SRAM feature, you can add a string in dts under
NFC driver node.

This driver has been tested on SAMA5D3X-EK with JFFS2, YAFFS2, UBIFS and
mtd-utils.

Here is part of mtd_speedtest (writing test) result, compare with non-NFC
writing, it reduces %65 cpu load with loss %12 speed.

- commands use to test:
  # insmod /mnt/mtd_speedtest.ko dev=2 &
  # top -n 30 -d 1 | grep speedtest

- test result:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
mtd_speedtest: testing eraseblock write speed
  509   495 root     D     1164   0%   7% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%   8% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     R     1164   0%   5% insmod /mnt/mtd_speedtest.ko dev=2
mtd_speedtest: eraseblock write speed is 5194 KiB/s
mtd_speedtest: testing page write speed
  509   495 root     D     1164   0%  32% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  27% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  25% insmod /mnt/mtd_speedtest.ko dev=2
  509   495 root     D     1164   0%  30% insmod /mnt/mtd_speedtest.ko dev=2
mtd_speedtest: page write speed is 5024 KiB/s

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
v3 --> v4:
  - no blank line change.

v2 --> v3:
  - use a property of NFC node to enable/disable NFC write via sram.

 .../devicetree/bindings/mtd/atmel-nand.txt         |    2 +
 drivers/mtd/nand/atmel_nand.c                      |  106 +++++++++++++++++++-
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 5d8b7d5..c472883 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -36,6 +36,8 @@ Optional properties:
     - reg : should specify the address and size used for NFC command registers,
             NFC registers and NFC Sram. NFC Sram address and size can be absent
             if don't want to use it.
+  - Optional properties:
+    - atmel,write-by-sram: boolean to enable NFC write by sram.
 
 Examples:
 nand0: nand at 40000000,0 {
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 7e14dbe..a784704 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -95,12 +95,14 @@ struct atmel_nfc {
 	void __iomem		*sram_bank0;
 	dma_addr_t		sram_bank0_phys;
 	bool			use_nfc_sram;
+	bool			write_by_sram;
 
 	bool			is_initialized;
 	struct completion	comp_nfc;
 
 	/* Point to the sram bank which include readed data via NFC */
 	void __iomem		*data_in_sram;
+	bool			will_write_sram;
 };
 static struct atmel_nfc	nand_nfc;
 
@@ -262,6 +264,16 @@ static void memcpy32_fromio(void *trg, const void __iomem  *src, size_t size)
 		*t++ = readl_relaxed(s++);
 }
 
+static void memcpy32_toio(void __iomem *trg, const void *src, int size)
+{
+	int i;
+	u32 __iomem *t = trg;
+	const u32 *s = src;
+
+	for (i = 0; i < (size >> 2); i++)
+		writel_relaxed(*s++, t++);
+}
+
 /*
  * Minimal-overhead PIO for data access.
  */
@@ -383,7 +395,11 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 		dma_dst_addr = phys_addr;
 	} else {
 		dma_src_addr = phys_addr;
-		dma_dst_addr = host->io_phys;
+
+		if (nfc && nfc->write_by_sram)
+			dma_dst_addr = nfc_sram_phys(host);
+		else
+			dma_dst_addr = host->io_phys;
 	}
 
 	tx = dma_dev->device_prep_dma_memcpy(host->dma_chan, dma_dst_addr,
@@ -955,9 +971,10 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 	int i, j;
 	unsigned long end_time;
 
-	pmecc_enable(host, NAND_ECC_WRITE);
-
-	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
+	if (!host->nfc || !host->nfc->write_by_sram) {
+		pmecc_enable(host, NAND_ECC_WRITE);
+		chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
+	}
 
 	end_time = jiffies + msecs_to_jiffies(PMECC_MAX_TIMEOUT_MS);
 	while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
@@ -1799,6 +1816,8 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 	case NAND_CMD_SEQIN:
 	case NAND_CMD_RNDIN:
 		nfcwr = NFCADDR_CMD_NFCWR;
+		if (host->nfc->will_write_sram && command == NAND_CMD_SEQIN)
+			dataen = NFCADDR_CMD_DATAEN;
 		break;
 	default:
 		break;
@@ -1843,6 +1862,68 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 	}
 }
 
+static int nfc_sram_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+			uint32_t offset, int data_len, const uint8_t *buf,
+			int oob_required, int page, int cached, int raw)
+{
+	int cfg, len;
+	int status = 0;
+	struct atmel_nand_host *host = chip->priv;
+	void __iomem *sram = host->nfc->sram_bank0 + nfc_get_sram_off(host);
+
+	/* Subpage write is not supported */
+	if (offset || (data_len < mtd->writesize))
+		return -EINVAL;
+
+	cfg = nfc_readl(host->nfc->hsmc_regs, CFG);
+	len = mtd->writesize;
+
+	if (unlikely(raw)) {
+		len += mtd->oobsize;
+		nfc_writel(host->nfc->hsmc_regs, CFG, cfg | NFC_CFG_WSPARE);
+	} else
+		nfc_writel(host->nfc->hsmc_regs, CFG, cfg & ~NFC_CFG_WSPARE);
+
+	/* Copy page data to sram that will write to nand via NFC */
+	if (use_dma) {
+		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) != 0)
+			/* Fall back to use cpu copy */
+			memcpy32_toio(sram, buf, len);
+	} else {
+		memcpy32_toio(sram, buf, len);
+	}
+
+	if (chip->ecc.mode == NAND_ECC_HW && host->has_pmecc)
+		/*
+		 * When use NFC sram, need set up PMECC before send
+		 * NAND_CMD_SEQIN command. Since when the nand command
+		 * is sent, nfc will do transfer from sram and nand.
+		 */
+		pmecc_enable(host, NAND_ECC_WRITE);
+
+	host->nfc->will_write_sram = true;
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
+	host->nfc->will_write_sram = false;
+
+	if (likely(!raw))
+		/* Need to write ecc into oob */
+		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+
+	if (status < 0)
+		return status;
+
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+	status = chip->waitfunc(mtd, chip);
+
+	if ((status & NAND_STATUS_FAIL) && (chip->errstat))
+		status = chip->errstat(mtd, chip, FL_WRITING, status, page);
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+
 static int nfc_sram_init(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
@@ -1885,10 +1966,20 @@ static int nfc_sram_init(struct mtd_info *mtd)
 
 	nfc_writel(host->nfc->hsmc_regs, CFG, cfg_nfc);
 
+	host->nfc->will_write_sram = false;
 	nfc_set_sram_bank(host, 0);
 
-	dev_info(host->dev, "Using NFC Sram read\n");
+	/* Use Write page with NFC SRAM only for PMECC or ECC NONE. */
+	if (host->nfc->write_by_sram) {
+		if ((chip->ecc.mode == NAND_ECC_HW && host->has_pmecc) ||
+				chip->ecc.mode == NAND_ECC_NONE)
+			chip->write_page = nfc_sram_write_page;
+		else
+			host->nfc->write_by_sram = false;
+	}
 
+	dev_info(host->dev, "Using NFC Sram read %s\n",
+			host->nfc->write_by_sram ? "and write" : "");
 	return 0;
 }
 
@@ -2156,6 +2247,11 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 		} else {
 			nfc->use_nfc_sram = true;
 			nfc->sram_bank0_phys = (dma_addr_t)nfc_sram->start;
+
+			if (pdev->dev.of_node)
+				nfc->write_by_sram = of_property_read_bool(
+						pdev->dev.of_node,
+						"atmel,write-by-sram");
 		}
 	}
 
-- 
1.7.9.5

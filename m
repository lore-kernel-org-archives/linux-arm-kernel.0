From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 22:11:50 +0200
Subject: [PATCH v2 4/4] mtd: atmel_nand: enable Nand Flash Controller
 (NFC) write via sram
In-Reply-To: <1368784308-7600-5-git-send-email-josh.wu@atmel.com>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
 <1368784308-7600-5-git-send-email-josh.wu@atmel.com>
Message-ID: <20130524201150.GN24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:51 Fri 17 May     , Josh Wu wrote:
> This patch enable writing nand flash via NFC SRAM. It will minimize the CPU
> overhead. The SRAM write only support ECC_NONE and ECC_HW with PMECC.
> 
> This driver has been tested on SAMA5D3X-EK with JFFS2, YAFFS2, UBIFS and
> mtd-utils.
> 
> Here is part of mtd_speedtest (writing test) result, compare with non-NFC
> writing, it reduces %65 cpu load with loss %12 speed.

we may want to enable only read on sram and not write as the write speed can
be critic on some system

Best Regards,
J.
> 
> - commands use to test:
>   # insmod /mnt/mtd_speedtest.ko dev=2 &
>   # top -n 30 -d 1 | grep speedtest
> 
> - test result:
> =================================================
> mtd_speedtest: MTD device: 2
> mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
> mtd_speedtest: testing eraseblock write speed
>   509   495 root     D     1164   0%   7% insmod /mnt/mtd_speedtest.ko dev=2
>   509   495 root     D     1164   0%   8% insmod /mnt/mtd_speedtest.ko dev=2
>   509   495 root     R     1164   0%   5% insmod /mnt/mtd_speedtest.ko dev=2
> mtd_speedtest: eraseblock write speed is 5194 KiB/s
> mtd_speedtest: testing page write speed
>   509   495 root     D     1164   0%  32% insmod /mnt/mtd_speedtest.ko dev=2
>   509   495 root     D     1164   0%  27% insmod /mnt/mtd_speedtest.ko dev=2
>   509   495 root     D     1164   0%  25% insmod /mnt/mtd_speedtest.ko dev=2
>   509   495 root     D     1164   0%  30% insmod /mnt/mtd_speedtest.ko dev=2
> mtd_speedtest: page write speed is 5024 KiB/s
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v1 --> v2:
>   use NAND_ECC_WRITE instead of use new defined pass to pmecc_enable().
>   report a error if use a partial page write via nfc sram.
> 
>  drivers/mtd/nand/atmel_nand.c |   94 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index c10cd71..4490bd6 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -99,6 +99,7 @@ struct atmel_nfc {
>  
>  	/* Point to the sram bank which include readed data via NFC */
>  	void __iomem		*data_in_sram;
> +	bool			will_write_sram;
>  };
>  
>  struct atmel_nand_host {
> @@ -218,6 +219,16 @@ static void memcpy32_fromio(void *trg, const void __iomem  *src, size_t size)
>  		*t++ = readl_relaxed(s++);
>  }
>  
> +static void memcpy32_toio(void __iomem *trg, const void *src, int size)
> +{
> +	int i;
> +	u32 __iomem *t = trg;
> +	const u32 *s = src;
> +
> +	for (i = 0; i < (size >> 2); i++)
> +		writel_relaxed(*s++, t++);
> +}
> +
>  /*
>   * Minimal-overhead PIO for data access.
>   */
> @@ -339,7 +350,11 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
>  		dma_dst_addr = phys_addr;
>  	} else {
>  		dma_src_addr = phys_addr;
> -		dma_dst_addr = host->io_phys;
> +
> +		if (host->use_nfc_sram)
> +			dma_dst_addr = nfc_sram_phys(host);
> +		else
> +			dma_dst_addr = host->io_phys;
>  	}
>  
>  	tx = dma_dev->device_prep_dma_memcpy(host->dma_chan, dma_dst_addr,
> @@ -919,9 +934,10 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
>  	int i, j;
>  	unsigned long end_time;
>  
> -	pmecc_enable(host, NAND_ECC_WRITE);
> -
> -	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
> +	if (!host->use_nfc_sram) {
> +		pmecc_enable(host, NAND_ECC_WRITE);
> +		chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
> +	}
>  
>  	end_time = jiffies + msecs_to_jiffies(PMECC_MAX_TIMEOUT_MS);
>  	while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
> @@ -1805,6 +1821,8 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
>  	case NAND_CMD_SEQIN:
>  	case NAND_CMD_RNDIN:
>  		nfcwr = NFCADDR_CMD_NFCWR;
> +		if (host->nfc.will_write_sram && command == NAND_CMD_SEQIN)
> +			dataen = NFCADDR_CMD_DATAEN;
>  		break;
>  	default:
>  		break;
> @@ -1849,6 +1867,68 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
>  	}
>  }
>  
> +static int nfc_sram_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> +			uint32_t offset, int data_len, const uint8_t *buf,
> +			int oob_required, int page, int cached, int raw)
> +{
> +	int cfg, len;
> +	int status = 0;
> +	struct atmel_nand_host *host = chip->priv;
> +	void __iomem *sram = host->nfc.sram_bank0 + nfc_get_sram_off(host);
> +
> +	/* Subpage write is not supported */
> +	if (offset || (data_len < mtd->writesize))
> +		return -EINVAL;
> +
> +	cfg = nfc_readl(host->nfc.hsmc_regs, CFG);
> +	len = mtd->writesize;
> +
> +	if (unlikely(raw)) {
> +		len += mtd->oobsize;
> +		nfc_writel(host->nfc.hsmc_regs, CFG, cfg | ATMEL_HSMC_WSPARE);
> +	} else
> +		nfc_writel(host->nfc.hsmc_regs, CFG, cfg & ~ATMEL_HSMC_WSPARE);
> +
> +	/* Copy page data to sram that will write to nand via NFC */
> +	if (use_dma) {
> +		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) != 0)
> +			/* Fall back to use cpu copy */
> +			memcpy32_toio(sram, buf, len);
> +	} else {
> +		memcpy32_toio(sram, buf, len);
> +	}
> +
> +	if (chip->ecc.mode == NAND_ECC_HW && host->has_pmecc)
> +		/*
> +		 * When use NFC sram, need set up PMECC before send
> +		 * NAND_CMD_SEQIN command. Since when the nand command
> +		 * is sent, nfc will do transfer from sram and nand.
> +		 */
> +		pmecc_enable(host, NAND_ECC_WRITE);
> +
> +	host->nfc.will_write_sram = true;
> +	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
> +	host->nfc.will_write_sram = false;
> +
> +	if (likely(!raw))
> +		/* Need to write ecc into oob */
> +		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
> +
> +	if (status < 0)
> +		return status;
> +
> +	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
> +	status = chip->waitfunc(mtd, chip);
> +
> +	if ((status & NAND_STATUS_FAIL) && (chip->errstat))
> +		status = chip->errstat(mtd, chip, FL_WRITING, status, page);
> +
> +	if (status & NAND_STATUS_FAIL)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static int nfc_sram_init(struct mtd_info *mtd)
>  {
>  	struct nand_chip *chip = mtd->priv;
> @@ -1887,10 +1967,16 @@ static int nfc_sram_init(struct mtd_info *mtd)
>  
>  	nfc_writel(host->nfc.hsmc_regs, CFG, cfg_nfc);
>  
> +	host->nfc.will_write_sram = false;
>  	nfc_set_sram_bank(host, 0);
>  
>  	dev_info(host->dev, "Using NFC Sram\n");
>  
> +	/* Use Write page with NFC SRAM only for PMECC or ECC NONE. */
> +	if ((chip->ecc.mode == NAND_ECC_HW && host->has_pmecc) ||
> +			chip->ecc.mode == NAND_ECC_NONE)
> +		chip->write_page = nfc_sram_write_page;
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 

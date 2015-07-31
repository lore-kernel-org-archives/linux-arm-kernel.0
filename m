From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 31 Jul 2015 16:09:01 -0700
Subject: [PATCH v9 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1438361581-2702-3-git-send-email-stefan@agner.ch>
References: <1438361581-2702-1-git-send-email-stefan@agner.ch>
 <1438361581-2702-3-git-send-email-stefan@agner.ch>
Message-ID: <20150731230901.GK10676@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Again, this patch doesn't seem to have made it to the public mailing
lists. Entire context left intact:

On Fri, Jul 31, 2015 at 06:52:58PM +0200, Stefan Agner wrote:
> This adds hardware ECC support using the BCH encoder in the NFC IP.
> The ECC encoder supports up to 32-bit correction by using 60 error
> correction bytes. There is no sub-page ECC step, ECC is calculated
> always accross the whole page (up to 2k pages). Raw writes writes
> are possible through the common nand_write_page_raw implementation,
> however raw reads are not possible since the hardware ECC mode need
> to be enabled at command time.
> 
> Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mtd/nand/Kconfig     |   6 +-
>  drivers/mtd/nand/vf610_nfc.c | 201 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 204 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 8550b14..e05f53c 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -469,8 +469,10 @@ config MTD_NAND_VF610_NFC
>  	help
>  	  Enables support for NAND Flash Controller on some Freescale
>  	  processors like the VF610, MPC5125, MCF54418 or Kinetis K70.
> -	  The driver supports a maximum 2k page size. The driver
> -	  currently does not support hardware ECC.
> +	  The driver supports a maximum 2k page size. With 2k pages and
> +	  64 bytes or more of OOB, hardware ECC with up to 32-bit error
> +	  correction is supported. Hardware ECC is only enabled through
> +	  device tree.
>  
>  config MTD_NAND_MXC
>  	tristate "MXC NAND support"
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index d9fc73f..b87841c 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -19,6 +19,8 @@
>   * - Untested on MPC5125 and M54418.
>   * - DMA not used.
>   * - 2K pages or less.
> + * - Only 2K page w. 64+ OOB and hardware ECC.
> + * - Raw page reads not implemented when using ECC.
>   */
>  
>  #include <linux/module.h>
> @@ -72,6 +74,8 @@
>  
>  /* NFC ECC mode define */
>  #define ECC_BYPASS			0
> +#define ECC_45_BYTE			6
> +#define ECC_60_BYTE			7
>  
>  /*** Register Mask and bit definitions */
>  
> @@ -104,6 +108,8 @@
>  #define STATUS_BYTE1_MASK			0x000000FF
>  
>  /* NFC_FLASH_CONFIG Field */
> +#define CONFIG_ECC_SRAM_ADDR_MASK		0x7FC00000
> +#define CONFIG_ECC_SRAM_ADDR_SHIFT		22
>  #define CONFIG_ECC_SRAM_REQ_BIT			(1<<21)
>  #define CONFIG_DMA_REQ_BIT			(1<<20)
>  #define CONFIG_ECC_MODE_MASK			0x000E0000
> @@ -122,6 +128,21 @@
>  #define CMD_DONE_CLEAR_BIT			(1<<18)
>  #define IDLE_CLEAR_BIT				(1<<17)
>  
> +/* ECC status placed at end of buffers. */
> +#define ECC_SRAM_ADDR	((PAGE_2K + 256 - 8) >> 3)
> +#define ECC_STATUS_MASK	0x80
> +#define ECC_ERR_COUNT	0x3F
> +
> +/*
> + * ECC status is stored at NFC_CFG[ECCADD] +4 for little-endian
> + * and +7 for big-endian SoCs.
> + */
> +#ifdef __LITTLE_ENDIAN
> +#define ECC_OFFSET	4
> +#else
> +#define ECC_OFFSET	7
> +#endif
> +
>  struct vf610_nfc {
>  	struct mtd_info mtd;
>  	struct nand_chip chip;
> @@ -136,10 +157,40 @@ struct vf610_nfc {
>  #define ALT_BUF_STAT 2
>  #define ALT_BUF_ONFI 3
>  	struct clk *clk;
> +	bool use_hw_ecc;
> +	u32 ecc_mode;
>  };
>  
>  #define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
>  
> +static struct nand_ecclayout vf610_nfc_ecc45 = {
> +	.eccbytes = 45,
> +	.eccpos = {19, 20, 21, 22, 23,
> +		   24, 25, 26, 27, 28, 29, 30, 31,
> +		   32, 33, 34, 35, 36, 37, 38, 39,
> +		   40, 41, 42, 43, 44, 45, 46, 47,
> +		   48, 49, 50, 51, 52, 53, 54, 55,
> +		   56, 57, 58, 59, 60, 61, 62, 63},
> +	.oobfree = {
> +		{.offset = 2,
> +		 .length = 17} }
> +};
> +
> +static struct nand_ecclayout vf610_nfc_ecc60 = {
> +	.eccbytes = 60,
> +	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
> +		   12, 13, 14, 15, 16, 17, 18, 19,
> +		   20, 21, 22, 23, 24, 25, 26, 27,
> +		   28, 29, 30, 31, 32, 33, 34, 35,
> +		   36, 37, 38, 39, 40, 41, 42, 43,
> +		   44, 45, 46, 47, 48, 49, 50, 51,
> +		   52, 53, 54, 55, 56, 57, 58, 59,
> +		   60, 61, 62, 63 },
> +	.oobfree = {
> +		{.offset = 2,
> +		 .length = 2} }
> +};
> +
>  static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
>  {
>  	return readl(nfc->regs + reg);
> @@ -281,6 +332,13 @@ static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
>  				    ROW_ADDR_SHIFT, page);
>  }
>  
> +static inline void vf610_nfc_ecc_mode(struct vf610_nfc *nfc, int ecc_mode)
> +{
> +	vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
> +			    CONFIG_ECC_MODE_MASK,
> +			    CONFIG_ECC_MODE_SHIFT, ecc_mode);
> +}
> +
>  static inline void vf610_nfc_transfer_size(struct vf610_nfc *nfc, int size)
>  {
>  	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, size);
> @@ -299,13 +357,20 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
>  	case NAND_CMD_SEQIN:
>  		/* Use valid column/page from preread... */
>  		vf610_nfc_addr_cycle(nfc, column, page);
> +		nfc->buf_offset = 0;
> +
>  		/*
>  		 * SEQIN => data => PAGEPROG sequence is done by the controller
>  		 * hence we do not need to issue the command here...
>  		 */
>  		return;
>  	case NAND_CMD_PAGEPROG:
> -		page_sz += mtd->writesize + mtd->oobsize;
> +		page_sz += nfc->page_sz;
> +		if (nfc->use_hw_ecc)
> +			vf610_nfc_ecc_mode(nfc, nfc->ecc_mode);
> +		else
> +			vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
> +
>  		vf610_nfc_transfer_size(nfc, page_sz);
>  		vf610_nfc_send_commands(nfc, NAND_CMD_SEQIN,
>  					command, PROGRAM_PAGE_CMD_CODE);
> @@ -323,11 +388,13 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
>  		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
>  					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
>  		vf610_nfc_addr_cycle(nfc, column, page);
> +		vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
>  		break;
>  
>  	case NAND_CMD_READ0:
>  		page_sz += mtd->writesize + mtd->oobsize;
>  		vf610_nfc_transfer_size(nfc, page_sz);
> +		vf610_nfc_ecc_mode(nfc, nfc->ecc_mode);
>  		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
>  					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
>  		vf610_nfc_addr_cycle(nfc, column, page);
> @@ -339,6 +406,7 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
>  		vf610_nfc_send_command(nfc, command, READ_ONFI_PARAM_CMD_CODE);
>  		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
>  				    ROW_ADDR_SHIFT, column);
> +		vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
>  		break;
>  
>  	case NAND_CMD_ERASE1:
> @@ -367,6 +435,9 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
>  	}
>  
>  	vf610_nfc_done(nfc);
> +
> +	nfc->use_hw_ecc = false;
> +	nfc->page_sz = 0;
>  }
>  
>  static void vf610_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int len)
> @@ -392,6 +463,7 @@ static void vf610_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
>  	l = min_t(uint, len, mtd->writesize + mtd->oobsize - c);
>  	vf610_nfc_memcpy(nfc->regs + NFC_MAIN_AREA(0) + c, buf, l);
>  
> +	nfc->page_sz += l;
>  	nfc->buf_offset += l;
>  }
>  
> @@ -459,6 +531,84 @@ static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
>  #endif
>  }
>  
> +/* Count the number of 0's in buff up to max_bits */
> +static inline int count_written_bits(uint8_t *buff, int size, int max_bits)
> +{
> +	uint32_t *buff32 = (uint32_t *)buff;
> +	int k, written_bits = 0;
> +
> +	for (k = 0; k < (size / 4); k++) {
> +		written_bits += hweight32(~buff32[k]);
> +		if (written_bits > max_bits)
> +			break;
> +	}
> +
> +	return written_bits;
> +}
> +
> +static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat)
> +{
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +	u8 ecc_status;
> +	u8 ecc_count;
> +	int flip;
> +
> +	ecc_status = __raw_readb(nfc->regs + ECC_SRAM_ADDR * 8 + ECC_OFFSET);
> +	ecc_count = ecc_status & ECC_ERR_COUNT;
> +	if (!(ecc_status & ECC_STATUS_MASK))
> +		return ecc_count;
> +
> +	/*
> +	 * On an erased page, bit count should be zero or at least
> +	 * less then half of the ECC strength
> +	 */
> +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);

Sorry I didn't notice this earlier, but it appears you are falling into
the same trap that almost everyone else is -- it is not sufficient to
check just the page area; you also need to check the OOB. Suppose that
a MTD user wrote mostly-0xff data to the page, then the page accumulates
bitflips in the spare area and a few in the page area, such that
eventually HW ECC can't correct them. If there are few enough zero bits
in the data area, you will mistakenly think that this is a blank page
below, and memset() it to 0xff. That would be disastrous!

Fortunately, your code is otherwise quite well structured and looks
good. A tip below.

> +
> +	if (flip > ecc_count && flip > (nfc->chip.ecc.strength / 2))
> +		return -1;
> +
> +	/* Erased page. */
> +	memset(dat, 0xff, nfc->chip.ecc.size);
> +	return 0;
> +}
> +
> +static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> +				uint8_t *buf, int oob_required, int page)
> +{
> +	int eccsize = chip->ecc.size;
> +	int stat;
> +
> +	vf610_nfc_read_buf(mtd, buf, eccsize);
> +
> +	if (oob_required)
> +		vf610_nfc_read_buf(mtd, chip->oob_poi, mtd->oobsize);

To fix the bitflips issue above, you'll just want to unconditionally
read the OOB (it's fine to ignore 'oob_required') and...

> +
> +	stat = vf610_nfc_correct_data(mtd, buf);

...pass in chip->oob_poi as a third argument.

> +
> +	if (stat < 0)
> +		mtd->ecc_stats.failed++;
> +	else
> +		mtd->ecc_stats.corrected += stat;

You've got another problem here: ecc.read_page() should be returning
'max_bitflips' here. So, since you have a single ECC region, this block
should probably be:

	if (stat < 0) {
		mtd->ecc_stats.failed++;
		return 0;
	} else {
		mtd->ecc_stats.corrected += stat;
		return stat;
	}

> +
> +	return 0;
> +}
> +
> +static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> +			       const uint8_t *buf, int oob_required)
> +{
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +
> +	vf610_nfc_write_buf(mtd, buf, mtd->writesize);
> +	if (oob_required)
> +		vf610_nfc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	/* Always write whole page including OOB due to HW ECC */
> +	nfc->use_hw_ecc = true;
> +	nfc->page_sz = mtd->writesize + mtd->oobsize;
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id vf610_nfc_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-nfc" },
>  	{ /* sentinel */ }
> @@ -485,6 +635,16 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
>  		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
>  	else
>  		vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
> +
> +	if (nfc->chip.ecc.mode == NAND_ECC_HW) {
> +		/* Set ECC status offset in SRAM */
> +		vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
> +				    CONFIG_ECC_SRAM_ADDR_MASK,
> +				    CONFIG_ECC_SRAM_ADDR_SHIFT, ECC_SRAM_ADDR);
> +
> +		/* Enable ECC status in SRAM */
> +		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_ECC_SRAM_REQ_BIT);
> +	}
>  }
>  
>  static int vf610_nfc_probe(struct platform_device *pdev)
> @@ -568,6 +728,45 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>  
> +	if (chip->ecc.mode == NAND_ECC_HW) {
> +		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
> +			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
> +			err = -ENXIO;
> +			goto error;
> +		}
> +
> +		if (chip->ecc.size != mtd->writesize) {
> +			dev_err(nfc->dev, "Step size needs to be page size\n");
> +			err = -ENXIO;
> +			goto error;
> +		}
> +
> +		/* Only 64 byte ECC layouts known */
> +		if (mtd->oobsize > 64)
> +			mtd->oobsize = 64;
> +
> +		if (chip->ecc.strength == 32) {
> +			nfc->ecc_mode = ECC_60_BYTE;
> +			chip->ecc.bytes = 60;
> +			chip->ecc.layout = &vf610_nfc_ecc60;
> +		} else if (chip->ecc.strength == 24) {
> +			nfc->ecc_mode = ECC_45_BYTE;
> +			chip->ecc.bytes = 45;
> +			chip->ecc.layout = &vf610_nfc_ecc45;
> +		} else {
> +			dev_err(nfc->dev, "Unsupported ECC strength\n");
> +			err = -ENXIO;
> +			goto error;
> +		}
> +
> +		/* propagate ecc.layout to mtd_info */
> +		mtd->ecclayout = chip->ecc.layout;
> +		chip->ecc.read_page = vf610_nfc_read_page;
> +		chip->ecc.write_page = vf610_nfc_write_page;
> +
> +		chip->ecc.size = PAGE_2K;
> +	}
> +
>  	/* second phase scan */
>  	if (nand_scan_tail(mtd)) {
>  		err = -ENXIO;
> -- 
> 2.4.5
> 

I'll give the other patches a quick look over, but otherwise I think
this should be looking good soon.

Brian

From: stefan@agner.ch (Stefan Agner)
Date: Fri, 20 Oct 2017 11:29:18 +0200
Subject: [RFC 02/12] mtd: nand: force drivers to explicitly send READ/PROG
 commands
In-Reply-To: <20171018143629.29302-3-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
 <20171018143629.29302-3-miquel.raynal@free-electrons.com>
Message-ID: <af6a28eeafc9379c3f4e8bb03ff60fc7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

Thanks for the work on this, happy to see the new interface is moving
forward. Some comments below.

On 2017-10-18 16:36, Miquel Raynal wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The core currently send the READ0 and SEQIN+PAGEPROG commands in
> nand_do_read/write_ops(). This is inconsistent with
> ->read/write_oob[_raw]() hooks behavior which are expected to send
> these commands.
> 
> There's already a flag (NAND_ECC_CUSTOM_PAGE_ACCESS) to inform the core
> that a specific controller wants to send the READ/SEQIN+PAGEPROG
> commands on its own, but it's an opt-in flag, and existing drivers are
> unlikely to be updated to pass it.
> 
> Moreover, some controllers cannot dissociate the READ/PAGEPROG commands
> from the associated data transfer and ECC engine activation, and
> developers have to hack things in their ->cmdfunc() implementation to
> handle such complex cases, or have to accept the perf penalty of sending
> twice the same command.
> To address this problem we are planning on adding a new interface which
> is passed all information about a NAND operation (including the amount
> of data to transfer) and replacing all calls to ->cmdfunc() to calls to
> this new ->exec_op() hook. But, in order to do that, we need to have all
> ->cmdfunc() calls placed near their associated ->read/write_buf/byte()
> calls.
> 
> Modify the core and relevant drivers to make NAND_ECC_CUSTOM_PAGE_ACCESS
> the default case, and remove this flag.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> [miquel.raynal at free-electrons.com: rebased and fixed some conflicts]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c      |  7 ++-
>  drivers/mtd/nand/bf5xx_nand.c                 |  6 ++-
>  drivers/mtd/nand/brcmnand/brcmnand.c          | 13 +++--
>  drivers/mtd/nand/cafe_nand.c                  |  6 +--
>  drivers/mtd/nand/denali.c                     | 14 +++++-
>  drivers/mtd/nand/docg4.c                      | 12 +++--
>  drivers/mtd/nand/fsl_elbc_nand.c              |  6 +--
>  drivers/mtd/nand/fsl_ifc_nand.c               |  6 +--
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c        | 30 ++++++------
>  drivers/mtd/nand/hisi504_nand.c               |  6 +--
>  drivers/mtd/nand/lpc32xx_mlc.c                |  5 +-
>  drivers/mtd/nand/lpc32xx_slc.c                | 11 +++--
>  drivers/mtd/nand/mtk_nand.c                   | 10 ++--
>  drivers/mtd/nand/nand_base.c                  | 68 +++++++++------------------
>  drivers/mtd/nand/nand_micron.c                |  1 -
>  drivers/mtd/nand/sh_flctl.c                   |  6 +--
>  drivers/mtd/nand/sunxi_nand.c                 | 34 +++++++++-----
>  drivers/mtd/nand/tango_nand.c                 |  1 -
>  drivers/mtd/nand/vf610_nfc.c                  |  6 +--
>  drivers/staging/mt29f_spinand/mt29f_spinand.c |  7 ++-
>  include/linux/mtd/rawnand.h                   | 11 -----
>  21 files changed, 142 insertions(+), 124 deletions(-)
> 

<snip>

> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index c8ceaecd8065..3f2b903158c1 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -1043,6 +1043,8 @@ static int gpmi_ecc_read_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	unsigned int  max_bitflips = 0;
>  	int           ret;
>  
> +	nand_read_page_op(chip, page, 0, NULL, 0);
> +
>  	dev_dbg(this->dev, "page number is : %d\n", page);
>  	ret = read_page_prepare(this, buf, nfc_geo->payload_size,
>  					this->payload_virt, this->payload_phys,
> @@ -1220,12 +1222,13 @@ static int gpmi_ecc_read_subpage(struct
> mtd_info *mtd, struct nand_chip *chip,
>  	meta = geo->metadata_size;
>  	if (first) {
>  		col = meta + (size + ecc_parity_size) * first;
> -		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, col, -1);

Shouldn't we add nand_change_read_column_op here?


>  
>  		meta = 0;
>  		buf = buf + first * size;
>  	}
>  
> +	nand_read_page_op(chip, page, col, NULL, 0);
> +
>  	/* Save the old environment */
>  	r1_old = r1_new = readl(bch_regs + HW_BCH_FLASH0LAYOUT0);
>  	r2_old = r2_new = readl(bch_regs + HW_BCH_FLASH0LAYOUT1);
> @@ -1277,6 +1280,9 @@ static int gpmi_ecc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	int        ret;
>  
>  	dev_dbg(this->dev, "ecc write page.\n");
> +
> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +
>  	if (this->swap_block_mark) {
>  		/*
>  		 * If control arrives here, we're doing block mark swapping.
> @@ -1338,7 +1344,10 @@ static int gpmi_ecc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  				payload_virt, payload_phys);
>  	}
>  
> -	return 0;
> +	if (ret)
> +		return ret;
> +
> +	return nand_prog_page_end_op(chip);
>  }
>  
>  /*
> @@ -1472,8 +1481,8 @@ static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
>  	uint8_t *oob = chip->oob_poi;
>  	int step;
>  
> -	chip->read_buf(mtd, tmp_buf,
> -		       mtd->writesize + mtd->oobsize);
> +	nand_read_page_op(chip, page, 0, tmp_buf,
> +			  mtd->writesize + mtd->oobsize);
>  
>  	/*
>  	 * If required, swap the bad block marker and the data stored in the
> @@ -1617,24 +1626,19 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
>  		tmp_buf[mtd->writesize] = swap;
>  	}
>  
> -	chip->write_buf(mtd, tmp_buf, mtd->writesize + mtd->oobsize);
> -
> -	return 0;
> +	return nand_prog_page_op(chip, page, 0, tmp_buf,
> +				 mtd->writesize + mtd->oobsize);
>  }
>  
>  static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  				 int page)
>  {
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> -
>  	return gpmi_ecc_read_page_raw(mtd, chip, NULL, 1, page);
>  }
>  
>  static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  				 int page)
>  {
> -	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> -
>  	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1, page);
>  }
>  
> @@ -1806,9 +1810,7 @@ static int mx23_write_transcription_stamp(struct
> gpmi_nand_data *this)
>  		/* Write the first page of the current stride. */
>  		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
>  
> -		nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> -		chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
> -		status = nand_prog_page_end_op(chip);
> +		status = chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
>  		if (status)
>  			dev_err(dev, "[%s] Write failed.\n", __func__);
>  	}

<snip>

> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 8037d4b48a05..80d31a58e558 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -560,7 +560,7 @@ static int vf610_nfc_read_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	int eccsize = chip->ecc.size;
>  	int stat;
>  
> -	vf610_nfc_read_buf(mtd, buf, eccsize);
> +	nand_read_page_op(chip, page, 0, buf, eccsize);
>  	if (oob_required)
>  		vf610_nfc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
>  
> @@ -580,7 +580,7 @@ static int vf610_nfc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  {
>  	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>  
> -	vf610_nfc_write_buf(mtd, buf, mtd->writesize);

We currently ignore NAND_CMD_SEQIN in ->cmdfunc anyway, so I think this
change would not even be necessary here.

This is a NAND controller which will benefit from the new interface. I
plan to convert the driver to the new interface, maybe I manage to do
that soon so we have a second driver making use of the new interface.


> +	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
>  	if (oob_required)
>  		vf610_nfc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
>  
> @@ -588,7 +588,7 @@ static int vf610_nfc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	nfc->use_hw_ecc = true;
>  	nfc->write_sz = mtd->writesize + mtd->oobsize;
>  
> -	return 0;
> +	return nand_prog_page_end_op(chip);
>  }
>  
>  static const struct of_device_id vf610_nfc_dt_ids[] = {

--
Stefan

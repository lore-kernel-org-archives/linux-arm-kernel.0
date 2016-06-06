From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Jun 2016 14:07:09 +0200
Subject: [PATCH 3/3] mtd: nand: sunxi: fix subpage write
In-Reply-To: <1465214354-31493-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1465214354-31493-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465214354-31493-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160606140709.614bbb04@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  6 Jun 2016 13:59:14 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

Oops, I forgot to add this commit message:

"
Implement ecc->write_subpage() to prevent core code from assigning
this hook to nand_write_subpage_hwecc(). This default implementation
tries to call ecc->hwctl() which in our case is NULL, thus leading
to a NULL pointer dereference.
"

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 252cbbf..409acbe 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -1350,6 +1350,36 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
>  	return 0;
>  }
>  
> +static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
> +					  struct nand_chip *chip,
> +					  u32 data_offs, u32 data_len,
> +					  const u8 *buf, int oob_required,
> +					  int page)
> +{
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int ret, i, cur_off = 0;
> +
> +	sunxi_nfc_hw_ecc_enable(mtd);
> +
> +	for (i = data_offs / ecc->size;
> +	     i < DIV_ROUND_UP(data_offs + data_len, ecc->size); i++) {
> +		int data_off = i * ecc->size;
> +		int oob_off = i * (ecc->bytes + 4);
> +		const u8 *data = buf + data_off;
> +		const u8 *oob = chip->oob_poi + oob_off;
> +
> +		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
> +						   oob_off + mtd->writesize,
> +						   &cur_off, !i, page);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	sunxi_nfc_hw_ecc_disable(mtd);
> +
> +	return 0;
> +}
> +
>  static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
>  					   struct nand_chip *chip,
>  					   const u8 *buf,
> @@ -1862,7 +1892,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
>  		ecc->write_page = sunxi_nfc_hw_ecc_write_page;
>  	}
>  
> -	/* TODO: support DMA for raw accesses */
> +	/* TODO: support DMA for raw accesses and subpage write */
> +	ecc->write_subpage = sunxi_nfc_hw_ecc_write_subpage;
>  	ecc->read_oob_raw = nand_read_oob_std;
>  	ecc->write_oob_raw = nand_write_oob_std;
>  	ecc->read_subpage = sunxi_nfc_hw_ecc_read_subpage;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

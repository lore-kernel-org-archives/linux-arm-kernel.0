From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 08:56:14 +0200
Subject: [PATCH v4 08/35] mtd: rawnand: gpmi: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-9-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-9-miquel.raynal@bootlin.com>
Message-ID: <20180721085614.16ebca4d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:00 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 56 ++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 6294d018df65..1c1ebbc82824 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -744,9 +744,9 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
>  	 * [2] Allocate a read/write data buffer.
>  	 *     The gpmi_alloc_dma_buffer can be called twice.
>  	 *     We allocate a PAGE_SIZE length buffer if gpmi_alloc_dma_buffer
> -	 *     is called before the nand_scan_ident; and we allocate a buffer
> -	 *     of the real NAND page size when the gpmi_alloc_dma_buffer is
> -	 *     called after the nand_scan_ident.
> +	 *     is called before the NAND identification; and we allocate a
> +	 *     buffer of the real NAND page size when the gpmi_alloc_dma_buffer
> +	 *     is called after.
>  	 */
>  	this->data_buffer_dma = kzalloc(mtd->writesize ?: PAGE_SIZE,
>  					GFP_DMA | GFP_KERNEL);
> @@ -1865,6 +1865,34 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
>  	return 0;
>  }
>  
> +static int gpmi_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct gpmi_nand_data *this = nand_get_controller_data(chip);
> +	int ret;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +		if (of_property_read_bool(this->dev->of_node,
> +					  "fsl,no-blockmark-swap"))
> +			this->swap_block_mark = false;
> +	}
> +	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> +		this->swap_block_mark ? "en" : "dis");
> +
> +	ret = gpmi_init_last(this);
> +	if (ret)
> +		return ret;
> +
> +	chip->options |= NAND_SKIP_BBTSCAN;
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops gpmi_nand_controller_ops = {
> +	.attach_chip = gpmi_nand_attach_chip,
> +};
> +
>  static int gpmi_nand_init(struct gpmi_nand_data *this)
>  {
>  	struct nand_chip *chip = &this->nand;
> @@ -1905,26 +1933,8 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
>  	if (ret)
>  		goto err_out;
>  
> -	ret = nand_scan_ident(mtd, GPMI_IS_MX6(this) ? 2 : 1, NULL);
> -	if (ret)
> -		goto err_out;
> -
> -	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> -		chip->bbt_options |= NAND_BBT_NO_OOB;
> -
> -		if (of_property_read_bool(this->dev->of_node,
> -						"fsl,no-blockmark-swap"))
> -			this->swap_block_mark = false;
> -	}
> -	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> -		this->swap_block_mark ? "en" : "dis");
> -
> -	ret = gpmi_init_last(this);
> -	if (ret)
> -		goto err_out;
> -
> -	chip->options |= NAND_SKIP_BBTSCAN;
> -	ret = nand_scan_tail(mtd);
> +	chip->dummy_controller.ops = &gpmi_nand_controller_ops;
> +	ret = nand_scan(mtd, GPMI_IS_MX6(this) ? 2 : 1);
>  	if (ret)
>  		goto err_out;
>  

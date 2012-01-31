From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 13:10:07 +0100
Subject: [PATCH v3] mtd/gpmi : add BBT support to gpmi nand driver
In-Reply-To: <1328008316-27258-1-git-send-email-b32955@freescale.com>
References: <1328008316-27258-1-git-send-email-b32955@freescale.com>
Message-ID: <20120131121007.GO2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 07:11:56PM +0800, Huang Shijie wrote:
> Add a new field to gpmi_nand_platform_data{}.
> Make the BBT support to board specific.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

I'd think you won't be able to mark blocks bad, though. Will send a
patch in a minute. Please test.

> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 ++
>  include/linux/mtd/gpmi-nand.h          |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 493ec2f..4d369df 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -1493,6 +1493,8 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
>  	chip->ecc.mode		= NAND_ECC_HW;
>  	chip->ecc.size		= 1;
>  	chip->ecc.layout	= &gpmi_hw_ecclayout;
> +	if (pdata->enable_bbt)
> +		chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
>  
>  	/* Allocate a temporary DMA buffer for reading ID in the nand_scan() */
>  	this->bch_geometry.payload_size = 1024;
> diff --git a/include/linux/mtd/gpmi-nand.h b/include/linux/mtd/gpmi-nand.h
> index 69b6dbf..04ab366 100644
> --- a/include/linux/mtd/gpmi-nand.h
> +++ b/include/linux/mtd/gpmi-nand.h
> @@ -51,6 +51,7 @@
>   * @partitions:              An optional pointer to an array of partition
>   *                           descriptions.
>   * @partition_count:         The number of elements in the partitions array.
> + * @enable_bbt:              Enable the BBT or not.
>   */
>  struct gpmi_nand_platform_data {
>  	/* SoC hardware information. */
> @@ -64,5 +65,6 @@ struct gpmi_nand_platform_data {
>  	/* Medium information. */
>  	struct		mtd_partition *partitions;
>  	unsigned	partition_count;
> +	unsigned int	enable_bbt:1;
>  };
>  #endif
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/437474bc/attachment.sig>

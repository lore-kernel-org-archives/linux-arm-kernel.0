From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 26 Apr 2015 22:07:25 +0200
Subject: [PATCH 2/4] mtd: mxc_nand: limit the size of used oob
In-Reply-To: <4bd5da1f7d57aa32c5682297f7aa0c768e8c6e49.1430034929.git.baruch@tkos.co.il>
References: <cover.1430034929.git.baruch@tkos.co.il>
 <4bd5da1f7d57aa32c5682297f7aa0c768e8c6e49.1430034929.git.baruch@tkos.co.il>
Message-ID: <20150426200725.GC19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 26, 2015 at 11:16:49AM +0300, Baruch Siach wrote:
> For 4k pages the i.MX NFC hardware uses exactly 218 or 128 bytes for 4bit or
> 8bit ECC data, respectively. Larger oobsize confuses the logic of copy_spare().
> Limit the size of used oob size to avoid that.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/mtd/nand/mxc_nand.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 33b22b9c0b30..c650f0950b20 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -819,15 +819,22 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
>  {
>  	struct nand_chip *this = mtd->priv;
>  	struct mxc_nand_host *host = this->priv;
> -	u16 i, oob_chunk_size;
> +	u16 i, oob_chunk_size, used_oobsize;
>  	u16 num_chunks = mtd->writesize / 512;
>  
>  	u8 *d = host->data_buf + mtd->writesize;
>  	u8 __iomem *s = host->spare0;
>  	u16 sparebuf_size = host->devtype_data->spare_len;
>  
> +	/* hardware can only use 218 or 128 oob bytes for ecc */
> +	if (mtd->oobsize >= 218)
IMHO this is the wrong check. What if your part (with 224 bytes spare)
is used but the machine only uses the small layout e.g. for booting?
(That would work, wouldn't it?) Moreover the comment is misleading as it
only applies to 4K flashes. At least the driver works well with (2ki +
128) bytes pages (while there are only 64 bytes spare used?? Maybe there
are still more bugs?).

> +		used_oobsize = 218;
> +	else if (mtd->oobsize >= 128)
> +		used_oobsize = 128;
> +	else
> +		used_oobsize = mtd->oobsize;
Is it worth to put this check into _probe and put the used size into
driver data?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

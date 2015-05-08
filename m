From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 May 2015 09:21:19 +0200
Subject: [PATCH v2 4/4] mtd: mxc_nand: generate nand_ecclayout for 8 bit
 ECC
In-Reply-To: <e717cffe04cfe814528efe5fbdeb228afe1ec68e.1430636819.git.baruch@tkos.co.il>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <e717cffe04cfe814528efe5fbdeb228afe1ec68e.1430636819.git.baruch@tkos.co.il>
Message-ID: <20150508072119.GI12671@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 10:18:54AM +0300, Baruch Siach wrote:
> Hardware 8 bit ECC requires a different nand_ecclayout. Instead of adding yet
> another static struct nand_ecclayout, generate it in code.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
A nice possible follow-up for this patch would be to substitute all
layouts by a function.

> ---
> v2:
>    Initialize eccbytes
> ---
>  drivers/mtd/nand/mxc_nand.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 010be8aa41d4..68aec99f0d4b 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -960,6 +960,23 @@ static int get_eccsize(struct mtd_info *mtd)
>  		return 8;
>  }
>  
> +static void ecc_8bit_layout(struct nand_ecclayout *layout)
As this only applies to 4k nand chips I'd suggest to add 4k somewhere in
the name of this function.

> +{
> +	int i, j;
> +
> +	layout->eccbytes = 8*18;
> +	for (i = 0; i < 8; i++)
> +		for (j = 0; j < 18; j++)
> +			layout->eccpos[i*18 + j] = i*26 + j + 7;
> +
> +	layout->oobfree[0].offset = 2;
> +	layout->oobfree[0].length = 4;
> +	for (i = 1; i < 8; i++) {
> +		layout->oobfree[i].offset = i*26;
> +		layout->oobfree[i].length = 7;
> +	}
> +}
> +
>  static void preset_v1(struct mtd_info *mtd)
>  {
>  	struct nand_chip *nand_chip = mtd->priv;
> @@ -1636,8 +1653,11 @@ static int mxcnd_probe(struct platform_device *pdev)
>  
>  	if (mtd->writesize == 2048)
>  		this->ecc.layout = host->devtype_data->ecclayout_2k;
> -	else if (mtd->writesize == 4096)
> +	else if (mtd->writesize == 4096) {
>  		this->ecc.layout = host->devtype_data->ecclayout_4k;
> +		if (get_eccsize(mtd) == 8)
> +			ecc_8bit_layout(this->ecc.layout);
> +	}
>  
>  	/*
>  	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
> -- 
> 2.1.4
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

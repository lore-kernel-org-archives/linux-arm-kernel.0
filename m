From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 20 May 2015 15:41:20 -0700
Subject: [PATCH v3 4/4] mtd: mxc_nand: generate nand_ecclayout for 8 bit
 ECC
In-Reply-To: <95e2a17d74da5a0415ab93e060f6efc681216313.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
 <95e2a17d74da5a0415ab93e060f6efc681216313.1431504091.git.baruch@tkos.co.il>
Message-ID: <20150520224120.GS11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:17:39AM +0300, Baruch Siach wrote:
> Hardware 8 bit ECC requires a different nand_ecclayout. Instead of adding yet
> another static struct nand_ecclayout, generate it in code.

I like the idea of not adding more static declarations. But I think you
have a potential problem below.

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v3:
>    Rename ecc_8bit_layout to ecc_8bit_layout_4k (Uwe Kleine-K?nig)
> 
> v2:
>    Initialize eccbytes
> ---
>  drivers/mtd/nand/mxc_nand.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 010be8aa41d4..25759563bf11 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -960,6 +960,23 @@ static int get_eccsize(struct mtd_info *mtd)
>  		return 8;
>  }
>  
> +static void ecc_8bit_layout_4k(struct nand_ecclayout *layout)
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
> +			ecc_8bit_layout_4k(this->ecc.layout);

So you're overwriting an existing layout (e.g., nandv2_hw_eccoob_4k).
What if you have more than one NAND chip? You might do better by
dynamically allocating the memory.

> +	}
>  
>  	/*
>  	 * Experimentation shows that i.MX NFC can only handle up to 218 oob

Brian

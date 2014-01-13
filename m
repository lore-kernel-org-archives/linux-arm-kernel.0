From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 13 Jan 2014 08:10:38 -0300
Subject: NAND support for Armada 370
In-Reply-To: <20140106153438.GX10251@enneenne.com>
References: <20140102124407.GF10251@enneenne.com>
 <20140102144236.270c4a6a@skate>
 <20140103112926.GP10251@enneenne.com>
 <20140103145336.GA9618@localhost>
 <20140106153438.GX10251@enneenne.com>
Message-ID: <20140113111037.GA9918@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rodolfo,

After reviewing the driver and the NAND kernel core, I think we should
use your first version of the patch (with the custom ECC layout).

The default ECC layout provided by Linux for 64-byte OOB is different from
the actual layout used by the ECC BCH "16-bit over 2048B" that we use.

IIRC, this ECC layout is not really in use so that's why you didn't spot
any issues while removing. Nevertheless, we should try to have it right.

Can you please re-submit the quoted patch (see below) to the MTD mailing list?
(don't forget to add me on Cc)

Thanks a lot!

> From 8fc320506e1573dbff4844f4d98e20ff91c43ffd Mon Sep 17 00:00:00 2001
> From: Rodolfo Giometti <giometti@linux.it>
> Date: Mon, 6 Jan 2014 16:18:49 +0100
> Subject: [PATCH] mtd pxa3xx_nand.c: add support for 2048 bytes page size
>  layout
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 31aae53..2a7a0b2 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -286,6 +286,16 @@ static struct nand_bbt_descr bbt_mirror_descr = {
>  	.pattern = bbt_mirror_pattern
>  };
>  
> +static struct nand_ecclayout ecc_layout_2KB_bch4bit = {
> +	.eccbytes = 32,
> +	.eccpos = {
> +		32, 33, 34, 35, 36, 37, 38, 39,
> +		40, 41, 42, 43, 44, 45, 46, 47,
> +		48, 49, 50, 51, 52, 53, 54, 55,
> +		56, 57, 58, 59, 60, 61, 62, 63},
> +	.oobfree = { {2, 30} }
> +};
> +
>  static struct nand_ecclayout ecc_layout_4KB_bch4bit = {
>  	.eccbytes = 64,
>  	.eccpos = {
> @@ -1360,6 +1370,17 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
>  	 * Required ECC: 4-bit correction per 512 bytes
>  	 * Select: 16-bit correction per 2048 bytes
>  	 */
> +	} else if (strength == 4 && ecc_stepsize == 512 && page_size == 2048) {
> +		info->ecc_bch = 1;
> +		info->chunk_size = 2048;
> +		info->spare_size = 32;
> +		info->ecc_size = 32;
> +		ecc->mode = NAND_ECC_HW;
> +		ecc->size = info->chunk_size;
> +		ecc->layout = &ecc_layout_2KB_bch4bit;
> +		ecc->strength = 16;
> +		return 1;
> +
>  	} else if (strength == 4 && ecc_stepsize == 512 && page_size == 4096) {
>  		info->ecc_bch = 1;
>  		info->chunk_size = 2048;
> -- 
> 1.8.1.2
> 


-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

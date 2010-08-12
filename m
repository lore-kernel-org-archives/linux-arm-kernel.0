From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 12 Aug 2010 08:42:38 +0300
Subject: [PATCH] nand: fix .correct callback return value check
In-Reply-To: <ca767a0d6cafbea862c307e944c2b800dafb6660.1281327492.git.baruch@tkos.co.il>
References: <20100808204341.GA20065@pengutronix.de>
	<ca767a0d6cafbea862c307e944c2b800dafb6660.1281327492.git.baruch@tkos.co.il>
Message-ID: <20100812054237.GB13166@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi linux-mtd list,

Ping?

At least the atmel_nand and the bf5xx_nand drivers may return -EIO for 
uncorrectable errors, so this patch fixes a real bug.

baruch

On Mon, Aug 09, 2010 at 07:20:23AM +0300, Baruch Siach wrote:
> Drivers may (and do) return negative errno values other than -1 from the
> .correct callback.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/mtd/nand/nand_base.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 4a7b864..080f551 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -1210,7 +1210,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip, uint3
>  		int stat;
>  
>  		stat = chip->ecc.correct(mtd, p, &chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
> -		if (stat == -1)
> +		if (stat < 0)
>  			mtd->ecc_stats.failed++;
>  		else
>  			mtd->ecc_stats.corrected += stat;
> -- 
> 1.7.1

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

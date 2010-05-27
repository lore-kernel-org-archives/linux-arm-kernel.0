From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 27 May 2010 13:11:34 +0200
Subject: [PATCH] mxc_nand: add support for platform defined partitions
In-Reply-To: <7d46e3bafd160eaa9c5d9a09b88ea1cb4a2d5b89.1274950000.git.baruch@tkos.co.il>
References: <7d46e3bafd160eaa9c5d9a09b88ea1cb4a2d5b89.1274950000.git.baruch@tkos.co.il>
Message-ID: <4BFE5366.3000705@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Just coding style comments from me, see inline

> ---
>  arch/arm/plat-mxc/include/mach/mxc_nand.h |    4 ++++
>  drivers/mtd/nand/mxc_nand.c               |    2 ++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mxc_nand.h b/arch/arm/plat-mxc/include/mach/mxc_nand.h
> index 5d2d21d..a07bae9 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc_nand.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc_nand.h
> @@ -20,9 +20,13 @@
>  #ifndef __ASM_ARCH_NAND_H
>  #define __ASM_ARCH_NAND_H
>  
> +#include <linux/mtd/partitions.h>
> +
>  struct mxc_nand_platform_data {
>  	int width;	/* data bus width in bytes */
>  	int hw_ecc:1;	/* 0 if supress hardware ECC */
>  	int flash_bbt:1; /* set to 1 to use a flash based bbt */
> +	struct mtd_partition	*parts;	/* partition table */
> +	int			nr_parts; /* size of parts */

Please don't use tab(s) between type and variable name. Use tabs to
align the comment though. (Just like the other members of the struct do.)

>  };
>  #endif /* __ASM_ARCH_NAND_H */
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index b2900d8..4f615d2 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -838,6 +838,8 @@ static int __init mxcnd_probe(struct platform_device *pdev)
>  	    parse_mtd_partitions(mtd, part_probes, &host->parts, 0);
>  	if (nr_parts > 0)
>  		add_mtd_partitions(mtd, host->parts, nr_parts);
> +	else if (pdata->parts)
> +		add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
>  	else
>  #endif
>  	{

Cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/625adc1f/attachment.sig>

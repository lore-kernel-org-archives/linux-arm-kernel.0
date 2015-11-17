From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 16 Nov 2015 19:03:53 -0800
Subject: [PATCH 18/27] mtd: nand: update mtd_to_nand()
In-Reply-To: <1447681080-31232-19-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-19-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151117030353.GZ8456@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 02:37:51PM +0100, Boris Brezillon wrote:
> Now that all drivers are using the mtd instance embedded in the nand_chip

Do you have a script that verifies this? I thought you did at some
point, and it'd be nice to note it, so I can also use it to verify
things once it gets applied.

> struct we can safely update the mtd_to_nand_chip() implementation to use

Nit: s/mtd_to_nand_chip/mtd_to_nand/

> the container_of macro instead of returning the content of mtd->priv.
> This will allow us to remove mtd->priv = chip assignments done in all
> NAND controller drivers.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/mtd/nand.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 8ec071e..873646d 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -734,7 +734,7 @@ static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
>  
>  static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
>  {
> -	return mtd->priv;
> +	return container_of(mtd, struct nand_chip, mtd);
>  }
>  
>  static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
> -- 
> 2.1.4
> 

From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 1 Dec 2015 14:15:31 -0800
Subject: [PATCH v2 12/25] mtd: nand: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151201221531.GA64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Dec 01, 2015 at 12:03:09PM +0100, Boris Brezillon wrote:
> struct nand_chip now embeds an mtd device. Patch all drivers to make use
> of this mtd instance instead of using the instance embedded in their
> private struct or dynamically allocated.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> ---
> Most of those changes were generated with the coccinelle script added
> in commit c671312 "coccinelle: nand: detect and correct drivers embedding
> an mtd_info object"
> ---
>  drivers/mtd/nand/ams-delta.c                   | 13 ++--
>  drivers/mtd/nand/atmel_nand.c                  | 13 ++--
>  drivers/mtd/nand/au1550nd.c                    | 19 ++---
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |  1 -
>  drivers/mtd/nand/bcm47xxnflash/main.c          |  8 ++-
>  drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  2 +-
>  drivers/mtd/nand/bf5xx_nand.c                  | 12 ++--
>  drivers/mtd/nand/brcmnand/brcmnand.c           | 13 ++--
>  drivers/mtd/nand/cafe_nand.c                   |  8 +--
>  drivers/mtd/nand/cmx270_nand.c                 | 11 ++-
>  drivers/mtd/nand/cs553x_nand.c                 | 13 ++--
>  drivers/mtd/nand/davinci_nand.c                | 30 ++++----
>  drivers/mtd/nand/denali.c                      | 68 ++++++++++--------
>  drivers/mtd/nand/denali.h                      |  1 -
>  drivers/mtd/nand/diskonchip.c                  | 11 ++-
>  drivers/mtd/nand/docg4.c                       | 16 ++---
>  drivers/mtd/nand/fsl_elbc_nand.c               | 26 ++++---
>  drivers/mtd/nand/fsl_ifc_nand.c                | 28 ++++----
>  drivers/mtd/nand/fsl_upm.c                     | 28 ++++----
>  drivers/mtd/nand/fsmc_nand.c                   | 56 ++++++++-------
>  drivers/mtd/nand/gpio.c                        | 20 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |  2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c         | 20 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |  1 -
>  drivers/mtd/nand/hisi504_nand.c                | 13 ++--
>  drivers/mtd/nand/jz4740_nand.c                 |  9 ++-
>  drivers/mtd/nand/lpc32xx_mlc.c                 |  7 +-
>  drivers/mtd/nand/lpc32xx_slc.c                 |  7 +-
>  drivers/mtd/nand/mpc5121_nfc.c                 |  3 +-
>  drivers/mtd/nand/mxc_nand.c                    |  5 +-
>  drivers/mtd/nand/nandsim.c                     | 12 ++--
>  drivers/mtd/nand/ndfc.c                        | 24 ++++---
>  drivers/mtd/nand/nuc900_nand.c                 | 24 +++----
>  drivers/mtd/nand/omap2.c                       | 98 +++++++++++++++-----------
>  drivers/mtd/nand/orion_nand.c                  |  4 +-
>  drivers/mtd/nand/pasemi_nand.c                 | 12 ++--
>  drivers/mtd/nand/plat_nand.c                   | 15 ++--
>  drivers/mtd/nand/pxa3xx_nand.c                 | 33 ++++-----
>  drivers/mtd/nand/r852.c                        | 34 ++++-----
>  drivers/mtd/nand/r852.h                        |  1 -
>  drivers/mtd/nand/s3c2410.c                     | 23 +++---

^^ some errors in this one

>  drivers/mtd/nand/sh_flctl.c                    |  8 +--
>  drivers/mtd/nand/sharpsl.c                     | 22 +++---
>  drivers/mtd/nand/socrates_nand.c               |  5 +-
>  drivers/mtd/nand/sunxi_nand.c                  | 13 ++--
>  drivers/mtd/nand/tmio_nand.c                   | 10 +--
>  drivers/mtd/nand/txx9ndfmc.c                   |  3 +-
>  drivers/mtd/nand/vf610_nfc.c                   |  8 ++-
>  include/linux/mtd/sh_flctl.h                   |  3 +-
>  49 files changed, 426 insertions(+), 390 deletions(-)
> 

[...]

> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index e658b29..3f29734 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -104,7 +104,6 @@ struct s3c2410_nand_info;
>   * @scan_res: The result from calling nand_scan_ident().
>  */
>  struct s3c2410_nand_mtd {
> -	struct mtd_info			mtd;
>  	struct nand_chip		chip;
>  	struct s3c2410_nand_set		*set;
>  	struct s3c2410_nand_info	*info;
> @@ -168,7 +167,8 @@ struct s3c2410_nand_info {
>  
>  static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
>  {
> -	return container_of(mtd, struct s3c2410_nand_mtd, mtd);
> +	return container_of(mtd_to_nand(mtd), struct s3c2410_nand_mtd,
> +			    chip);
>  }
>  
>  static struct s3c2410_nand_info *s3c2410_nand_mtd_toinfo(struct mtd_info *mtd)
> @@ -745,7 +745,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
>  
>  		for (mtdno = 0; mtdno < info->mtd_count; mtdno++, ptr++) {
>  			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
> -			nand_release(&ptr->mtd);
> +			nand_release(nand_to_mtd(&ptr->chip));
>  		}
>  	}
>  
> @@ -762,9 +762,11 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
>  				      struct s3c2410_nand_set *set)
>  {
>  	if (set) {
> -		mtd->mtd.name = set->name;
> +		struct mtd_info *mtd = nand_to_mtd(&mtd->chip);

You're shadowing the earlier 'mtd' variable:

drivers/mtd/nand/s3c2410.c: In function ?s3c2410_nand_add_partition?:
drivers/mtd/nand/s3c2410.c:765:42: error: ?struct mtd_info? has no member named ?chip?

>  
> -		return mtd_device_parse_register(&mtd->mtd, NULL, NULL,
> +		mtd->name = set->name;
> +
> +		return mtd_device_parse_register(mtd, NULL, NULL,
>  					 set->partitions, set->nr_partitions);
>  	}
>  
> @@ -786,6 +788,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>  				   struct s3c2410_nand_set *set)
>  {
>  	struct nand_chip *chip = &nmtd->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	void __iomem *regs = info->regs;
>  
>  	chip->write_buf    = s3c2410_nand_write_buf;
> @@ -831,7 +834,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>  	chip->IO_ADDR_R = chip->IO_ADDR_W;
>  
>  	nmtd->info	   = info;
> -	nmtd->mtd.priv	   = chip;
> +	mtd->priv	   = chip;
>  	nmtd->set	   = set;
>  
>  #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
> @@ -1012,19 +1015,21 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
>  	nmtd = info->mtds;
>  
>  	for (setno = 0; setno < nr_sets; setno++, nmtd++) {
> +		struct mtd_info *mtd = nand_to_mtd(&nmtd->chip);
> +
>  		pr_debug("initialising set %d (%p, info %p)\n",
>  			 setno, nmtd, info);
>  
> -		nmtd->mtd.dev.parent = &pdev->dev;
> +		mtd->dev.parent = &pdev->dev;
>  		s3c2410_nand_init_chip(info, nmtd, sets);
>  
> -		nmtd->scan_res = nand_scan_ident(&nmtd->mtd,
> +		nmtd->scan_res = nand_scan_ident(mtd,
>  						 (sets) ? sets->nr_chips : 1,
>  						 NULL);
>  
>  		if (nmtd->scan_res == 0) {
>  			s3c2410_nand_update_chip(info, nmtd);
> -			nand_scan_tail(&nmtd->mtd);
> +			nand_scan_tail(mtd);
>  			s3c2410_nand_add_partition(info, nmtd, sets);
>  		}
>  

[...]

Brian

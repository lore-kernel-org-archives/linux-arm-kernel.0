From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 1 Dec 2015 14:21:21 -0800
Subject: [PATCH v2 12/25] mtd: nand: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151201222121.GC64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

^^ some errors here too

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

...

> diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
> index da93d7f..f8d5e27 100644
> --- a/drivers/mtd/nand/docg4.c
> +++ b/drivers/mtd/nand/docg4.c
> @@ -1305,14 +1305,13 @@ static int __init probe_docg4(struct platform_device *pdev)
>  		return -EIO;
>  	}
>  
> -	len = sizeof(struct mtd_info) + sizeof(struct nand_chip) +
> -		sizeof(struct docg4_priv);
> -	mtd = kzalloc(len, GFP_KERNEL);
> -	if (mtd == NULL) {
> +	len = sizeof(struct nand_chip) + sizeof(struct docg4_priv);
> +	nand = kzalloc(len, GFP_KERNEL);
> +	if (nand == NULL) {
>  		retval = -ENOMEM;
>  		goto fail;
>  	}
> -	nand = (struct nand_chip *) (mtd + 1);
> +	mtd = nand_to_mtd(nand);
>  	doc = (struct docg4_priv *) (nand + 1);
>  	mtd->priv = nand;
>  	nand->priv = doc;
> @@ -1355,13 +1354,12 @@ static int __init probe_docg4(struct platform_device *pdev)
>  
>   fail:
>  	iounmap(virtadr);
> -	if (mtd) {
> +	if (nand) {
>  		/* re-declarations avoid compiler warning */
> -		struct nand_chip *nand = mtd_to_nand(mtd);
>  		struct docg4_priv *doc = nand->priv;
>  		nand_release(mtd); /* deletes partitions and mtd devices */

drivers/mtd/nand/docg4.c: In function ?probe_docg4?:
drivers/mtd/nand/docg4.c:1359:15: warning: ?mtd? may be used uninitialized in this function [-Wmaybe-uninitialized]
   nand_release(mtd); /* deletes partitions and mtd devices */
               ^

>  		free_bch(doc->bch);
> -		kfree(mtd);
> +		kfree(nand);
>  	}
>  
>  	return retval;
> @@ -1372,7 +1370,7 @@ static int __exit cleanup_docg4(struct platform_device *pdev)
>  	struct docg4_priv *doc = platform_get_drvdata(pdev);
>  	nand_release(doc->mtd);
>  	free_bch(doc->bch);
> -	kfree(doc->mtd);
> +	kfree(mtd_to_nand(doc->mtd));
>  	iounmap(doc->virtadr);
>  	return 0;
>  }

Brian 

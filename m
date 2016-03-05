From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 4 Mar 2016 18:26:21 -0800
Subject: [PATCH v3 16/52] mtd: nand: use mtd_set_ecclayout() where
 appropriate
In-Reply-To: <1456448280-27788-17-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-17-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160305022621.GN55664@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 01:57:24AM +0100, Boris Brezillon wrote:
> Use the mtd_set_ecclayout() helper instead of directly assigning the
> mtd->ecclayout field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 17504f2..5093a3c 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -4288,7 +4288,7 @@ int nand_scan_tail(struct mtd_info *mtd)
>  		ecc->write_oob_raw = ecc->write_oob;
>  
>  	/* propagate ecc info to mtd_info */
> -	mtd->ecclayout = ecc->layout;
> +	mtd_set_ecclayout(mtd, ecc->layout);

I'm having trouble applying this one. For the life of me, I can't figure
out where you got this context from. This block only appears much later
in nand_scan_tail()...

Do you think you could post a git tree with your intended changes? I may
just try to pull something in like that instead.

BTW, I'm not sure the OMAP refactorings are going to come in time, but I
was planning to pull those directly from the TI folks (i.e., they won't
be rebased on l2-mtd.git), since there's some intermingling of platform
changes there. I think I can fix the conflicts fine, but FYI.

Brian

>  	mtd->ecc_strength = ecc->strength;
>  	mtd->ecc_step_size = ecc->size;
>  
> -- 
> 2.1.4
> 

From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 1 Dec 2015 14:17:47 -0800
Subject: [PATCH v2 17/25] mtd: nand: remove useless mtd->priv = chip
 assignments
In-Reply-To: <1448967802-25796-18-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-18-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151201221747.GB64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 12:03:14PM +0100, Boris Brezillon wrote:
> mtd_to_nand() now uses the container_of() approach to transform an
> mtd_info pointer into a nand_chip one. Drop useless mtd->priv
> assignments from NAND controller drivers.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Patch generated with the following coccinelle script:
> 
> ---8<----
> virtual patch
> 
> @@
> struct mtd_info m;
> struct mtd_info *mp;
> struct nand_chip *c;
> @@
> (
> -(m).priv = c;
> |
> -(mp)->priv = c;
> |
> -(mp)->priv = (void *)c;
> )
> ---8<----
> ---

...

> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index 3f29734..ed4184c 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -834,7 +834,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>  	chip->IO_ADDR_R = chip->IO_ADDR_W;
>  
>  	nmtd->info	   = info;
> -	mtd->priv	   = chip;

After this one, we have:

drivers/mtd/nand/s3c2410.c: In function ?s3c2410_nand_init_chip?:
drivers/mtd/nand/s3c2410.c:791:19: warning: unused variable ?mtd? [-Wunused-variable]


>  	nmtd->set	   = set;
>  
>  #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
 
Brian

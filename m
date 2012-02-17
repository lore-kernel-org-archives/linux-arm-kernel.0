From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Fri, 17 Feb 2012 20:52:19 +0530
Subject: [PATCH] mtd: omap2: Release memory region in .remove function
In-Reply-To: <1329490172-8043-1-git-send-email-walle@corscience.de>
References: <1329490172-8043-1-git-send-email-walle@corscience.de>
Message-ID: <CAM=Q2cuXfYA=bibwzDBdb41_KiHu1X4bExbyS2FsfjBM7RXopQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 8:19 PM, Bernhard Walle <walle@corscience.de> wrote:
> When the driver is compiled as module, it's not possible to unload and
> reload the driver again:
>
> ? ?omap2-nand: probe of omap2-nand.0 failed with error -16
>
Looks right to me
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>

> This patch fixes the problem because it releases the memory region, so
> that it can be requested again.
>
> Signed-off-by: Bernhard Walle <walle@corscience.de>
> ---
> ?drivers/mtd/nand/omap2.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index b3a883e..7dfcf68 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1132,6 +1132,7 @@ static int omap_nand_remove(struct platform_device *pdev)
> ? ? ? ?/* Release NAND device, its internal structures and partitions */
> ? ? ? ?nand_release(&info->mtd);
> ? ? ? ?iounmap(info->nand.IO_ADDR_R);
> + ? ? ? release_mem_region(info->phys_base, NAND_IO_SIZE);
> ? ? ? ?kfree(&info->mtd);
> ? ? ? ?return 0;
> ?}
> --
> 1.7.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

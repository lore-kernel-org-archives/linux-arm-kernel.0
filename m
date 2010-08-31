From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 31 Aug 2010 13:51:06 +0800
Subject: [PATCH] ARM: pxa3xx: fix build error when CONFIG_MTD_PARTITIONS
	is not defined
In-Reply-To: <1282813011-6187-2-git-send-email-mark.brown314@gmail.com>
References: <1282813011-6187-1-git-send-email-mark.brown314@gmail.com>
	<1282813011-6187-2-git-send-email-mark.brown314@gmail.com>
Message-ID: <AANLkTinn_Yb+jGOcpc139X2cW0ax5Ev23ovjpp9NrPJC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 4:56 PM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
> ?drivers/mtd/nand/pxa3xx_nand.c | ? ?6 ++++++
> ?1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 4d89f37..4d01cda 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -1320,6 +1320,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto fail_free_irq;
> ? ? ? ?}
>
> +#ifdef CONFIG_MTD_PARTITIONS
> ? ? ? ?if (mtd_has_cmdlinepart()) {
> ? ? ? ? ? ? ? ?static const char *probes[] = { "cmdlinepart", NULL };
> ? ? ? ? ? ? ? ?struct mtd_partition *parts;
> @@ -1332,6 +1333,9 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
> +#else
> + ? ? ? return 0;
> +#endif
>
> ?fail_free_irq:
> ? ? ? ?free_irq(irq, info);
> @@ -1364,7 +1368,9 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
> ? ? ? ?platform_set_drvdata(pdev, NULL);
>
> ? ? ? ?del_mtd_device(mtd);
> +#ifdef CONFIG_MTD_PARTITIONS
> ? ? ? ?del_mtd_partitions(mtd);
> +#endif
> ? ? ? ?irq = platform_get_irq(pdev, 0);
> ? ? ? ?if (irq >= 0)
> ? ? ? ? ? ? ? ?free_irq(irq, info);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>

Hi Mark,

Don't forget to cc maintainer of mtd tree. I loop them now.

Thanks
Haojian

From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 19:48:56 -0300
Subject: [PATCH 1/3] mtd: omap-onenand: pass device_node in platform data
In-Reply-To: <1356307280-8323-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1356307280-8323-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CALF0-+Xpvn45ZXOawyFzkqMt5t7--CLZYhkr6RwRX7WWnqdnqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Artem,

On Sun, Dec 23, 2012 at 9:01 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Pass an optional device_node pointer in the platform data,
> which in turn will be put into a mtd_part_parser_data.
> This way, code that sets up the platform devices can pass
> along the node from DT so that the partitions can be parsed.
>
> For non-DT boards, this change has no effect.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/mtd/onenand/omap2.c                     |    4 +++-
>  include/linux/platform_data/mtd-onenand-omap2.h |    3 +++
>  2 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 065f3fe..eec2aed 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -637,6 +637,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>         struct onenand_chip *this;
>         int r;
>         struct resource *res;
> +       struct mtd_part_parser_data ppdata = {};
>
>         pdata = pdev->dev.platform_data;
>         if (pdata == NULL) {
> @@ -767,7 +768,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>         if ((r = onenand_scan(&c->mtd, 1)) < 0)
>                 goto err_release_regulator;
>
> -       r = mtd_device_parse_register(&c->mtd, NULL, NULL,
> +       ppdata.of_node = pdata->of_node;
> +       r = mtd_device_parse_register(&c->mtd, NULL, &ppdata,
>                                       pdata ? pdata->parts : NULL,
>                                       pdata ? pdata->nr_parts : 0);
>         if (r)
> diff --git a/include/linux/platform_data/mtd-onenand-omap2.h b/include/linux/platform_data/mtd-onenand-omap2.h
> index 685af7e..e9a9fb1 100644
> --- a/include/linux/platform_data/mtd-onenand-omap2.h
> +++ b/include/linux/platform_data/mtd-onenand-omap2.h
> @@ -29,5 +29,8 @@ struct omap_onenand_platform_data {
>         u8                      flags;
>         u8                      regulator_can_sleep;
>         u8                      skip_initial_unlocking;
> +
> +       /* for passing the partitions */
> +       struct device_node      *of_node;
>  };
>  #endif
> --
> 1.7.8.6
>

I saw you have acked the gpmc patch on nand.
Can I add your Acked-by on this one, when I send the rebased patch set?

Thanks,

-- 
    Ezequiel

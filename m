From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Mon, 17 Dec 2012 11:10:10 +0900
Subject: [PATCH 3/4 v2] spi: sh-msiof: Add device tree parsing to driver
In-Reply-To: <1355313289-29769-3-git-send-email-hechtb+renesas@gmail.com>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
 <1355313289-29769-3-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <CABMQnV+CSEKwq=4kQYUDXOuARLA_WgvnkJEME_VeYmAv3PLXBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bastian.

On Wed, Dec 12, 2012 at 8:54 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> From: Bastian Hecht <hechtb@gmail.com>
>
> This adds the capability to retrieve setup data from the device tree
> node. The usage of platform data is still available.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v2:
>         - renamed property "chip_select" to "num-cs"
>         - renamed property "tx_fifo_size" to "renesas,tx-fifo-size"
>         - renamed property "rx_fifo_size" to "renesas,rx-fifo-size"
>
>  drivers/spi/spi-sh-msiof.c |   56 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 96358d0..8b40d08 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -20,6 +20,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> @@ -592,6 +593,37 @@ static u32 sh_msiof_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
>         return 0;
>  }
>
> +#ifdef CONFIG_OF
> +static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
> +{
> +       struct sh_msiof_spi_info *info;
> +       struct device_node *np = dev->of_node;
> +       u32 num_cs = 0;
> +
> +       info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
> +       if (!info) {
> +               dev_err(dev, "failed to allocate setup data\n");
> +               return NULL;
> +       }
> +
> +       /* Parse the MSIOF properties */
> +       of_property_read_u32(np, "num-cs", &num_cs);
> +       of_property_read_u32(np, "renesas,tx-fifo-size",
> +                                       &info->tx_fifo_override);
> +       of_property_read_u32(np, "renesas,rx-fifo-size",
> +                                       &info->rx_fifo_override);
> +
> +       info->num_chipselect = num_cs;
> +
> +       return info;
> +}
> +#else
> +static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  static int sh_msiof_spi_probe(struct platform_device *pdev)
>  {
>         struct resource *r;
> @@ -610,7 +642,17 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>         p = spi_master_get_devdata(master);
>
>         platform_set_drvdata(pdev, p);
> -       p->info = pdev->dev.platform_data;
> +       if (pdev->dev.of_node)
> +               p->info = sh_msiof_spi_parse_dt(&pdev->dev);
> +       else
> +               p->info = pdev->dev.platform_data;
> +
> +       if (!p->info) {
> +               dev_err(&pdev->dev, "failed to obtain device info\n");
> +               ret = -ENXIO;
> +               goto err1;
> +       }
> +
>         init_completion(&p->done);
>
>         p->clk = clk_get(&pdev->dev, NULL);
> @@ -715,6 +757,17 @@ static int sh_msiof_spi_runtime_nop(struct device *dev)
>         return 0;
>  }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id sh_msiof_match[] = {
> +       { .compatible = "renesas,sh-msiof", },
> +       { .compatible = "renesas,sh-mobile-msiof", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sh_msiof_match);
> +#else
> +#define sh_msiof_match NULL
> +#endif

You can remove ifdef if you use of_match_ptr().

> +
>  static struct dev_pm_ops sh_msiof_spi_dev_pm_ops = {
>         .runtime_suspend = sh_msiof_spi_runtime_nop,
>         .runtime_resume = sh_msiof_spi_runtime_nop,
> @@ -727,6 +780,7 @@ static struct platform_driver sh_msiof_spi_drv = {
>                 .name           = "spi_sh_msiof",
>                 .owner          = THIS_MODULE,
>                 .pm             = &sh_msiof_spi_dev_pm_ops,
> +               .of_match_table = sh_msiof_match,

You can use of_match_ptr(sh_msiof_match).

>         },
>  };
>  module_platform_driver(sh_msiof_spi_drv);
> --
> 1.7.9.5

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 2 Jun 2018 21:03:48 +0900
Subject: [PATCH 8/8] media: uniphier: add LD20 adapter driver for ISDB
In-Reply-To: <20180530090946.1635-9-suzuki.katsuhiro@socionext.com>
References: <20180530090946.1635-1-suzuki.katsuhiro@socionext.com>
 <20180530090946.1635-9-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNARx0Em0P9BWfTGjroGkyELeHo3T-YcWWDAwdsGePXuS0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-05-30 18:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds UniPhier LD20 DVB adapter driver for ISDB-S/T
> that equipments SONY SUT-PJ series using CXD2858 tuner and Socionext
> MN884434 demodulator.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  drivers/media/platform/uniphier/Kconfig       |  10 +
>  drivers/media/platform/uniphier/Makefile      |   1 +
>  .../platform/uniphier/ld20-mn884434-helene.c  | 274 ++++++++++++++++++
>  3 files changed, 285 insertions(+)
>  create mode 100644 drivers/media/platform/uniphier/ld20-mn884434-helene.c
>


> +
> +static const struct of_device_id uniphier_hsc_adapter_of_match[] = {
> +       {
> +               .compatible = "socionext,uniphier-ld20-mn884434-helene",
> +               .data = &ld20_mn884434_helene_spec,
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_hsc_adapter_of_match);
> +
> +static struct platform_driver uniphier_hsc_adapter_driver = {
> +       .driver = {
> +               .name = "uniphier-ld20-isdb",
> +               .of_match_table = of_match_ptr(uniphier_hsc_adapter_of_match),
> +       },
> +       .probe  = uniphier_adapter_probe,
> +       .remove = uniphier_adapter_remove,
> +};
> +module_platform_driver(uniphier_hsc_adapter_driver);
> +
> +MODULE_AUTHOR("Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier LD20 adapter driver for ISDB.");
> +MODULE_LICENSE("GPL v2");


This is weird.

>From drivers/media/platform/uniphier/Makefile,
obviously you link all the objects into the single module, uniphier-dvb.ko


It contains zero, one, or two sets of MODULE_* depending on CONFIG options.


 - Zero MODULE_LICENSE / MODULE_AUTHOR / MODULE_DESCRIPTION
   if CONFIG_DVB_UNIPHIER_LD11_ISDB=n &&
      CONFIG_DVB_UNIPHIER_LD20_ISDB=n


 - Two sets of MODULE_LICENSE / MODULE_AUTHOR / MODULE_DESCRIPTION
   if CONFIG_DVB_UNIPHIER_LD11_ISDB=y &&
      CONFIG_DVB_UNIPHIER_LD20_ISDB=y



What you can do is:

 - Split the module into core, ld11, ld20

    or

 - Move the module tags and entry to hsc-core.c
   and leave only the data arrays in ld11, ld20.






-- 
Best Regards
Masahiro Yamada

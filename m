From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 7 Sep 2017 09:36:21 +0900
Subject: [PATCH v1 2/3] nvmem: uniphier: add UniPhier eFuse driver
In-Reply-To: <CAK7LNAQc_xJ9qCQw=taeO24-2kzXW4pQHXfJ5+FhsO4-aXG4zQ@mail.gmail.com>
References: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
 <1504221620-358-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAK7LNAQc_xJ9qCQw=taeO24-2kzXW4pQHXfJ5+FhsO4-aXG4zQ@mail.gmail.com>
Message-ID: <000001d32771$544d0dc0$fce72940$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yamada-san,

Thank you for your comment.

> From: Masahiro Yamada [mailto:yamada.masahiro at socionext.com]
> Sent: Monday, September 4, 2017 9:58 PM
> 
> 2017-09-01 8:20 GMT+09:00 Keiji Hayashibara
> <hayashibara.keiji@socionext.com>:
> > Add eFuse driver for Socionext UniPhier series SoC.
> > Note that eFuse device is under soc-glue and this register implements
> > as read only.
> >
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > ---
> >  arch/arm64/configs/defconfig   |  1 +
> >  drivers/nvmem/Kconfig          | 11 +++++
> >  drivers/nvmem/Makefile         |  2 +
> >  drivers/nvmem/uniphier-efuse.c | 98
> > ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 112 insertions(+)
> >  create mode 100644 drivers/nvmem/uniphier-efuse.c
> >
> > diff --git a/arch/arm64/configs/defconfig
> > b/arch/arm64/configs/defconfig index 6c7d147..5c38b4a 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -514,6 +514,7 @@ CONFIG_PHY_XGENE=y  CONFIG_PHY_TEGRA_XUSB=y
> > CONFIG_QCOM_L2_PMU=y  CONFIG_QCOM_L3_PMU=y
> > +CONFIG_UNIPHIER_EFUSE=y
> >  CONFIG_ARM_SCPI_PROTOCOL=y
> >  CONFIG_RASPBERRYPI_FIRMWARE=y
> >  CONFIG_EFI_CAPSULE_LOADER=y
> 
> 
> You need to send this separately
> (after this driver is accepted)

I see.
Next I will post this separately.

> 
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig index
> > 101ced4..aaeaebe 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -123,6 +123,17 @@ config NVMEM_SUNXI_SID
> >           This driver can also be built as a module. If so, the module
> >           will be called nvmem_sunxi_sid.
> >
> > +config UNIPHIER_EFUSE
> > +       tristate "UniPhier SoCs eFuse support"
> > +       depends on ARCH_UNIPHIER || COMPILE_TEST
> > +       depends on OF && MFD_SYSCON
> > +       help
> > +         This is a simple drive to dump specified values of UniPhier
> SoC
> > +         from eFuse.
> 
> 
> s/drive/driver/
> 
> 
> I see the same typo in ROCKCHIP_EFUSE.
> 
> You copied it verbatim.
> 

I will fix it...

> 
> 
> > +         This driver can also be built as a module. If so, the module
> > +         will be called nvmem_uniphier-efuse.
> 
> 
> I do not like a mixture of '_' and '-' though...
> 

I will fix it.
> 
> 
> >  config NVMEM_VF610_OCOTP
> >         tristate "VF610 SoC OCOTP support"
> >         depends on SOC_VF610 || COMPILE_TEST diff --git
> > a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile index
> > 1731406..f5277c3 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -26,6 +26,8 @@ obj-$(CONFIG_ROCKCHIP_EFUSE)  +=
> nvmem_rockchip_efuse.o
> >  nvmem_rockchip_efuse-y         := rockchip-efuse.o
> >  obj-$(CONFIG_NVMEM_SUNXI_SID)  += nvmem_sunxi_sid.o
> >  nvmem_sunxi_sid-y              := sunxi_sid.o
> > +obj-$(CONFIG_UNIPHIER_EFUSE)   += nvmem_uniphier-efuse.o
> > +nvmem_uniphier-efuse-y         := uniphier-efuse.o
> >  obj-$(CONFIG_NVMEM_VF610_OCOTP)        += nvmem-vf610-ocotp.o
> >  nvmem-vf610-ocotp-y            := vf610-ocotp.o
> >  obj-$(CONFIG_MESON_EFUSE)      += nvmem_meson_efuse.o
> > diff --git a/drivers/nvmem/uniphier-efuse.c
> > b/drivers/nvmem/uniphier-efuse.c new file mode 100644 index
> > 0000000..d553fa3
> > --- /dev/null
> > +++ b/drivers/nvmem/uniphier-efuse.c
> > @@ -0,0 +1,98 @@
> > +/*
> > + * UniPhier eFuse driver
> > + *
> > + * Copyright (C) 2017 Socionext Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define UNIPHIER_EFUSE_WORD_SIZE       4
> > +#define UNIPHIER_EFUSE_STRIDE          4
> > +
> > +static int uniphier_reg_read(void *context,
> > +                            unsigned int offset, void *val, size_t
> > +bytes) {
> > +       int words = bytes / UNIPHIER_EFUSE_WORD_SIZE;
> > +
> > +       return regmap_bulk_read(context, offset, val, words); }
> > +
> > +static struct nvmem_config econfig = {
> > +       .name = "uniphier-efuse",
> > +       .owner = THIS_MODULE,
> > +       .read_only = true,
> > +       .reg_read = uniphier_reg_read,
> > +       .word_size = UNIPHIER_EFUSE_WORD_SIZE,
> > +       .stride = UNIPHIER_EFUSE_STRIDE, };
> 
> 
> 
> "struct nvmem_config" exists for the purpose of containing driver-specific
> parameters.
> Do you still want to use
> UNIPHIER_EFUSE_WORD_SIZE / UNIPHIER_EFUSE_STRIDE macros here?
> 
> 
> 
> 
> static struct nvmem_config econfig = {
>        .name = "uniphier-efuse",
>        .owner = THIS_MODULE,
>        .read_only = true,
>        .reg_read = uniphier_reg_read,
>        .word_size = 4,
>        .stride = 4,
> };
> 
> looks nicer in my taste.
> 

I will fix it.

> 
> BTW, is there really no possibility
> where the unphier_efuse_probe() is run concurrently?
> 
> Many other drivers pass statically allocated memory to nvmem_register()
> like this...
> 
In the case of the uniphier system, since there is only one efuse device,
it will not run concurrently. 
I would like to fix it when I need it in the future.

> 
> > +static int uniphier_efuse_probe(struct platform_device *pdev) {
> > +       struct device *dev = &pdev->dev;
> > +       struct nvmem_device *nvmem;
> > +       struct regmap *regmap;
> > +       struct resource res;
> > +       int ret;
> > +
> > +       ret = of_address_to_resource(dev->of_node, 0, &res);
> > +       if (ret)
> > +               return ret;
> > +
> > +       regmap = syscon_node_to_regmap(dev->of_node);
> > +       if (IS_ERR(regmap))
> > +               return PTR_ERR(regmap);
> 
> 
> In my understanding,
> syscon_node_to_regmap() is generally useful to get regmap of another node,
> i.e. it is often used together with of_get_parent / of_parse_phandle etc.
> 
> You can use devm_regmap_init_mmio()
> to init regmap for itself.
> 
> 
> BTW, what is your motivation of using regmap?
>
> 
> I think what you want to do is
> the same as mtk-efuse.c, right?
> (and qfprom.c is similar, the difference is just register width)

Since redundancy can be omitted, implementation is easier, I think so.
However, since I can't find the merit of using regmap,
I will implement it in a method that does not use it.

> 
> 
> > +       econfig.size = resource_size(&res);
> > +       econfig.priv = regmap;
> > +       econfig.dev = dev;
> > +
> > +       nvmem = nvmem_register(&econfig);
> > +       if (IS_ERR(nvmem))
> > +               return PTR_ERR(nvmem);
> > +
> > +       platform_set_drvdata(pdev, nvmem);
> > +
> > +       return 0;
> > +}
> > +
> > +static int uniphier_efuse_remove(struct platform_device *pdev) {
> > +       struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> > +
> > +       return nvmem_unregister(nvmem); }
> > +
> > +static const struct of_device_id uniphier_efuse_of_match[] = {
> > +       { .compatible = "socionext,uniphier-efuse",},
> > +       {/* sentinel */},
> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_efuse_of_match);
> > +
> > +static struct platform_driver uniphier_efuse_driver = {
> > +       .probe = uniphier_efuse_probe,
> > +       .remove = uniphier_efuse_remove,
> > +       .driver = {
> > +               .name = "uniphier-efuse",
> > +               .of_match_table = uniphier_efuse_of_match,
> > +       },
> > +};
> > +module_platform_driver(uniphier_efuse_driver);
> > +
> > +MODULE_AUTHOR("Keiji Hayashibara <hayashibara.keiji@socionext.com>");
> > +MODULE_DESCRIPTION("UniPhier eFuse driver"); MODULE_LICENSE("GPL
> > +v2");
> > --
> > 2.7.4
> >
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada

Best Regards,
Keiji Hayashibara

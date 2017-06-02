From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 2 Jun 2017 17:35:45 +0800
Subject: [PATCH 3/6] mfd: hi6421v530: add support for HiSilicon Hi6421v530
In-Reply-To: <20170530073606.tm4gacph4yj47ntx@dell>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
 <20170526063518.21246-4-guodong.xu@linaro.org>
 <20170530073606.tm4gacph4yj47ntx@dell>
Message-ID: <CAFGCpxzvJ2hm0hrb6T-faPeKhLhMOMMWZi7HO=oUOa+pHFdd2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 3:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 26 May 2017, Guodong Xu wrote:
>
>> Add support for HiSilicon Hi6421v530 PMIC. Hi6421v530 communicates with
>> main SoC via memory-mapped I/O.
>>
>> Hi6421v530 and Hi6421 are PMIC chips from the same vendor, HiSilicon, but
>> at different revisions. They share the same memory-mapped I/O design. They
>> differ in regulator details, eg. LDO voltage points.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>> ---
>>  drivers/mfd/Kconfig           |  9 +++++
>>  drivers/mfd/Makefile          |  1 +
>>  drivers/mfd/hi6421v530-pmic.c | 92 +++++++++++++++++++++++++++++++++++++++++++
>
> As previously discussed, this support should be added to the existing
> driver.

Yes, I will do that.

>
>>  3 files changed, 102 insertions(+)
>>  create mode 100644 drivers/mfd/hi6421v530-pmic.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3eb5c93..bdc8304 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -388,6 +388,15 @@ config MFD_HI6421_PMIC
>>         menus in order to enable them.
>>         We communicate with the Hi6421 via memory-mapped I/O.
>>
>> +config MFD_HI6421V530_PMIC
>> +     tristate "HiSilicon Hi6421v530 PMU/Codec IC"
>> +     depends on OF
>> +     select MFD_CORE
>> +     select REGMAP_MMIO
>> +     help
>> +       Add support for HiSilicon Hi6421v530 PMIC. Hi6421v530 communicates
>> +       with main SoC via memory-mapped I/O.
>> +
>>  config MFD_HI655X_PMIC
>>       tristate "HiSilicon Hi655X series PMU/Codec IC"
>>       depends on ARCH_HISI || COMPILE_TEST
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index c16bf1e..cde62fc 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -206,6 +206,7 @@ obj-$(CONFIG_MFD_STW481X) += stw481x.o
>>  obj-$(CONFIG_MFD_IPAQ_MICRO) += ipaq-micro.o
>>  obj-$(CONFIG_MFD_MENF21BMC)  += menf21bmc.o
>>  obj-$(CONFIG_MFD_HI6421_PMIC)        += hi6421-pmic-core.o
>> +obj-$(CONFIG_MFD_HI6421V530_PMIC)    += hi6421v530-pmic.o
>>  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>>  obj-$(CONFIG_MFD_DLN2)               += dln2.o
>>  obj-$(CONFIG_MFD_RT5033)     += rt5033.o
>> diff --git a/drivers/mfd/hi6421v530-pmic.c b/drivers/mfd/hi6421v530-pmic.c
>> new file mode 100644
>> index 0000000..651659a
>> --- /dev/null
>> +++ b/drivers/mfd/hi6421v530-pmic.c
>> @@ -0,0 +1,92 @@
>> +/*
>> + * Device driver for Hi6421 IC
>> + *
>> + * Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
>> + *              http://www.hisilicon.com
>> + * Copyright (c) <2017> Linaro Ltd.
>> + *              http://www.linaro.org
>> + *
>> + * Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>> + *         Guodong Xu <guodong.xu@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>
> Can you use the shorter licence script?
>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/hi6421-pmic.h>
>
> Alphabetical.
>

I will update that in the existing drivers/mfd/hi6421-pmic-core.c
together with my other changes.

>> +static const struct mfd_cell hi6421v530_devs[] = {
>> +     { .name = "hi6421v530-regulator", },
>> +};
>
> Chen Feng promised me that he would add other devices to the original
> driver nearly 18 months ago.  Until more devices are added, these are
> not MFD drivers.  When will you add the remaining devices?
>

New devices will be added when enabling functions on the hikey960
board. v530 provides a clk for wifi/bt, that can be added very quick.

>> +static int hi6421v530_pmic_probe(struct platform_device *pdev)
>> +{
>> +     struct hi6421_pmic *pmic;
>> +     struct resource *res;
>> +     void __iomem *base;
>> +     int ret;
>> +
>> +     pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
>> +     if (!pmic)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     pmic->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
>> +                                              &hi6421_regmap_config);
>> +     if (IS_ERR(pmic->regmap)) {
>> +             dev_err(&pdev->dev,
>> +                     "regmap init failed: %ld\n", PTR_ERR(pmic->regmap));
>
> "Failed to initialise Regmap"

Thanks, will update in the existing drivers/mfd/hi6421-pmic-core.c

>
>> +             return PTR_ERR(pmic->regmap);
>> +     }
>> +
>> +     platform_set_drvdata(pdev, pmic);
>> +
>> +     ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421v530_devs,
>
> Use the #defines provided instead of '0'.
>
>> +                                ARRAY_SIZE(hi6421v530_devs), NULL, 0, NULL);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
>
> "Failed to add child devices"
>

Thanks, will update in the existing drivers/mfd/hi6421-pmic-core.c

>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id of_hi6421v530_pmic_match_tbl[] = {
>> +     { .compatible = "hisilicon,hi6421v530-pmic", },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_hi6421v530_pmic_match_tbl);
>
> Drop the "_tbl" part, it's implied and superfluous.
>

Will update.

>> +static struct platform_driver hi6421v530_pmic_driver = {
>> +     .driver = {
>> +             .name   = "hi6421v530_pmic",
>
> One space please.
>

Thanks, will update.

I will send updates in v3 soon.

-Guodong

>> +             .of_match_table = of_hi6421v530_pmic_match_tbl,
>> +     },
>> +     .probe  = hi6421v530_pmic_probe,
>> +};
>> +module_platform_driver(hi6421v530_pmic_driver);
>> +
>> +MODULE_AUTHOR("Guodong Xu <guodong.xu@linaro.org>");
>> +MODULE_DESCRIPTION("Hi6421v530 PMIC driver");
>> +MODULE_LICENSE("GPL v2");
>
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

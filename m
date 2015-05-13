From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 13 May 2015 09:31:59 -0700
Subject: [PATCH v8 5/9] mfd: Add driver for NVIDIA Tegra XUSB
In-Reply-To: <20150513143715.GZ3394@x1>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-6-git-send-email-abrestic@chromium.org>
 <20150513143715.GZ3394@x1>
Message-ID: <CAL1qeaEJMfS7KO=w+3koMsVr5UR9CH2QmJQq7KAf2a0fuA4GOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee,

On Wed, May 13, 2015 at 7:37 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 04 May 2015, Andrew Bresticker wrote:
>
>> Add an MFD driver for the XUSB host complex found on NVIDIA Tegra124
>> and later SoCs.
>
> What else does it do besides USB?

Nothing - it's just the xHCI host controller and mailbox.  As I
mentioned in the binding document, the purpose of this is simply to
map and share the register set which is shared between the two
devices.

>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> ---
>> Changes from v7:
>>  - Have child nodes get non-shared memory and interrupts from DT.
>>  - Use of_platform_populate rather than mfd_add_devices.
>>  - Get rid of struct tegra_xusb.
>> New for v7.
>> ---
>>  drivers/mfd/Kconfig      |  7 +++++
>>  drivers/mfd/Makefile     |  1 +
>>  drivers/mfd/tegra-xusb.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 83 insertions(+)
>>  create mode 100644 drivers/mfd/tegra-xusb.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index d5ad04d..61872b4 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1430,6 +1430,13 @@ config MFD_STW481X
>>         in various ST Microelectronics and ST-Ericsson embedded
>>         Nomadik series.
>>
>> +config MFD_TEGRA_XUSB
>> +     tristate "NVIDIA Tegra XUSB"
>> +     depends on ARCH_TEGRA
>> +     select MFD_CORE
>> +     help
>> +       Support for the XUSB complex found on NVIDIA Tegra124 and later SoCs.
>> +
>>  menu "Multimedia Capabilities Port drivers"
>>       depends on ARCH_SA1100
>>
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 0e5cfeb..7588caf 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)     += hi6421-pmic-core.o
>>  obj-$(CONFIG_MFD_DLN2)               += dln2.o
>>  obj-$(CONFIG_MFD_RT5033)     += rt5033.o
>>  obj-$(CONFIG_MFD_SKY81452)   += sky81452.o
>> +obj-$(CONFIG_MFD_TEGRA_XUSB) += tegra-xusb.o
>>
>>  intel-soc-pmic-objs          := intel_soc_pmic_core.o intel_soc_pmic_crc.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC) += intel-soc-pmic.o
>> diff --git a/drivers/mfd/tegra-xusb.c b/drivers/mfd/tegra-xusb.c
>> new file mode 100644
>> index 0000000..e11fa23
>> --- /dev/null
>> +++ b/drivers/mfd/tegra-xusb.c
>> @@ -0,0 +1,75 @@
>> +/*
>> + * NVIDIA Tegra XUSB MFD driver
>> + *
>> + * Copyright (C) 2015 Google, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +static const struct of_device_id tegra_xusb_of_match[] = {
>> +     { .compatible = "nvidia,tegra124-xusb", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
>
> If you're not using this to patch on, I'd prefer you place it next to
> where it's first used i.e. down at the bottom of the file.

Ok.

>> +static struct regmap_config tegra_fpci_regmap_config = {
>> +     .reg_bits = 32,
>> +     .val_bits = 32,
>> +     .reg_stride = 4,
>> +};
>> +
>> +static int tegra_xusb_probe(struct platform_device *pdev)
>> +{
>> +     struct resource *res;
>> +     struct regmap *fpci_regs;
>> +     void __iomem *fpci_base;
>> +     int ret;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     fpci_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(fpci_base))
>> +             return PTR_ERR(fpci_base);
>> +
>> +     tegra_fpci_regmap_config.max_register = res->end - res->start - 3;
>> +     fpci_regs = devm_regmap_init_mmio(&pdev->dev, fpci_base,
>> +                                       &tegra_fpci_regmap_config);
>> +     if (IS_ERR(fpci_regs)) {
>> +             ret = PTR_ERR(fpci_regs);
>> +             dev_err(&pdev->dev, "Failed to init regmap: %d\n", ret);
>> +             return ret;
>> +     }
>> +     platform_set_drvdata(pdev, fpci_regs);
>> +
>> +     ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to add sub-devices: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver tegra_xusb_driver = {
>> +     .probe = tegra_xusb_probe,
>
> No .remove()?

It would be empty.

Thanks,
Andrew

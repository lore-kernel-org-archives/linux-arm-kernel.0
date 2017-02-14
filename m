From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Feb 2017 07:46:18 -0800
Subject: [PATCH v2] reset: Add i.MX7 SRC reset driver
In-Reply-To: <1487004643.2873.97.camel@pengutronix.de>
References: <20170213153338.13518-1-andrew.smirnov@gmail.com>
 <1487004643.2873.97.camel@pengutronix.de>
Message-ID: <CAHQ1cqFXiu03902jWLkg8X6jdQ3+TiLj02dSDFBAVH98ABo70A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 8:50 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Andrey,
>
> thank you for the driver, I have a few comments below.
>
> On Mon, 2017-02-13 at 07:33 -0800, Andrey Smirnov wrote:
>> This driver exposes various reset faculties, impelented by System Reset
>
> s/impelented/implemented/

Thanks for noticing, will fix in v3.

>
>> Controller IP block, as a reset driver. Currently only PCIE related
>> reset lines are implemented.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> Changes since v1 (see [v1]):
>>
>>       - Various small DT bindings description fixes as per feedback
>>           from Rob Herring
>>
>>
>> [v1] https://lkml.org/lkml/2017/2/6/554
>>
>>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  47 +++++++
>>  drivers/reset/Kconfig                              |   8 ++
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-imx7.c                         | 149 +++++++++++++++++++++
>>  include/dt-bindings/reset/imx7-reset.h             |  28 ++++
>>  5 files changed, 233 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>>  create mode 100644 drivers/reset/reset-imx7.c
>>  create mode 100644 include/dt-bindings/reset/imx7-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>> new file mode 100644
>> index 0000000..c38f7f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>> @@ -0,0 +1,47 @@
>> +Freescale i.MX7 System Reset Controller
>> +======================================
>> +
>> +Please also refer to reset.txt in this directory for common reset
>> +controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be "fsl,imx7-src", "syscon"
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +- interrupts: Should contain SRC interrupt
>> +- #reset-cells: 1, see below
>> +
>> +example:
>> +
>> +src: reset-controller at 30390000 {
>> +     compatible = "fsl,imx7d-src", "syscon";
>> +     reg = <0x30390000 0x2000>;
>> +     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>> +     #reset-cells = <1>;
>> +};
>> +
>> +
>> +Specifying reset lines connected to IP modules
>> +==============================================
>> +
>> +The system reset controller can be used to reset various set of
>> +peripherals. Device nodes that need access to reset lines should
>> +specify them as a reset phandle in their corresponding node as
>> +specified in reset.txt.
>> +
>> +Example:
>> +
>> +     pcie: pcie at 33800000 {
>> +
>> +             ...
>> +
>> +             resets = <&src IMX7_RESET_PCIEPHY>,
>> +                      <&src IMX7_RESET_PCIE_CTRL_APPS>;
>> +             reset-names = "pciephy", "apps";
>> +
>> +             ...
>> +        };
>> +
>> +
>> +For list of all valid reset indicies see
>> +<dt-bindings/reset/imx7-reset.h>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 172dc96..664a88b 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -92,6 +92,14 @@ config RESET_ZYNQ
>>       help
>>         This enables the reset controller driver for Xilinx Zynq SoCs.
>>
>> +config RESET_IMX7
>> +     bool "i.MX7 Reset Driver"
>> +     depends on SOC_IMX7D || COMPILE_TEST
>> +     select MFD_SYSCON
>> +     default SOC_IMX7D
>> +     help
>> +       This enables the reset controller driver for i.MX7 SoCs.
>> +
>
> Alphabetical order, please.

OK, will fix in v3.

>
>>  source "drivers/reset/sti/Kconfig"
>>  source "drivers/reset/hisilicon/Kconfig"
>>  source "drivers/reset/tegra/Kconfig"
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 13b346e..417c9d0 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>>  obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>> +obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>
> See above, those are also in alphabetical order.

Ditto.

>
>> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
>> new file mode 100644
>> index 0000000..6d90e57
>> --- /dev/null
>> +++ b/drivers/reset/reset-imx7.c
>> @@ -0,0 +1,149 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * i.MX7 System Reset Controller (SRC) driver
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>
> I think this is not be necessary because register access is done via
> regmap. Please cull unnecessary headers.

OK, will do for v3.

>
>> +#include <linux/init.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
>> +#include <dt-bindings/reset/imx7-reset.h>
>> +
>> +struct imx7_src {
>> +     struct reset_controller_dev rcdev;
>> +     struct device *dev;
>> +     struct regmap *regmap;
>> +};
>> +
>> +enum imx7_src_registers {
>> +     SRC_PCIEPHY_RCR = 0x002c,
>> +     SRC_PCIEPHY_RCR_PCIEPHY_G_RST     = BIT(1),
>
> What about the others resets? There's at least HSICPHY, MIPIPHY and
> USBOPHY registers before the PCIEPHY register.

I don't really have any code using anything but PCI reset related
functionality, so I can't test any of the resets you mention. In light
of that I didn't want to add any of the definitions that are not going
to be used anywhere in the code.

>
>> +     SRC_PCIEPHY_RCR_PCIEPHY_BTN       = BIT(2),
>> +     SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN = BIT(6),
>
> Are those really resets? At least the PCIE_CTRL_APPS_EN has a bit called
> PCIE_CTRL_APPS_RST right next to it, so this warrants some explanation.
>

Public documentation for that aspect of i.MX7 is nonexistent and,
unfortunately, that is my only source of information. Given that, I
can't really tell you what the difference between PCIE_CTRL_APPS_EN
and PCIE_CTRL_APPS_RST besides that the former is what downstream PCIe
driver uses to inhibit LTSSM and the latter is not referenced or used
by any code (as far as I am aware).

>> +};
>> +
>> +static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
>> +{
>> +     return container_of(rcdev, struct imx7_src, rcdev);
>> +}
>> +
>> +static int imx7_reset_assert(struct reset_controller_dev *rcdev,
>> +                          unsigned long id)
>> +{
>> +     struct imx7_src *imx7src = to_imx7_src(rcdev);
>> +
>> +     switch (id) {
>> +     case IMX7_RESET_PCIE_CTRL_APPS:
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN, 0);
>> +             return 0;
>> +
>> +     case IMX7_RESET_PCIEPHY:
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_G_RST,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_G_RST);
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN);
>
> What is the PCIE PHY button, and why does it have to be set with the
> reset bit?

I am sorry, but just as above, I wouldn't be able to enlighten you any
more about the subject. I have no knowledge about the details of G_RST
and BTN signal (or even if BTN stands for "button") behavior beyond
the fact that that is how downstream driver performs PCIEPHY reset.

>
>> +             return 0;
>> +     default:
>> +             dev_err(imx7src->dev, "Unknown reset ID %lu\n", id);
>> +             break;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int imx7_reset_deassert(struct reset_controller_dev *rcdev,
>> +                            unsigned long id)
>> +{
>> +     struct imx7_src *imx7src = to_imx7_src(rcdev);
>> +
>> +     switch (id) {
>> +     case IMX7_RESET_PCIE_CTRL_APPS:
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN,
>> +                                SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN);
>> +             return 0;
>> +
>> +     case IMX7_RESET_PCIEPHY:
>> +             /* wait for more than 10us to release phy g_rst and btnrst */
>> +             udelay(10);
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_G_RST, 0);
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN, 0);
>> +             return 0;
>> +     default:
>> +             dev_err(imx7src->dev, "Unknown reset ID %lu\n", id);
>> +             break;
>> +     };
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static const struct reset_control_ops imx7_reset_ops = {
>> +     .assert         = imx7_reset_assert,
>> +     .deassert       = imx7_reset_deassert,
>> +};
>> +
>> +static int imx7_reset_probe(struct platform_device *pdev)
>> +{
>> +     struct imx7_src *imx7src;
>> +     struct device *dev = &pdev->dev;
>> +
>> +     imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
>> +     if (!imx7src)
>> +             return -ENOMEM;
>> +
>> +     imx7src->dev = dev;
>> +     imx7src->regmap = syscon_node_to_regmap(dev->of_node);
>> +     if (IS_ERR(imx7src->regmap)) {
>> +             dev_err(dev, "Unable to get imx7-src regmap");
>> +             return PTR_ERR(imx7src->regmap);
>> +     }
>
> You could use regmap_attach_dev to attach the device to the regmap. This
> would improve error messages, regmap debugfs structure, and make
> imx7src->dev unnecessary.

OK, will do that in v3.

>
>> +
>> +     imx7src->rcdev.owner     = THIS_MODULE;
>> +     imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
>> +     imx7src->rcdev.ops       = &imx7_reset_ops;
>> +     imx7src->rcdev.of_node   = dev->of_node;
>> +
>> +     return devm_reset_controller_register(dev, &imx7src->rcdev);
>> +}
>> +
>> +static const struct of_device_id imx7_reset_dt_ids[] = {
>> +     { .compatible = "fsl,imx7d-src", },
>> +     { /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver imx7_reset_driver = {
>> +     .probe  = imx7_reset_probe,
>> +     .driver = {
>> +             .name           = KBUILD_MODNAME,
>> +             .of_match_table = imx7_reset_dt_ids,
>> +     },
>> +};
>> +builtin_platform_driver(imx7_reset_driver);
>> diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
>> new file mode 100644
>> index 0000000..e20f2db
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/imx7-reset.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Copyright (C) 2017 Impinj, Inc.
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef DT_BINDING_RESET_IMX7_H
>> +#define DT_BINDING_RESET_IMX7_H
>> +
>> +#define IMX7_RESET_PCIE_CTRL_APPS    0
>> +#define IMX7_RESET_PCIEPHY           1
>
> It would expect these to be numbered in the order they appear in the
> register map, not starting from the end. Could you add all available
> peripheral resets to this list, in the correct order?

The numbering is just a consequence of me adding only resets I could
exercise with my code and numbering then starting from zero. I also
was hesitant adding more sources since it seemed to me that some of
less trivial registers in that IP block might be best represented as a
single reset source doing something more sophisticated that just
setting a bit under the hood.

Thanks,
Andrey Smirnov

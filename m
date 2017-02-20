From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 20 Feb 2017 11:46:26 -0800
Subject: [PATCH v3] reset: Add i.MX7 SRC reset driver
In-Reply-To: <1487607099.3878.44.camel@pengutronix.de>
References: <20170220152653.31739-1-andrew.smirnov@gmail.com>
 <1487607099.3878.44.camel@pengutronix.de>
Message-ID: <CAHQ1cqFKfez4mGS982mVUz7Sek9Ms2OAkqgd292aOh-RB3OQBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 8:11 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Andrey,
>
> On Mon, 2017-02-20 at 07:26 -0800, Andrey Smirnov wrote:
>> Add reset controller driver exposing various reset faculties,
>> implemented by System Reset Controller IP block.
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
>> Changes since v2 (see [v2]):
>>
>>       - Fix typos
>>
>>       - Kconfig/Makefile chagnes account for alphabetical sorting of
>>           those files
>>
>>       - Remove redundant includes
>>
>>       - Make use of regmap_attach_dev and avoid storing refernce to
>>           struct *dev in private data
>>
>>       - Change code and headers to expose almost all of the reset
>>           related bits in SRC IP block
>
> Thank you, this is looking much better!
>
>> Changes since v1 (see [v1]):
>>
>>       - Various small DT bindings description fixes as per feedback
>>           from Rob Herring
>>
>>
>> [v1] https://lkml.org/lkml/2017/2/6/554
>> [v2] https://lkml.org/lkml/2017/2/13/488
>>
>>
>>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  47 ++++++
>>  drivers/reset/Kconfig                              |   8 +
>>  drivers/reset/Makefile                             |   2 +
>>  drivers/reset/reset-imx7.c                         | 186 +++++++++++++++++++++
>>  include/dt-bindings/reset/imx7-reset.h             |  62 +++++++
>>  5 files changed, 305 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>>  create mode 100644 drivers/reset/reset-imx7.c
>>  create mode 100644 include/dt-bindings/reset/imx7-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>> new file mode 100644
>> index 0000000..5e1afc3
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
>> +                      <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
>> +             reset-names = "pciephy", "apps";
>> +
>> +             ...
>> +        };
>> +
>> +
>> +For list of all valid reset indicies see
>> +<dt-bindings/reset/imx7-reset.h>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 172dc96..bea1800 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -27,6 +27,14 @@ config RESET_BERLIN
>>       help
>>         This enables the reset controller driver for Marvell Berlin SoCs.
>>
>> +config RESET_IMX7
>> +     bool "i.MX7 Reset Driver"
>> +     depends on SOC_IMX7D || COMPILE_TEST
>> +     select MFD_SYSCON
>> +     default SOC_IMX7D
>> +     help
>> +       This enables the reset controller driver for i.MX7 SoCs.
>> +
>>  config RESET_LPC18XX
>>       bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
>>       default ARCH_LPC18XX
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 13b346e..a24aa80 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_STI) += sti/
>>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>> +obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>> @@ -14,3 +15,4 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>>  obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>> +
>> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
>> new file mode 100644
>> index 0000000..6e26796
>> --- /dev/null
>> +++ b/drivers/reset/reset-imx7.c
>> @@ -0,0 +1,186 @@
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
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/regmap.h>
>> +#include <dt-bindings/reset/imx7-reset.h>
>> +
>> +struct imx7_src {
>> +     struct reset_controller_dev rcdev;
>> +     struct regmap *regmap;
>> +};
>> +
>> +enum imx7_src_registers {
>> +     SRC_A7RCR0              = 0x0004,
>> +     SRC_M4RCR               = 0x000c,
>> +     SRC_ERCR                = 0x0014,
>> +     SRC_HSICPHY_RCR         = 0x001c,
>> +     SRC_USBOPHY1_RCR        = 0x0020,
>> +     SRC_USBOPHY2_RCR        = 0x0024,
>> +     SRC_MIPIPHY_RCR         = 0x0028,
>> +     SRC_PCIEPHY_RCR         = 0x002c,
>> +     SRC_DDRC_RCR            = 0x1000,
>> +
>> +     SRC_PCIEPHY_RCR_PCIEPHY_G_RST   = BIT(1),
>> +     SRC_PCIEPHY_RCR_PCIEPHY_BTN     = BIT(2),
>> +};
>> +
>> +struct imx7_src_signal {
>> +     unsigned int offset, bit;
>> +};
>> +
>> +static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
>> +     [IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
>> +     [IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
>> +     [IMX7_RESET_A7_CORE_RESET0]     = { SRC_A7RCR0, BIT(4) },
>> +     [IMX7_RESET_A7_CORE_RESET1]     = { SRC_A7RCR0, BIT(5) },
>> +     [IMX7_RESET_A7_DBG_RESET0]      = { SRC_A7RCR0, BIT(8) },
>> +     [IMX7_RESET_A7_DBG_RESET1]      = { SRC_A7RCR0, BIT(9) },
>> +     [IMX7_RESET_A7_ETM_RESET0]      = { SRC_A7RCR0, BIT(12) },
>> +     [IMX7_RESET_A7_ETM_RESET1]      = { SRC_A7RCR0, BIT(13) },
>> +     [IMX7_RESET_A7_SOC_DBG_RESET]   = { SRC_A7RCR0, BIT(20) },
>> +     [IMX7_RESET_A7_L2RESET]         = { SRC_A7RCR0, BIT(21) },
>> +     [IMX7_RESET_SW_M4C_RST]         = { SRC_M4RCR, BIT(1) },
>> +     [IMX7_RESET_SW_M4P_RST]         = { SRC_M4RCR, BIT(2) },
>> +     [IMX7_RESET_EIM_RST]            = { SRC_ERCR, BIT(0) },
>> +     [IMX7_RESET_HSICPHY_PORT_RST]   = { SRC_HSICPHY_RCR, BIT(1) },
>> +     [IMX7_RESET_USBPHY1_POR]        = { SRC_USBOPHY1_RCR, BIT(0) },
>> +     [IMX7_RESET_USBPHY1_PORT_RST]   = { SRC_USBOPHY1_RCR, BIT(1) },
>> +     [IMX7_RESET_USBPHY2_POR]        = { SRC_USBOPHY2_RCR, BIT(0) },
>> +     [IMX7_RESET_USBPHY2_PORT_RST]   = { SRC_USBOPHY2_RCR, BIT(1) },
>> +     [IMX7_RESET_MIPI_PHY_MRST]      = { SRC_MIPIPHY_RCR, BIT(1) },
>> +     [IMX7_RESET_MIPI_PHY_SRST]      = { SRC_MIPIPHY_RCR, BIT(2) },
>> +     [IMX7_RESET_PCIEPHY]            = { /* Placeholder */ },
>> +     [IMX7_RESET_PCIEPHY_PERST]      = { SRC_PCIEPHY_RCR, BIT(3) },
>> +     [IMX7_RESET_PCIE_CTRL_APPS_EN]  = { SRC_PCIEPHY_RCR, BIT(6) },
>> +     [IMX7_RESET_DDRC_PRST]          = { SRC_DDRC_RCR, BIT(0) },
>> +     [IMX7_RESET_DDRC_CORE_RST]      = { SRC_DDRC_RCR, BIT(1) },
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
>> +     const struct imx7_src_signal *signal = &imx7_src_signals[id];
>> +     unsigned int value = signal->bit;
>> +
>> +     switch (id) {
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
> Is it possible to assert (and deassert) both bits at the same time?
> That would allow to use the default case here.

Good point and I am not sure, I'll do an experiment and see if they can.

>
>> +             break;
>> +
>> +     case IMX7_RESET_PCIE_CTRL_APPS_EN:
>> +             value = 0;
>> +     default:                /* FALLTHROUGH */
>> +             regmap_update_bits(imx7src->regmap,
>> +                                signal->offset, signal->bit, value);
>> +             break;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int imx7_reset_deassert(struct reset_controller_dev *rcdev,
>> +                            unsigned long id)
>> +{
>> +     struct imx7_src *imx7src = to_imx7_src(rcdev);
>> +     const struct imx7_src_signal *signal = &imx7_src_signals[id];
>> +     unsigned int value = 0;
>> +
>> +     switch (id) {
>> +     case IMX7_RESET_PCIEPHY:
>> +             /*
>> +              * wait for more than 10us to release phy g_rst and
>> +              * btnrst
>> +              */
>> +             udelay(10);
>
> What is the purpose of this delay?

That's how downstream PCIe driver is using those lines. I haven't seen
anything in datasheet that would explain the purpose of it.

>
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_G_RST, 0);
>> +             regmap_update_bits(imx7src->regmap,
>> +                                SRC_PCIEPHY_RCR,
>> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN, 0);
>
> Same as above. Assert and deassert using the same order makes me think
> that the order may not be important at all. If they do on the other hand
> have to be flipped in a certain order, it would be better to expose them
> separately.
>
>> +             break;
>> +     case IMX7_RESET_PCIE_CTRL_APPS_EN:
>> +             value = signal->bit;
>> +     default:                /* FALLTHROUGH */
>> +             regmap_update_bits(imx7src->regmap,
>> +                                signal->offset, signal->bit, value);
>> +
>> +             break;
>> +     };
>> +
>> +     return 0;
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
>> +     struct regmap_config config = { .name = "src" };
>> +
>> +     imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
>> +     if (!imx7src)
>> +             return -ENOMEM;
>> +
>> +     imx7src->regmap = syscon_node_to_regmap(dev->of_node);
>> +     if (IS_ERR(imx7src->regmap)) {
>> +             dev_err(dev, "Unable to get imx7-src regmap");
>> +             return PTR_ERR(imx7src->regmap);
>> +     }
>> +     regmap_attach_dev(dev, imx7src->regmap, &config);
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
>> index 0000000..6394817
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/imx7-reset.h
>> @@ -0,0 +1,62 @@
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
>> +#define IMX7_RESET_A7_CORE_POR_RESET0        0
>> +#define IMX7_RESET_A7_CORE_POR_RESET1        1
>> +#define IMX7_RESET_A7_CORE_RESET0    2
>> +#define IMX7_RESET_A7_CORE_RESET1    3
>> +#define IMX7_RESET_A7_DBG_RESET0     4
>> +#define IMX7_RESET_A7_DBG_RESET1     5
>> +#define IMX7_RESET_A7_ETM_RESET0     6
>> +#define IMX7_RESET_A7_ETM_RESET1     7
>> +#define IMX7_RESET_A7_SOC_DBG_RESET  8
>> +#define IMX7_RESET_A7_L2RESET                9
>> +#define IMX7_RESET_SW_M4C_RST                10
>> +#define IMX7_RESET_SW_M4P_RST                11
>> +#define IMX7_RESET_EIM_RST           12
>> +#define IMX7_RESET_HSICPHY_PORT_RST  13
>> +#define IMX7_RESET_USBPHY1_POR               14
>> +#define IMX7_RESET_USBPHY1_PORT_RST  15
>> +#define IMX7_RESET_USBPHY2_POR               16
>> +#define IMX7_RESET_USBPHY2_PORT_RST  17
>> +#define IMX7_RESET_MIPI_PHY_MRST     18
>> +#define IMX7_RESET_MIPI_PHY_SRST     19
>> +
>> +/*
>> + * IMX7_RESET_PCIEPHY is a logical reset line combining PCIEPHY_BTN
>> + * and PCIEPHY_G_RST
>> + */
>> +#define IMX7_RESET_PCIEPHY           20
>> +#define IMX7_RESET_PCIEPHY_PERST     21
>> +
>> +/*
>> + * IMX7_RESET_PCIE_CTRL_APPS_EN is not strictly a reset line, but it
>> + * can be used to inhibit PCIe LTTSM, so, in a way, it can be thoguht
>> + * of as one
>> + */
>> +#define IMX7_RESET_PCIE_CTRL_APPS_EN 22
>> +#define IMX7_RESET_DDRC_PRST         23
>> +#define IMX7_RESET_DDRC_CORE_RST     24
>> +
>> +#define IMX7_RESET_NUM                       25
>> +
>> +#endif
>> +
>
> regards
> Philipp
>
>

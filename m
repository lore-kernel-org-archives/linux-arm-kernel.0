From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jul 2016 12:42:10 +0200
Subject: [PATCH v2 2/6] clk: mvebu: Add the xtal clock for Armada 3700 SoC
In-Reply-To: <146799916006.73491.13586762303347604368@resonance> (Michael
 Turquette's message of "Fri, 08 Jul 2016 10:32:40 -0700")
References: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
 <1467931071-31004-3-git-send-email-gregory.clement@free-electrons.com>
 <146799916006.73491.13586762303347604368@resonance>
Message-ID: <87zipnrvct.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,
 
 On ven., juil. 08 2016, Michael Turquette <mturquette@baylibre.com> wrote:

> Quoting Gregory CLEMENT (2016-07-07 15:37:47)
>> This clock is the parent of all the Armada 3700 clocks. It is a fixed
>> rate clock which depends on the gpio configuration read when resetting
>> the SoC.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/clk/mvebu/Kconfig            |  3 ++
>>  drivers/clk/mvebu/Makefile           |  1 +
>>  drivers/clk/mvebu/armada-37xx-xtal.c | 98 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 102 insertions(+)
>>  create mode 100644 drivers/clk/mvebu/armada-37xx-xtal.c
>> 
>> diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
>> index 3165da77d525..fddc8ac5faff 100644
>> --- a/drivers/clk/mvebu/Kconfig
>> +++ b/drivers/clk/mvebu/Kconfig
>> @@ -24,6 +24,9 @@ config ARMADA_39X_CLK
>>         bool
>>         select MVEBU_CLK_COMMON
>>  
>> +config ARMADA_37XX_CLK
>> +       bool
>> +
>>  config ARMADA_XP_CLK
>>         bool
>>         select MVEBU_CLK_COMMON
>> diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
>> index 7172ef65693d..4257a36d0219 100644
>> --- a/drivers/clk/mvebu/Makefile
>> +++ b/drivers/clk/mvebu/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_ARMADA_370_CLK)    += armada-370.o
>>  obj-$(CONFIG_ARMADA_375_CLK)   += armada-375.o
>>  obj-$(CONFIG_ARMADA_38X_CLK)   += armada-38x.o
>>  obj-$(CONFIG_ARMADA_39X_CLK)   += armada-39x.o
>> +obj-$(CONFIG_ARMADA_37XX_CLK)  += armada-37xx-xtal.o
>>  obj-$(CONFIG_ARMADA_XP_CLK)    += armada-xp.o
>>  obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
>>  obj-$(CONFIG_ARMADA_CP110_SYSCON) += cp110-system-controller.o
>> diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
>> new file mode 100644
>> index 000000000000..f832c219420f
>> --- /dev/null
>> +++ b/drivers/clk/mvebu/armada-37xx-xtal.c
>> @@ -0,0 +1,98 @@
>> +/*
>> + * Marvell Armada 37xx SoC xtal clocks
>> + *
>> + * Copyright (C) 2016 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/clk.h>
>
> Is clk.h necessary? Is this driver also a clock consumer?

This driver is not a clock consumer so it is not needed.
I will remove it.

Thanks,

Gregory

>
> Regards,
> Mike
>
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define NB_GPIO1_LATCH 0xC
>> +#define XTAL_MODE          BIT(31)
>> +
>> +static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       const char *xtal_name = "xtal";
>> +       struct device_node *parent;
>> +       struct regmap *regmap;
>> +       struct clk_hw *xtal_hw;
>> +       unsigned int rate;
>> +       u32 reg;
>> +       int ret;
>> +
>> +       xtal_hw = devm_kzalloc(&pdev->dev, sizeof(*xtal_hw), GFP_KERNEL);
>> +       if (!xtal_hw)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, xtal_hw);
>> +
>> +       parent = np->parent;
>> +       if (!parent) {
>> +               dev_err(&pdev->dev, "no parent\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       regmap = syscon_node_to_regmap(parent);
>> +       if (IS_ERR(regmap)) {
>> +               dev_err(&pdev->dev, "cannot get regmap\n");
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       ret = regmap_read(regmap, NB_GPIO1_LATCH, &reg);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "cannot read from regmap\n");
>> +               return ret;
>> +       }
>> +
>> +       if (reg & XTAL_MODE)
>> +               rate = 40000000;
>> +       else
>> +               rate = 25000000;
>> +
>> +       of_property_read_string_index(np, "clock-output-names", 0, &xtal_name);
>> +       xtal_hw = clk_hw_register_fixed_rate(NULL, xtal_name, NULL, 0, rate);
>> +       if (IS_ERR(xtal_hw))
>> +               return PTR_ERR(xtal_hw);
>> +       ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, xtal_hw);
>> +
>> +       return ret;
>> +}
>> +
>> +static int armada_3700_xtal_clock_remove(struct platform_device *pdev)
>> +{
>> +       of_clk_del_provider(pdev->dev.of_node);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id armada_3700_xtal_clock_of_match[] = {
>> +       { .compatible = "marvell,armada-3700-xtal-clock", },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, armada_3700_xtal_clock_of_match);
>> +
>> +static struct platform_driver armada_3700_xtal_clock_driver = {
>> +       .probe = armada_3700_xtal_clock_probe,
>> +       .remove = armada_3700_xtal_clock_remove,
>> +       .driver         = {
>> +               .name   = "marvell-armada-3700-xtal-clock",
>> +               .of_match_table = armada_3700_xtal_clock_of_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(armada_3700_xtal_clock_driver);
>> +
>> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
>> +MODULE_DESCRIPTION("Marvell Armada 37xx SoC xtal clocks driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.5.0
>> 

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: carlo@caione.org (Carlo Caione)
Date: Mon, 10 Feb 2014 23:34:44 +0100
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <20140210211900.GC32042@lee--X1>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210211900.GC32042@lee--X1>
Message-ID: <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 10:19 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> This patch introduces the preliminary support for PMICs X-Powers AXP202
>> and AXP209. The core contains support only for two sub-modules (PEK
>> and regulators) that will be added with two different patch-sets.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  drivers/mfd/Kconfig        |  12 +++
>>  drivers/mfd/Makefile       |   1 +
>>  drivers/mfd/axp20x.c       | 251 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h | 178 ++++++++++++++++++++++++++++++++
>>  4 files changed, 442 insertions(+)
>>  create mode 100644 drivers/mfd/axp20x.c
>>  create mode 100644 include/linux/mfd/axp20x.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index dd67158..33d38c4 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -59,6 +59,18 @@ config MFD_AAT2870_CORE
>>         additional drivers must be enabled in order to use the
>>         functionality of the device.
>
> <snip>
>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> new file mode 100644
>> index 0000000..efd0cb3
>> --- /dev/null
>> +++ b/drivers/mfd/axp20x.c
>> @@ -0,0 +1,251 @@
>> +/*
>
> A nice descriptive title here would be good.

Agree.

>> + * Author: Carlo Caione <carlo@caione.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/mfd/axp20x.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +
>> +static const struct regmap_range axp20x_writeable_ranges[] = {
>> +     {
>> +             .range_min = AXP20X_DATA(0),
>> +             .range_max = AXP20X_IRQ5_STATE,
>> +     }, {
>> +             .range_min = AXP20X_DCDC_MODE,
>> +             .range_max = AXP20X_FG_RES,
>> +     },
>> +};
>> +
>> +static const struct regmap_range axp20x_volatile_ranges[] = {
>> +     {
>> +             .range_min = AXP20X_IRQ1_EN,
>> +             .range_max = AXP20X_IRQ5_STATE,
>> +     },
>> +};
>> +
>> +static const struct regmap_access_table axp20x_writeable_table = {
>> +     .yes_ranges     = axp20x_writeable_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(axp20x_writeable_ranges),
>> +};
>> +
>> +static const struct regmap_access_table axp20x_volatile_table = {
>> +     .yes_ranges     = axp20x_volatile_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(axp20x_volatile_ranges),
>> +};
>> +
>> +static struct resource axp20x_pek_resources[] = {
>> +     {
>> +             .name   = "PEK_DBR",
>> +             .start  = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +     {
>> +             .name   = "PEK_DBF",
>> +             .start  = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +
>
> Superfluous new line.
>
>> +};
>> +
>> +static const struct regmap_config axp20x_regmap_config = {
>> +     .reg_bits       = 8,
>> +     .val_bits       = 8,
>> +     .wr_table       = &axp20x_writeable_table,
>> +     .volatile_table = &axp20x_volatile_table,
>> +     .max_register   = AXP20X_FG_RES,
>> +     .cache_type     = REGCACHE_RBTREE,
>> +};
>> +
>> +#define AXP20X_IRQ(_irq, _off, _mask) \
>> +     [AXP20X_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
>> +
>> +static const struct regmap_irq axp20x_regmap_irqs[] = {
>> +     AXP20X_IRQ(ACIN_OVER_V,         0, 7),
>> +     AXP20X_IRQ(ACIN_PLUGIN,         0, 6),
>> +     AXP20X_IRQ(ACIN_REMOVAL,        0, 5),
>> +     AXP20X_IRQ(VBUS_OVER_V,         0, 4),
>> +     AXP20X_IRQ(VBUS_PLUGIN,         0, 3),
>> +     AXP20X_IRQ(VBUS_REMOVAL,        0, 2),
>> +     AXP20X_IRQ(VBUS_V_LOW,          0, 1),
>> +     AXP20X_IRQ(BATT_PLUGIN,         1, 7),
>> +     AXP20X_IRQ(BATT_REMOVAL,        1, 6),
>> +     AXP20X_IRQ(BATT_ENT_ACT_MODE,   1, 5),
>> +     AXP20X_IRQ(BATT_EXIT_ACT_MODE,  1, 4),
>> +     AXP20X_IRQ(CHARG,               1, 3),
>> +     AXP20X_IRQ(CHARG_DONE,          1, 2),
>> +     AXP20X_IRQ(BATT_TEMP_HIGH,      1, 1),
>> +     AXP20X_IRQ(BATT_TEMP_LOW,       1, 0),
>> +     AXP20X_IRQ(DIE_TEMP_HIGH,       2, 7),
>> +     AXP20X_IRQ(CHARG_I_LOW,         2, 6),
>> +     AXP20X_IRQ(DCDC1_V_LONG,        2, 5),
>> +     AXP20X_IRQ(DCDC2_V_LONG,        2, 4),
>> +     AXP20X_IRQ(DCDC3_V_LONG,        2, 3),
>> +     AXP20X_IRQ(PEK_SHORT,           2, 1),
>> +     AXP20X_IRQ(PEK_LONG,            2, 0),
>> +     AXP20X_IRQ(N_OE_PWR_ON,         3, 7),
>> +     AXP20X_IRQ(N_OE_PWR_OFF,        3, 6),
>> +     AXP20X_IRQ(VBUS_VALID,          3, 5),
>> +     AXP20X_IRQ(VBUS_NOT_VALID,      3, 4),
>> +     AXP20X_IRQ(VBUS_SESS_VALID,     3, 3),
>> +     AXP20X_IRQ(VBUS_SESS_END,       3, 2),
>> +     AXP20X_IRQ(LOW_PWR_LVL1,        3, 1),
>> +     AXP20X_IRQ(LOW_PWR_LVL2,        3, 0),
>> +     AXP20X_IRQ(TIMER,               4, 7),
>> +     AXP20X_IRQ(PEK_RIS_EDGE,        4, 6),
>> +     AXP20X_IRQ(PEK_FAL_EDGE,        4, 5),
>> +     AXP20X_IRQ(GPIO3_INPUT,         4, 3),
>> +     AXP20X_IRQ(GPIO2_INPUT,         4, 2),
>> +     AXP20X_IRQ(GPIO1_INPUT,         4, 1),
>> +     AXP20X_IRQ(GPIO0_INPUT,         4, 0),
>> +};
>
> Where are these handled i.e. where is the irq_handler located?

Each one is used by a different driver for each subsystem of the MFD,
so each driver will have a specific irq_handler. I need the full list
here to register with regmap_add_irq_chip() the generic
regmap_irq_thread.

>> +static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>> +     .name                   = "axp20x_irq_chip",
>> +     .status_base            = AXP20X_IRQ1_STATE,
>> +     .ack_base               = AXP20X_IRQ1_STATE,
>> +     .mask_base              = AXP20X_IRQ1_EN,
>> +     .num_regs               = 5,
>> +     .irqs                   = axp20x_regmap_irqs,
>> +     .num_irqs               = ARRAY_SIZE(axp20x_regmap_irqs),
>> +     .mask_invert            = 1,
>
> This is a bool; true or false please.
>
>> +     .init_ack_masked        = 1,
>
> Same here.

I'll fix both in v2.

>> +};
>> +
>> +static struct mfd_cell axp20x_cells[] = {
>> +     {
>> +             .name           = "axp20x-pek",
>> +             .of_compatible  = "x-powers,axp20x-pek",
>> +             .num_resources  = ARRAY_SIZE(axp20x_pek_resources),
>> +             .resources      = axp20x_pek_resources,
>
> I already saw the comments about these.
>
>> +     }, {
>> +             .name           = "axp20x-regulator",
>> +     },
>> +};
>> +
>> +const struct of_device_id axp20x_of_match[] = {
>> +     { .compatible = "x-powers,axp20x", .data = (void *)AXP20X },
>
> There's no need to add device IDs if you only support one device.

Ok. But what if in the future we want to add a new device?

>> +     { },
>> +};
>> +
>> +static struct axp20x_dev *axp20x_pm_power_off;
>
> This looks pretty unconventional. What's the point of it?

On a single board we can have multiple AXPs so I track which one is in
charge of powering off the board (and to get the correct device in the
axp20x_power_off())

>> +static void axp20x_power_off(void)
>> +{
>> +     regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL, 0x80);
>
> What does the 0x80 do exactly? Think about #defining.

It's only used here, but I'll #define it.

>> +}
>> +
>> +static int axp20x_i2c_probe(struct i2c_client *i2c,
>> +                      const struct i2c_device_id *id)
>> +{
>> +     struct axp20x_dev *axp20x;
>> +     const struct of_device_id *of_id;
>> +     int ret;
>> +
>> +     axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
>> +     if (!axp20x)
>> +             return -ENOMEM;
>> +
>> +     of_id = of_match_device(axp20x_of_match, &i2c->dev);
>> +     if (!of_id) {
>> +             dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
>> +             return -ENODEV;
>> +     }
>> +     axp20x->variant = (int) of_id->data;
>
> Lots of code here surrounding added device support, but only one
> device is supported. Why so?

Because at the moment I support only axp202 and axp209 but I wanted
something future-proof

>> +     axp20x->i2c_client = i2c;
>> +     i2c_set_clientdata(i2c, axp20x);
>> +
>> +     axp20x->dev = &i2c->dev;
>> +     dev_set_drvdata(axp20x->dev, axp20x);
>
> Do you make use of all this saving of the device container?
>
> If so, where?

In the drivers for subsystems (input, regulators, gpio, etc..)

> Also:
>   i2c_set_clientdata(i2c)
>
> and:
>   dev_set_drvdata(i2c->dev);
>
> ... do exactly the same thing i.e. set i2c->dev->p->device_data.

Right.

>> +     axp20x->regmap = devm_regmap_init_i2c(i2c, &axp20x_regmap_config);
>> +     if (IS_ERR(axp20x->regmap)) {
>> +             ret = PTR_ERR(axp20x->regmap);
>> +             dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     axp20x->irq = i2c->irq;
>> +     ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
>> +                               IRQF_ONESHOT | IRQF_SHARED, -1,
>> +                               &axp20x_regmap_irq_chip,
>> +                               &axp20x->regmap_irqc);
>> +     if (ret != 0) {
>
> It's more succinct to say:
>   if (!ret)

Agree

>> +             dev_err(&i2c->dev, "failed to add irq chip: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = mfd_add_devices(axp20x->dev, -1, axp20x_cells,
>> +                           ARRAY_SIZE(axp20x_cells), NULL, 0, NULL);
>> +     if (ret != 0) {
>> +             dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
>> +             goto mfd_err;
>> +     }
>> +
>> +     if (!pm_power_off) {
>> +             axp20x_pm_power_off = axp20x;
>> +             pm_power_off = axp20x_power_off;
>> +     }
>
> Can you describe to me what you're using the pm_power_off call-back
> for please?

It's meant to poweroff the board

>> +     dev_info(&i2c->dev, "AXP20X driver loaded\n");
>> +
>> +     return 0;
>> +
>> +mfd_err:
>> +     regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
>> +
>> +     return ret;
>> +}
>> +
>> +static int axp20x_i2c_remove(struct i2c_client *i2c)
>> +{
>> +     struct axp20x_dev *axp20x = i2c_get_clientdata(i2c);
>> +
>> +     if (axp20x == axp20x_pm_power_off) {
>> +             axp20x_pm_power_off = NULL;
>> +             pm_power_off = NULL;
>> +     }
>> +
>> +     mfd_remove_devices(axp20x->dev);
>> +     regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct i2c_device_id axp20x_i2c_id[] = {
>> +     { "axp20x", AXP20X },
>
> It doesn't look like you're using this ID either?

No, I am not. I'll fix it in v2.

>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
>> +
>> +static struct i2c_driver axp20x_i2c_driver = {
>> +     .driver = {
>> +             .name   = "axp20x",
>> +             .owner  = THIS_MODULE,
>> +             .of_match_table = of_match_ptr(axp20x_of_match),
>> +     },
>> +     .probe          = axp20x_i2c_probe,
>> +     .remove         = axp20x_i2c_remove,
>> +     .id_table       = axp20x_i2c_id,
>> +};
>> +
>> +module_i2c_driver(axp20x_i2c_driver);
>> +
>> +MODULE_DESCRIPTION("PMIC MFD core driver for AXP20X");
>> +MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>> new file mode 100644
>> index 0000000..94d99fd
>> --- /dev/null
>> +++ b/include/linux/mfd/axp20x.h
>> @@ -0,0 +1,178 @@
>> +/*
>> + * Functions to access AXP20X power management chip.
>> + *
>> + * Copyright (C) 2013, Carlo Caione <carlo@caione.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_MFD_AXP20X_H
>> +#define __LINUX_MFD_AXP20X_H
>> +
>> +#define AXP20X                               0
>> +
>> +#define AXP20X_DATA(m)                       (0x04 + (m))
>
> This is not a great name for a macro.  'data' and 'value' seldom make
> for good names for variables/macros.  Please replace it with something
> more descriptive.

Agree. I'll change it.

> In fact, on closer inspection it appears as though you only use this
> once while defining writable registers.  What happened to registers
> 0x00 to 0x03, and why have the top registers below been omitted from
> the range(s)?

All the registers defined here can be used by the drivers of the
different subsystems including this header file, thus all the
registers are reported here though they are not directly used by the
core driver.
About the range you are right, I'll fix it in v2. Thanks for noticing.

>> +
>> +/* Power supply */
>> +#define AXP20X_PWR_INPUT_STATUS              0x00
>> +#define AXP20X_PWR_OP_MODE           0x01
>> +#define AXP20X_USB_OTG_STATUS                0x02
>> +#define AXP20X_PWR_OUT_CTRL          0x12
>> +#define AXP20X_DCDC2_V_OUT           0x23
>> +#define AXP20X_DCDC2_LDO3_V_SCAL     0x25
>> +#define AXP20X_DCDC3_V_OUT           0x27
>> +#define AXP20X_LDO24_V_OUT           0x28
>> +#define AXP20X_LDO3_V_OUT            0x29
>> +#define AXP20X_VBUS_IPSOUT_MGMT              0x30
>> +#define AXP20X_V_OFF                 0x31
>> +#define AXP20X_OFF_CTRL                      0x32
>> +#define AXP20X_CHRG_CTRL1            0x33
>> +#define AXP20X_CHRG_CTRL2            0x34
>> +#define AXP20X_CHRG_BAK_CTRL         0x35
>> +#define AXP20X_PEK_KEY                       0x36
>> +#define AXP20X_DCDC_FREQ             0x37
>> +#define AXP20X_V_LTF_CHRG            0x38
>> +#define AXP20X_V_HTF_CHRG            0x39
>> +#define AXP20X_APS_WARN_L1           0x3a
>> +#define AXP20X_APS_WARN_L2           0x3b
>> +#define AXP20X_V_LTF_DISCHRG         0x3c
>> +#define AXP20X_V_HTF_DISCHRG         0x3d
>> +
>> +/* Interrupt */
>> +#define AXP20X_IRQ1_EN                       0x40
>> +#define AXP20X_IRQ2_EN                       0x41
>> +#define AXP20X_IRQ3_EN                       0x42
>> +#define AXP20X_IRQ4_EN                       0x43
>> +#define AXP20X_IRQ5_EN                       0x44
>> +#define AXP20X_IRQ1_STATE            0x48
>> +#define AXP20X_IRQ2_STATE            0x49
>> +#define AXP20X_IRQ3_STATE            0x4a
>> +#define AXP20X_IRQ4_STATE            0x4b
>> +#define AXP20X_IRQ5_STATE            0x4c
>> +
>> +/* ADC */
>> +#define AXP20X_ACIN_V_ADC_H          0x56
>> +#define AXP20X_ACIN_V_ADC_L          0x57
>> +#define AXP20X_ACIN_I_ADC_H          0x58
>> +#define AXP20X_ACIN_I_ADC_L          0x59
>> +#define AXP20X_VBUS_V_ADC_H          0x5a
>> +#define AXP20X_VBUS_V_ADC_L          0x5b
>> +#define AXP20X_VBUS_I_ADC_H          0x5c
>> +#define AXP20X_VBUS_I_ADC_L          0x5d
>> +#define AXP20X_TEMP_ADC_H            0x5e
>> +#define AXP20X_TEMP_ADC_L            0x5f
>> +#define AXP20X_TS_IN_H                       0x62
>> +#define AXP20X_TS_IN_L                       0x63
>> +#define AXP20X_GPIO0_V_ADC_H         0x64
>> +#define AXP20X_GPIO0_V_ADC_L         0x65
>> +#define AXP20X_GPIO1_V_ADC_H         0x66
>> +#define AXP20X_GPIO1_V_ADC_L         0x67
>> +#define AXP20X_PWR_BATT_H            0x70
>> +#define AXP20X_PWR_BATT_M            0x71
>> +#define AXP20X_PWR_BATT_L            0x72
>> +#define AXP20X_BATT_V_H                      0x78
>> +#define AXP20X_BATT_V_L                      0x79
>> +#define AXP20X_BATT_CHRG_I_H         0x7a
>> +#define AXP20X_BATT_CHRG_I_L         0x7b
>> +#define AXP20X_BATT_DISCHRG_I_H              0x7c
>> +#define AXP20X_BATT_DISCHRG_I_L              0x7d
>> +#define AXP20X_IPSOUT_V_HIGH_H               0x7e
>> +#define AXP20X_IPSOUT_V_HIGH_L               0x7f
>> +
>> +/* Power supply */
>> +#define AXP20X_DCDC_MODE             0x80
>> +#define AXP20X_ADC_EN1                       0x82
>> +#define AXP20X_ADC_EN2                       0x83
>> +#define AXP20X_ADC_RATE                      0x84
>> +#define AXP20X_GPIO10_IN_RANGE               0x85
>> +#define AXP20X_GPIO1_ADC_IRQ_RIS     0x86
>> +#define AXP20X_GPIO1_ADC_IRQ_FAL     0x87
>> +#define AXP20X_TIMER_CTRL            0x8a
>> +#define AXP20X_VBUS_MON                      0x8b
>> +#define AXP20X_OVER_TMP                      0x8f
>> +
>> +/* GPIO */
>> +#define AXP20X_GPIO0_CTRL            0x90
>> +#define AXP20X_LDO5_V_OUT            0x91
>> +#define AXP20X_GPIO1_CTRL            0x92
>> +#define AXP20X_GPIO2_CTRL            0x93
>> +#define AXP20X_GPIO20_SS             0x94
>> +#define AXP20X_GPIO3_CTRL            0x95
>> +
>> +/* Battery */
>> +#define AXP20X_CHRG_CC_31_24         0xb0
>> +#define AXP20X_CHRG_CC_23_16         0xb1
>> +#define AXP20X_CHRG_CC_15_8          0xb2
>> +#define AXP20X_CHRG_CC_7_0           0xb3
>> +#define AXP20X_DISCHRG_CC_31_24              0xb4
>> +#define AXP20X_DISCHRG_CC_23_16              0xb5
>> +#define AXP20X_DISCHRG_CC_15_8               0xb6
>> +#define AXP20X_DISCHRG_CC_7_0                0xb7
>> +#define AXP20X_CC_CTRL                       0xb8
>> +#define AXP20X_FG_RES                        0xb9
>> +
>> +/* Regulators IDs */
>> +enum {
>> +     AXP20X_LDO1 = 0,
>> +     AXP20X_LDO2,
>> +     AXP20X_LDO3,
>> +     AXP20X_LDO4,
>> +     AXP20X_LDO5,
>> +     AXP20X_DCDC2,
>> +     AXP20X_DCDC3,
>> +     AXP20X_REG_ID_MAX,
>> +};
>> +
>> +/* IRQs */
>> +enum {
>> +     AXP20X_IRQ_ACIN_OVER_V = 1,
>> +     AXP20X_IRQ_ACIN_PLUGIN,
>> +     AXP20X_IRQ_ACIN_REMOVAL,
>> +     AXP20X_IRQ_VBUS_OVER_V,
>> +     AXP20X_IRQ_VBUS_PLUGIN,
>> +     AXP20X_IRQ_VBUS_REMOVAL,
>> +     AXP20X_IRQ_VBUS_V_LOW,
>> +     AXP20X_IRQ_BATT_PLUGIN,
>> +     AXP20X_IRQ_BATT_REMOVAL,
>> +     AXP20X_IRQ_BATT_ENT_ACT_MODE,
>> +     AXP20X_IRQ_BATT_EXIT_ACT_MODE,
>> +     AXP20X_IRQ_CHARG,
>> +     AXP20X_IRQ_CHARG_DONE,
>> +     AXP20X_IRQ_BATT_TEMP_HIGH,
>> +     AXP20X_IRQ_BATT_TEMP_LOW,
>> +     AXP20X_IRQ_DIE_TEMP_HIGH,
>> +     AXP20X_IRQ_CHARG_I_LOW,
>> +     AXP20X_IRQ_DCDC1_V_LONG,
>> +     AXP20X_IRQ_DCDC2_V_LONG,
>> +     AXP20X_IRQ_DCDC3_V_LONG,
>> +     AXP20X_IRQ_PEK_SHORT = 22,
>> +     AXP20X_IRQ_PEK_LONG,
>> +     AXP20X_IRQ_N_OE_PWR_ON,
>> +     AXP20X_IRQ_N_OE_PWR_OFF,
>> +     AXP20X_IRQ_VBUS_VALID,
>> +     AXP20X_IRQ_VBUS_NOT_VALID,
>> +     AXP20X_IRQ_VBUS_SESS_VALID,
>> +     AXP20X_IRQ_VBUS_SESS_END,
>> +     AXP20X_IRQ_LOW_PWR_LVL1,
>> +     AXP20X_IRQ_LOW_PWR_LVL2,
>> +     AXP20X_IRQ_TIMER,
>> +     AXP20X_IRQ_PEK_RIS_EDGE,
>> +     AXP20X_IRQ_PEK_FAL_EDGE,
>> +     AXP20X_IRQ_GPIO3_INPUT,
>> +     AXP20X_IRQ_GPIO2_INPUT,
>> +     AXP20X_IRQ_GPIO1_INPUT,
>> +     AXP20X_IRQ_GPIO0_INPUT,
>> +};
>> +
>> +struct axp20x_dev {
>> +     struct device                   *dev;
>> +     struct i2c_client               *i2c_client;
>> +     struct regmap                   *regmap;
>> +     struct regmap_irq_chip_data     *regmap_irqc;
>> +     int                             variant;
>> +     int                             irq;
>> +};
>
> Is this used anywhere else except in the MFD driver?
>
> If not, consider moving it into the *.c file.

Yes, it is used by drivers of subsystems.

Thank you,

-- 
Carlo Caione

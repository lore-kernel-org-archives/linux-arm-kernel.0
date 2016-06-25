From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 25 Jun 2016 09:00:57 +0800
Subject: [PATCH 07/14] regulator: SY8106A regulator driver
In-Reply-To: <e297ffd8-12c1-88cd-06d0-6136f0e1ccb0@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-8-megous@megous.com>
 <CAGb2v64D3Bou62iZgDU9kFHLofQ9tPGdyw6PKTdoTaZqPCn+8w@mail.gmail.com>
 <e297ffd8-12c1-88cd-06d0-6136f0e1ccb0@megous.com>
Message-ID: <CAGb2v64Ln9Ndp7sRBRpXU4-SnkrYJ0Ws=LyX0Q_PGaZwUNvUsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 8:11 AM, Ond?ej Jirman <megous@megous.com> wrote:
> Hi,
>
> thank you for the review. I've resolved most of the issues. Some more
> comments below.
>
> On 24.6.2016 05:41, Chen-Yu Tsai wrote:
>> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
>>> From: Ondrej Jirman <megous@megous.com>
>>>
>>> SY8106A is I2C attached single output voltage regulator
>>> made by Silergy.
>>>
>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>> ---
>>>  drivers/regulator/Kconfig             |   8 +-
>>>  drivers/regulator/Makefile            |   2 +-
>>>  drivers/regulator/sy8106a-regulator.c | 153 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 161 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/regulator/sy8106a-regulator.c
>>>
>>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>>> index 144cbf5..fc3fae2 100644
>>> --- a/drivers/regulator/Kconfig
>>> +++ b/drivers/regulator/Kconfig
>>> @@ -860,5 +860,11 @@ config REGULATOR_WM8994
>>>           This driver provides support for the voltage regulators on the
>>>           WM8994 CODEC.
>>>
>>> -endif
>>> +config REGULATOR_SY8106A
>>> +       tristate "Silergy SY8106A"
>>> +       depends on I2C
>>
>> Maybe you should also depend on OF since the driver is going to crippled
>> without any constraints set, or (OF || COMPILE_TEST) if you want some
>> compile test coverage.
>>
>>> +       select REGMAP_I2C
>>> +       help
>>> +         This driver provides support for the voltage regulator SY8106A.
>>>
>>> +endif
>>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>>> index 85a1d44..f382095 100644
>>> --- a/drivers/regulator/Makefile
>>> +++ b/drivers/regulator/Makefile
>>> @@ -110,6 +110,6 @@ obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
>>>  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>>>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>>>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
>>> -
>>> +obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>>
>> Follow the existing ordering in the Makefile.
>>
>>>
>>>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
>>> diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
>>> new file mode 100644
>>> index 0000000..34bd69c
>>> --- /dev/null
>>> +++ b/drivers/regulator/sy8106a-regulator.c
>>> @@ -0,0 +1,153 @@
>>> +/*
>>> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>>> + *
>>> + * Copyright (C) 2016  Ond?ej Jirman <megous@megous.com>
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Library General Public
>>> + * License as published by the Free Software Foundation; either
>>> + * version 2 of the License, or (at your option) any later version.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * Library General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Library General Public
>>> + * License along with this library; if not, write to the
>>> + * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
>>> + * Boston, MA  02110-1301, USA.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>
>> Do you need this one?
>>
>>> +#include <linux/regulator/driver.h>
>>> +#include <linux/regulator/machine.h>
>>
>> And this one?
>>
>>> +#include <linux/regulator/of_regulator.h>
>>> +#include <linux/regmap.h>
>>
>> Sort alphabetically please.
>>
>>> +
>>> +#define SY8106A_REG_VOUT1_SEL          0x01
>>> +#define SY8106A_REG_VOUT_COM           0x02
>>> +#define SY8106A_REG_VOUT1_SEL_MASK     0x7f
>>> +#define SY8106A_DISABLE_REG            0x01
>>
>> BIT(0) would be clearer.
>>
>>> +
>>> +struct sy8106a {
>>> +       struct regulator_dev *rdev;
>>> +       struct regmap *regmap;
>>> +};
>>> +
>>> +static const struct regmap_config sy8106a_regmap_config = {
>>> +       .reg_bits = 8,
>>> +       .val_bits = 8,
>>> +};
>>> +
>>> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
>>> +{
>>> +       return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
>>> +                                 0xff, sel | 0x80);
>>
>> Can you use .apply_bit / .apply_reg with regulator_set_voltage_sel_regmap?
>
> I understand the code savings, but I'd rather avoid that, because it
> would involve 2 needless readouts and rewrites of the voltage setting
> register. I'd rather change this to regmap_write, so that the regulator
> only receives writes over I2C, to minimize possibility of bit flip error
> by minimizing the communication over the I2C bus.

OK. It's best to add a comment then, in case someone comes in and refactors it.

>
>>> +}
>>> +
>>> +static const struct regulator_ops sy8106a_ops = {
>>> +       .is_enabled = regulator_is_enabled_regmap,
>>> +       .set_voltage_sel = sy8106a_set_voltage_sel,
>>> +       .set_voltage_time_sel = regulator_set_voltage_time_sel,
>>> +       .get_voltage_sel = regulator_get_voltage_sel_regmap,
>>> +       .list_voltage = regulator_list_voltage_linear,
>>> +};
>>> +
>>> +/* Default limits measured in millivolts and milliamps */
>>> +#define SY8106A_MIN_MV         680
>>> +#define SY8106A_MAX_MV         1950
>>> +#define SY8106A_STEP_MV                10
>>> +
>>> +static const struct regulator_desc sy8106a_reg = {
>>> +       .name = "SY8106A",
>>> +       .id = 0,
>>> +       .ops = &sy8106a_ops,
>>> +       .type = REGULATOR_VOLTAGE,
>>> +       .n_voltages = ((SY8106A_MAX_MV - SY8106A_MIN_MV) / SY8106A_STEP_MV) + 1,
>>> +       .min_uV = (SY8106A_MIN_MV * 1000),
>>> +       .uV_step = (SY8106A_STEP_MV * 1000),
>>> +       .vsel_reg = SY8106A_REG_VOUT1_SEL,
>>> +       .vsel_mask = SY8106A_REG_VOUT1_SEL_MASK,
>>> +       .enable_reg = SY8106A_REG_VOUT_COM,
>>> +       .enable_mask = SY8106A_DISABLE_REG,
>>> +       .disable_val = SY8106A_DISABLE_REG,
>>> +       .enable_is_inverted = 1,
>>> +       .owner = THIS_MODULE,
>>> +};
>>> +
>>> +/*
>>> + * I2C driver interface functions
>>> + */
>>> +static int sy8106a_i2c_probe(struct i2c_client *i2c,
>>> +                           const struct i2c_device_id *id)
>>> +{
>>> +       struct sy8106a *chip;
>>> +       struct device *dev = &i2c->dev;
>>> +       struct regulator_dev *rdev = NULL;
>>> +       struct regulator_config config = { };
>>> +       unsigned int selector;
>>> +       int error;
>>> +
>>> +       chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERNEL);
>>> +       if (!chip)
>>> +               return -ENOMEM;
>>> +
>>> +       chip->regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
>>> +       if (IS_ERR(chip->regmap)) {
>>> +               error = PTR_ERR(chip->regmap);
>>> +               dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
>>> +                       error);
>>> +               return error;
>>> +       }
>>> +
>>> +       config.dev = &i2c->dev;
>>> +       config.init_data = of_get_regulator_init_data(dev, dev->of_node, &sy8106a_reg);
>>
>> Check for possible failures?
>>
>>> +       config.driver_data = chip;
>>> +       config.regmap = chip->regmap;
>>> +       config.of_node = dev->of_node;
>>> +
>>> +       /* Probe regulator */
>>> +       error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &selector);
>>> +       dev_info(&i2c->dev, "SY8106A voltage at boot: %u mV\n", SY8106A_MIN_MV + SY8106A_STEP_MV * (selector & SY8106A_REG_VOUT1_SEL_MASK));
>>> +       if (error) {
>>> +               dev_err(&i2c->dev, "Failed to read voltage at probe time: %d\n", error);
>>> +               return error;
>>> +       }
>>> +
>>> +       rdev = devm_regulator_register(&i2c->dev, &sy8106a_reg, &config);
>>> +       if (IS_ERR(rdev)) {
>>> +               dev_err(&i2c->dev, "Failed to register SY8106A regulator\n");
>>> +               return PTR_ERR(rdev);
>>> +       }
>>> +
>>> +       chip->rdev = rdev;
>>> +
>>> +       i2c_set_clientdata(i2c, chip);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct i2c_device_id sy8106a_i2c_id[] = {
>>> +       {"sy8106a", 0},
>>> +       {},
>>> +};
>>> +
>>
>> Extra line.
>>
>>> +MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
>>
>> IMHO probing explicitly through DT (of_device_id) would be better.
>
> I checked out a few recently added i2c regulator drivers, and this is
> the way they're written. I'd rather not differ, especially since I'm a
> beginner with this thing, atm. Also, I'm not sure what chanhge in
> particular you're suggesting.

See drivers/mfd/axp20x-i2c.c , the last 50 lines or so.

ChenYu

>
> thanks,
>   Ondrej
>
>>
>> Regards
>> ChenYu
>>
>>> +
>>> +static struct i2c_driver sy8106a_regulator_driver = {
>>> +       .driver = {
>>> +               .name = "sy8106a",
>>> +       },
>>> +       .probe = sy8106a_i2c_probe,
>>> +       .id_table = sy8106a_i2c_id,
>>> +};
>>> +
>>> +module_i2c_driver(sy8106a_regulator_driver);
>>> +
>>> +MODULE_AUTHOR("Ond?ej Jirman <megous@megous.com>");
>>> +MODULE_DESCRIPTION("Regulator device driver for Silergy SY8106A");
>>> +MODULE_LICENSE("GPL v2");
>>> --
>>> 2.9.0
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

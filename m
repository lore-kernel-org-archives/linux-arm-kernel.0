From: amazon@baker-net.org.uk (Adam Baker)
Date: Sun, 7 Feb 2016 14:57:23 +0000
Subject: nsa3xx-hwmon mainline patch
In-Reply-To: <56AFDE4F.5060507@gmail.com>
References: <CAPEAnwBtW9QS=6Wp7WH2sNzwERFB_YXByyg-pF+36SwB0Cijpg@mail.gmail.com>
 <56A67820.60802@googlemail.com> <56A96534.4040407@baker-net.org.uk>
 <56A9EA4D.2020108@awi.de> <56AE986E.8090400@baker-net.org.uk>
 <56AFDE4F.5060507@gmail.com>
Message-ID: <56B75B53.8070600@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

Thanks for the review. Now that I have confirmation no-one else wants to 
claim copyright on this I've added the linux-arm list to the 
distribution so the review comments end up in a public archive.

On 01/02/16 22:38, Sebastian Hesselbarth wrote:
> On 01.02.2016 00:27, Adam Baker wrote:
>> Having concluded that the SPI GPIO driver doesn't support introducing
>> the delays that this driver would need (and modifications to make it do
>> so touch hot paths so are unlikely to be acceptable) I've made a further
>> clean up of the original variant, removing all of the now useless board
>> file support and migrating it to use the new GPIO descriptor syntax.
>>
>> I think this is close to being ready to post to the arm kernel and
>> lm-sensors lists for wider comment but before I do, do any of you want
>> your names added to the list of authors and do you want your email
>> addresses on the CC when posting publicly.
> I do not claim any authorship on the drivers. Feel free to
> reuse anything I provided (or did not provide ;)).
>
>> Hopefully Thunderbird hasn't munged this too much, I'll use git to post
>> it publicly to ensure a clean version.
> If you post to LAKML and others, make sure to use git format-patch
> and possibly also git send-email.
>
> Sending a non-conformant email will just slow your review down ...
>
> And while at it, below is your first review..
>
>> diff --git a/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
>> b/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
>> new file mode 100644
>> index 0000000..7899d6c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
>> @@ -0,0 +1,21 @@
>> +Bindings for the fan / temperature monitor microcontroller used on
>> +the Zyxel NSA 320 and several subsequent models.
>> +
>> +Required properties:
>> +- compatible    : "zyxel,nsa320-mcu"
>> +- data-gpios    : The GPIO pin connected to the data line on the MCU
>> +- clk-gpios    : The GPIO pin connected to the clock line on the MCU
>> +- act-gpios    : The GPIO pin connected to the active line on the MCU
>> +
>> +Example:
>> +
>> +    nsa3xx-hwmon {
> just use hwmon { above.
done
>> +        compatible = "zyxel,nsa320-mcu";
>> +        pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act>;
>> +        pinctrl-names = "default";
>> +
>> +        data-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
>> +        clk-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
>> +        act-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> If act is really ACTIVE_HIGH, then SPI would have a problem.
> Can you double-check that mcu is accessed when act is _high_?
It is active low as per the DTS file below, example corrected
>> +    };
>> +
>> diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts
>> b/arch/arm/boot/dts/kirkwood-nsa320.dts
>> index 24f686d..b663bd7 100644
>> --- a/arch/arm/boot/dts/kirkwood-nsa320.dts
>> +++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
>> @@ -193,10 +193,19 @@
>>           };
>>       };
>>
>> +    nsa3xx-hwmon {
> Just "hwmon" again.
Done
>> +        compatible = "zyxel,nsa320-mcu";
>> +        pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act>;
>> +        pinctrl-names = "default";
>> +
>> +        data-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
>> +        clk-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
>> +        act-gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
> Ah, look. here it is ACTIVE_LOW. You should get both into sync.
>
>> +    };
>> +
>>       /* The following pins are currently not assigned to a driver,
>>          some of them should be configured as inputs.
>> -    pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
>> -             &pmx_htp &pmx_vid_b1
>> +    pinctrl-0 = <&pmx_htp &pmx_vid_b1
>>                &pmx_power_resume_data &pmx_power_resume_clk>; */
>>   };
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 80a73bf..8801b78 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1757,6 +1757,19 @@ config SENSORS_ULTRA45
>>         This driver provides support for the Ultra45 workstation
>> environmental
>>         sensors.
>>
>> +config SENSORS_NSA3XX
>> +    tristate "ZyXEL NSA3xx fan speed and temperature sensors"
> I heard of NSA3xx versions not using the SPI interface and
> a different protocol? Is the driver generic enough to support
> all NSA3-series devices?
I believe that there are at least 3 models that use this MCU (the 
NSA320, NSA325 and some variants of the NSA310). As I only own an NSA320 
that's all I've tested but I've seen references to the board file driver 
this is based on working unchanged on the other two. Some of the NSA310 
variants and the NSA320S use an off the shelf I2C based monitoring chip 
that already has drivers
>> +    depends on GPIOLIB && OF
>> +    help
>> +      If you say yes here you get support for hardware monitoring
>> +      for the ZyXEL NSA3XX Media Servers.
>> +
>> +      The sensor data is taken from a Holtek HT46R065 microcontroller
>> +      connected to GPIO lines.
>> +
>> +      This driver can also be built as a module. If so, the module
>> +      will be called nsa3xx-hwmon.
>> +
>>   if ACPI
>>
>>   comment "ACPI drivers"
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 12a3239..e85414a 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -118,6 +118,7 @@ obj-$(CONFIG_SENSORS_MAX6650)    += max6650.o
>>   obj-$(CONFIG_SENSORS_MAX6697)    += max6697.o
>>   obj-$(CONFIG_SENSORS_MAX31790)    += max31790.o
>>   obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>> +obj-$(CONFIG_SENSORS_NSA3XX)    += nsa3xx-hwmon.o
>>   obj-$(CONFIG_SENSORS_MCP3021)    += mcp3021.o
>>   obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>>   obj-$(CONFIG_SENSORS_NCT6683)    += nct6683.o
>> diff --git a/drivers/hwmon/nsa3xx-hwmon.c b/drivers/hwmon/nsa3xx-hwmon.c
>> new file mode 100644
>> index 0000000..11fd5e3
>> --- /dev/null
>> +++ b/drivers/hwmon/nsa3xx-hwmon.c
>> @@ -0,0 +1,267 @@
>> +/*
>> + * drivers/hwmon/nsa3xx-hwmon.c
>> + *
>> + * ZyXEL NSA3xx Media Servers
>> + * hardware monitoring
>> + *
>> + * Copyright (C) 2012 Peter Schildmann<linux@schildmann.info>
>> + * Copyright (C) 2016 Adam Baker<linux@baker-net.org.uk>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License v2 as published by
>> the
>> + * Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>> License for
>> + * more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/err.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/delay.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define MAGIC_NUMBER 0x55
>> +#define DRVNAME "nsa3xx-hwmon"
> is DRVNAME used at all? If you really want to have the
> define, use it _everywhere_ or even better, do not have
> the define at all.

It was only used once so I've removed it

>> +/*
>> + * The Zyxel hwmon MCU is a Holtek HT46R065 that is factory programmed
>> + * to perform temperature and fan speed monitoring. It is read by taking
>> + * the active pin low. The 32 bit output word is then clocked onto the
>> + * data line. The MSB of the data word is a magic nuber to indicate it
>> + * has been read correctly, the next byte is the fan speed (in hundreds
>> + * of RPM) and the last two bytes are the temperature (in tenths of a
>> + * degree
> Missing )
Fixed
>> + */
>> +
>> +struct nsa3xx_hwmon {
>> +    struct device        *classdev;
>> +    struct mutex        update_lock;    /* lock GPIO operations */
>> +    unsigned long        last_updated;    /* jiffies */
>> +    unsigned long        mcu_data;
> u32?
Changed
>> +    struct gpio_desc    *act;
>> +    struct gpio_desc    *clk;
>> +    struct gpio_desc    *data;
>> +};
>> +
>> +enum nsa3xx_inputs {
>> +    NSA3XX_FAN = 1,
>> +    NSA3XX_TEMP = 0,
>> +};
>> +
>> +static const char * const nsa3xx_input_names[] = {
>> +    [NSA3XX_FAN] = "Chassis Fan",
>> +    [NSA3XX_TEMP] = "System Temperature",
>> +};
>> +
>> +/* Although this protocol looks similar to SPI the long delay
>> + * between the active (aka chip select) signal and the shorter
>> + * delay between clock pulses are needed for reliable operation.
>> + * The delays provifded are taken from the manufacturer kernel,
> s/provifded/provided/
Done
>
>> + * testing suggest they probably incorporate a reasonable safety
>> + * margin (the single device tested became unreliable with delays
>> + * around 10% of the values below).
> 10% of the original values or with 10% off, i.e. 90% of the original
> value?
Reworded to make clear it is 10% of the value, not 10% off. With a 
sample size
of one I wouldn't be comfortable if it failed with a value that is 10% off.
>> + */
>> +static unsigned long nsa3xx_hwmon_update(struct device *dev)
>> +{
>> +    int i;
>> +    uint32_t mcu_data;
>> +    struct nsa3xx_hwmon *hwmon = dev_get_drvdata(dev);
>> +
>> +    mutex_lock(&hwmon->update_lock);
>> +
>> +    mcu_data = hwmon->mcu_data;
>> +
>> +    if (time_after(jiffies, hwmon->last_updated + HZ) ||
>> +                            mcu_data == 0) {
>> +
>> +        gpiod_set_value(hwmon->act, 1);
>> +        msleep(100);
>> +
>> +        for (i = 31; i >= 0; i--) {
>> +            gpiod_set_value(hwmon->clk, 0);
>> +            usleep_range(100, 200);
>> +
>> +            gpiod_set_value(hwmon->clk, 1);
>> +            usleep_range(100, 200);
>> +
>> +            mcu_data |=
>> +                 gpiod_get_value(hwmon->data) ? (1 << i) : 0;
>> +        }
> u32 mask;
>
> for (mask = BIT(31); mask; mask >>= 1) {
> 	gpiod_set_value(hwmon->clk, 0);
> 	usleep_range(100, 200);
> 	gpiod_set_value(hwmon->clk, 1);
> 	usleep_range(100, 200);
> 	if (gpiod_get_value(hwmon->data))
> 		mcu_data |= mask;
> }
Changed
>> +
>> +        gpiod_set_value(hwmon->act, 0);
>> +        dev_dbg(dev, "Read raw MCU data %08x\n", mcu_data);
>> +
>> +        if ((mcu_data & 0xff000000) != (MAGIC_NUMBER << 24)) {
> if ((mcu_data >> 24) != MAGIC_NUMBER) { ?
Changed
>> +            dev_err(dev, "Read invalid MCU data %08x\n", mcu_data);
>> +            mcu_data = 0;
>> +        }
>> +
>> +        hwmon->mcu_data = mcu_data;
>> +        hwmon->last_updated = jiffies;
>> +    }
>> +
>> +    mutex_unlock(&hwmon->update_lock);
>> +
>> +    return mcu_data;
>> +}
>> +
>> +static ssize_t show_name(struct device *dev,
>> +             struct device_attribute *attr, char *buf)
>> +{
>> +    return sprintf(buf, "nsa3xx\n");
> Shouldn't that return "nsa3xx-hwmon" or something?
I've changed the registration to use 
devm_hwmon_device_register_with_groups()
so this function has disappeared but the register with groups function 
requires
a name that doesn't have a hyphen in it.
>> +}
>> +
>> +static ssize_t show_label(struct device *dev,
>> +              struct device_attribute *attr, char *buf)
>> +{
>> +    int channel = to_sensor_dev_attr(attr)->index;
>> +
>> +    return sprintf(buf, "%s\n", nsa3xx_input_names[channel]);
>> +}
>> +
>> +static ssize_t show_value(struct device *dev,
>> +              struct device_attribute *attr, char *buf)
>> +{
>> +    int channel = to_sensor_dev_attr(attr)->index;
>> +    unsigned long mcu_data = nsa3xx_hwmon_update(dev);
>> +    unsigned long value = 0;
>> +
>> +    pr_debug("channel value 0x%02x!\n", channel);
>> +    switch (channel) {
>> +    case NSA3XX_TEMP:
>> +        value = (mcu_data & 0xffff) * 100;
>> +        break;
>> +    case NSA3XX_FAN:
>> +        value = ((mcu_data & 0xff0000) >> 16) * 100;
> That's the point: If you claim to support nsa3xx devices,
> you should move all nsa320 stuff into a single update function
> and just return pre-parsed temp and fan rpm here.
>
> If you move the mcu_data parsing to nsa320_hwmon_update()
> you have only one Board-specific function while the rest
> is still more or less generic to easily add nsa310/325/3??
> support to _nsa3xx_ hwmon driver.
>
> And that question will come for sure: How generic is nsa3xx
> hwmon? Currently, it does only support nsa320, right?
As stated above I believe the driver, including the parsing logic, is 
valid for all board variants that have an MCU on them rather than a 
standard I2C monitoring chip.

>> +        break;
>> +    }
>> +    return sprintf(buf, "%lu\n", value);
>> +}
>> +
>> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
>> NSA3XX_TEMP);
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_value, NULL,
>> NSA3XX_TEMP);
>> +static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_label, NULL,
>> NSA3XX_FAN);
>> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_value, NULL,
>> NSA3XX_FAN);
>> +
>> +static struct attribute *nsa3xx_attributes[] = {
>> +    &dev_attr_name.attr,
>> +    &sensor_dev_attr_temp1_label.dev_attr.attr,
>> +    &sensor_dev_attr_temp1_input.dev_attr.attr,
>> +    &sensor_dev_attr_fan1_label.dev_attr.attr,
>> +    &sensor_dev_attr_fan1_input.dev_attr.attr,
>> +    NULL
>> +};
>> +
>> +/*
>> + * Look up GPIO pins in device tree
>> + */
>> +static int nsa3xx_hwmon_get_pins(struct device *dev)
>> +{
>> +    struct nsa3xx_hwmon *hwmon = dev_get_drvdata(dev);
>> +
>> +    hwmon->act = devm_gpiod_get(dev, "act", GPIOD_OUT_LOW);
>> +    hwmon->clk = devm_gpiod_get(dev, "clk", GPIOD_OUT_LOW);
>> +    hwmon->data = devm_gpiod_get(dev, "data", GPIOD_IN);
> Not really DT-specific? I guess you can move all of it in
> _probe().
Moved
>> +    if (IS_ERR(hwmon->act))
>> +        return PTR_ERR(hwmon->act);
>> +    if (IS_ERR(hwmon->clk))
>> +        return PTR_ERR(hwmon->clk);
>> +    if (IS_ERR(hwmon->data))
>> +        return PTR_ERR(hwmon->data);
>> +
>> +    return 0;
>> +
>> +}
>> +
>> +static const struct of_device_id of_nsa3xx_hwmon_match[] = {
>> +    {
>> +        .name = "nas3xx-hwmon",
> s/nas/nsa/ but get rid of .name completely.
Done
>> +        .compatible = "zyxel,nsa320-mcu",
>> +    },
>> +    { },
>> +};
>> +
>> +static const struct attribute_group nsa3xx_attr_group = {
>> +    .attrs    = nsa3xx_attributes,
>> +};
>> +
>> +static int nsa3xx_hwmon_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct nsa3xx_hwmon *hwmon;
>> +
>> +    hwmon = devm_kzalloc(&pdev->dev, sizeof(struct nsa3xx_hwmon),
> use sizeof(*hwmon)
Done
>> +                GFP_KERNEL);
>> +    if (!hwmon)
>> +        return -ENOMEM;
>> +
>> +    platform_set_drvdata(pdev, hwmon);
>> +
>> +    ret = nsa3xx_hwmon_get_pins(&pdev->dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mutex_init(&hwmon->update_lock);
>> +
>> +    ret = sysfs_create_group(&pdev->dev.kobj, &nsa3xx_attr_group);
>> +    if (ret)
>> +        goto err;
>> +
>> +    hwmon->classdev = hwmon_device_register(&pdev->dev);
>> +    if (IS_ERR(hwmon->classdev)) {
>> +        ret = PTR_ERR(hwmon->classdev);
>> +        goto err_sysfs;
>> +    }
>> +
>> +    dev_info(&pdev->dev, "initialized\n");
> IMHO dev_dbg is sufficient.
Changed
> Sebastian
>
>> +    return 0;
>> +
>> +err_sysfs:
>> +    sysfs_remove_group(&pdev->dev.kobj, &nsa3xx_attr_group);
>> +err:
>> +    platform_set_drvdata(pdev, NULL);
>> +    return ret;
>> +}
>> +
>> +static int nsa3xx_hwmon_remove(struct platform_device *pdev)
>> +{
>> +    struct nsa3xx_hwmon *hwmon = platform_get_drvdata(pdev);
>> +
>> +    hwmon_device_unregister(hwmon->classdev);
>> +    sysfs_remove_group(&pdev->dev.kobj, &nsa3xx_attr_group);
>> +    platform_set_drvdata(pdev, NULL);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver nsa3xx_hwmon_driver = {
>> +    .probe = nsa3xx_hwmon_probe,
>> +    .remove = nsa3xx_hwmon_remove,
>> +    .driver = {
>> +        .name = DRVNAME,
>> +        .owner = THIS_MODULE,
>> +        .of_match_table = of_match_ptr(of_nsa3xx_hwmon_match),
>> +    },
>> +};
>> +
>> +module_platform_driver(nsa3xx_hwmon_driver);
>> +
>> +MODULE_DEVICE_TABLE(of, of_nsa3xx_hwmon_match);
>> +MODULE_AUTHOR("Peter Schildmann<linux@schildmann.info>");
>> +MODULE_AUTHOR("Adam Baker<linux@baker-net.org.uk>");
>> +MODULE_DESCRIPTION("NSA3XX Hardware Monitoring");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:nsa3xx-hwmon");
>>

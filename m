From: carlo@caione.org (Carlo Caione)
Date: Tue, 4 Mar 2014 21:56:23 +0100
Subject: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
In-Reply-To: <20140303015616.GN2411@sirena.org.uk>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140303015616.GN2411@sirena.org.uk>
Message-ID: <CAOQ7t2a2TLcckDn21obOvR6rfvbaM4kDeE_2Kdgj__JC3xAzKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 2:56 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
>
>> index d59c826..0cef101 100644
>> --- a/arch/arm/configs/sunxi_defconfig
>> +++ b/arch/arm/configs/sunxi_defconfig
>> @@ -69,3 +69,4 @@ CONFIG_NFS_FS=y
>>  CONFIG_ROOT_NFS=y
>>  CONFIG_NLS=y
>>  CONFIG_PRINTK_TIME=y
>> +CONFIG_REGULATOR_AXP20X=y
>
> If you want to update the defconfig do it in a separate patch.

Ok, I'll split the patch.

>> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
>> +{
>> +     return regulator_set_voltage_sel_regmap(rdev, 0);
>> +}

Right. I'll fix it in v2.

> I'm not entirely clear what this is supposed to do but it's broken - it
> both ignores the voltage that is passed in and immediately writes to the
> normal voltage select register which will presumably distrupt the system.
>
>> +static int axp20x_io_enable_regmap(struct regulator_dev *rdev)
>> +{
>> +     return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
>> +                               rdev->desc->enable_mask, AXP20X_IO_ENABLED);
>> +}
>
> Please make some helpers for this (or extend the existing ones to cope
> with more than a single bit control) - there's several other devices
> which have similar multi-bit controls so we should factor this out
> rather than open coding.

No prob, I'll submit a patch for the helpers before submitting the v2
of this patchset

>> +     np = of_node_get(pdev->dev.parent->of_node);
>> +     if (!np)
>> +             return 0;
>> +
>> +     regulators = of_find_node_by_name(np, "regulators");
>> +     if (!regulators) {
>> +             dev_err(&pdev->dev, "regulators node not found\n");
>> +             return -EINVAL;
>> +     }
>
> The driver should be able to start up with no configuration provided at
> all except for the device being registered - the user won't be able to
> change anything but they will be able to read the current state of the
> hardware which can be useful for diagnostics.

seems reasonable

>> +static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
>> +{
>> +     unsigned int mask = AXP20X_WORKMODE_DCDC2_MASK;
>> +
>> +     if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
>> +             return -EINVAL;
>> +
>> +     if (id == AXP20X_DCDC3)
>> +             mask = AXP20X_WORKMODE_DCDC3_MASK;
>> +
>> +     return regmap_update_bits(rdev->regmap, AXP20X_DCDC_MODE, mask, workmode);
>> +}
>
> What is a workmode?

It defines if the output from DCDC2 or DCDC3 (that can be used as PWM chargers).
I'll document it better in the bindings documentation.

>> +             pmic->rdev[i] = regulator_register(&pmic->rdesc[i], &config);
>> +             if (IS_ERR(pmic->rdev[i])) {
>
> Use devm_regulator_register() and then you don't need to clean up the
> regulators either.
>
>> +static int __init axp20x_regulator_init(void)
>> +{
>> +     return platform_driver_register(&axp20x_regulator_driver);
>> +}
>> +
>> +subsys_initcall(axp20x_regulator_init);
>
> module_platform_driver().

I'll fix both in v2.

Thank you,

-- 
Carlo Caione

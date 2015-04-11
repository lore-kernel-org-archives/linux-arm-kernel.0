From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 11 Apr 2015 23:54:21 +0300
Subject: [PATCH] power: add poodle battery driver
In-Reply-To: <20150407154023.GA23823@earth>
References: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
 <20150406164428.GB18145@earth>
 <CALT56yOH-rc1RG=xQhcGT-FKJz7D9qKd+rO+8s4PdYrK0weCGQ@mail.gmail.com>
 <20150407154023.GA23823@earth>
Message-ID: <CALT56yN-dH=0Er01V3MUYEK2t1gw0Zb6gO_qqnUpPspqrJVPYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-04-07 18:40 GMT+03:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> On Tue, Apr 07, 2015 at 03:34:30PM +0300, Dmitry Eremin-Solenikov wrote:
>> > On Mon, Mar 30, 2015 at 02:24:39PM +0300, Dmitry Eremin-Solenikov wrote:
>> >> Add a driver supporting battery charging on Sharp SL-5600 (poodle).
>> >> Voltage and temperature readings are provided through add7846 hwmon
>> >> interface. Battery voltage is in1_input (mV) and temp in in0_input
>> >> (values unknown, but should be less than 2441).
>> >
>> > You may want to convert add7846 to iio interface, which can be
>> > exposed via hwmon and requested by other kernel drivers (e.g. this
>> > one).
>>
>> This needs a more careful thought. I have several devices in mind,
>> which provide touchscreen + ADC interfaces, where ADC is used
>> for battery voltage and temperature sensing. Sometimes additional
>> GPIOs are in play. Thus I'd like for now to sustain from changing
>> ads7846 driver. Or, at least to delay such changes, iff there will be
>> no real design/ideas how to handle such devices in a generic enough
>> way.
>
> If you have more of these devices it's even more appealing to use
> the IIO interface. You can basically keep the touchscreen part of
> the ads7846 driver and replace hwmon with IIO. Then other kernel
> drivers can request an IIO channel, but you are still able to use
> hwmon interface from userspace via iio-hwmon.

There are more chips like this, not all of them are ads7846.
I'll think about your suggestion. However I do not see this as a first
priority task.


>
>> [...]
>
>> >> +static int poodle_battery_probe(struct platform_device *dev)
>> >> +{
>> >> + int ret;
>> >> +
>> >> + ret = gpio_request_array(poodle_batt_gpios,
>> >> + ARRAY_SIZE(poodle_batt_gpios));
>> >> + if (ret)
>> >> + return ret;
>> >> +
>> >> + mutex_init(&poodle_bat_main.work_lock);
>> >> +
>> >> + INIT_WORK(&bat_work, poodle_bat_work);
>> >> +
>> >> + ret = power_supply_register(&dev->dev, &poodle_bat_main.psy);
>> >> + if (ret)
>> >> + goto err_psy_reg_main;
>> >
>> > we have devm_power_supply_register() now.
>>
>> Not so sure about it. I'd like to cancel work after unregistering power_supply.
>> I think I'll even switch from devm_request_irq back to request_irq to be able
>> to cancel IRQs before canceling work.

To be sure that there are no pending work items, after canceling the work
in driver remove callback. Basically I'd like to be sure of the following
sequence:

- shut down IRQs, so that no external events can schedule work
- unregister psy so replugging AC can not schedule work
- cancel all pending work
- free memory

Would you have any suggestions other than doing first two unregistrations
by hand?


-- 
With best wishes
Dmitry

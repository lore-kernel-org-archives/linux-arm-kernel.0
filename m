From: carlo@caione.org (Carlo Caione)
Date: Tue, 11 Feb 2014 10:33:22 +0100
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <20140211091505.GE32042@lee--X1>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210211900.GC32042@lee--X1>
 <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
 <20140211091505.GE32042@lee--X1>
Message-ID: <CAOQ7t2ZWneDDrqpBQTWpmUozK8Pu4Ri97FX4E2R9NK72XECtaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:15 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> +const struct of_device_id axp20x_of_match[] = {
>> >> +     { .compatible = "x-powers,axp20x", .data = (void *)AXP20X },
>> >
>> > There's no need to add device IDs if you only support one device.
>>
>> Ok. But what if in the future we want to add a new device?
>
> Then we add support for device identification. Until then, it's just
> meaningless cruft.

Ok, I'll get rid of it in v2.

>> >> +     { },
>> >> +};
>> >> +
>> >> +static struct axp20x_dev *axp20x_pm_power_off;
>> >
>> > This looks pretty unconventional. What's the point of it?
>>
>> On a single board we can have multiple AXPs so I track which one is in
>> charge of powering off the board (and to get the correct device in the
>> axp20x_power_off())
>
> Is it this device's responsibility to shut down the _entire_ board? Or
> does the call below only turn off _this_ device?

AXP shutdowns the entire board

>> >> +static void axp20x_power_off(void)
>> >> +{
>> >> +     regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL, 0x80);
>
> <snip>
>
>> >> +     of_id = of_match_device(axp20x_of_match, &i2c->dev);
>> >> +     if (!of_id) {
>> >> +             dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
>> >> +             return -ENODEV;
>> >> +     }
>> >> +     axp20x->variant = (int) of_id->data;
>> >
>> > Lots of code here surrounding added device support, but only one
>> > device is supported. Why so?
>>
>> Because at the moment I support only axp202 and axp209 but I wanted
>> something future-proof
>
> Nothing is future-proof. :)
>
> You only need to add this functionality when it's going to be
> utilised.

I agree. Fix in v2.

>> >> +     axp20x->i2c_client = i2c;
>> >> +     i2c_set_clientdata(i2c, axp20x);
>> >> +
>> >> +     axp20x->dev = &i2c->dev;
>> >> +     dev_set_drvdata(axp20x->dev, axp20x);
>> >
>> > Do you make use of all this saving of the device container?
>> >
>> > If so, where?
>>
>> In the drivers for subsystems (input, regulators, gpio, etc..)
>
> Can you link me to the patches please?  Any reason why they're not in
> this set?  By submitting them together you give the Maintainers a good
> over-view on how the system works together.

I wasn't sure it was a good idea to submit all the drivers altogether,
so my idea was to submit one driver at a time.
Do you think is it better to submit all the subsystems in one patch-set?

>> > Also:
>> >   i2c_set_clientdata(i2c)
>> >
>> > and:
>> >   dev_set_drvdata(i2c->dev);
>> >
>> > ... do exactly the same thing i.e. set i2c->dev->p->device_data.
>>
>> Right.
>
> Right.  So why are you doing them both?

Right == I'll fix it :)

Thank you,

-- 
Carlo Caione

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Feb 2014 09:15:06 +0000
Subject: [linux-sunxi] Re: [PATCH 1/3] mfd: axp20x: Add mfd driver for
 axp20x PMIC
In-Reply-To: <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-2-git-send-email-carlo@caione.org>
 <20140210211900.GC32042@lee--X1>
 <CAOQ7t2axObbBpVcF0z826Q2b0DaCx+wr0fvJ1X9Ek33174pOwA@mail.gmail.com>
Message-ID: <20140211091505.GE32042@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static const struct regmap_irq axp20x_regmap_irqs[] = {
> >> +     AXP20X_IRQ(ACIN_OVER_V,         0, 7),
> >> +     AXP20X_IRQ(ACIN_PLUGIN,         0, 6),

[...]

> >> +     AXP20X_IRQ(GPIO1_INPUT,         4, 1),
> >> +     AXP20X_IRQ(GPIO0_INPUT,         4, 0),
> >> +};
> >
> > Where are these handled i.e. where is the irq_handler located?
> 
> Each one is used by a different driver for each subsystem of the MFD,
> so each driver will have a specific irq_handler. I need the full list
> here to register with regmap_add_irq_chip() the generic

> regmap_irq_thread.

Okay, this is all I needed.  I must confess that I haven't _used_
regmap_add_irq_chip() before and was a little confused as to how it
worked exactly.  We used to handle hierarchical IRQs ourselves, but
this is better I think.

<snip>

> >> +const struct of_device_id axp20x_of_match[] = {
> >> +     { .compatible = "x-powers,axp20x", .data = (void *)AXP20X },
> >
> > There's no need to add device IDs if you only support one device.
> 
> Ok. But what if in the future we want to add a new device?

Then we add support for device identification. Until then, it's just
meaningless cruft.

> >> +     { },
> >> +};
> >> +
> >> +static struct axp20x_dev *axp20x_pm_power_off;
> >
> > This looks pretty unconventional. What's the point of it?
> 
> On a single board we can have multiple AXPs so I track which one is in
> charge of powering off the board (and to get the correct device in the
> axp20x_power_off())

Is it this device's responsibility to shut down the _entire_ board? Or
does the call below only turn off _this_ device?

> >> +static void axp20x_power_off(void)
> >> +{
> >> +     regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL, 0x80);

<snip>

> >> +     of_id = of_match_device(axp20x_of_match, &i2c->dev);
> >> +     if (!of_id) {
> >> +             dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> >> +             return -ENODEV;
> >> +     }
> >> +     axp20x->variant = (int) of_id->data;
> >
> > Lots of code here surrounding added device support, but only one
> > device is supported. Why so?
> 
> Because at the moment I support only axp202 and axp209 but I wanted
> something future-proof

Nothing is future-proof. :)

You only need to add this functionality when it's going to be
utilised.

> >> +     axp20x->i2c_client = i2c;
> >> +     i2c_set_clientdata(i2c, axp20x);
> >> +
> >> +     axp20x->dev = &i2c->dev;
> >> +     dev_set_drvdata(axp20x->dev, axp20x);
> >
> > Do you make use of all this saving of the device container?
> >
> > If so, where?
> 
> In the drivers for subsystems (input, regulators, gpio, etc..)

Can you link me to the patches please?  Any reason why they're not in
this set?  By submitting them together you give the Maintainers a good
over-view on how the system works together.

> > Also:
> >   i2c_set_clientdata(i2c)
> >
> > and:
> >   dev_set_drvdata(i2c->dev);
> >
> > ... do exactly the same thing i.e. set i2c->dev->p->device_data.
> 
> Right.

Right.  So why are you doing them both?

<snip>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

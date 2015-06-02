From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 2 Jun 2015 10:27:16 -0700
Subject: [PATCH v2 4/6] gpio: brcmstb: Allow GPIOs to be wakeup sources
In-Reply-To: <20150530004343.GX27753@ld-irv-0074>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-5-git-send-email-gregory.0xf0@gmail.com>
 <20150530004343.GX27753@ld-irv-0074>
Message-ID: <CADtm3G6fd3=xPL-LSMCahoR2X+R60ryPrnVVy589MO3vyfj9VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 5:43 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Thu, May 28, 2015 at 07:14:08PM -0700, Gregory Fong wrote:
>> Several drivers (e.g. gpio-keys) allow for GPIOs to be configured as
>> wakeup sources, and this GPIO controller supports that through a
>> separate interrupt path.
>>
>> The de-facto standard DT property "wakeup-source" is checked, since
>> that indicates whether the GPIO controller hardware can wake.  Uses
>> the IRQCHIP_MASK_ON_SUSPEND irq_chip flag because UPG GIO doesn't have
>> any of its own wakeup source configuration.
>>
>> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
>> ---
>> New in v2.
>>
>>  drivers/gpio/gpio-brcmstb.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
>> index b9962ff..2598c1e 100644
>> --- a/drivers/gpio/gpio-brcmstb.c
>> +++ b/drivers/gpio/gpio-brcmstb.c
>> [...]
>> @@ -369,6 +396,32 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
>>       priv->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
>>       priv->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
>>       priv->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
>> +
>> +     /* Ensures that all non-wakeup IRQs are disabled at suspend */
>> +     priv->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
>> +
>> +     if (IS_ENABLED(CONFIG_PM_SLEEP) &&
>> +                     of_get_property(np, "wakeup-source", NULL)) {
>
> of_property_read_bool()?

Will change.

>
>> +             priv->parent_wake_irq = platform_get_irq(pdev, 1);
>> +             if (priv->parent_wake_irq < 0)  {
>> +                     dev_warn(dev,
>> +                             "Couldn't get wake IRQ - GPIOs will not be able to wake from sleep");
>> +             } else {
>> +                     int err = devm_request_irq(dev, priv->parent_wake_irq,
>> +                                     brcmstb_gpio_wake_irq_handler, 0,
>> +                                     "brcmstb-gpio-wake", priv);
>> +
>> +                     if (err < 0) {
>> +                             dev_err(dev, "Couldn't request wake IRQ");
>> +                             return err;
>> +                     }
>> +
>> +                     device_set_wakeup_capable(dev, true);
>> +                     device_wakeup_enable(dev);
>
> Might want to move these two lines above the devm_request_irq(), so that
> you're ready to record PM events immediately at probe time. This is
> important when waking from S5 states, where we sometimes want to be able
> to check the /sys/devices/.../wakeup_count stats to see what woke us up.

Makes sense.  We'll also need a reboot notifier for S5 to work.

>
>> +                     priv->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
>> +             }
>> +     }
>> +
>>       priv->irq_domain =
>>               irq_domain_add_linear(np, priv->num_gpios,
>>                                     &brcmstb_gpio_irq_domain_ops,
>
> With that:
>
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>

Thanks,
Gregory

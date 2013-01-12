From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 12 Jan 2013 10:06:44 +0100
Subject: [PATCH 1/2] ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
In-Reply-To: <CACRpkda0yhVvCW9edWBi3XusfS4NaiWqKsoCfLpT9+X5iO-GXg@mail.gmail.com>
References: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
 <1357317909-12458-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkda0yhVvCW9edWBi3XusfS4NaiWqKsoCfLpT9+X5iO-GXg@mail.gmail.com>
Message-ID: <50F127A4.907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 10/01/2013 12:06, Linus Walleij wrote:
> On Fri, Jan 4, 2013 at 5:45 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> +static int __devinit
>> +sunxi_pinctrl_register_gpio_ranges(struct sunxi_pinctrl *pctl)
>> +{
>> +       int id = 0, base = 0, npins = 1, i, prev_pin = -1;
>> +       struct pinctrl_gpio_range *range;
>> +
>> +       for (i = 0; i < pctl->desc->npins; i++) {
>> +               const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
>> +               unsigned pin_num = pin->pin.number;
>> +
>> +               if (prev_pin < 0) {
>> +                       prev_pin = pin_num;
>> +                       base = pin_num;
>> +               } else if (prev_pin + 1 != pin_num) {
>> +                       range = devm_kzalloc(pctl->dev,
>> +                                       sizeof(*range),
>> +                                       GFP_KERNEL);
>> +                       if (!range)
>> +                               return -ENOMEM;
>> +
>> +                       range->name = "sunxi";
>> +                       range->id = id;
>> +                       range->base = base;
>> +                       range->pin_base = base;
>> +                       range->npins = npins;
>> +
>> +                       pinctrl_add_gpio_range(pctl->pctl_dev, range);
>> +
>> +                       id++;
>> +                       npins = 1;
>> +                       prev_pin = pin_num;
>> +                       base = prev_pin;
>> +               } else {
>> +                       prev_pin++;
>> +                       npins++;
>> +               }
>> +       }
>> +
>> +       range = devm_kzalloc(pctl->dev, sizeof(*range),
>> +                       GFP_KERNEL);
>> +       if (!range)
>> +               return -ENOMEM;
>> +
>> +       range->name = "sunxi";
>> +       range->id = id;
>> +       range->base = base;
>> +       range->pin_base = base;
>> +       range->npins = npins;
>> +
>> +       pinctrl_add_gpio_range(pctl->pctl_dev, range);
>> +
>> +       return 0;
>> +}
> 
> Really hairy way to add ranges right?

Yes... I didn't find any best way to do so. It was either that or
duplicate the already existing informations we had about the pins ranges
into a ranges array, which is pretty error-prone.

I guess I could add some comments though.

> Registering ranges from the pinctrl side is deprecated and discouraged.
> 
> Instead register the ranges from the GPIO driver.
> 
> Use gpiochip_add_pin_range() from the GPIO driver.
> 
> An example is provided in
> drivers/pinctrl/pinctrl-coh901.c

Ok, will do. But we need to find a way to share the pins arrays between
the pinctrl and gpio drivers then.

Maybe add a pinctrl-sunxi-pins.h file? or merge the pinctrl and gpio
drivers?

I'm kind of reluctant to merging the drivers into one single messy file,
but if that's the way to go, fine.

> 
> After you have done this, you can probably get rid of this as well:
> 
> +static int __init sunxi_gpio_init(void)
> +{
> +       return platform_driver_register(&sunxi_gpio_driver);
> +}
> +postcore_initcall(sunxi_gpio_init);
> 
> This will become a simple module_init() if you are handling
> deferred probe correctly.

Ok. Thanks for your review!
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

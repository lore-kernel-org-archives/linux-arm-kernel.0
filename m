From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 27 Mar 2017 11:46:48 +0200
Subject: [PATCH v2 4/7] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <CACRpkdaueEJKTJq6QihyBS18wgtgqVLHAFa=13_2X8AYuh7tqg@mail.gmail.com>
 (Linus Walleij's message of "Mon, 27 Mar 2017 10:57:15 +0200")
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <913cf9807c7c351bb7dabac9b3336431dac060e5.1490120798.git-series.gregory.clement@free-electrons.com>
 <CACRpkdaueEJKTJq6QihyBS18wgtgqVLHAFa=13_2X8AYuh7tqg@mail.gmail.com>
Message-ID: <878tnraw6v.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On lun., mars 27 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Mar 21, 2017 at 7:28 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
> You should add something to your Kconfig including:
>
> select GPIOLIB
> select OF_GPIO
>
> or so... or depends on. You certainly need them.

I missed it I will do it in v4.

>
>> +static int armada_37xx_gpiochip_register(struct platform_device *pdev,
>> +                                       struct armada_37xx_pinctrl *info)
>> +{
>> +       struct device_node *np;
>> +       struct gpio_chip *gc;
>> +       int ret = -ENODEV;
>> +
>> +       for_each_child_of_node(info->dev->of_node, np) {
>> +               if (of_find_property(np, "gpio-controller", NULL)) {
>> +                       ret = 0;
>> +                       break;
>> +               }
>> +       };
>
> OK so several GPIO chips as subnodes, why not one device per
> chip? Or have we discussed this before? It seems a bit weird,
> apparently there is just one node with a gpio-controller, as you're
> just adding one pin range.

As you probably noticed pinctrl and gpio register are mixed in this
hardware. One of the register is alos use to get some clock freqeuncy,
so that's why I ended with a syscon node. The parent node is the
pinctrl. My main motivation to use a subnode was to be ablee to have a
phandle associated with the GPIO chip. In my first version I only have
one node but then I realized that I could not use GPIO in the device
tree without an phandle to point it.

If you have an other solution, I would be happy to remove this subnode.


>
> What happens if there would be two gpio-controllers? The second
> is just ignored without error?

There won't be a second gpio-controllers because we only have one gpio
controller by pin controller (as they are actually the same). Also as I
said above, the subnode is mainly here to provide a phandle.

But I can add a comment to emphasize it.


>
>> +       ret = gpiochip_add_data(gc, info);
>> +       if (ret)
>> +               return ret;
>
> Can't you use devm_gpiochip_add_data()?

I think I can.

>
>> +       ret = gpiochip_add_pin_range(&info->gpio_chip, dev_name(dev), 0,
>> +                                    pinbase, info->data->nr_pins);
>> +       if (ret)
>> +               return ret;
>
> Why can't you put the range(s) into the device tree?
>
> We already have code in drivers/gpio/gpiolib-of.c to do this
> for you. And generic range definition bindings.

It was done in the v3.

Tanks,

Gregory

>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

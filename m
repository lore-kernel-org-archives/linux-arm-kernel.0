From: yingjoe.chen@mediatek.com (Joe.C)
Date: Mon, 6 Oct 2014 18:35:41 +0800
Subject: [PATCH v2 2/4] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <CACRpkdYY7e0OQL1YTEASxJw7E0FPAyOrPi0g93A9aRbfss0Vpw@mail.gmail.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-3-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkdYY7e0OQL1YTEASxJw7E0FPAyOrPi0g93A9aRbfss0Vpw@mail.gmail.com>
Message-ID: <1412591741.19977.527.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Linus,

Thanks for your detail review.
We'll fix the driver according to your suggestion in next version.
Please see the inline comments below for thing that I feel deserve
discussion:


On Thu, 2014-10-02 at 15:38 +0200, Linus Walleij wrote:
(...)
> > +static struct mt_desc_function *
> > +mt_pctrl_desc_find_irq_by_name(struct mt_pinctrl *pctl,
> > +                                        const char *pin_name)
> 
> Why is it called *find_irq_by_name if it returns a
> function? Seems more like find_function_from_pin_name
> really.
> 
> And I don't know if that is such a good idea.

In 8135 & 6589, not every gpio pin support interrupt function. For those
support interrupt, it will have a EINT function and use a different EINT
offset number.
In 8127, EINT support is merged into gpio function, but they still use a
different EINT offset number.

For example, mt8135 pin 0 use function 2 for interrupt support, EINT
number for this pin is 49.
        MT_PIN(
                PINCTRL_PIN(0, "MSDC0_DAT7"),
                "D21", "mt8135",
                MT_FUNCTION(0, "GPIO0"),
                MT_FUNCTION(1, "MSDC0_DAT7"),
                MT_FUNCTION_IRQ(2, "EINT49", 49),
                MT_FUNCTION(3, "I2SOUT_DAT"),
                MT_FUNCTION(4, "DAC_DAT_OUT"),
                MT_FUNCTION(5, "PCM1_DO"),
                MT_FUNCTION(6, "SPI1_MO"),
                MT_FUNCTION(7, "NALE")
        ),

This function is used to find EINT function for the pin. Maybe we should
name this mt_pctrl_desc_find_irq_function_from_name to make it more
clear.

> > +{
> > +       int i, j;
> > +
> > +       for (i = 0; i < pctl->devdata->npins; i++) {
> > +               const struct mt_desc_pin *pin = pctl->devdata->pins + i;
> > +
> > +               if (!strcmp(pin->pin.name, pin_name)) {
> > +                       struct mt_desc_function *func = pin->functions;
> > +
> > +                       for (j = 0; j < PINMUX_MAX_VAL; j++) {
> > +                               if (func->irqnum != 255)
> 
> So why does it end at 255? Seems pretty arbitrary.

If a function support interrupt, we put its interrupt number in irqnum,
otherwise it will be 255. Does it make it more clear if we use macro
name MT_NO_EINT_SUPPORT?

> > +static int mt_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       struct mt_pinctrl *pctl = dev_get_drvdata(chip->dev);
> > +       struct mt_pinctrl_group *g = pctl->groups + offset;
> > +       struct mt_desc_function *desc = mt_pctrl_desc_find_irq_by_name(
> > +                       pctl, g->name);
> > +       if (!desc)
> > +               return -EINVAL;
> > +
> > +       mt_gpio_set_mode(pctl->pctl_dev, g->pin, desc->muxval);
> 
> No mode setting in the .to_irq() function, that makes the irqchip
> not orthogonal to the gpio_chip.

I see, we should do this in irq_request_resources instead.

> 
> > +       return desc->irqnum;
> > +}
> 
> By the way use GPIOLIB_IRQCHIP for this and get rid
> of .to_irq altogether.
> (...)
> > +       ret = gpiochip_add(pctl->chip);
> > +       if (ret) {
> > +               ret = -EINVAL;
> > +               goto pctrl_error;
> > +       }
> 
> Here  you should be using gpiochip_irqchip_add()
> followed by gpiochip_set_chained_irqchip().

We use a different interrupt number than gpio pin number. I think it
more nature to use EINT interrupt number as the hw_number, so I think we
can't use gpiochip_irqchip_add and we still need to provide our
own .to_irq mapping function.


> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> (...)
> > +static const struct mt_desc_pin mt_pins_mt8135[] = {
> > +       MT_PIN(
> > +               PINCTRL_PIN(0, "MSDC0_DAT7"),
> > +               "D21", "mt8135",
> > +               MT_FUNCTION(0, "GPIO0"),
> > +               MT_FUNCTION(1, "MSDC0_DAT7"),
> > +               MT_FUNCTION_IRQ(2, "EINT49", 49),
> > +               MT_FUNCTION(3, "I2SOUT_DAT"),
> > +               MT_FUNCTION(4, "DAC_DAT_OUT"),
> > +               MT_FUNCTION(5, "PCM1_DO"),
> > +               MT_FUNCTION(6, "SPI1_MO"),
> > +               MT_FUNCTION(7, "NALE")
> > +       ),
> 
> I don't think this is a good idea and to encode all functions in a pin,
> rather the revers is custom: define all functions and collect arrays
> of pin numbers in the definitions of pin groups, then map the functions
> and groups of pins together.
> 
> Look at other drivers for examples..
> 
> I don't like the device tree bindings for the very same reason: it moves
> all this numeric encoding of pin-functions into the device tree instead
> of combining group+function strings like most drivers do.
> 
> Is there some special reason to why you're turning this on its head?
> 
> Yours,
> Linus Walleij

Our driver code is based on sunxi driver. We got base source structure
and this pin descriptor array from sunxi. We follow imx's use of device
tree macros.

Our pinctrl can set mux for each individual pins, so I think this
pin_desc array fully describe the capability of pinctrl HW. It is
generated from datasheet, which can easily prove it correctness.

With the help of device tree header file, pinctrl users can describe
pins used by their components easily in device tree. The change could be
fully tested with their driver to make sure it is correct. Also, we
don't need to change pinctrl driver just to add or correct a group for
the component.

While it might still be possible to generate group+function array based
on datasheet, IMHO the structure will be more complicate and harder to
prove the correctness.

So we choose to use descriptor array + macros in device tree because it
is quite simple to generate the pin descriptors and easier to notice if
there's error in device tree pin groups description.

Even if we change to use group+function strings as you said, we
probably will still use this array to find out which function we should
set for each pin in a group.

Regards,
Joe.C

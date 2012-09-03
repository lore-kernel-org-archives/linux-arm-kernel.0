From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 13:48:04 +0200
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CAPub14-CQCXf3pfZqXjHarfMfaYG3Me7aNffFJ3JMYhr8J4osg@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
 <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
 <CACRpkday9+zhMHWWjNNBfhhQ2NXPc+RoGkHvxodud5HY7hLm4g@mail.gmail.com>
 <CAPub14-CQCXf3pfZqXjHarfMfaYG3Me7aNffFJ3JMYhr8J4osg@mail.gmail.com>
Message-ID: <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 1:22 PM, shiraz hashim
<shiraz.linux.kernel@gmail.com> wrote:
> Hi Linus, Grant,
> On Wed, Jun 20, 2012 at 1:55 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Jun 19, 2012 at 4:11 PM, viresh kumar <viresh.linux@gmail.com> wrote:

>> The outcome was basically this work item from Linaro:
>> https://blueprints.launchpad.net/linux-linaro/+spec/pinctrl-gpiorange-makeover
>>
>> So the idea is that GPIO drivers should register their pin ranges
>> instead of the other way around (pinctrl drivers register them, as it
>> is done today), and that we need to move the mapping to be
>> GPIO-driver local, which in turn mandates stashing the
>> struct gpio_chip into the GPIO range mapping.
>>
>> Not a simple refactoring but probably necessary (all current users need
>> to be switched over).
>>
>> Interested? ;-)
>
> I tried to prepare a basic patch based upon this, can you please
> see if the approach is fine.

Hey :-)

Thanks for working on this!!

>     gpiolib: provide provision for gpios to register pin range
>
>     pinctrl subsystem needs gpio chip base to prepare set of gpio pin ranges
>     which a given pinctrl driver can handle. This is important to handle
>     pinctrl gpio request calls in order to program a given pin properly for
>     gpio operation.
>
>     As gpio base is allocated dynamically while gpiochip registration,
>     presently there exists no clean way to pass this information to the
>     pinctrl subsystem.
>
>     After few discussions from [1], it was concluded that may be gpio
>     reporting the pin range it supports is a better way than pinctrl
>     subsystem directly registering it.
>
>     [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/166668
>
>     Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>

(Some spelling/grammar errors above but I can fix that, no big issue.)

> +2.1) gpio-controller and pinctrl subsystem
> +------------------------------------------
>
> +gpio-controller on a SOC might be tightly coupled with the pinctrl
> +subsystem, in the sense that the pins can be used by other functions
> +together with optional gpio feature.
> +
> +While the pin allocation is totally managed by the pin ctrl subsystem,
> +gpio (under gpiolib) is still maintained by gpio drivers. It may happen
> +that different pin ranges in a SoC is managed by different gpio drivers.
> +
> +This makes it logical to let gpio drivers announce their pin ranges to
> +the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
> +request the corresponding pin before any gpio usage.
> +
> +For this, the gpio controller can use a pinctrl phandle and pins to
> +announce the pinrange to the pin ctrl subsystem. For example,
> +
> +       qe_pio_e: gpio-controller at 1460 {
> +               #gpio-cells = <2>;
> +               compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
> +               reg = <0x1460 0x18>;
> +               gpio-controller;
> +                                 pins = <&pinctrl1 20 10>,
> +                                <&pinctrl2 50 20>;
> +
> +    }

This needs to go into the binding document in
Documentation/devicetree/bindings/gpio/gpio.txt as well.

> +
> +where,
> +   &pinctrl1 and &pinctrl2 is the phandle to the pinctrl DT node.
> +
> +   Next values specify the base pin and number of pins for the range
> +   handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
> +   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
> +   by this gpio controller.

The above implies that only devcie tree is used for this. That is not
the case: other architectures like Blackfin, MIPS and x86 shall also use
the pinctrl subsystem, and they may not have device tree. Maybe they
have ACPI, maybe BIOS or SFI (Simple Firmware Interface).

So the basic problem with the patch is that you cannot hard-code it
to use *only* device tree, it must also accept ranges registered
directly, not using of_*.

Basically this comes down to creating two functions more
to add pin ranges from GPIO chips, see below comments.

Also, you should put a big "DEPRECATED" mark on the old gpio
range concept, and refer to the new way of doing things.

> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index d18068a..cadbbff 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/pinctrl.h>

This is a good idea, patching gpiolib so everyone can use this
easily.

(...)
> +#ifdef CONFIG_PINCTRL
> +void of_gpiochip_add_pin_range(struct gpio_chip *chip)
> +{
> +       struct device_node *np = chip->of_node;
> +       struct gpio_pin_range *pin_range;
> +       struct of_phandle_args pinspec;
> +       int index = 0;
> +
> +       if (!chip->of_node)
> +               return;
> +
> +       INIT_LIST_HEAD(&chip->pin_ranges);
> +
> +       do {
> +               int ret;
> +
> +               ret = of_parse_phandle_with_args(np, "gpio-ranges", "#gpio-range-cells",
> +                               index, &pinspec);
> +
> +               if (ret)
> +                       break;
> +
> +               pin_range = kzalloc(sizeof(*pin_range), GFP_KERNEL);
> +               if (!pin_range) {
> +                       pr_err("%s: GPIO chip: failed to allocate pin ranges\n",
> +                                       chip->label);
> +                       break;
> +               }
> +
> +               pin_range->range.name = chip->label;
> +               pin_range->range.base = chip->base;
> +               pin_range->range.pin_base = pinspec.args[0];
> +               pin_range->range.npins = pinspec.args[1];
> +               pin_range->pctldev = of_pinctrl_add_gpio_range(pinspec.np,
> +                               &pin_range->range);
> +
> +               list_add_tail(&pin_range->node, &chip->pin_ranges);
> +
> +       } while (index++);
> +
> +}
> +
> +void of_gpiochip_remove_pin_range(struct gpio_chip *chip)
> +{
> +       struct gpio_pin_range *pin_range, *tmp;
> +
> +       list_for_each_entry_safe(pin_range, tmp, &chip->pin_ranges, node) {
> +               pinctrl_remove_gpio_range(pin_range->pctldev,
> +                               &pin_range->range);
> +               list_del(&pin_range->node);
> +               kfree(pin_range);
> +       }
> +}
> +#else
> +void of_gpiochip_add_pin_range(struct gpio_chip *chip) {}
> +void of_gpiochip_remove_pin_range(struct gpio_chip *chip) {}
> +#endif
> +
>  void of_gpiochip_add(struct gpio_chip *chip)
>  {
>         if ((!chip->of_node) && (chip->dev))
> @@ -226,11 +285,14 @@ void of_gpiochip_add(struct gpio_chip *chip)
>                 chip->of_xlate = of_gpio_simple_xlate;
>         }
>
> +       of_gpiochip_add_pin_range(chip);
>         of_node_get(chip->of_node);
>  }
>
>  void of_gpiochip_remove(struct gpio_chip *chip)
>  {
> +       of_gpiochip_remove_pin_range(chip);
> +
>         if (chip->of_node)
>                 of_node_put(chip->of_node);
>  }

This part looks good.

But I want two similar function named:

gpiochip_add_pin_range();
gpiochip_remove_pin_range();

that can be used for platforms that doesn't support DT.

For example I'd like to convert over some of my existing
drivers that do not have DT support to do this thing instead
of registering ranges from the pin controller...

(...)
> +++ b/drivers/pinctrl/devicetree.c
> @@ -106,6 +106,19 @@ static struct pinctrl_dev
> *find_pinctrl_by_of_node(struct device_node *np)
>         return NULL;
>  }
>
> +struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
> +               struct pinctrl_gpio_range *range)
> +{
> +       struct pinctrl_dev *pctldev;
> +
> +       pctldev = find_pinctrl_by_of_node(np);
> +       if (!pctldev)
> +               return NULL;
> +
> +       pinctrl_add_gpio_range(pctldev, range);
> +       return pctldev;
> +}
> +
>  static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
>                                 struct device_node *np_config)
>  {
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 365ea09..f7e0648 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/pinctrl.h>
>
>  #ifdef CONFIG_GPIOLIB
>
> @@ -47,6 +48,21 @@ struct seq_file;
>  struct module;
>  struct device_node;
>
> +#ifdef CONFIG_PINCTRL

There's no need to #ifdef this I think.

> +/**
> + * struct gpio_pin_range - pin range controlled by a gpio chip
> + * @head: list for maintaining set of pin ranges, used internally
> + * @pctldev: pinctrl device which handles corresponding pins
> + * @range: actual range of pins controlled by a gpio controller
> + */
> +
> +struct gpio_pin_range {
> +       struct list_head node;
> +       struct pinctrl_dev *pctldev;
> +       struct pinctrl_gpio_range range;
> +};
> +#endif

Hm I cannot really decide whether thus range should be in
<linux/pinctrl/pinctrl.h> or here. Isn't it easier to just put it in
<linux/pinctrl/pinctrl.h>?

>  /**
>   * struct gpio_chip - abstract a GPIO controller
>   * @label: for diagnostics
> @@ -132,6 +148,14 @@ struct gpio_chip {
>         int (*of_xlate)(struct gpio_chip *gc,
>                         const struct of_phandle_args *gpiospec, u32 *flags);
>  #endif
> +#ifdef CONFIG_PINCTRL
> +       /* If CONFIG_PINCTRL is enabled, then gpio controllers can
> +        * optionally describe the actual pin range which they serve in
> +        * an SoC. This information would be used by pinctrl subsystem
> +        * to configure corresponding pins for gpio usage.
> +        */
> +       struct list_head pin_ranges;
> +#endif

OK...

(...)
> +++ b/include/linux/pinctrl/pinctrl.h
> @@ -133,6 +133,12 @@ extern void pinctrl_add_gpio_range(struct
> pinctrl_dev *pctldev,
>                                 struct pinctrl_gpio_range *range);
>  extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
>                                 struct pinctrl_gpio_range *range);
> +#ifdef CONFIG_OF
> +extern struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
> +               struct pinctrl_gpio_range *range);
> +
> +#endif

Don't #ifdef this, then all code using it has to be #ifdef:ed too.

Provide a stub function below like with all the other functions instead.

Yours,
Linus Walleij

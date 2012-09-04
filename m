From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Tue, 4 Sep 2012 09:49:40 +0530
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
 <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
 <CACRpkday9+zhMHWWjNNBfhhQ2NXPc+RoGkHvxodud5HY7hLm4g@mail.gmail.com>
 <CAPub14-CQCXf3pfZqXjHarfMfaYG3Me7aNffFJ3JMYhr8J4osg@mail.gmail.com>
 <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
Message-ID: <20120904041940.GA2037@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thanks for reviewing,

On Mon, Sep 03, 2012 at 01:48:04PM +0200, Linus Walleij wrote:
> On Sat, Sep 1, 2012 at 1:22 PM, shiraz hashim
> >     gpiolib: provide provision for gpios to register pin range
> >
> >     pinctrl subsystem needs gpio chip base to prepare set of gpio pin ranges
> >     which a given pinctrl driver can handle. This is important to handle
> >     pinctrl gpio request calls in order to program a given pin properly for
> >     gpio operation.
> >
> >     As gpio base is allocated dynamically while gpiochip registration,
> >     presently there exists no clean way to pass this information to the
> >     pinctrl subsystem.
> >
> >     After few discussions from [1], it was concluded that may be gpio
> >     reporting the pin range it supports is a better way than pinctrl
> >     subsystem directly registering it.
> >
> >     [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/166668
> >
> >     Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> 
> (Some spelling/grammar errors above but I can fix that, no big issue.)
> 

Sorry for the English.

> > +2.1) gpio-controller and pinctrl subsystem
> > +------------------------------------------
> >
> > +gpio-controller on a SOC might be tightly coupled with the pinctrl
> > +subsystem, in the sense that the pins can be used by other functions
> > +together with optional gpio feature.
> > +
> > +While the pin allocation is totally managed by the pin ctrl subsystem,
> > +gpio (under gpiolib) is still maintained by gpio drivers. It may happen
> > +that different pin ranges in a SoC is managed by different gpio drivers.
> > +
> > +This makes it logical to let gpio drivers announce their pin ranges to
> > +the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
> > +request the corresponding pin before any gpio usage.
> > +
> > +For this, the gpio controller can use a pinctrl phandle and pins to
> > +announce the pinrange to the pin ctrl subsystem. For example,
> > +
> > +       qe_pio_e: gpio-controller at 1460 {
> > +               #gpio-cells = <2>;
> > +               compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
> > +               reg = <0x1460 0x18>;
> > +               gpio-controller;
> > +                                 pins = <&pinctrl1 20 10>,
> > +                                <&pinctrl2 50 20>;
> > +
> > +    }
> 
> This needs to go into the binding document in
> Documentation/devicetree/bindings/gpio/gpio.txt as well.
> 

right.

> > +
> > +where,
> > +   &pinctrl1 and &pinctrl2 is the phandle to the pinctrl DT node.
> > +
> > +   Next values specify the base pin and number of pins for the range
> > +   handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
> > +   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
> > +   by this gpio controller.
> 
> The above implies that only devcie tree is used for this. That is not
> the case: other architectures like Blackfin, MIPS and x86 shall also use
> the pinctrl subsystem, and they may not have device tree. Maybe they
> have ACPI, maybe BIOS or SFI (Simple Firmware Interface).

Okay.

> So the basic problem with the patch is that you cannot hard-code it
> to use *only* device tree, it must also accept ranges registered
> directly, not using of_*.

For describing gpio pin ranges, we need to know corresponding pinctrl
implementation handling this range, base pin and number of pins
belonging to the range. Further there can be multiple such ranges for
a gpio driver.

With devicetree it was easy to provide this information and parse it
inside gpiolib itself. Without DT how do you suggest gpio drivers must
pass range information to gpiolib ?


> Basically this comes down to creating two functions more
> to add pin ranges from GPIO chips, see below comments.
> 
> Also, you should put a big "DEPRECATED" mark on the old gpio
> range concept, and refer to the new way of doing things.

Okay.


[...]

> >  void of_gpiochip_remove(struct gpio_chip *chip)
> >  {
> > +       of_gpiochip_remove_pin_range(chip);
> > +
> >         if (chip->of_node)
> >                 of_node_put(chip->of_node);
> >  }
> 
> This part looks good.
> 
> But I want two similar function named:
> 
> gpiochip_add_pin_range();
> gpiochip_remove_pin_range();
> 
> that can be used for platforms that doesn't support DT.

How to pass the information required by these functions is something we
need to think about.


[...]

> >  #ifdef CONFIG_GPIOLIB
> >
> > @@ -47,6 +48,21 @@ struct seq_file;
> >  struct module;
> >  struct device_node;
> >
> > +#ifdef CONFIG_PINCTRL
> 
> There's no need to #ifdef this I think.
> 

Yes, you are right.

> > +/**
> > + * struct gpio_pin_range - pin range controlled by a gpio chip
> > + * @head: list for maintaining set of pin ranges, used internally
> > + * @pctldev: pinctrl device which handles corresponding pins
> > + * @range: actual range of pins controlled by a gpio controller
> > + */
> > +
> > +struct gpio_pin_range {
> > +       struct list_head node;
> > +       struct pinctrl_dev *pctldev;
> > +       struct pinctrl_gpio_range range;
> > +};
> > +#endif
> 
> Hm I cannot really decide whether thus range should be in
> <linux/pinctrl/pinctrl.h> or here. Isn't it easier to just put it in
> <linux/pinctrl/pinctrl.h>?
> 

pinctrl describes gpio range through 'pinctrl_gpio_range' while
'gpio_pin_range' is defined here to maintain gpio exported pin ranges.

Since pinctrl is only bothered about pinctrl_gpio_range and not
gpio_pin_range, I think we can keep it here.

[...]

> > +++ b/include/linux/pinctrl/pinctrl.h
> > @@ -133,6 +133,12 @@ extern void pinctrl_add_gpio_range(struct
> > pinctrl_dev *pctldev,
> >                                 struct pinctrl_gpio_range *range);
> >  extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
> >                                 struct pinctrl_gpio_range *range);
> > +#ifdef CONFIG_OF
> > +extern struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
> > +               struct pinctrl_gpio_range *range);
> > +
> > +#endif
> 
> Don't #ifdef this, then all code using it has to be #ifdef:ed too.
> 
> Provide a stub function below like with all the other functions instead.

Sure.

--
regards
Shiraz

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 16 Aug 2012 14:18:52 +0200
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
Message-ID: <20120816121852.GA7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:38 Wed 15 Aug     , Linus Walleij wrote:
> (Hm maybe I should've read this patch first, well whatever.)
> 
> On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> 
> > This is also include the gpio controller as the IP share both.
> > Each soc will have to describe the SoC limitation and pin configuration via
> > DT.
> 
> This is very good.
> 
> > This will allow to do not need to touch the C code when adding new SoC if the
> > IP version is supported.
> 
> Which is what we want -> less churn.
> 
> > +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> 
> This needs to be CC to devicetree-discuss at lists.ozlabs.org where bindings
> are discussed, the people there sometimes make a good job to make sure
> the bindings are OS-neutral and stuff (doesn't seem like a problem in this
> very case, but anyway).
> 
> > +Required properties for iomux controller:
> > +- compatible: "atmel,at91rm9200-pinctrl"
> > +- atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
> > +  configured in this periph mode. All the periph and bank need to be describe.
> 
> Can you please be more elaborate on this mux-mask, like what each bit
> means and why the bits are arranged like that and what it means on the
> AT91 platform.... I was first reading the .dts and was like ?woot? so
> I go to the bindings doc and I read this and I'm still like ?woot?..
> 
> > +Required properties for pin configuration node:
> > +- atmel,pins: 4 integers array, represents a group of pins mux and config
> 
> This also need to be detailed so you can just read this and then
> look at the numbers in the device tree and, "aha I get it!".
> 
> > +  setting. The format is atmel,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
> > +  The PERIPH 0 means gpio.
> 
> So please elaborate a bit on the three first members, so it's easy to read
> and understand the device tree. I "sort of" understand it but better
> be explicit.
> 
> (...)
> > +Bits used for CONFIG:
> > +PULL_UP(1 << 0): indicate this pin need a pull up.
> > +MULTIDRIVE(1 << 1): indicate this pin need to be configured as multidrive.
> 
> Hm if we just add multidrive to <linux/pinctrl/pinconf-generic.h> we
> could probably get this driver (and bindings) to use the generic
> pinconf library in drivers/pinctrl/pinonf-generic.c as the coh901
> currently does.
> 
> Actually multidrive makes me think that this is just shunting in
> several MOSFET driver stages, which we *used* to have in
> pinconf-generic, just by documenting that the argument passed
> with parameter PIN_CONFIG_DRIVE_PUSH_PULL
> would indicate the number of drive stages if != 0.
> 
> Like this (old doc):
> 
> + * @PIN_CONFIG_DRIVE_PUSH_PULL: the pin will be driven actively high and
> + *     low, this is the most typical case and is typically achieved with two
> + *     active transistors on the output. If the pin can support different
> + *     drive strengths for push/pull, the strength is given in the argument
> + *     as the number of driving stages vs nominal load impedance, so say
> + *     quadruple driving stages (usually 8 transistors rather than two) will
> + *     be configured with the 8 passed as argument.
> 
> We're not mandate generic pin config because driver authors told me
> repeatedly that their chips are very special (like everyone else, hehe)
> but please keep it in mind as it could be hard to change this later.
> I'd be happy to put back this piece of doc...
> 
> > +2. The pin configuration node intends to work on a specific function should
> > +   to be defined under that specific function node.
> > +   The function node's name should represent well about what function
> > +   this group of pins in this pin configuration node are working on.
> 
> I cannot parse this, sorry :-) could you detail...
> 
> > +3. The driver can use the function node's name and pin configuration node's
> > +   name describe the pin function and group hierarchy.
> > +   For example, Linux Iat91 pinctrl driver takes the function node's name
> > +   as the function name and pin configuration node's name as group name to
> > +   create the map table.
> > +4. Each pin configuration node should have a phandle, devices can set pins
> > +   configurations by referring to the phandle of that pin configuration node.
> > +5. The gpio controller must be describe in the pinctrl simple-bus.
> 
> I think I understand this part...
> 
> > +pinctrl at fffff400 {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       ranges;
> > +       compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> > +       reg = <0xfffff400 0x600>;
> > +
> > +       atmel,mux-mask = <
> > +             /*    A         B     */
> > +              0xffffffff 0xffc00c3b  /* pioA */
> > +              0xffffffff 0x7fff3ccf  /* pioB */
> > +              0xffffffff 0x007fffff  /* pioC */
> > +             >;
> 
> I still have a real hard time understanding what is happening here,
> but maybe I'll understand as I go on reading the driver.
> 
> > +       /* shared pinctrl settings */
> > +       dbgu {
> > +               pinctrl_dbgu: dbgu-0 {
> > +                       atmel,pins =
> > +                               <1 14 0x1 0x0   /* PB14 periph A */
> > +                                1 15 0x1 0x1>; /* PB15 periph with pullup */
> 
> I understand that Pin 14 and 15 in pin bank 1 is connected to some
> peripheral numbered 1 and pin 15 is pulled up.
> 
> I guess perioheral 1 is identical to debugf uart 0 or something
> like that, since the node has this name? ut shouldn't this
> peripheral number come from the fact that it's dbgu so there
> is somewhere a table cross referencing ... or the device itself
> has some node which is separate and has some name like
> "pinctrl-periphid" or so?
> 
> Just trying to decipher this a bit so I see if I could maintain
> it...
> 
> Would it be possible to have the periphid as a separate node
> entry if it is anyway going to be the same value for all
> pins, or is this number also unique per bank or something
> like that, so debug uart would be say peripheral ID 5 on another
> pin bank? (In that case, keep it like this.)
the pin can be anywhere on the different bank and configured in different mux
(periph) so can not do as you suggest
> 
> > +dbgu: serial at fffff200 {
> > +       compatible = "atmel,at91sam9260-usart";
> > +       reg = <0xfffff200 0x200>;
> > +       interrupts = <1 4 7>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_dbgu>;
> > +       status = "disabled";
> > +};
> 
> I really like the looks of this.
> 
> (...)
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e91c7cd..178a619 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -352,6 +352,7 @@ config ARCH_AT91
> >         select CLKDEV_LOOKUP
> >         select IRQ_DOMAIN
> >         select NEED_MACH_IO_H if PCCARD
> > +       select PINCTRL
> 
> Richard said something about also selectong the AT91 driver which
> seemed lika a good idea.
as I reply Richard we need to force the at91 driver only when DT enabled
> 
> (There follow some changes moving a lot of IRQ domain stuff etc from
> the GPIO driver which is hard to understand, but I guess you're doing
> the right thing.)
> 
> (...)
> > --- /dev/null
> > +++ b/drivers/pinctrl/pinctrl-at91.c
> > @@ -0,0 +1,1448 @@
> > +/*
> > + * at91 pinctrl driver based on at91 pinmux core
> > + *
> > + * Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD
> > + * <plagnioj@jcrosoft.com>
> > + *
> > + * Under GPLv2 only
> > + */
> > +
> > +#define DEBUG
> 
> As noted rely on switching on DEBUG_PINCTRL where needed.
> It tags on -DDEBUG in the Makefile.
> 
> > +#include <asm/mach/irq.h>
> 
> Hm, it seems this platform is not using SPARSE_IRQ ...
it does

see chained_irq_enter/chained_irq_exit
> 
> (...)
> > +static struct at91_gpio_chip *gpio_chip[MAX_GPIO_BANKS];
> 
> Nitpick should it not be named *gpio_chips[] (plural) since
> there are several chips in that array?
ok
> 
> > +static int gpio_banks;
> > +static unsigned long at91_gpio_caps;
> 
> I usually protect this kind of variables with a mutex but it
> may be over-cautious.
> 
> (...)
> > +#define PULL_UP                (0 << 1)
> > +#define MULTI_DRIVE    (1 << 1)
> 
> So this I would have attempted to use pinconf-generic.[c|h] for
> and use PIN_CONFIG_BIAS_PULL_UP and
> PIN_CONFIG_DRIVER_PUSH_PULL with a specific
> argument for the multidrive.
> 
> Beware that you may want to patch pinconf-generic.c
> to get the debugfs output you want etc.
> 
> But as I said this is optional, just a good idea in general.
I'll take a look
> 
> (...)
> > +struct at91_pmx_pin {
> > +       uint32_t bank;
> > +       uint32_t pin;
> > +       uint32_t mux;
> > +       uint32_t pullup;
> > +       unsigned long conf;
> > +};
> 
> Are they all u32 really? I understand that they are u32 in the
> devicetree but pullup seems like a candidate for a bool.
> 
> Reading below it seems the "mux" member should be some
> kind of enum. Doing that an enum and documenting it seems
> like it would solve other readability issues.
> 
> And this could actually use some kerneldoc too, if possible.
ok
> 
> > +/**
> > + * struct at91_pin_group - describes an At91 pin group
> > + * @name: the name of this specific pin group
> 
> @pins_conf is not documented.
> 
> > + * @pins: an array of discrete physical pins used in this group, taken
> > + *     from the driver-local pin enumeration space
> > + * @npins: the number of pins in this group array, i.e. the number of
> > + *     elements in .pins so we can iterate over that array
> > + */
> > +struct at91_pin_group {
> > +       const char *name;
> > +       struct at91_pmx_pin *pins_conf;
> > +       unsigned int *pins;
> > +       unsigned npins;
> > +};
> 
> 
> > +struct at91_pinctrl {
> > +       struct device *dev;
> > +       struct pinctrl_dev *pctl;
> > +
> > +       int nbanks;
> > +
> > +       int nmux;
> > +       uint32_t *mux_mask;
> > +
> > +       struct at91_pmx_func *functions;
> > +       int nfunctions;
> > +
> > +       struct at91_pin_group *groups;
> > +       int ngroups;
> > +
> > +       void (*set_A_periph)(void __iomem *pio, unsigned mask);
> > +       void (*set_B_periph)(void __iomem *pio, unsigned mask);
> > +};
> 
> kerneldoc. Especually the two last functions are mysterious when just
> looking at the struct.
> 
> (Then follows a block of really nice code...)
> 
> (...)
> > +static void at91_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
> > +                  unsigned offset)
> > +{
> > +       seq_printf(s, "%s", dev_name(pctldev->dev));
> > +}
> 
> This print should actually output something interesting (if it helps)
> maybe you could skip it?
I've plan at a second step
> 
> > +static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
> > +                       struct device_node *np,
> > +                       struct pinctrl_map **map, unsigned *num_maps)
> 
> DT parse code, looks nice but would request Stephen to have a look
> at it.
> 
> (...)
> > +       new_map = kmalloc(sizeof(*new_map) * map_num, GFP_KERNEL);
> 
> Maybe devm_kzalloc()?
> 
> Because:
> 
> (...)
> > +       if (!parent) {
> > +               kfree(new_map);
> > +               return -EINVAL;
> 
> You could just return here. And:
> 
> (...)
> > +static void at91_dt_free_map(struct pinctrl_dev *pctldev,
> > +                               struct pinctrl_map *map, unsigned num_maps)
> > +{
> > +       kfree(map);
> > +}
> 
> Then this wouldn't be needed at all.
> 
> (...)
> > +static void at91_mux_disable_interrupt(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(mask, pio + PIO_IDR);
> > +}
> 
> I think most people use writel_relaxed() for this purpose (non-timeconsuming
> register write) these days. So conside replacing all __raw_* with *_relaxed().
I known this one I've in mind to do it as second patch
> 
> (...)
> > +static void at91_mux_pio3_set_A_periph(void __iomem *pio, unsigned mask)
> > +{
> > +
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask,
> > +                                               pio + PIO_ABCDSR1);
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
> > +                                               pio + PIO_ABCDSR2);
> > +}
> > +
> > +static void at91_mux_pio3_set_B_periph(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask,
> > +                                               pio + PIO_ABCDSR1);
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
> > +                                               pio + PIO_ABCDSR2);
> > +}
> > +
> > +static void at91_mux_set_A_periph(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(mask, pio + PIO_ASR);
> > +}
> > +
> > +static void at91_mux_set_B_periph(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(mask, pio + PIO_BSR);
> > +}
> > +
> > +static void at91_mux_set_C_periph(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask, pio + PIO_ABCDSR1);
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
> > +}
> > +
> > +static void at91_mux_set_D_periph(void __iomem *pio, unsigned mask)
> > +{
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask, pio + PIO_ABCDSR1);
> > +       __raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
> > +}
> 
> I have no clue whatsoever what is going on here, A? B? C? D?
> Some small comment or something giving a hint about this grouping
> system and how it works would be really nice.
periph (mux)
> 
> > +static void at91_pin_dbg(const struct device *dev, const struct at91_pmx_pin *pin)
> > +{
> > +       if (pin->mux) {
> > +               dev_dbg(dev, "pio%c%d configured as periph%c with conf = 0x%lu\n",
> > +                       pin->bank + 'A', pin->pin, pin->mux - 1 + 'A', pin->conf);
> > +       } else {
> > +               dev_dbg(dev, "pio%c%d configured as gpio with conf = 0x%lu\n",
> > +                       pin->bank + 'A', pin->pin, pin->conf);
> > +       }
> > +}
> 
> This is nice, and one of the things we try to centralize and standardize in
> pinconf-generic. However as I said that would be optional.
> 
> (...)
> 
> > +static void at91_mux_gpio_enable(void __iomem *pio, unsigned mask, unsigned input)
> > +{
> > +       __raw_writel(mask, pio + PIO_PER);
> > +       __raw_writel(mask, pio + (input ? PIO_ODR : PIO_OER));
> > +}
> > +
> 
> The last argument, "input" seems to be a bool.
> 
> Also not that this should maybe be named at91_mux_gpio_endisable()
> since it is called from the disable() function below.
ok
> 
> (...)
> > +       for (i = 0; i < npins; i++) {
> > +               pin = &pins_conf[i];
> > +               at91_pin_dbg(info->dev, pin);
> > +               pio = pin_to_controller(info, pin->bank);
> > +               mask = pin_to_mask(pin->pin);
> > +               at91_mux_disable_interrupt(pio, mask);
> > +               switch(pin->mux) {
> > +               case 0:
> > +                       at91_mux_gpio_enable(pio, mask, 1);
> > +                       break;
> > +               case 1:
> > +                       info->set_A_periph(pio, mask);
> > +                       break;
> > +               case 2:
> > +                       info->set_B_periph(pio, mask);
> > +                       break;
> > +               case 3:
> > +                       at91_mux_set_C_periph(pio, mask);
> > +                       break;
> > +               case 4:
> > +                       at91_mux_set_D_periph(pio, mask);
> > +                       break;
> > +               }
> > +               if (pin->mux)
> > +                       at91_mux_gpio_disable(pio, mask);
> 
> Looking at this it seems that the pin->mux variable should be an
> enum so we get rid of these magic values 0,1,2,3,4. Documenting
> these enums with kerneldoc would probably solve a lot of
> questionmarks.
> 
> (Noted in the struct review above as well.)
ok
> 
> (...)
> > +static void at91_pmx_disable(struct pinctrl_dev *pctldev, unsigned selector,
> > +                          unsigned group)
> > +{
> > +       struct at91_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
> > +       const struct at91_pmx_pin *pins_conf = info->groups[group].pins_conf;
> > +       const struct at91_pmx_pin *pin;
> > +       uint32_t npins = info->groups[group].npins;
> > +       int i;
> > +       unsigned mask;
> > +       void __iomem *pio;
> > +
> > +       for (i = 0; i < npins; i++) {
> > +               pin = &pins_conf[i];
> > +               at91_pin_dbg(info->dev, pin);
> > +               pio = pin_to_controller(info, pin->bank);
> > +               mask = pin_to_mask(pin->pin);
> > +               at91_mux_gpio_enable(pio, mask, 1);
> 
> Actually calling a function named "*enable" to disable something looks
> quite unintuitive. Maybe rename that function to
> "at91_mux_gpio_endisable()" or something?
> 
> (...)
...
> > +{
> > +       struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
> > +       unsigned        mask = 1 << d->hwirq;
> > +       unsigned        bank = at91_gpio->pioc_idx;
> > +
> > +       if (unlikely(bank >= MAX_GPIO_BANKS))
> > +               return -EINVAL;
> > +
> > +       if (state)
> > +               wakeups[bank] |= mask;
> > +       else
> > +               wakeups[bank] &= ~mask;
> > +
> > +       irq_set_irq_wake(at91_gpio->pioc_virq, state);
> > +
> > +       return 0;
> > +}
> 
> So I can see that this sets or clears bits in a 32-bit word per
> bank. But I don't see these words being used for anything at all?
> 
> So what's the point of all this?
> 
> In  ux500 we have a register bit that enables wakeup on a
> certain pin, then it makes all kind of sense to have this,
> but what is this stuff, really? It seems the function can be
> stripped down to two lines just calling irq_set_irq_wake().
> 
will take a look on this
> (...)
> > +       range = &at91_chip->range;
> > +       range->name = chip->label;
> > +       range->id = alias_idx;
> > +       range->pin_base = range->base = range->id * MAX_NB_GPIO_PER_BANK;
> > +
> > +       range->npins = chip->ngpio;
> > +       range->gc = chip;
> 
> This way of handling ranges looks very smooth, great that this works
> for you!

should work for everyone with pinctrl that combine both

Best Regards,
J.

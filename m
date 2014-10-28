From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 15:19:13 +0100
Subject: [PATCH v2 1/3] pinctrl: add driver for Amlogic Meson SoCs
In-Reply-To: <1413321714-25931-2-git-send-email-b.galvani@gmail.com>
References: <1413321714-25931-1-git-send-email-b.galvani@gmail.com>
 <1413321714-25931-2-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkdaO5wHB1fMR1Pw6R7bs9Qk14p3wOP8dxco7yAnqMOP_Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 11:21 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> This is a driver for the pinmux and GPIO controller available in
> Amlogic Meson SoCs. At the moment it only supports Meson8 devices,
> however other SoC families like Meson6 and Meson8b (the Cortex-A5
> variant) appear to be similar, with just different sets of banks and
> registers.
>
> GPIO interrupts are not supported at the moment due to lack of
> documentation.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

(...)
>  arch/arm/mach-meson/Kconfig            |   3 +

Still not split off from the main patch.

> +static void meson_domain_set_bit(struct meson_domain *domain,
> +                                void __iomem *addr, unsigned int bit,
> +                                unsigned int value)

Still not migrated to regmap MMIO.

> +       /* Copy group and function definitions from domains to pinctrl */
> +       pc->groups = devm_kzalloc(pc->dev, pc->num_groups *
> +                                 sizeof(struct meson_pmx_group), GFP_KERNEL);
> +       pc->funcs = devm_kzalloc(pc->dev, pc->num_funcs *
> +                                 sizeof(struct meson_pmx_func), GFP_KERNEL);
> +       if (!pc->groups || !pc->funcs)
> +               return -ENOMEM;

Still lots of copying of data.

> +static int meson_gpiolib_register(struct meson_pinctrl *pc)
> +{
> +       struct meson_domain *domain;
> +       unsigned int base = 0;

No.

> +       int i, ret;
> +
> +       for (i = 0; i < pc->num_domains; i++) {
> +               domain = &pc->domains[i];
> +
> +               domain->chip.label = domain->data->name;
> +               domain->chip.dev = pc->dev;
> +               domain->chip.request = meson_gpio_request;
> +               domain->chip.free = meson_gpio_free;
> +               domain->chip.direction_input = meson_gpio_direction_input;
> +               domain->chip.direction_output = meson_gpio_direction_output;
> +               domain->chip.get = meson_gpio_get;
> +               domain->chip.set = meson_gpio_set;
> +               domain->chip.base = base;

No. Set it to -1 and let the gpiolib assign some random GPIO numbers.

> +               domain->chip.ngpio = domain->data->num_pins;
> +               domain->chip.names = domain->data->pin_names;
> +               domain->chip.can_sleep = false;
> +               domain->chip.of_node = domain->of_node;
> +               domain->chip.of_gpio_n_cells = 2;
> +               domain->chip.of_xlate = meson_gpio_of_xlate;

Go for the generic xlate function instead.

> +               domain->gpio_range.name = domain->data->name;
> +               domain->gpio_range.id = i;
> +               domain->gpio_range.base = base;
> +               domain->gpio_range.pin_base = base;
> +               domain->gpio_range.npins = domain->data->num_pins;
> +               domain->gpio_range.gc = &domain->chip;
> +
> +               pinctrl_add_gpio_range(pc->pcdev, &domain->gpio_range);

Don't add the gpio range from the pinctrl side, add it from the
gpiolib side using gpiochip_add_pin_range() instead.

> +static int __init meson_pinctrl_drv_register(void)
> +{
> +       return platform_driver_register(&meson_pinctrl_driver);
> +}
> +postcore_initcall(meson_pinctrl_drv_register);

Does it have to be this early?

> +/**
> + * struct meson_domain
> + *
> + * @reg_mux:   registers for mux settings
> + * @reg_pullen:        registers for pull-enable settings
> + * @reg_pull:  registers for pull settings
> + * @reg_gpio:  registers for gpio settings
> + * @mux_size:  size of mux register range (in words)
> + * @pullen_size:size of pull-enable register range
> + * @pull_size: size of pull register range
> + * @gpio_size: size of gpio register range
> + * @chip:      gpio chip associated with the domain
> + * @data;      platform data for the domain
> + * @node:      device tree node for the domain
> + * @gpio_range:        gpio range that maps domain gpios to the pin controller
> + * @lock:      spinlock for accessing domain registers
> + *
> + * A domain represents a set of banks controlled by the same set of
> + * registers. Typically there is a domain for the normal banks and
> + * another one for the Always-On bus.
> + */

Insert all the info from your previous mail.

Yours,
Linus Walleij

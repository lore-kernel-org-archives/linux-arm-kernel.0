From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 14 Mar 2013 08:00:20 +1300
Subject: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <CACRpkdZ14k_o-aO248NZJ6-jqxJf8AYhsZHLN_wPToyU1NsM6w@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <CACRpkdZ14k_o-aO248NZJ6-jqxJf8AYhsZHLN_wPToyU1NsM6w@mail.gmail.com>
Message-ID: <1363201220.2452.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 17:11 +0100, Linus Walleij wrote:
> On Sat, Mar 9, 2013 at 6:39 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> 
> > This patch adds support for the GPIO/pinmux controller found on the VIA
> > VT8500 and Wondermedia WM8xxx-series SoCs.
> (...)
> 
> Allright!
> 
> The per-soc plugs and data look allright.
> 
> Maybe you want to put all files in drivers/pinctrl/wmt/*?
> 
> Just to keep track of things...
> 
> I start reviewing here:
> 
> (...)
> > --- /dev/null
> > +++ b/drivers/pinctrl/pinctrl-wmt.c
> (...)
> > +static void wmt_setbits(struct wmt_pinctrl_data *data, u32 reg, u32 mask)
> > +{
> > +       u32 val;
> > +
> > +       val = readl(data->base + reg);
> > +       val |= mask;
> > +       writel(val, data->base + reg);
> 
> Consider readl_relaxed(), writel_relaxed()
> 
> > +}
> > +
> > +static void wmt_clearbits(struct wmt_pinctrl_data *data, u32 reg, u32 mask)
> > +{
> > +       u32 val;
> > +
> > +       val = readl(data->base + reg);
> > +       val &= ~mask;
> > +       writel(val, data->base + reg);
> 
> Dito.
> 
> > +}
> 
> I usually type "static inline" on such functions, not for the compiler but for
> the human reader so as to understand it is to be quick.
> 
> (...)
> > +static int wmt_set_pinmux(struct wmt_pinctrl_data *data, unsigned func,
> > +                         unsigned pin)
> > +{
> > +       u32 bank = WMT_BANK_FROM_PIN(pin);
> > +       u32 bit = WMT_BIT_FROM_PIN(pin);
> > +       u32 reg_en = data->banks[bank].reg_en;
> > +       u32 reg_dir = data->banks[bank].reg_dir;
> > +
> > +       if (reg_dir == NO_REG) {
> > +               dev_err(data->dev, "pin:%d no direction register defined\n",
> > +                       pin);
> > +               return -EINVAL;
> > +       }
> > +
> > +/*
> > + * If reg_en == NO_REG, we assume it is a dedicated GPIO and cannot be
> > + * disabled (as on VT8500) and that no alternate function is available.
> > + */
> 
> There is something strange about the indentation of this comment
> that hurts my head. Please indent it like the surrounding code.
> 
> > +       switch (func) {
> > +       case WMT_FSEL_GPIO_IN:
> > +               if (reg_en != NO_REG)
> > +                       wmt_setbits(data, reg_en, BIT(bit));
> > +               wmt_clearbits(data, reg_dir, BIT(bit));
> > +               break;
> > +       case WMT_FSEL_GPIO_OUT:
> > +               if (reg_en != NO_REG)
> > +                       wmt_setbits(data, reg_en, BIT(bit));
> > +               wmt_setbits(data, reg_dir, BIT(bit));
> > +               break;
> > +       case WMT_FSEL_ALT:
> > +               if (reg_en == NO_REG) {
> > +                       dev_err(data->dev, "pin:%d no alt function available\n",
> > +                               pin);
> > +                       return -EINVAL;
> > +               }
> > +               wmt_clearbits(data, reg_en, BIT(bit));
> > +       }
> > +
> > +       return 0;
> > +}
> 
> (...)
> > +static int wmt_pctl_find_group_by_pin(struct wmt_pinctrl_data *data, u32 pin)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < data->npins; i++) {
> > +               if (data->pins[i].number == pin)
> > +                       return i;
> > +       }
> > +
> > +       return -1;
> 
> Is that a valid return code?
> 
> Use -EINVAL or something.
> 
> > +}
> > +
> > +static int wmt_pctl_dt_node_to_map_func(struct wmt_pinctrl_data *data,
> > +                                       struct device_node *np,
> > +                                       u32 pin, u32 fnum,
> > +                                       struct pinctrl_map **maps)
> > +{
> > +       u32 group;
> 
> int group;
> 
> > +       struct pinctrl_map *map = *maps;
> > +
> > +       if (fnum >= ARRAY_SIZE(wmt_functions)) {
> > +               dev_err(data->dev, "invalid wm,function %d\n", fnum);
> > +               return -EINVAL;
> > +       }
> > +
> > +       group = wmt_pctl_find_group_by_pin(data, pin);
> > +       if (group == -1) {
> 
> if (group < 0)
> 
> > +               dev_err(data->dev, "unable to match pin %d to group\n", pin);
> > +               return -EINVAL;
> 
> Then just return group;
> 
> > +       }
> > +
> > +       map->type = PIN_MAP_TYPE_MUX_GROUP;
> > +       map->data.mux.group = data->groups[group];
> > +       map->data.mux.function = wmt_functions[fnum];
> > +       (*maps)++;
> > +
> > +       return 0;
> > +}
> > +
> > +static int wmt_pctl_dt_node_to_map_pull(struct wmt_pinctrl_data *data,
> > +                                       struct device_node *np,
> > +                                       u32 pin, u32 pull,
> > +                                       struct pinctrl_map **maps)
> > +{
> > +       u32 group;
> 
> int group;
> 
> > +       unsigned long *configs;
> > +       struct pinctrl_map *map = *maps;
> > +
> > +
> 
> You can never have enough whitespace?
> 
> > +       if (pull > 2) {
> > +               dev_err(data->dev, "invalid wm,pull %d\n", pull);
> > +               return -EINVAL;
> > +       }
> > +
> > +       group = wmt_pctl_find_group_by_pin(data, pin);
> > +       if (group == -1) {
> 
> if (group < 0)
> 
> > +               dev_err(data->dev, "unable to match pin %d to group\n", pin);
> > +               return -EINVAL;
> 
> return group;
> 
> > +       }
> > +
> > +       configs = kzalloc(sizeof(*configs), GFP_KERNEL);
> > +       if (!configs)
> > +               return -ENOMEM;
> > +
> > +       configs[0] = 0;
> > +
> > +       map->type = PIN_MAP_TYPE_CONFIGS_PIN;
> > +       map->data.configs.group_or_pin = data->groups[group];
> > +       map->data.configs.configs = configs;
> > +       map->data.configs.num_configs = 1;
> > +       (*maps)++;
> > +
> > +       return 0;
> > +}
> > +
> > +static inline u32 prop_u32(struct property *p, int i)
> > +{
> > +       return be32_to_cpup(((__be32 *)p->value) + i);
> > +}
> 
> Oh um I don't understand this helper. Can you explain or atleast
> add a comment?
> 
> If you really need it it should *not* be added to this driver
> but to the generic OF helpers in <linux/of_*>
> 
> > +static int wmt_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
> > +                                  struct device_node *np,
> > +                                  struct pinctrl_map **map,
> > +                                  unsigned *num_maps)
> > +{
> > +       struct pinctrl_map *maps, *cur_map;
> > +       struct property *pins, *funcs, *pulls;
> > +       u32 pin, func, pull;
> > +       int num_pins, num_funcs, num_pulls, maps_per_pin;
> > +       int i, err;
> > +       struct wmt_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
> > +
> > +       pins = of_find_property(np, "wm,pins", NULL);
> > +       if (!pins) {
> > +               dev_err(data->dev, "missing wmt,pins property\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       funcs = of_find_property(np, "wm,function", NULL);
> > +       pulls = of_find_property(np, "wm,pull", NULL);
> > +
> > +       if (!funcs && !pulls) {
> > +               dev_err(data->dev, "neither wm,function nor wm,pull specified\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       num_pins = pins->length / 4;
> > +       num_funcs = funcs ? (funcs->length / 4) : 0;
> > +       num_pulls = pulls ? (pulls->length / 4) : 0;
> 
> Explain the magic constant (4) or use a #define.
> 
> > +
> > +       if (num_funcs > 1 && num_funcs != num_pins) {
> > +               dev_err(data->dev, "wm,function must have 1 or %d entries\n",
> > +                       num_pins);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (num_pulls > 1 && num_pulls != num_pins) {
> > +               dev_err(data->dev, "wm,pull must have 1 or %d entries\n",
> > +                       num_pins);
> > +               return -EINVAL;
> > +       }
> > +
> > +       maps_per_pin = 0;
> > +       if (num_funcs)
> > +               maps_per_pin++;
> > +       if (num_pulls)
> > +               maps_per_pin++;
> > +
> > +       cur_map = maps = kzalloc(num_pins * maps_per_pin * sizeof(*maps),
> > +                                GFP_KERNEL);
> > +       if (!maps)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < num_pins; i++) {
> > +               pin = prop_u32(pins, i);
> 
> So I don't get this. What is wrong with of_property_read_u32()?
> 
> I think there is something very strange about this parsing code
> if you can't use the common accessors to get the stuff you want,
> if you really need to inspect properties like that static inline does,
> then it should be explained and the function should *not* be in
> this driver but a helper in <linux/of_*> somewhere.
> 
> (...)
> > +static int wmt_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       struct wmt_pinctrl_data *data = dev_get_drvdata(chip->dev);
> > +       u32 bank = WMT_BANK_FROM_PIN(offset);
> > +       u32 bit = WMT_BIT_FROM_PIN(offset);
> > +       u32 reg_dir = data->banks[bank].reg_dir;
> > +       u32 val;
> > +
> > +       val = readl(data->base + reg_dir) & BIT(bit);
> 
> Consider readl_relaxed()
> 
> Don't do the & operation there plese...
> 
> > +       if (val)
> 
> Do if (val & BIT(bit)) here instead.
> 
> > +               return GPIOF_DIR_OUT;
> > +       else
> > +               return GPIOF_DIR_IN;
> > +}
> > +
> > +static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       return pinctrl_gpio_direction_input(chip->base + offset);
> > +}
> > +
> > +static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
> > +                                    int value)
> > +{
> > +       return pinctrl_gpio_direction_output(chip->base + offset);
> > +}
> > +
> > +static int wmt_gpio_get_value(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       struct wmt_pinctrl_data *data = dev_get_drvdata(chip->dev);
> > +       u32 bank = WMT_BANK_FROM_PIN(offset);
> > +       u32 bit = WMT_BIT_FROM_PIN(offset);
> > +       u32 reg_data_in = data->banks[bank].reg_data_in;
> > +
> > +       if (reg_data_in == NO_REG) {
> > +               dev_err(data->dev, "no data in register defined\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return (readl(data->base + reg_data_in) >> bit) & 1;
> 
> Consider readl_relaxed()
> 
> Consider this pattern:
> return !!(readl(data->base + reg_data_in) & BIT(bit));
> 
> > +static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
> > +                              int value)
> 
> Just int val since you use "val" rather than "value" elsewhere in the code.
> 
> > +{
> > +       struct wmt_pinctrl_data *data = dev_get_drvdata(chip->dev);
> > +       u32 bank = WMT_BANK_FROM_PIN(offset);
> > +       u32 bit = WMT_BIT_FROM_PIN(offset);
> > +       u32 reg_data_out = data->banks[bank].reg_data_out;
> > +
> > +       if (reg_data_out == NO_REG) {
> > +               dev_err(data->dev, "no data out register defined\n");
> > +               return;
> > +       }
> > +
> > +       if (value)
> > +               wmt_setbits(data, reg_data_out, BIT(bit));
> > +       else
> > +               wmt_clearbits(data, reg_data_out, BIT(bit));
> > +}
> > +
> > +static struct gpio_chip wmt_gpio_chip = {
> > +       .label = "gpio-wmt",
> > +       .owner = THIS_MODULE,
> > +       .request = wmt_gpio_request,
> > +       .free = wmt_gpio_free,
> > +       .get_direction = wmt_gpio_get_direction,
> > +       .direction_input = wmt_gpio_direction_input,
> > +       .direction_output = wmt_gpio_direction_output,
> > +       .get = wmt_gpio_get_value,
> > +       .set = wmt_gpio_set_value,
> > +       .base = -1,
> > +       .can_sleep = 0,
> > +};
> > +
> > +void wmt_dt_pinmux_config(struct wmt_pinctrl_data *data)
> > +{
> > +       struct device_node *np = data->dev->of_node;
> > +       u32 pinmux[2];
> > +       u32 val;
> > +       int ret;
> > +
> > +       ret = of_property_read_u32_array(np, "wm,pinmux", pinmux, 2);
> > +       if (!ret) {
> > +               /* pinmux[0] = data, pinmux[1] = mask */
> > +               val = readl(data->base + 0x200);
> 
> +0x200?
> 
> Please #define this magic constand so we understand what
> kind of register this is.
> 
> But I understand this may be that register that does some pinmuxing
> that is not properly documented... Then just
> 
> #define VT8500_MAGIC_PMX_REG 0x200 or whatever.
> 
> 
> > +               val &= ~(~pinmux[0] & pinmux[1]);
> > +               val |= (pinmux[0] & pinmux[1]);
> > +               writel(val, data->base + 0x200);
> 
> Consider readl_relaxed()/writel_relaxed().
> 
> > +       }
> > +}
> > +
> > +int wmt_pinctrl_probe(struct platform_device *pdev,
> > +                     struct wmt_pinctrl_data *data)
> > +{
> > +       int err;
> > +
> > +       wmt_desc.pins = data->pins;
> > +       wmt_desc.npins = data->npins;
> > +
> > +       data->gpio_chip = wmt_gpio_chip;
> > +       data->gpio_chip.dev = &pdev->dev;
> > +       data->gpio_chip.of_node = pdev->dev.of_node;
> > +       data->gpio_chip.ngpio = data->nbanks * 32;
> > +
> > +       platform_set_drvdata(pdev, data);
> > +
> > +       data->dev = &pdev->dev;
> > +       wmt_dt_pinmux_config(data);
> > +
> > +       data->pctl_dev = pinctrl_register(&wmt_desc, &pdev->dev, data);
> > +       if (IS_ERR(data->pctl_dev)) {
> > +               dev_err(&pdev->dev, "Failed to register pinctrl\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       err = gpiochip_add(&data->gpio_chip);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "could not add GPIO chip\n");
> > +               goto fail_gpio;
> > +       }
> > +
> > +       err = gpiochip_add_pin_range(&data->gpio_chip, dev_name(data->dev),
> > +                                    0, 0, data->nbanks * 32);
> 
> Good that you use gpiochip_add_pin_range()!
> 
> > +       if (err)
> > +               goto fail_range;
> > +
> > +       dev_info(&pdev->dev, "Pin controller initialized\n");
> > +
> > +       return 0;
> 
> Newline.
> 
> > +fail_range:
> > +       err = gpiochip_remove(&data->gpio_chip);
> > +       if (err)
> > +               dev_err(&pdev->dev, "failed to remove gpio chip\n");
> > +fail_gpio:
> > +       pinctrl_unregister(data->pctl_dev);
> > +       return err;
> > +}
> > +
> > +int wmt_pinctrl_remove(struct platform_device *pdev)
> > +{
> > +       struct wmt_pinctrl_data *data = platform_get_drvdata(pdev);
> > +       int err;
> > +
> > +       err = gpiochip_remove(&data->gpio_chip);
> > +       if (err)
> > +               dev_err(&pdev->dev, "failed to remove gpio chip\n");
> > +
> > +       pinctrl_unregister(data->pctl_dev);
> > +
> > +       return 0;
> > +}
> 
> Quite a bit of code. I might have missed something that I will
> come back and complain about later...
> 
> Yours,
> Linus Walleij

Thanks for the feedback. I'll look over it shortly and tidy it up.

Regards
Tony P

From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 00:08:58 +0800
Subject: [PATCH RESEND 2/2] gpio: axp209: add pinctrl support
In-Reply-To: <20161123141151.25315-3-quentin.schulz@free-electrons.com>
References: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
 <20161123141151.25315-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64TfspS0_DR3vEyjtfN-6tRnoT89Q-Gx5ctzDim5vW_fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 10:11 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The GPIOs present in the AXP209 PMIC have multiple functions. They
> typically allow a pin to be used as GPIO input or output and can also be
> used as ADC or regulator for example.[1]
>
> This adds the possibility to use all functions of the GPIOs present in
> the AXP209 PMIC thanks to pinctrl subsystem.
>
> [1] see registers 90H, 92H and 93H at
>     http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/gpio/gpio-axp209.txt       |  28 +-
>  drivers/gpio/gpio-axp209.c                         | 551 ++++++++++++++++++---
>  2 files changed, 503 insertions(+), 76 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> index a661130..a5bfe87 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> @@ -1,4 +1,4 @@
> -AXP209 GPIO controller
> +AXP209 GPIO & pinctrl controller
>
>  This driver follows the usual GPIO bindings found in
>  Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -28,3 +28,29 @@ axp209: pmic at 34 {
>                 #gpio-cells = <2>;
>         };
>  };
> +
> +The GPIOs can be muxed to other functions and therefore, must be a subnode of
> +axp_gpio.
> +
> +Example:
> +
> +&axp_gpio {
> +       gpio0_adc: gpio0_adc {
> +               pin = "GPIO0";
> +               function = "adc";
> +       };
> +};
> +
> +&example_node {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&gpio0_adc>;
> +};
> +
> +GPIOs and their functions
> +-------------------------
> +
> +GPIO   |       Functions
> +------------------------
> +GPIO0  |       gpio_in, gpio_out, ldo, adc
> +GPIO1  |       gpio_in, gpio_out, ldo, adc
> +GPIO2  |       gpio_in, gpio_out
> diff --git a/drivers/gpio/gpio-axp209.c b/drivers/gpio/gpio-axp209.c
> index 4a346b7..0a64cfc 100644
> --- a/drivers/gpio/gpio-axp209.c
> +++ b/drivers/gpio/gpio-axp209.c
> @@ -1,7 +1,8 @@
>  /*
> - * AXP20x GPIO driver
> + * AXP20x Pin control driver
>   *
>   * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
> + * Copyright (C) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under  the terms of the GNU General  Public License as published by the
> @@ -21,52 +22,103 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>
>  #define AXP20X_GPIO_FUNCTIONS          0x7
>  #define AXP20X_GPIO_FUNCTION_OUT_LOW   0
>  #define AXP20X_GPIO_FUNCTION_OUT_HIGH  1
>  #define AXP20X_GPIO_FUNCTION_INPUT     2
>
> -struct axp20x_gpio {
> -       struct gpio_chip        chip;
> -       struct regmap           *regmap;
> -};
> +#define AXP20X_PINCTRL_PIN(_pin_num, _pin, _regs)              \
> +       {                                                       \
> +               .number = _pin_num,                             \
> +               .name = _pin,                                   \
> +               .drv_data = _regs,                              \
> +       }
>
> -static int axp20x_gpio_get_reg(unsigned offset)
> -{
> -       switch (offset) {
> -       case 0:
> -               return AXP20X_GPIO0_CTRL;
> -       case 1:
> -               return AXP20X_GPIO1_CTRL;
> -       case 2:
> -               return AXP20X_GPIO2_CTRL;
> +#define AXP20X_PIN(_pin, ...)                                  \
> +       {                                                       \
> +               .pin = _pin,                                    \
> +               .functions = (struct axp20x_desc_function[]) {  \
> +                             __VA_ARGS__, { } },               \
>         }
>
> -       return -EINVAL;
> -}
> +#define AXP20X_FUNCTION(_val, _name)                           \
> +       {                                                       \
> +               .name = _name,                                  \
> +               .muxval = _val,                                 \
> +       }
>
> -static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
> -{
> -       struct axp20x_gpio *gpio = gpiochip_get_data(chip);
> -       int reg;
> +struct axp20x_desc_function {
> +       const char      *name;
> +       u8              muxval;
> +};
>
> -       reg = axp20x_gpio_get_reg(offset);
> -       if (reg < 0)
> -               return reg;
> +struct axp20x_desc_pin {
> +       struct pinctrl_pin_desc         pin;
> +       struct axp20x_desc_function     *functions;
> +};
>
> -       return regmap_update_bits(gpio->regmap, reg,
> -                                 AXP20X_GPIO_FUNCTIONS,
> -                                 AXP20X_GPIO_FUNCTION_INPUT);
> -}
> +struct axp20x_pinctrl_desc {
> +       const struct axp20x_desc_pin    *pins;
> +       int                             npins;
> +       unsigned int                    pin_base;

You do not need pin_base.

> +};
> +
> +struct axp20x_pinctrl_function {
> +       const char      *name;
> +       const char      **groups;
> +       unsigned int    ngroups;
> +};
> +
> +struct axp20x_pinctrl_group {
> +       const char      *name;
> +       unsigned long   config;
> +       unsigned int    pin;
> +};
> +
> +struct axp20x_pctl {
> +       struct pinctrl_dev                      *pctl_dev;
> +       struct device                           *dev;
> +       struct gpio_chip                        chip;
> +       struct regmap                           *regmap;
> +       const struct axp20x_pinctrl_desc        *desc;
> +       struct axp20x_pinctrl_group             *groups;
> +       unsigned int                            ngroups;
> +       struct axp20x_pinctrl_function          *functions;
> +       unsigned int                            nfunctions;
> +};
> +
> +static const struct axp20x_desc_pin axp209_pins[] = {
> +       AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0", (void *)AXP20X_GPIO0_CTRL),
> +                  AXP20X_FUNCTION(0x0, "gpio_out"),
> +                  AXP20X_FUNCTION(0x2, "gpio_in"),
> +                  AXP20X_FUNCTION(0x3, "ldo"),
> +                  AXP20X_FUNCTION(0x4, "adc")),
> +       AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1", (void *)AXP20X_GPIO1_CTRL),
> +                  AXP20X_FUNCTION(0x0, "gpio_out"),
> +                  AXP20X_FUNCTION(0x2, "gpio_in"),
> +                  AXP20X_FUNCTION(0x3, "ldo"),
> +                  AXP20X_FUNCTION(0x4, "adc")),
> +       AXP20X_PIN(AXP20X_PINCTRL_PIN(2, "GPIO2", (void *)AXP20X_GPIO2_CTRL),
> +                  AXP20X_FUNCTION(0x0, "gpio_out"),
> +                  AXP20X_FUNCTION(0x2, "gpio_in")),
> +};
> +
> +static const struct axp20x_pinctrl_desc axp20x_pinctrl_data = {
> +       .pins   = axp209_pins,
> +       .npins  = ARRAY_SIZE(axp209_pins),
> +};
>
>  static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
> -       struct axp20x_gpio *gpio = gpiochip_get_data(chip);
> +       struct axp20x_pctl *pctl = gpiochip_get_data(chip);
>         unsigned int val;
>         int ret;
>
> -       ret = regmap_read(gpio->regmap, AXP20X_GPIO20_SS, &val);
> +       ret = regmap_read(pctl->regmap, AXP20X_GPIO20_SS, &val);
>         if (ret)
>                 return ret;
>
> @@ -75,15 +127,12 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
>
>  static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>  {
> -       struct axp20x_gpio *gpio = gpiochip_get_data(chip);
> +       struct axp20x_pctl *pctl = gpiochip_get_data(chip);
> +       int pin_reg = (int)pctl->desc->pins[offset].pin.drv_data;
>         unsigned int val;
> -       int reg, ret;
> -
> -       reg = axp20x_gpio_get_reg(offset);
> -       if (reg < 0)
> -               return reg;
> +       int ret;
>
> -       ret = regmap_read(gpio->regmap, reg, &val);
> +       ret = regmap_read(pctl->regmap, pin_reg, &val);
>         if (ret)
>                 return ret;
>
> @@ -102,33 +151,335 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>         return val & 2;
>  }
>
> -static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
> +static void axp20x_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +                           int value)
> +{
> +       struct axp20x_pctl *pctl = gpiochip_get_data(chip);
> +       int pin_reg = (int)pctl->desc->pins[offset].pin.drv_data;
> +
> +       regmap_update_bits(pctl->regmap, pin_reg,
> +                          AXP20X_GPIO_FUNCTIONS,
> +                          value ? AXP20X_GPIO_FUNCTION_OUT_HIGH
> +                                : AXP20X_GPIO_FUNCTION_OUT_LOW);
> +}
> +
> +static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       return pinctrl_gpio_direction_input(chip->base + offset);
> +}
> +
> +static int axp20x_gpio_output(struct gpio_chip *chip, unsigned int offset,
>                               int value)
>  {
> -       struct axp20x_gpio *gpio = gpiochip_get_data(chip);
> -       int reg;
> +       chip->set(chip, offset, value);
>
> -       reg = axp20x_gpio_get_reg(offset);
> -       if (reg < 0)
> -               return reg;
> +       return 0;
> +}
>
> -       return regmap_update_bits(gpio->regmap, reg,
> -                                 AXP20X_GPIO_FUNCTIONS,
> -                                 value ? AXP20X_GPIO_FUNCTION_OUT_HIGH
> -                                 : AXP20X_GPIO_FUNCTION_OUT_LOW);
> +static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
> +                         u8 config)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       int pin_reg = (int)pctl->desc->pins[offset].pin.drv_data;
> +
> +       return regmap_update_bits(pctl->regmap, pin_reg, AXP20X_GPIO_FUNCTIONS,
> +                                 config);
>  }
>
> -static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
> -                           int value)
> +static int axp20x_pmx_func_cnt(struct pinctrl_dev *pctldev)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->nfunctions;
> +}
> +
> +static const char *axp20x_pmx_func_name(struct pinctrl_dev *pctldev,
> +                                       unsigned int selector)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->functions[selector].name;
> +}
> +
> +static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
> +                                 unsigned int selector,
> +                                 const char * const **groups,
> +                                 unsigned int *num_groups)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       *groups = pctl->functions[selector].groups;
> +       *num_groups = pctl->functions[selector].ngroups;
> +
> +       return 0;
> +}
> +
> +static struct axp20x_desc_function *
> +axp20x_pinctrl_desc_find_func_by_name(struct axp20x_pctl *pctl,
> +                                     const char *group, const char *func)
> +{
> +       const struct axp20x_desc_pin *pin;
> +       struct axp20x_desc_function *desc_func;
> +       int i;
> +
> +       for (i = 0; i < pctl->desc->npins; i++) {
> +               pin = &pctl->desc->pins[i];
> +
> +               if (!strcmp(pin->pin.name, group)) {
> +                       desc_func = pin->functions;
> +
> +                       while (desc_func->name) {
> +                               if (!strcmp(desc_func->name, func))
> +                                       return desc_func;
> +                               desc_func++;
> +                       }
> +
> +                       /*
> +                        * Pins are uniquely named. Groups are named after one
> +                        * pin name. If one pin matches group name but its
> +                        * function cannot be found, no other pin will match
> +                        * group name.
> +                        */
> +                       return NULL;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
> +                             unsigned int function, unsigned int group)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct axp20x_pinctrl_group *g = pctl->groups + group;
> +       struct axp20x_pinctrl_function *func = pctl->functions + function;
> +       struct axp20x_desc_function *desc_func =
> +               axp20x_pinctrl_desc_find_func_by_name(pctl, g->name,
> +                                                     func->name);
> +       if (!desc_func)
> +               return -EINVAL;
> +
> +       return axp20x_pmx_set(pctldev, g->pin, desc_func->muxval);
> +}
> +
> +static struct axp20x_desc_function *
> +axp20x_pctl_desc_find_func_by_pin(struct axp20x_pctl *pctl, unsigned int offset,
> +                                 const char *func)
> +{
> +       const struct axp20x_desc_pin *pin;
> +       struct axp20x_desc_function *desc_func;
> +       int i;
> +
> +       for (i = 0; i < pctl->desc->npins; i++) {
> +               pin = &pctl->desc->pins[i];
> +
> +               if (pin->pin.number == offset) {
> +                       desc_func = pin->functions;
> +
> +                       while (desc_func->name) {
> +                               if (!strcmp(desc_func->name, func))
> +                                       return desc_func;
> +
> +                               desc_func++;
> +                       }
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int axp20x_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +                                        struct pinctrl_gpio_range *range,
> +                                        unsigned int offset, bool input)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct axp20x_desc_function *desc_func;
> +       const char *func;
> +
> +       if (input)
> +               func = "gpio_in";
> +       else
> +               func = "gpio_out";
> +
> +       desc_func = axp20x_pctl_desc_find_func_by_pin(pctl, offset, func);
> +       if (!desc_func)
> +               return -EINVAL;
> +
> +       return axp20x_pmx_set(pctldev, offset, desc_func->muxval);
> +}
> +
> +static const struct pinmux_ops axp20x_pmx_ops = {
> +       .get_functions_count    = axp20x_pmx_func_cnt,
> +       .get_function_name      = axp20x_pmx_func_name,
> +       .get_function_groups    = axp20x_pmx_func_groups,
> +       .set_mux                = axp20x_pmx_set_mux,
> +       .gpio_set_direction     = axp20x_pmx_gpio_set_direction,
> +       .strict                 = true,
> +};
> +
> +static int axp20x_groups_cnt(struct pinctrl_dev *pctldev)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->ngroups;
> +}
> +
> +static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
> +                            const unsigned int **pins, unsigned int *num_pins)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct axp20x_pinctrl_group *g = pctl->groups + selector;
> +
> +       *pins = (unsigned int *)&g->pin;
> +       *num_pins = 1;
> +
> +       return 0;
> +}
> +
> +static const char *axp20x_group_name(struct pinctrl_dev *pctldev,
> +                                    unsigned int selector)
> +{
> +       struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->groups[selector].name;
> +}
> +
> +static const struct pinctrl_ops axp20x_pctrl_ops = {
> +       .dt_node_to_map         = pinconf_generic_dt_node_to_map_group,
> +       .dt_free_map            = pinconf_generic_dt_free_map,
> +       .get_groups_count       = axp20x_groups_cnt,
> +       .get_group_name         = axp20x_group_name,
> +       .get_group_pins         = axp20x_group_pins,
> +};
> +
> +static struct axp20x_pinctrl_function *
> +axp20x_pinctrl_function_by_name(struct axp20x_pctl *pctl, const char *name)
> +{
> +       struct axp20x_pinctrl_function *func = pctl->functions;
> +
> +       while (func->name) {
> +               if (!strcmp(func->name, name))
> +                       return func;
> +               func++;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int axp20x_pinctrl_add_function(struct axp20x_pctl *pctl,
> +                                      const char *name)
>  {
> -       axp20x_gpio_output(chip, offset, value);
> +       struct axp20x_pinctrl_function *func = pctl->functions;
> +
> +       while (func->name) {
> +               if (!strcmp(func->name, name)) {
> +                       func->ngroups++;
> +                       return -EEXIST;
> +               }
> +
> +               func++;
> +       }
> +
> +       func->name = name;
> +       func->ngroups = 1;
> +
> +       pctl->nfunctions++;
> +
> +       return 0;
>  }
>
> -static int axp20x_gpio_probe(struct platform_device *pdev)
> +static int axp20x_attach_group_function(struct platform_device *pdev,
> +                                       const struct axp20x_desc_pin *pin)
> +{
> +       struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
> +       struct axp20x_desc_function *desc_func = pin->functions;
> +       struct axp20x_pinctrl_function *func;
> +       const char **func_grp;
> +
> +       while (desc_func->name) {
> +               func = axp20x_pinctrl_function_by_name(pctl, desc_func->name);
> +               if (!func)
> +                       return -EINVAL;
> +
> +               if (!func->groups) {
> +                       func->groups = devm_kzalloc(&pdev->dev,
> +                                                   func->ngroups * sizeof(const char *),
> +                                                   GFP_KERNEL);
> +                       if (!func->groups)
> +                               return -ENOMEM;
> +               }
> +
> +               func_grp = func->groups;
> +               while (*func_grp)
> +                       func_grp++;
> +
> +               *func_grp = pin->pin.name;
> +               desc_func++;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_build_state(struct platform_device *pdev)
> +{
> +       struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
> +       unsigned int npins = pctl->desc->npins;
> +       const struct axp20x_desc_pin *pin;
> +       struct axp20x_desc_function *func;
> +       int i, ret;
> +
> +       pctl->ngroups = npins;
> +       pctl->groups = devm_kzalloc(&pdev->dev,
> +                                   pctl->ngroups * sizeof(*pctl->groups),
> +                                   GFP_KERNEL);
> +       if (!pctl->groups)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < npins; i++) {
> +               pctl->groups[i].name = pctl->desc->pins[i].pin.name;
> +               pctl->groups[i].pin = pctl->desc->pins[i].pin.number;
> +       }
> +
> +       /* We assume 4 functions per pin should be enough as a default max */
> +       pctl->functions = devm_kzalloc(&pdev->dev,
> +                                      npins * 4 * sizeof(*pctl->functions),
> +                                      GFP_KERNEL);
> +       if (!pctl->functions)
> +               return -ENOMEM;
> +
> +       /* Create a list of uniquely named functions */
> +       for (i = 0; i < npins; i++) {
> +               pin = &pctl->desc->pins[i];
> +               func = pin->functions;
> +
> +               while (func->name) {
> +                       axp20x_pinctrl_add_function(pctl, func->name);
> +                       func++;
> +               }
> +       }
> +
> +       pctl->functions = krealloc(pctl->functions,
> +                                  pctl->nfunctions * sizeof(*pctl->functions),
> +                                  GFP_KERNEL);
> +
> +       for (i = 0; i < npins; i++) {
> +               pin = &pctl->desc->pins[i];
> +               ret = axp20x_attach_group_function(pdev, pin);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_pctl_probe(struct platform_device *pdev)
>  {
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> -       struct axp20x_gpio *gpio;
> -       int ret;
> +       const struct axp20x_desc_pin *pin;
> +       struct axp20x_pctl *pctl;
> +       struct pinctrl_desc *pctrl_desc;
> +       struct pinctrl_pin_desc *pins;
> +       int ret, i;
>
>         if (!of_device_is_available(pdev->dev.of_node))
>                 return -ENODEV;
> @@ -138,51 +489,101 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> -       if (!gpio)
> +       pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
> +       if (!pctl)
> +               return -ENOMEM;
> +
> +       pctl->chip.base                 = -1;
> +       pctl->chip.can_sleep            = true;
> +       pctl->chip.request              = gpiochip_generic_request;
> +       pctl->chip.free                 = gpiochip_generic_free;
> +       pctl->chip.parent               = &pdev->dev;
> +       pctl->chip.label                = dev_name(&pdev->dev);
> +       pctl->chip.owner                = THIS_MODULE;
> +       pctl->chip.get                  = axp20x_gpio_get;
> +       pctl->chip.get_direction        = axp20x_gpio_get_direction;
> +       pctl->chip.set                  = axp20x_gpio_set;
> +       pctl->chip.direction_input      = axp20x_gpio_input;
> +       pctl->chip.direction_output     = axp20x_gpio_output;
> +       pctl->chip.ngpio                = 3;
> +       pctl->chip.can_sleep            = true;
> +
> +       pctl->regmap = axp20x->regmap;
> +
> +       pctl->desc = &axp20x_pinctrl_data;
> +       pctl->dev = &pdev->dev;
> +
> +       platform_set_drvdata(pdev, pctl);
> +
> +       ret = axp20x_build_state(pdev);
> +       if (ret)
> +               return ret;
> +
> +       pins = devm_kzalloc(&pdev->dev, pctl->desc->npins * sizeof(*pins),
> +                           GFP_KERNEL);
> +       if (!pins)
>                 return -ENOMEM;
>
> -       gpio->chip.base                 = -1;
> -       gpio->chip.can_sleep            = true;
> -       gpio->chip.parent               = &pdev->dev;
> -       gpio->chip.label                = dev_name(&pdev->dev);
> -       gpio->chip.owner                = THIS_MODULE;
> -       gpio->chip.get                  = axp20x_gpio_get;
> -       gpio->chip.get_direction        = axp20x_gpio_get_direction;
> -       gpio->chip.set                  = axp20x_gpio_set;
> -       gpio->chip.direction_input      = axp20x_gpio_input;
> -       gpio->chip.direction_output     = axp20x_gpio_output;
> -       gpio->chip.ngpio                = 3;
> -
> -       gpio->regmap = axp20x->regmap;
> -
> -       ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> +       for (i = 0; i < pctl->desc->npins; i++)
> +               pins[i] = pctl->desc->pins[i].pin;
> +
> +       pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
> +       if (!pctrl_desc)
> +               return -ENOMEM;
> +
> +       pctrl_desc->name = dev_name(&pdev->dev);
> +       pctrl_desc->owner = THIS_MODULE;
> +       pctrl_desc->pins = pins;
> +       pctrl_desc->npins = pctl->desc->npins;
> +       pctrl_desc->pctlops = &axp20x_pctrl_ops;
> +       pctrl_desc->pmxops = &axp20x_pmx_ops;
> +
> +       pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
> +       if (IS_ERR(pctl->pctl_dev)) {
> +               dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
> +               return PTR_ERR(pctl->pctl_dev);
> +       }
> +
> +       ret = devm_gpiochip_add_data(&pdev->dev, &pctl->chip, pctl);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to register GPIO chip\n");
>                 return ret;
>         }
>
> +       for (i = 0; i < pctl->desc->npins; i++) {
> +               pin = pctl->desc->pins + i;
> +
> +               ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
> +                                            pin->pin.number, pin->pin.number,
> +                                            1);

The pins, unlike in sunxi, are sequential and contiguous. There's no need for
the loop. Just add them in one go.

> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to add pin range\n");
> +                       return ret;
> +               }
> +       }
> +
>         dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");
>
>         return 0;
>  }
>
> -static const struct of_device_id axp20x_gpio_match[] = {
> +static const struct of_device_id axp20x_pctl_match[] = {
>         { .compatible = "x-powers,axp209-gpio" },
>         { }
>  };
> -MODULE_DEVICE_TABLE(of, axp20x_gpio_match);
> +MODULE_DEVICE_TABLE(of, axp20x_pctl_match);
>
> -static struct platform_driver axp20x_gpio_driver = {
> -       .probe          = axp20x_gpio_probe,
> +static struct platform_driver axp20x_pctl_driver = {
> +       .probe          = axp20x_pctl_probe,
>         .driver = {
>                 .name           = "axp20x-gpio",
> -               .of_match_table = axp20x_gpio_match,
> +               .of_match_table = axp20x_pctl_match,
>         },
>  };
>
> -module_platform_driver(axp20x_gpio_driver);
> +module_platform_driver(axp20x_pctl_driver);
>
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
>  MODULE_DESCRIPTION("AXP20x PMIC GPIO driver");
>  MODULE_LICENSE("GPL");
> --
> 2.9.3
>

Apart from the minor comments above, and Thomas' earlier comments,
this patch looks good to me.

ChenYu

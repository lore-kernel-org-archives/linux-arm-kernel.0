From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 11:26:49 +0200
Subject: [PATCH v2 3/7] pinctrl: armada-37xx: Add pin controller support
 for Armada 37xx
In-Reply-To: <087ef357fa23193d135d37ec2206a5798d27aab5.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <087ef357fa23193d135d37ec2206a5798d27aab5.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYQb9wL+g5T08Mgv+RQYaUZPoS+0RXXfk2XdD+AHSs9gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 7:28 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Armada 37xx SoC come with 2 pin controllers: one on the south
> bridge (managing 28 pins) and one on the north bridge (managing 36 pins).
>
> At the hardware level the controller configure the pins by group and not
> pin by pin. This constraint is reflected in the design of the driver:
> only the group related functions are implemented.

Interesting!

> +static int armada_37xx_pmx_direction_input(struct armada_37xx_pinctrl *info,
> +                                          unsigned int offset)
> +{
> +       unsigned int reg = OUTPUT_EN;
> +       unsigned int mask;
> +
> +       if (offset >= GPIO_PER_REG) {
> +               offset -= GPIO_PER_REG;
> +               reg += sizeof(u32);
> +       }
> +       mask = BIT(offset);
> +
> +       return regmap_update_bits(info->regmap, reg, mask, 0);
> +}
> +
> +
> +

A bit of excess whitespace, OK nitpicking.

Then this stuff:

> +static int armada_37xx_add_function(struct armada_37xx_pmx_func *funcs,
> +                                   int *funcsize, const char *name)
> +{
> +       int i = 0;
> +
> +       if (*funcsize <= 0)
> +               return -EOVERFLOW;
> +
> +       while (funcs->ngroups) {
> +               /* function already there */
> +               if (strcmp(funcs->name, name) == 0) {
> +                       funcs->ngroups++;
> +
> +                       return -EEXIST;
> +               }
> +               funcs++;
> +               i++;
> +       }
> +
> +       /* append new unique function */
> +       funcs->name = name;
> +       funcs->ngroups = 1;
> +       (*funcsize)--;
> +
> +       return 0;
> +}
> +
> +static int armada_37xx_fill_group(struct armada_37xx_pinctrl *info, int base)
> +{
> +       int n, num = 0, funcsize = info->data->nr_pins;
> +
> +       for (n = 0; n < info->ngroups; n++) {
> +               struct armada_37xx_pin_group *grp = &info->groups[n];
> +               int i, j, f;
> +
> +               grp->pins = devm_kzalloc(info->dev,
> +                                        (grp->npins + grp->extra_npins) *
> +                                        sizeof(*grp->pins), GFP_KERNEL);
> +               if (!grp->pins)
> +                       return -ENOMEM;
> +
> +               for (i = 0; i < grp->npins; i++)
> +                       grp->pins[i] = grp->start_pin + base + i;
> +
> +               for (j = 0; j < grp->extra_npins; j++)
> +                       grp->pins[i+j] = grp->extra_pin + base + j;
> +
> +               for (f = 0; f < NB_FUNCS; f++) {
> +                       int ret;
> +                       /* check for unique functions and count groups */
> +                       ret = armada_37xx_add_function(info->funcs, &funcsize,
> +                                           grp->funcs[f]);
> +                       if (ret == -EOVERFLOW)
> +                               dev_err(info->dev,
> +                                       "More functions than pins(%d)\n",
> +                                       info->data->nr_pins);
> +                       if (ret < 0)
> +                               continue;
> +                       num++;
> +               }
> +       }
> +
> +       info->nfuncs = num;
> +
> +       return 0;
> +}
> +
> +static int armada_37xx_fill_func(struct armada_37xx_pinctrl *info)
> +{
> +       struct armada_37xx_pmx_func *funcs = info->funcs;
> +       int n;
> +
> +       for (n = 0; n < info->nfuncs; n++) {
> +               const char *name = funcs[n].name;
> +               const char **groups;
> +               int g;
> +
> +               funcs[n].groups = devm_kzalloc(info->dev, funcs[n].ngroups *
> +                                              sizeof(*(funcs[n].groups)),
> +                                              GFP_KERNEL);
> +               if (!funcs[n].groups)
> +                       return -ENOMEM;
> +
> +               groups = funcs[n].groups;
> +
> +               for (g = 0; g < info->ngroups; g++) {
> +                       struct armada_37xx_pin_group *gp = &info->groups[g];
> +                       int f;
> +
> +                       for (f = 0; f < NB_FUNCS; f++) {
> +                               if (strcmp(gp->funcs[f], name) == 0) {
> +                                       *groups = gp->name;
> +                                       groups++;
> +                               }
> +                       }
> +               }
> +       }
> +       return 0;
> +}

I would be happy if you add kerneldoc to these functions and explain
what they do. Because I don't get it. I guess they are filling in the data
structures but yeah. Hard to follow.

> +       match = of_match_node(armada_37xx_pinctrl_of_match, np);
> +       info->data = (struct armada_37xx_pin_data *)match->data;

Use of_device_get_match_data()


> +static struct platform_driver armada_37xx_pinctrl_driver = {
> +       .driver = {
> +               .name = "armada-37xx-pinctrl",
> +               .of_match_table = armada_37xx_pinctrl_of_match,
> +       },
> +       .probe = armada_37xx_pinctrl_probe,
> +};
> +
> +builtin_platform_driver(armada_37xx_pinctrl_driver);

It almost looks like your could use builting_platform_driver_probe() actually,
and tag the costly initfunctions with __init so they get dicarded after probe.

Yours,
Linus Walleij

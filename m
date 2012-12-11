From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 01:28:20 +0100
Subject: [PATCH 1/6] ARM: sunxi: Add pinctrl driver for Allwinner SoCs
In-Reply-To: <1355177301-31928-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
 <1355177301-31928-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbE=y377X4_5c0wD+U3+drBBptDB8x_s-dQjNBemnbsyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 11:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> This IP has 8 banks of 32 bits, with a number of pins actually useful
> for each of these banks varying from one to another, and depending on
> the SoC used on the board.
>
> This driver only implements the pinctrl part, the gpio part will come
> eventually.

It's looking pretty nice already :-)

Of course I have some comments...

OK will it be a combined driver so the same file implement both pinctrl
and gpio?

(...)
> +- allwinner,pin-ids: An integer array. Each integer in the array
> +  specify a pin with given mux function, with bank, pin and mux packed
> +  as below.
> +
> +    [15..12] : bank number
> +    [11..4]  : pin number
> +    [3..0]   : mux selection

Why are you using this scheme instead of just open-coding the three
things? Well maybe I'm not getting it... Device Trees are usually for reading,
not for bitstuffing, that's why I ask.

You should pass all this DT stuff to the devicetree-discuss list because
I'm not any good at this (paging Stephen Warren.)

> +- allwinner,pull: Integer.
> +    0: No resistor
> +    1: Pull-up resistor
> +    2: Pull-down resistor

This seems legit.

> +config PINCTRL_SUNXI
> +       bool
> +       select PINMUX
> +       select PINCONF

If your SoC is only simple pinconfig like pull-up/pull-down, why are
you not using PINCONF_GENERIC and <linux/pinctrl/pinconf-generic.h>?

(...)
> +       ret = of_property_read_u32(node, "allwinner,drive", &val);
> +       if (!ret)
> +               config |= val << DLEVEL_SHIFT | DLEVEL_PRESENT;
> +
> +       ret = of_property_read_u32(node, "allwinner,pull", &val);
> +       if (!ret)
> +               config |= val << PULL_SHIFT | PULL_PRESENT;

So looks nice... but can you use generic pinconfig?

> +static void sunxi_pmx_set_config(struct pinctrl_dev *pctldev,
> +                                unsigned pin,
> +                                u8 config)
> +{
> +       struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       u32 val = readl(pctl->membase + CFG_REG(pin));
> +       u32 mask = ((1 << CFG_PINS_BITS) - 1) << CFG_OFFSET(pin);
> +       writel((val & ~mask) | config << CFG_OFFSET(pin),
> +               pctl->membase + CFG_REG(pin));
> +}

There is something a bit confusing with the naming here, this is
configuring the multiplexing (mux) but named config and CFG,
which makes for great misunderstandings... can it be changed
to eg just pmx_set() and MUX_OFFSET and MUX_REG() for
example?

> +static struct of_device_id sunxi_pinctrl_match[] __devinitconst = {
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_pinctrl_match);

This table will not match very much :-/

You should put one example in atleast? Something must have
been used to test this...

> +static int __devinit sunxi_pinctrl_parse_group(struct platform_device *pdev,
> +                                              struct device_node *node,
> +                                              int idx,
> +                                              const char **out_name)
> +{
> +       struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
> +       struct sunxi_pinctrl_group *group = pctl->groups + idx;
> +       struct property *prop;
> +       char *group_name;
> +       int i;
> +       u32 val, proplen;
> +
> +       group_name = devm_kzalloc(&pdev->dev, strlen(node->name) + 4,
> +                                 GFP_KERNEL);
> +       if (!group_name)
> +               return -ENOMEM;
> +       if (of_property_read_u32(node, "reg", &val))
> +               snprintf(group_name, strlen(node->name), "%s", node->name);
> +       else
> +               snprintf(group_name, strlen(node->name) + 4,
> +                        "%s.%d", node->name, val);
> +       group->name = group_name;
> +
> +       prop = of_find_property(node, "allwinner,pin-ids", &proplen);
> +       if (!prop)
> +               return -EINVAL;
> +       group->npins = proplen / sizeof(u32);

So storing one u32 for every pin I guess.

> +       group->pins = devm_kzalloc(&pdev->dev,
> +                                  group->npins * sizeof(*group->pins),
> +                                  GFP_KERNEL);
> +       if (!group->pins)
> +               return -ENOMEM;
> +
> +       group->muxcfg = devm_kzalloc(&pdev->dev,
> +                                    group->npins * sizeof(*group->muxcfg),
> +                                    GFP_KERNEL);
> +       if (!group->muxcfg)
> +               return -ENOMEM;
> +
> +       of_property_read_u32_array(node, "allwinner,pin-ids", group->pins,
> +                                  group->npins);
> +       for (i = 0; i < group->npins; i++) {
> +               group->muxcfg[i] = MUXID_TO_MUXCFG(group->pins[i]);
> +               group->pins[i] = MUXID_TO_PIN(group->pins[i]);
> +       }

This loop is rather awkward I mean, instead of bitstuffing muxcfg and
pin ID into a single u32 why not just have them as separate attributes.

Then there was somthing about bank ID which I guess is just
discarded here?

(...)
> +static int __devinit sunxi_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct sunxi_pinctrl *pctl;
> +       int i, ret;
> +
> +       pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
> +       if (!pctl)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, pctl);
> +
> +       ret = sunxi_pinctrl_probe_dt(pdev, pctl);
> +       if (ret) {
> +               dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       pctl->data = (struct sunxi_pinctrl_data *)of_match_device(sunxi_pinctrl_match, &pdev->dev)->data;

I can't parse this, what is going on here?
Can you break this statement apart somehow?

(...)
> +++ b/drivers/pinctrl/pinctrl-sunxi.h

> +#define PINS_PER_BANK  32
> +
> +#define CFG_REG(pin)   (round_down(                                    \
> +                               (pin / PINS_PER_BANK) * 0x24 +          \
> +                               ((pin % PINS_PER_BANK) / 8) * 0x04, 4))
> +#define CFG_OFFSET(pin)        ((pin % 8) * 4)
> +
> +#define DLEVEL_REG(pin)        (round_down(                                    \
> +                               (pin / PINS_PER_BANK) * 0x24 +          \
> +                               ((pin % PINS_PER_BANK) / 16) * 0x04 +   \
> +                               0x14, 4))
> +#define DLEVEL_OFFSET(pin)     ((pin % 16) * 2)
> +
> +#define PULL_REG(pin)  (round_down(                                    \
> +                               (pin / PINS_PER_BANK) * 0x24 +          \
> +                               ((pin % PINS_PER_BANK) / 16) * 0x04 +   \
> +                               0x1c, 4))
> +#define PULL_OFFSET(pin)       ((pin % 16) * 2)

These are impossible to understand. Please convert these to
documented static inline functions instead so the code can
be maintained in the future.

> +#define CFG_PINS_PER_REG       8
> +#define CFG_PINS_BITS          4
> +#define DLEVEL_PINS_PER_REG    16
> +#define DLEVEL_PINS_BITS       2
> +#define PULL_PINS_PER_REG      16
> +#define PULL_PINS_BITS         2
> +
> +#define MUXID_TO_PIN(id)       ((((id) >> 12 & 0xf) * 32) + ((id) >> 4 & 0xff))
> +#define MUXID_TO_MUXCFG(id)    ((id) & 0xf)

Same here.

> +#define SUNXI_PINCTRL_PIN_PA0  PINCTRL_PIN(0 + 0, "PA0")
> +#define SUNXI_PINCTRL_PIN_PA1  PINCTRL_PIN(0 + 1, "PA1")
> +#define SUNXI_PINCTRL_PIN_PA2  PINCTRL_PIN(0 + 2, "PA2")
> +#define SUNXI_PINCTRL_PIN_PA3  PINCTRL_PIN(0 + 3, "PA3")
> +#define SUNXI_PINCTRL_PIN_PA4  PINCTRL_PIN(0 + 4, "PA4")
> +#define SUNXI_PINCTRL_PIN_PA5  PINCTRL_PIN(0 + 5, "PA5")
> +#define SUNXI_PINCTRL_PIN_PA6  PINCTRL_PIN(0 + 6, "PA6")
> +#define SUNXI_PINCTRL_PIN_PA7  PINCTRL_PIN(0 + 7, "PA7")
> +#define SUNXI_PINCTRL_PIN_PA8  PINCTRL_PIN(0 + 8, "PA8")
> +#define SUNXI_PINCTRL_PIN_PA9  PINCTRL_PIN(0 + 9, "PA9")
> +#define SUNXI_PINCTRL_PIN_PA10 PINCTRL_PIN(0 + 10, "PA10")
> +#define SUNXI_PINCTRL_PIN_PA11 PINCTRL_PIN(0 + 11, "PA11")
> +#define SUNXI_PINCTRL_PIN_PA12 PINCTRL_PIN(0 + 12, "PA12")
> +#define SUNXI_PINCTRL_PIN_PA13 PINCTRL_PIN(0 + 13, "PA13")
> +#define SUNXI_PINCTRL_PIN_PA14 PINCTRL_PIN(0 + 14, "PA14")
> +#define SUNXI_PINCTRL_PIN_PA15 PINCTRL_PIN(0 + 15, "PA15")
> +#define SUNXI_PINCTRL_PIN_PA16 PINCTRL_PIN(0 + 16, "PA16")
> +#define SUNXI_PINCTRL_PIN_PA17 PINCTRL_PIN(0 + 17, "PA17")
> +#define SUNXI_PINCTRL_PIN_PA18 PINCTRL_PIN(0 + 18, "PA18")
> +#define SUNXI_PINCTRL_PIN_PA19 PINCTRL_PIN(0 + 19, "PA19")
> +#define SUNXI_PINCTRL_PIN_PA20 PINCTRL_PIN(0 + 20, "PA20")
> +#define SUNXI_PINCTRL_PIN_PA21 PINCTRL_PIN(0 + 21, "PA21")
> +#define SUNXI_PINCTRL_PIN_PA22 PINCTRL_PIN(0 + 22, "PA22")
> +#define SUNXI_PINCTRL_PIN_PA23 PINCTRL_PIN(0 + 23, "PA23")
> +#define SUNXI_PINCTRL_PIN_PA24 PINCTRL_PIN(0 + 24, "PA24")
> +#define SUNXI_PINCTRL_PIN_PA25 PINCTRL_PIN(0 + 25, "PA25")
> +#define SUNXI_PINCTRL_PIN_PA26 PINCTRL_PIN(0 + 26, "PA26")
> +#define SUNXI_PINCTRL_PIN_PA27 PINCTRL_PIN(0 + 27, "PA27")
> +#define SUNXI_PINCTRL_PIN_PA28 PINCTRL_PIN(0 + 28, "PA28")
> +#define SUNXI_PINCTRL_PIN_PA29 PINCTRL_PIN(0 + 29, "PA29")
> +#define SUNXI_PINCTRL_PIN_PA30 PINCTRL_PIN(0 + 30, "PA30")
> +#define SUNXI_PINCTRL_PIN_PA31 PINCTRL_PIN(0 + 31, "PA31")

0+0, 0+1, 0+2 .... why not just use the scalar? 0, 1, 2, ... 31?

I understand that the zero denotes bank 0 or bank A or somtheing
(PA, PB etc) so if you need to keep that, use something like

#define PA_BASE 0

Then

#define SUNXI_PINCTRL_PIN_PA28 PINCTRL_PIN(PA_BASE + 28, "PA28")

which makes more sense.

> +#define SUNXI_PINCTRL_PIN_PB0  PINCTRL_PIN(32 + 0, "PB0")
> +#define SUNXI_PINCTRL_PIN_PB1  PINCTRL_PIN(32 + 1, "PB1")
(...)

Dito for C, D, E, F, G...

Yours,
Linus Walleij

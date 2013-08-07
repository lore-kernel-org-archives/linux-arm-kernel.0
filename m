From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 21:25:35 +0200
Subject: [PATCH 3/7] pinctrl: imx1 core driver
In-Reply-To: <1375439907-10462-4-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdabJnjo5i-NGS-sTb3dqQQ9xQa_CdUY=+a1rpaAfF7rhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 12:38 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I think you need a bit of patch description here. Zero lines of
commit message is not acceptable for an entire new driver.
Elaborate a bit on the imx27 hardware and so on.

> +/*
> + * Calculates the register offset from a pin_id
> + */
> +static void __iomem *imx1_mem(struct imx1_pinctrl *ipctl, unsigned int pin_id)
> +{
> +       unsigned int port = pin_id / 32;
> +       return ipctl->base + port * 0x100;

Use this:
#define IMX1_PORT_STRIDE 0x100

> +/*
> + * Write to a register with 2 bits per pin. The function will automatically
> + * use the next register if the pin is managed in the second register.
> + */
> +static void imx1_write_2bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> +               u32 value, u32 reg_offset)
> +{
> +       void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> +       int shift = (pin_id % 16) * 2;
> +       int mask = ~(0x3 << shift);

I think I understand this, but insert a comment on what this is
anyway.

> +       u32 old_value;
> +
> +       dev_dbg(ipctl->dev, "write: register 0x%p shift %d value 0x%x\n",
> +                       reg, shift, value);
> +
> +       if (pin_id % 32 >= 16)
> +               reg += 0x04;

Comment on what is happening here.

> +
> +       value = (value & 0x11) << shift;

What is this? 0x11? Shall this be #defined or
what does it mean? The "value" argument really needs
some documentation I think.

You're modifying the argument "value" which is confusing.
Try to avoid this.

> +       old_value = readl(reg) & mask;
> +       writel(value | old_value, reg);

This is a bit over-complicating things. Write out
the sequence and let the compiler do the optimization.

val = readl(reg);
val &= mask;
val |= value;
writel(val, reg);


> +static void imx1_write_bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> +               u32 value, u32 reg_offset)
> +{
> +       void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> +       int shift = pin_id % 32;
> +       int mask = ~(0x1 << shift);
> +       u32 old_value;
> +
> +       dev_dbg(ipctl->dev, "write: register 0x%p shift %d value 0x%x\n",
> +                       reg, shift, value);
> +
> +       value = (value & 0x1) << shift;
> +       old_value = readl(reg) & mask;
> +       writel(value | old_value, reg);

Same comments here.

> +static int imx1_read_bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> +               u32 reg_offset)
> +{
> +       void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> +       int shift = pin_id % 32;
> +
> +       return (readl(reg) >> shift) & 0x1;

Hard to read. Can't you just do this?

#include <linux/bitops.h>

u32 offset = pin_id % 32;

return !!(readl(reg) & BIT(offset));

> +static void imx1_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
> +                  unsigned offset)
> +{
> +       seq_printf(s, "%s", dev_name(pctldev->dev));
> +}

Don't you want to print some other more interesting things about
each pin?

This template is really just an example. The debugfs file is
intended to be helpful.

> +static int imx1_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
> +                          unsigned group)
> +{
> +       struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct imx_pinctrl_soc_info *info = ipctl->info;
> +       const unsigned *pins, *mux;
> +       unsigned int npins;
> +       int i;
> +
> +       /*
> +        * Configure the mux mode for each pin in the group for a specific
> +        * function.
> +        */
> +       pins = info->groups[group].pins;
> +       npins = info->groups[group].npins;
> +       mux = info->groups[group].mux_mode;
> +
> +       WARN_ON(!pins || !npins || !mux);
> +
> +       dev_dbg(ipctl->dev, "enable function %s group %s\n",
> +               info->functions[selector].name, info->groups[group].name);
> +
> +       for (i = 0; i < npins; i++) {
> +               unsigned int pin_id = pins[i];
> +               unsigned int afunction = 0x001 & mux[i];
> +               unsigned int gpio_in_use = (0x002 & mux[i]) >> 1;
> +               unsigned int direction = (0x004 & mux[i]) >> 2;
> +               unsigned int gpio_oconf = (0x030 & mux[i]) >> 4;
> +               unsigned int gpio_iconfa = (0x300 & mux[i]) >> 8;
> +               unsigned int gpio_iconfb = (0xc00 & mux[i]) >> 10;

If you use <linux/bitops.h> this can be made more understandable,
BIT(0), BIT(1), BIT(2) etc.

The shift offsets should be #defined.

> +static void imx1_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +                                  struct seq_file *s, unsigned pin_id)
> +{
> +       struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct imx_pinctrl_soc_info *info = ipctl->info;
> +       const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
> +       unsigned long config;
> +
> +       if (!pin_reg || !pin_reg->conf_reg) {
> +               seq_puts(s, "N/A");
> +               return;
> +       }
> +
> +       config = readl(ipctl->base + pin_reg->conf_reg);
> +       seq_printf(s, "0x%lx", config);
> +}

That's pretty helpful, nice!

> +static int imx1_pinctrl_parse_gpio(struct platform_device *pdev,
> +               struct imx1_pinctrl *pctl, struct device_node *np, int i,
> +               u32 base)
> +{
> +       int ret;
> +       u32 memoffset;
> +
> +       ret = of_property_read_u32(np, "reg", &memoffset);
> +       if (ret)
> +               return ret;
> +
> +       memoffset -= base;
> +       pctl->gpio_pdata[i].base = pctl->base + memoffset;
> +
> +       pctl->gpio_dev[i] = of_device_alloc(np, NULL, &pdev->dev);
> +       pctl->gpio_dev[i]->dev.platform_data = &pctl->gpio_pdata[i];
> +       pctl->gpio_dev[i]->dev.bus = &platform_bus_type;
> +
> +       ret = of_device_add(pctl->gpio_dev[i]);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                               "Failed to add child gpio device\n");
> +               return ret;
> +       }
> +       return 0;
> +}

As mentioned for the other patch I think this is the wrong approach.
Try to make the GPIO driver wholly independent.

Yours,
Linus Walleij

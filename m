From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jul 2015 16:15:57 +0200
Subject: [PATCH v3] gpio: UniPhier: add driver for UniPhier GPIO controller
In-Reply-To: <1436841787-7734-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436841787-7734-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYaAMw5U3pctf96j0QpY2Qf+e=LX740F0okCmVU6pXkhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 4:43 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This GPIO controller device is used on UniPhier SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v3:
>   - Use module_platform_driver()
>
> Changes in v2:
>   - Fix typos in the comment block

OK why no device tree bindings? Are they in a separate patch?

> +/*
> + * Unfortunately, the hardware specification adopts weird GPIO pin labeling.
> + * The ports are named as
> + *   PORT00,  PORT01,  PORT02,  ..., PORT07,
> + *   PORT10,  PORT11,  PORT12,  ..., PORT17,
> + *   PORT20,  PORT21,  PORT22,  ..., PORT27,
> + *    ...
> + *   PORT90,  PORT91,  PORT92,  ..., PORT97,
> + *   PORT100, PORT101, PORT102, ..., PORT107,
> + *    ...
> + *
> + * The PORTs with 8 or 9 in the one's place are missing, i.e. the one's place
> + * is octal, while the other places are decimal.  If we handle the port numbers
> + * as seen in the hardware documents, the GPIO offsets must be non-contiguous.
> + * It is possible to have sparse GPIO pins, but not handy for GPIO range
> + * mappings, register accessing, etc.
> + *
> + * To make things simpler (for driver and device tree implementation), this
> + * driver takes contiguously-numbered GPIO offsets.  GPIO consumers should make
> + * sure to convert the PORT number into the one that fits in this driver.
> + * The conversion logic is very easy math, for example,
> + *   PORT15  -->  GPIO offset 13   (8 * 1 + 5)
> + *   PORT123 -->  GPIO offset 99   (8 * 12 + 3)
> + */
> +#define UNIPHIER_GPIO_PORTS_PER_BANK   8
> +#define UNIPHIER_GPIO_BANK_MASK                \
> +                               ((1UL << (UNIPHIER_GPIO_PORTS_PER_BANK)) - 1)



> +
> +#define UNIPHIER_GPIO_REG_DATA         0       /* data */
> +#define UNIPHIER_GPIO_REG_DIR          4       /* direction (1:in, 0:out) */
> +
> +struct uniphier_gpio_priv {
> +       struct of_mm_gpio_chip mmchip;
> +       spinlock_t lock;
> +};
> +
> +static unsigned uniphier_gpio_bank_to_reg(unsigned bank, unsigned reg_type)
> +{
> +       unsigned reg;
> +
> +       reg = (bank + 1) * 8 + reg_type;
> +
> +       /*
> +        * Unfortunately, there is a register hole at offset 0x90-0x9f.
> +        * Add 0x10 when crossing the hole.
> +        */
> +       if (reg >= 0x90)
> +               reg += 0x10;
> +
> +       return reg;
> +}
> +
> +static void uniphier_gpio_bank_write(struct gpio_chip *chip,
> +                                    unsigned bank, unsigned reg_type,
> +                                    unsigned mask, unsigned value)
> +{
> +       struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
> +       struct uniphier_gpio_priv *priv;
> +       unsigned long flags;
> +       unsigned reg;
> +       u32 tmp;
> +
> +       if (!mask)
> +               return;
> +
> +       priv = container_of(mmchip, struct uniphier_gpio_priv, mmchip);
> +
> +       reg = uniphier_gpio_bank_to_reg(bank, reg_type);
> +
> +       /*
> +        * Note
> +        * regmap_update_bits() should not be used here.
> +        *
> +        * The DATA registers return the current readback of pins, not the
> +        * previously written data when they are configured as "input".
> +        * The DATA registers must be overwritten even if the data you are
> +        * going to write is the same as what readl() has returned.
> +        *
> +        * regmap_update_bits() does not write back if the data is not changed.
> +        */

Why is this mentioned when the driver doesn't even use regmap?
Development artifact?

> +static int uniphier_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       return uniphier_gpio_offset_read(chip, UNIPHIER_GPIO_REG_DIR, offset) ?
> +                                               GPIOF_DIR_IN : GPIOF_DIR_OUT;

Just use
return !!uniphier_gpio_offset_read(chip, UNIPHIER_GPIO_REG_DIR, offset);

> +static int uniphier_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       return uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_REG_DATA);

return !!uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_REG_DATA);

> +static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
> +                                      unsigned long *mask,
> +                                      unsigned long *bits)
> +{
> +       unsigned bank, shift, bank_mask, bank_bits;
> +       int i;
> +
> +       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_PORTS_PER_BANK) {
> +               bank = i / UNIPHIER_GPIO_PORTS_PER_BANK;
> +               shift = i % BITS_PER_LONG;
> +               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> +                                               UNIPHIER_GPIO_BANK_MASK;
> +               bank_bits = bits[BIT_WORD(i)] >> shift;
> +
> +               uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_REG_DATA,
> +                                        bank_mask, bank_bits);
> +       }

This looks like a piece of algorithm that we could make generic like in a
static function in drivers/gpio/gpiolib.h or so, that it may be shared with
other drivers. Do you see some clear way to break out the core of this?
Or is it as generic as I think?

> +static int uniphier_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct uniphier_gpio_priv *priv;
> +       u32 ngpio;
> +       int ret;
> +
> +       ret = of_property_read_u32(dev->of_node, "ngpio", &ngpio);
> +       if (ret) {
> +               dev_err(dev, "failed to get ngpio property\n");
> +               return ret;
> +       }

This needs to be documented, plus I don't see why it's needed.
The driver for this very specific hardware should already know
how many GPIOs there are in this hardware, it should not come
from the device tree.

ngpio is typically for the case where the hardware has 32 bits
for GPIO pins, but only the first 11 are actually used in the hardware.

> +static const struct of_device_id uniphier_gpio_match[] = {
> +       { .compatible = "socionext,uniphier-gpio" },
> +       { /* sentinel */ }
> +};

Needs a binding document.

Apart from this it looks nice!

Yours,
Linus Walleij

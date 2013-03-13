From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 15:15:16 +0100
Subject: [PATCH v8 07/12] gpio: palmas: add in GPIO support for palmas
 charger
In-Reply-To: <1362662276-20792-7-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-7-git-send-email-ian@slimlogic.co.uk>
Message-ID: <CACRpkdaNs+NmAbuwRYzn1xgjHy=7ZknJa-GD1+Q8HBsu53KQqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for slow replies :-(

On Thu, Mar 7, 2013 at 2:17 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:

> +static int palmas_gpio_read(struct palmas *palmas, unsigned int reg,
> +               int gpio, unsigned int *dest)

I don't like "int gpio" here, please use "int offset".

This is not a global GPIO number, it is an offset in the local gpio_chip,
right?

> +{
> +       /* registers for second bank are identical and offset by 0x9 */
> +       if (gpio > 7)
> +               reg += PALMAS_GPIO_DATA_IN2;
> +
> +       return palmas_read(palmas, PALMAS_GPIO_BASE, reg, dest);
> +}
> +
> +static int palmas_gpio_write(struct palmas *palmas, unsigned int reg,
> +               int gpio, unsigned int data)
> +{
> +       /* registers for second bank are identical and offset by 0x9 */
> +       if (gpio > 7)
> +               reg += PALMAS_GPIO_DATA_IN2;
> +
> +       return palmas_write(palmas, PALMAS_GPIO_BASE, reg, data);
> +}
> +
> +static int palmas_gpio_update_bits(struct palmas *palmas, unsigned int reg,
> +               int gpio, unsigned int mask, unsigned int data)
> +{
> +       /* registers for second bank are identical and offset by 0x9 */
> +       if (gpio > 7)
> +               reg += PALMAS_GPIO_DATA_IN2;
> +
> +       return palmas_update_bits(palmas, PALMAS_GPIO_BASE, reg, mask, data);
> +}


> -       ret = palmas_read(palmas, PALMAS_GPIO_BASE, PALMAS_GPIO_DATA_IN, &val);
> +       ret = palmas_gpio_read(palmas, PALMAS_GPIO_DATA_IN, offset, &val);

(Obviously you are passing the offset.)

> +               ret = palmas_gpio_write(palmas, PALMAS_GPIO_SET_DATA_OUT,
> +                               offset, BIT(offset % 8));
(..)
> +               ret = palmas_gpio_write(palmas, PALMAS_GPIO_CLEAR_DATA_OUT,
> +                               offset, BIT(offset % 8));
(...)
> +       ret = palmas_gpio_update_bits(palmas, PALMAS_GPIO_DATA_DIR,
> +                       offset, 1 << (offset % 8), 1 << (offset % 8));

Why aren't you using the BIT() macro here too?

Further: if these functions are always used like this, with offset
and some BIT() or (1 << (offset % 8)) why don't you move that
latter part into the static helper and just pass offset into the
helper?

Yours,
Linus Walleij

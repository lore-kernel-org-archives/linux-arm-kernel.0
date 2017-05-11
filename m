From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 15:56:00 +0200
Subject: [PATCH v3 4/6] bus: add driver for the Technologic Systems NBUS
In-Reply-To: <20170505193259.16517-5-sebastien.bourdelin@savoirfairelinux.com>
References: <20170505193259.16517-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170505193259.16517-5-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <CACRpkda0WdJQEm5i_LMB1o+c1R9Ux1T31SOAM0NUyucCz48NXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 5, 2017 at 9:32 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This driver implements a GPIOs bit-banged bus, called the NBUS by
> Technologic Systems. It is used to communicate with the peripherals in
> the FPGA on the TS-4600 SoM.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v2 -> v3:

This driver is pretty.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For future development (that is not about this patch, please
merge this):

> +static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
> +{
> +       struct gpio_descs *gpios = ts_nbus->data;
> +       int ret, i;
> +
> +       *val = 0;
> +       for (i = 0; i < 8; i++) {
> +               ret = gpiod_get_value_cansleep(gpios->desc[i]);
> +               if (ret < 0)
> +                       return ret;
> +               if (ret)
> +                       *val |= BIT(i);
> +       }
> +
> +       return 0;
> +}

That makes it pretty obvious that we really need gpiod_get_array_cansleep()
does it not. That would just become some single register read in
this case.

If you get some time one of these days and wand to have a go at adding
it to gpiolib using this driver as a testbed, do not hesitate.

Yours,
Linus Walleij

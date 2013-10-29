From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Oct 2013 15:09:00 +0100
Subject: [PATCH v6 1/8] pinctrl: imx1 core driver
In-Reply-To: <1382950843-26066-2-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdbrRhqd-Dho1eW2bWiGZSkgWzV-irEchrrFHdio9rei3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 10:00 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> +static int imx1_pinconf_get(struct pinctrl_dev *pctldev,
> +                            unsigned pin_id, unsigned long *config)
> +{
> +       struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       *config = imx1_read_bit(ipctl, pin_id, MX1_PUEN);
> +
> +       return 0;
> +}
> +
> +static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
> +                            unsigned pin_id, unsigned long *configs,
> +                            unsigned num_configs)
> +{
> +       struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct imx1_pinctrl_soc_info *info = ipctl->info;
> +       int i;
> +
> +       for (i = 0; i != num_configs; ++i) {
> +               imx1_write_bit(ipctl, pin_id, configs[i] & 0x01, MX1_PUEN);
> +
> +               dev_dbg(ipctl->dev, "pinconf set pullup pin %s\n",
> +                       info->pins[pin_id].name);
> +       }
> +
> +       return 0;
> +}

I should mention that this is only acceptable if modeled after the
other i.MX drivers. If we got a new, unrelated driver today, we
would require that it used GENERIC_PINCONF for this,
especially for something that can apparently only do
pull-up and nothing else.

The generic pinconf has standardized DT bindings and share
code with other drivers so it is generally very nice.

Yours,
Linus Walleij

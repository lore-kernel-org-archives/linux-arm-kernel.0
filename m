From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 21:40:12 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Message-ID: <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:

> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

So looking back at this after Stephen posed a real good
question, when you say "configure SoC pins to GPIO
mode", does that mean anything else than to mux them into
GPIO mode?

In that case, have you considered augmenting
pinctrl-single.c to implement .gpio_request_enable()
.gpio_disable_free() and maybe also .gpio_set_direction()
in its struct pinmux_ops pinmux backend?

If not, why?

Currently it looks like this:

static int pcs_request_gpio(struct pinctrl_dev *pctldev,
                        struct pinctrl_gpio_range *range, unsigned offset)
{
        return -ENOTSUPP;
}

static struct pinmux_ops pcs_pinmux_ops = {
        .get_functions_count = pcs_get_functions_count,
        .get_function_name = pcs_get_function_name,
        .get_function_groups = pcs_get_function_groups,
        .enable = pcs_enable,
        .disable = pcs_disable,
        .gpio_request_enable = pcs_request_gpio,
};

Yours,
Linus Walleij

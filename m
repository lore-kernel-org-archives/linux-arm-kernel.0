From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Oct 2014 09:32:11 -0700
Subject: [PATCH 2/4] pinctrl: rockchip: Don't call
 pinctrl_gpio_direction_output() in pin_config_set()
In-Reply-To: <1413847670-12245-2-git-send-email-dianders@chromium.org>
References: <1413847670-12245-1-git-send-email-dianders@chromium.org>
 <1413847670-12245-2-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=X4ZC9Nh2z6vtGwH1v3pGefGgeDw-JjA6R06XJmmvOFGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 20, 2014 at 4:27 PM, Doug Anderson <dianders@chromium.org> wrote:
> @@ -959,9 +968,10 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                                 return rc;
>                         break;
>                 case PIN_CONFIG_OUTPUT:
> -                       rc = rockchip_gpio_direction_output(&bank->gpio_chip,
> -                                                           pin - bank->pin_base,
> -                                                           arg);
> +                       rockchip_gpio_set(&bank->gpio_chip,
> +                                         pin - bank->pin_base, arg);
> +                       rc = _rockchip_pmx_gpio_set_direction(&bank->gpio_chip,
> +                                         pin - bank->pin_base, false);

I think something here is not quite right.  I did more testing today
and noticed that I'm getting failures in some cases.  I think I've got
the offset wrong, but I'm digging.  Please hold off review of this
patch till the next version.

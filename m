From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jan 2013 00:46:10 +0100
Subject: [PATCH 1/6] ARM: sunxi: Add pinctrl driver for Allwinner SoCs
In-Reply-To: <1355948295-19680-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
 <1355948295-19680-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYpnfWmo15vtUsvPobhFO3_wvYgaa04Mpa6QjWx2h+ezA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 9:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The Allwinner SoCs have an IP module that handle both the muxing and the
> GPIOs.

Sorry for very slow review :-( :-(

>  include/linux/pinctrl/pinconf-generic.h            |    1 +

Can you break this into a separate patch and rebase it?

It does not apply anymore after v3.8...

> diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
> index 4f0abb9..5f5968d 100644
> --- a/include/linux/pinctrl/pinconf-generic.h
> +++ b/include/linux/pinctrl/pinconf-generic.h
> @@ -74,6 +74,7 @@ enum pin_config_param {
>         PIN_CONFIG_DRIVE_PUSH_PULL,
>         PIN_CONFIG_DRIVE_OPEN_DRAIN,
>         PIN_CONFIG_DRIVE_OPEN_SOURCE,
> +       PIN_CONFIG_DRIVE_CURRENT,
>         PIN_CONFIG_INPUT_SCHMITT,
>         PIN_CONFIG_INPUT_DEBOUNCE,
>         PIN_CONFIG_POWER_SOURCE,

Above the definitions there is some kerneldoc and that is where this has to be
defined.

You also have to defines what the argument to this parameter is.

I think it should be renamed PIN_CONFIG_DRIVE_STRENGTH and the
argument should be the number of drivers stages.

These things are constructed with totem-pole-like outputs and the number
of totempoles define the drive strength, usually it will be something like

1 = 2mA
2 = 4mA
3 = 6mA
4 = 8mA

or similar, as you see 2 mA for each added driver stage. The driver can
convert to any internal representation...

Yours,
Linus Walleij

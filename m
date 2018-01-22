From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Jan 2018 09:37:38 +0100
Subject: [PATCH] pinctrl: at91-pio4: add support for drive-strength
 property
In-Reply-To: <20180118160208.16461-1-ludovic.desroches@microchip.com>
References: <20180118160208.16461-1-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdanweSmHd_M+feHauEHtvKSW+-W=djb186BFdbxTf20Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 5:02 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Add support for the drive-strength property. Usually its value is
> expressed in mA. Since the numeric value depends on VDDIOP voltage,
> the controller uses low, medium and high to define the drive-strengh.

Aha I see. That's complex. It certainly results in a certain mA drive
strength in the end, but what you're saying is that this is not usually
what we configure.

> The PIO controller accepts two values for the low drive: 0 or 1. Most
> of the time, we don't care about the drive strength, there is no need
> to change it, so 0 is considered as the default value.

Do you mean default value as in "whatever the hardware was set
up as at boot time"?

> The low-drive
> value won't be advertised through pinconf-pins file excepted if it

except?

> has been set explicitly in the device tree ie if its value is
> different from 0.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

OK I think I get it.

>  Optional properties:
>  - GENERIC_PINCONFIG: generic pinconfig options to use, bias-disable,
> -bias-pull-down, bias-pull-up, drive-open-drain, input-schmitt-enable,
> -input-debounce, output-low, output-high.
> +bias-pull-down, bias-pull-up, drive-open-drain, drive-strength,
> +input-schmitt-enable, input-debounce, output-low, output-high.
(...)
> +                       drive-strength = <ATMEL_PIO_DRVSTR_LO>;

So you say you support this argument and it will be something like

include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_LO  1
include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_ME  2
include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_HI  3

But the definition if generic drive strength is actually in mA.

I think it is OK to deviate from stating it in mA, but you should
write this in the DT bindings so people do not get confused.

> @@ -814,6 +834,19 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
>                 seq_printf(s, "%s ", "open-drain");
>         if (conf & ATMEL_PIO_SCHMITT_MASK)
>                 seq_printf(s, "%s ", "schmitt");
> +       if (conf & ATMEL_PIO_DRVSTR_MASK) {
> +               switch ((conf & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET) {
> +               case ATMEL_PIO_DRVSTR_LO:
> +                       seq_printf(s, "%s ", "low-drive");
> +                       break;
> +               case ATMEL_PIO_DRVSTR_ME:
> +                       seq_printf(s, "%s ", "medium-drive");
> +                       break;
> +               case ATMEL_PIO_DRVSTR_HI:
> +                       seq_printf(s, "%s ", "high-drive");
> +                       break;

But here you know what VDDIOP is, right?

So in debugfs you could actually print the real drive strength
in mA, or both "medium-drive, %u mA"?

Yours,
Linus Walleij

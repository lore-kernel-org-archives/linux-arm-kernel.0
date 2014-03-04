From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Mar 2014 09:33:51 +0800
Subject: [PATCH] ARM: pxa: add gpio keys information
In-Reply-To: <1393329559-25320-1-git-send-email-dbaryshkov@gmail.com>
References: <1393329559-25320-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CAN1soZzfr2QQ9=LoQ9qcFf-dLD-W6jiEiK+SiGbyeN=cfPJvYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 7:59 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Switching from corgikbd to matrixkbd corgi has lost support for few switches.
> Readd them through gpio-keys-polled device (-polled, since scoop does
> not provide IRQ for GPIO).
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/corgi.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index f162f1b..57d6054 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -32,6 +32,7 @@
>  #include <linux/spi/pxa2xx_spi.h>
>  #include <linux/mtd/sharpsl.h>
>  #include <linux/input/matrix_keypad.h>
> +#include <linux/gpio_keys.h>
>  #include <linux/module.h>
>  #include <video/w100fb.h>
>
> @@ -405,6 +406,44 @@ static struct platform_device corgikbd_device = {
>         },
>  };
>
> +static struct gpio_keys_button corgi_gpio_keys[] = {
> +       {
> +               .type   = EV_SW,
> +               .code   = SW_LID,
> +               .gpio   = CORGI_GPIO_SWA,
> +               .desc   = "Lid close switch",
> +               .debounce_interval = 500,
> +       },
> +       {
> +               .type   = EV_SW,
> +               .code   = SW_TABLET_MODE,
> +               .gpio   = CORGI_GPIO_SWB,
> +               .desc   = "Tablet mode switch",
> +               .debounce_interval = 500,
> +       },
> +       {
> +               .type   = EV_SW,
> +               .code   = SW_HEADPHONE_INSERT,
> +               .gpio   = CORGI_GPIO_AK_INT,
> +               .desc   = "HeadPhone insert",
> +               .debounce_interval = 500,
> +       },
> +};
> +
> +static struct gpio_keys_platform_data corgi_gpio_keys_platform_data = {
> +       .buttons        = corgi_gpio_keys,
> +       .nbuttons       = ARRAY_SIZE(corgi_gpio_keys),
> +       .poll_interval  = 250,
> +};
> +
> +static struct platform_device corgi_gpio_keys_device = {
> +       .name   = "gpio-keys-polled",
> +       .id     = -1,
> +       .dev    = {
> +               .platform_data  = &corgi_gpio_keys_platform_data,
> +       },
> +};
> +
>  /*
>   * Corgi LEDs
>   */
> @@ -646,6 +685,7 @@ static struct platform_device sharpsl_rom_device = {
>  static struct platform_device *devices[] __initdata = {
>         &corgiscoop_device,
>         &corgifb_device,
> +       &corgi_gpio_keys_device,
>         &corgikbd_device,
>         &corgiled_device,
>         &corgi_audio_device,
> --
> 1.8.5.3
>

Applied

Thanks
Haojian

From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sun, 26 Feb 2012 12:03:27 +0100
Subject: [PATCH v6 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <1325817448.50788.YahooMailClassic@web29004.mail.ird.yahoo.com>
References: <1325817448.50788.YahooMailClassic@web29004.mail.ird.yahoo.com>
Message-ID: <CA+gwMcd03tgoSYUTiLNCKHWNS5ZY+UceSHBAKHyKGJMwVQupig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 6, 2012 at 3:37 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
> in SPI slave mode. The driver implements a simple navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
> touchpad is mapped to the ENTER button.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> V6:
> Rebased to linux-3.2.
>
> diff -uprN clean-3.2/arch/arm/mach-pxa/hx4700.c linux-3.2/arch/arm/mach-pxa/hx4700.c
> --- clean-3.2/arch/arm/mach-pxa/hx4700.c ? ? ? ?2012-01-04 23:55:44.000000000 +0000
> +++ linux-3.2/arch/arm/mach-pxa/hx4700.c ? ? ? ?2012-01-06 02:25:35.580520397 +0000
> @@ -22,6 +22,7 @@
> ?#include <linux/gpio.h>
> ?#include <linux/gpio_keys.h>
> ?#include <linux/input.h>
> +#include <linux/input/navpoint.h>
> ?#include <linux/lcd.h>
> ?#include <linux/mfd/htc-egpio.h>
> ?#include <linux/mfd/asic3.h>
> @@ -111,7 +112,7 @@ static unsigned long hx4700_pin_config[]
> ? ? ? ?GPIO113_I2S_SYSCLK,
>
> ? ? ? ?/* SSP 1 (NavPoint) */
> - ? ? ? GPIO23_SSP1_SCLK,
> + ? ? ? GPIO23_SSP1_SCLK_IN,
> ? ? ? ?GPIO24_SSP1_SFRM,
> ? ? ? ?GPIO25_SSP1_TXD,
> ? ? ? ?GPIO26_SSP1_RXD,
> @@ -181,6 +182,23 @@ static struct platform_device gpio_keys
> ?};
>
> ?/*
> + * Synaptics NavPoint connected to SSP1
> + */
> +
> +static struct navpoint_platform_data navpoint_platform_data = {
> + ? ? ? .port ? = 1,
> + ? ? ? .gpio ? = GPIO102_HX4700_SYNAPTICS_ON,
> +};
> +
> +static struct platform_device navpoint = {
> + ? ? ? .name ? = "navpoint",
> + ? ? ? .id ? ? = -1,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &navpoint_platform_data,
> + ? ? ? },
> +};
> +
> +/*
> ?* ASIC3
> ?*/
>
> @@ -782,6 +800,7 @@ static struct platform_device pcmcia = {
> ?static struct platform_device *devices[] __initdata = {
> ? ? ? ?&asic3,
> ? ? ? ?&gpio_keys,
> + ? ? ? &navpoint,
> ? ? ? ?&backlight,
> ? ? ? ?&w3220,
> ? ? ? ?&hx4700_lcd,
> @@ -806,6 +825,7 @@ static struct gpio global_gpios[] = {
> ? ? ? ?{ GPIO32_HX4700_RS232_ON, ? ? ? ? GPIOF_OUT_INIT_HIGH, "RS232_ON" },
> ? ? ? ?{ GPIO71_HX4700_ASIC3_nRESET, ? ? GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
> ? ? ? ?{ GPIO82_HX4700_EUART_RESET, ? ? ?GPIOF_OUT_INIT_HIGH, "EUART_RESET" },
> + ? ? ? { GPIO102_HX4700_SYNAPTICS_ON, ? ?GPIOF_OUT_INIT_LOW, ?"SYNAPTICS_ON" },
> ? ? ? ?{ GPIO105_HX4700_nIR_ON, ? ? ? ? ?GPIOF_OUT_INIT_HIGH, "nIR_EN" },
> ?};
>
> diff -uprN clean-3.2/arch/arm/mach-pxa/include/mach/hx4700.h linux-3.2/arch/arm/mach-pxa/include/mach/hx4700.h
> --- clean-3.2/arch/arm/mach-pxa/include/mach/hx4700.h ? 2012-01-04 23:55:44.000000000 +0000
> +++ linux-3.2/arch/arm/mach-pxa/include/mach/hx4700.h ? 2012-01-06 02:25:35.580520397 +0000
> @@ -62,7 +62,7 @@
> ?#define GPIO97_HX4700_nBL_DETECT ? ? ? ? ? ? ? 97
> ?#define GPIO99_HX4700_KEY_CONTACTS ? ? ? ? ? ? 99
> ?#define GPIO100_HX4700_AUTO_SENSE ? ? ? ? ? ? ?100 /* BL auto brightness */
> -#define GPIO102_HX4700_SYNAPTICS_POWER_ON ? ? ?102
> +#define GPIO102_HX4700_SYNAPTICS_ON ? ? ? ? ? ?102
> ?#define GPIO103_HX4700_SYNAPTICS_INT ? ? ? ? ? 103
> ?#define GPIO105_HX4700_nIR_ON ? ? ? ? ? ? ? ? ?105
> ?#define GPIO106_HX4700_CPU_BT_nRESET ? ? ? ? ? 106

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

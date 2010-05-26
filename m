From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 May 2010 21:48:26 +0800
Subject: [PATCH 2/5] pxa/vpac270: Add PMIC support
In-Reply-To: <1274404366-26304-2-git-send-email-marek.vasut@gmail.com>
References: <1274404366-26304-1-git-send-email-marek.vasut@gmail.com>
	<1274404366-26304-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTimX-XQ8tMZ9q9JEG0TN1dz9fhdqKPrw_zi8FCNX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 9:12 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch adds support for the MAX1587A used on Voipac PXA270 board.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/vpac270.c | ? 61 +++++++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index 9884fa9..1192e2b 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -25,6 +25,7 @@
> ?#include <linux/dm9000.h>
> ?#include <linux/ucb1400.h>
> ?#include <linux/ata_platform.h>
> +#include <linux/regulator/max1586.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -464,7 +465,6 @@ static struct i2c_board_info __initdata vpac270_i2c_devs[] = {
>
> ?static void __init vpac270_rtc_init(void)
> ?{
> - ? ? ? pxa_set_i2c_info(NULL);
> ? ? ? ?i2c_register_board_info(0, ARRAY_AND_SIZE(vpac270_i2c_devs));
> ?}
> ?#else
> @@ -538,7 +538,8 @@ static inline void vpac270_lcd_init(void) {}
> ?/******************************************************************************
> ?* PATA IDE
> ?******************************************************************************/
> -#if defined(CONFIG_PATA_PLATFORM) || defined(CONFIG_PATA_PLATFORM_MODULE)
> +#if defined(CONFIG_PATA_PLATFORM) || \
> + ? ? ? defined(CONFIG_PATA_PLATFORM_MODULE)
> ?static struct pata_platform_info vpac270_pata_pdata = {
> ? ? ? ?.ioport_shift ? = 1,
> ? ? ? ?.irq_flags ? ? ?= IRQF_TRIGGER_RISING,
> @@ -580,6 +581,59 @@ static inline void vpac270_ide_init(void) {}
> ?#endif
>
> ?/******************************************************************************
> + * Core power regulator
> + ******************************************************************************/
> +#if defined(CONFIG_REGULATOR_MAX1586) || \
> + ? ? ? defined(CONFIG_REGULATOR_MAX1586_MODULE)
> +static struct regulator_consumer_supply vpac270_max1587a_consumers[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .supply = "vcc_core",
> + ? ? ? }
> +};
> +
> +static struct regulator_init_data vpac270_max1587a_v3_info = {
> + ? ? ? .constraints = {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "vcc_core range",
> + ? ? ? ? ? ? ? .min_uV ? ? ? ? = 900000,
> + ? ? ? ? ? ? ? .max_uV ? ? ? ? = 1705000,
> + ? ? ? ? ? ? ? .always_on ? ? ?= 1,
> + ? ? ? ? ? ? ? .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> + ? ? ? },
> + ? ? ? .consumer_supplies ? ? ?= vpac270_max1587a_consumers,
> + ? ? ? .num_consumer_supplies ?= ARRAY_SIZE(vpac270_max1587a_consumers),
> +};
> +
> +static struct max1586_subdev_data vpac270_max1587a_subdevs[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "vcc_core",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = MAX1586_V3,
> + ? ? ? ? ? ? ? .platform_data ?= &vpac270_max1587a_v3_info,
> + ? ? ? }
> +};
> +
> +static struct max1586_platform_data vpac270_max1587a_info = {
> + ? ? ? .subdevs ? ? = vpac270_max1587a_subdevs,
> + ? ? ? .num_subdevs = ARRAY_SIZE(vpac270_max1587a_subdevs),
> + ? ? ? .v3_gain ? ? = MAX1586_GAIN_R24_3k32, /* 730..1550 mV */
> +};
> +
> +static struct i2c_board_info __initdata vpac270_pi2c_board_info[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("max1586", 0x14),
> + ? ? ? ? ? ? ? .platform_data ?= &vpac270_max1587a_info,
> + ? ? ? },
> +};
> +
> +static void __init vpac270_pmic_init(void)
> +{
> + ? ? ? i2c_register_board_info(1, ARRAY_AND_SIZE(vpac270_pi2c_board_info));
> +}
> +#else
> +static inline void vpac270_pmic_init(void) {}
> +#endif
> +
> +
> +/******************************************************************************
> ?* Machine init
> ?******************************************************************************/
> ?static void __init vpac270_init(void)
> @@ -589,7 +643,10 @@ static void __init vpac270_init(void)
> ? ? ? ?pxa_set_ffuart_info(NULL);
> ? ? ? ?pxa_set_btuart_info(NULL);
> ? ? ? ?pxa_set_stuart_info(NULL);
> + ? ? ? pxa_set_i2c_info(NULL);
> + ? ? ? pxa27x_set_i2c_power_info(NULL);
>
> + ? ? ? vpac270_pmic_init();
> ? ? ? ?vpac270_lcd_init();
> ? ? ? ?vpac270_mmc_init();
> ? ? ? ?vpac270_nor_init();
> --
> 1.7.0
>
>

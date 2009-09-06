From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 7 Sep 2009 08:51:59 +0900
Subject: [PATCH 12/12] [ARM][S3C6410] Add support gpio function for keypad
	device
In-Reply-To: <00ab01ca2e2d$1b52fcf0$51f8f6d0$%yang@samsung.com>
References: <00ab01ca2e2d$1b52fcf0$51f8f6d0$%yang@samsung.com>
Message-ID: <9c9fda240909061651y68dd8579r6cea25638ea120f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/5 ??? <jsgood.yang@samsung.com>:
> This patch includes machine specific gpio function for keypad device
> which can be changed by platform hardware. The gpio function is
> related with keypad platform info such as rows and columns of
> those matrix.
>
> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> ---
> ?arch/arm/mach-s3c6410/mach-smdk6410.c | ? 23 +++++++++++++++++++++++
> ?1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
> index 95e130d..f297c26 100644
> --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> @@ -347,6 +347,28 @@ static struct s3c_platform_keypad keypad_data __initdata = {
> ? ? ? ?.delay = 50,
> ?};

I thinks it's not a good idea to place s3c6410 generic function to
board file. please move it platform or mach-s3c6410.
>
> +static void s3c_keypad_cfg_gpio(int rows, int columns)
> +{
> + ? ? ? unsigned int gpio;
> + ? ? ? unsigned int end;
> +
> + ? ? ? end = S3C64XX_GPK(8 + rows);
> +
> + ? ? ? /* Set all the necessary GPK pins to special-function 0 */

special-function 3?

> + ? ? ? for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +
> + ? ? ? end = S3C64XX_GPL(0 + columns);
> +
> + ? ? ? /* Set all the necessary GPK pins to special-function 0 */

ditto

> + ? ? ? for (gpio = S3C64XX_GPL(0); gpio < end; gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +}
> +
> ?static void __init smdk6410_map_io(void)
> ?{
> ? ? ? ?u32 tmp;
> @@ -382,6 +404,7 @@ static void __init smdk6410_machine_init(void)
> ? ? ? ?i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
>
> ? ? ? ?s3c_keypad_set_platdata(&keypad_data);
> + ? ? ? s3c_keypad_cfg_gpio(keypad_data.nr_rows, keypad_data.nr_cols);
>
> ? ? ? ?platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
> ?}
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

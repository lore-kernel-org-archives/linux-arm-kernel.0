From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:43:11 +0800
Subject: [PATCH] pxa/magician: use gpio arrays for backlight and lcd power
	init
In-Reply-To: <1303329323.21545.6.camel@flow>
References: <1303329323.21545.6.camel@flow>
Message-ID: <CAMPhdO_iP_gbjwoEZx8m8sUSpZXPAac_NgYTPAe4RonOGWBoCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 3:55 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Use gpio_request_array() / gpio_free_array() in backlight init and exit
> functions and lcd power initialization.
>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/magician.c | ? 43 ++++++++++++++++-------------------------
> ?1 files changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index 9984ef7..22da1e9 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -344,22 +344,14 @@ static struct pxafb_mach_info samsung_info = {
> ?* Backlight
> ?*/
>
> +static struct gpio magician_bl_gpios[] = {
> + ? ? ? ?{ EGPIO_MAGICIAN_BL_POWER, ?GPIOF_DIR_OUT, "Backlight power" },
> + ? ? ? ?{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
> +};
> +
> ?static int magician_backlight_init(struct device *dev)
> ?{
> - ? ? ? int ret;
> -
> - ? ? ? ret = gpio_request(EGPIO_MAGICIAN_BL_POWER, "BL_POWER");
> - ? ? ? if (ret)
> - ? ? ? ? ? ? ? goto err;
> - ? ? ? ret = gpio_request(EGPIO_MAGICIAN_BL_POWER2, "BL_POWER2");
> - ? ? ? if (ret)
> - ? ? ? ? ? ? ? goto err2;
> - ? ? ? return 0;
> -
> -err2:
> - ? ? ? gpio_free(EGPIO_MAGICIAN_BL_POWER);
> -err:
> - ? ? ? return ret;
> + ? ? ? return gpio_request_array(ARRAY_AND_SIZE(magician_bl_gpios));
> ?}
>
> ?static int magician_backlight_notify(struct device *dev, int brightness)
> @@ -376,8 +368,7 @@ static int magician_backlight_notify(struct device *dev, int brightness)
>
> ?static void magician_backlight_exit(struct device *dev)
> ?{
> - ? ? ? gpio_free(EGPIO_MAGICIAN_BL_POWER);
> - ? ? ? gpio_free(EGPIO_MAGICIAN_BL_POWER2);
> + ? ? ? gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
> ?}
>
> ?static struct platform_pwm_backlight_data backlight_data = {
> @@ -712,6 +703,12 @@ static struct platform_device *devices[] __initdata = {
> ? ? ? ?&leds_gpio,
> ?};
>
> +static struct gpio magician_lcd_gpios[] = {
> + ? ? ? { GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
> + ? ? ? { GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
> + ? ? ? { GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" }
> +};
> +
> ?static void __init magician_init(void)
> ?{
> ? ? ? ?void __iomem *cpld;
> @@ -747,16 +744,10 @@ static void __init magician_init(void)
> ? ? ? ? ? ? ? ?system_rev = board_id & 0x7;
> ? ? ? ? ? ? ? ?lcd_select = board_id & 0x8;
> ? ? ? ? ? ? ? ?pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
> - ? ? ? ? ? ? ? if (lcd_select && (system_rev < 3)) {
> - ? ? ? ? ? ? ? ? ? ? ? gpio_request(GPIO75_MAGICIAN_SAMSUNG_POWER, "SAMSUNG_POWER");
> - ? ? ? ? ? ? ? ? ? ? ? gpio_direction_output(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
> - ? ? ? ? ? ? ? }
> - ? ? ? ? ? ? ? gpio_request(GPIO104_MAGICIAN_LCD_POWER_1, "LCD_POWER_1");
> - ? ? ? ? ? ? ? gpio_request(GPIO105_MAGICIAN_LCD_POWER_2, "LCD_POWER_2");
> - ? ? ? ? ? ? ? gpio_request(GPIO106_MAGICIAN_LCD_POWER_3, "LCD_POWER_3");
> - ? ? ? ? ? ? ? gpio_direction_output(GPIO104_MAGICIAN_LCD_POWER_1, 0);
> - ? ? ? ? ? ? ? gpio_direction_output(GPIO105_MAGICIAN_LCD_POWER_2, 0);
> - ? ? ? ? ? ? ? gpio_direction_output(GPIO106_MAGICIAN_LCD_POWER_3, 0);
> + ? ? ? ? ? ? ? if (lcd_select && (system_rev < 3))
> + ? ? ? ? ? ? ? ? ? ? ? gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
> + ? ? ? ? ? ? ? gpio_request_array(ARRAY_AND_SIZE(magician_lcd_gpios));
> ? ? ? ? ? ? ? ?pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
> ? ? ? ?} else
> ? ? ? ? ? ? ? ?pr_err("LCD detection: CPLD mapping failed\n");
> --
> 1.7.4.4
>
>
>

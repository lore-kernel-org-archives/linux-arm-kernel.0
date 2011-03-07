From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 07 Mar 2011 16:11:24 +0900
Subject: [PATCH v2] ARM: EXYNOS4: enabled lcd and backlight in NURI board
In-Reply-To: <1299460218-22748-1-git-send-email-dh09.lee@samsung.com>
References: <1299460218-22748-1-git-send-email-dh09.lee@samsung.com>
Message-ID: <032401cbdc96$e134f360$a39eda20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Donghwa Lee wrote:
> 
> This patch enables lcd and backlight drivers in NURI board.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changes since v1:
> - Adds backlight platform data to control brightness and GPIO
> - Modify inappropriate function name and remove useless codes.
> - And so on.
> 
>  arch/arm/mach-exynos4/Kconfig     |    1 +
>  arch/arm/mach-exynos4/mach-nuri.c |   81
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 0 deletions(-)

Thanks for re-work :)
There are small comments below.

(snip)

> +static void nuri_lcd_power_on(struct plat_lcd_data *pd, unsigned int
power)
> +{
> +	int gpio = EXYNOS4_GPE1(5);
> +
> +	if (power)
> +		gpio_direction_output(gpio, 1);
> +	else
> +		gpio_direction_output(gpio, 0);

	gpio_direction_output(gpio, power);

> +}
> +
> +static int nuri_bl_init(struct device *dev)
> +{
> +	int ret, gpio = EXYNOS4_GPE2(3);
> +
> +	ret = gpio_request(gpio, "LCD_LDO_EN");
> +	if (!ret)
> +		gpio_direction_output(gpio, 0);
> +
> +	return 0;

	return ret;

> +}

(snip)

> +static struct platform_device nuri_lcd_device = {
> +	.name			= "platform-lcd",
> +	.id			= -1,
> +	.dev			= {
> +		.platform_data	= (void *) &nuri_lcd_platform_data,

		.platform_data = &nuri_lcd_platform_data,

> +	},
> +};

(snip)

You used gpio_request() for EXYNOS4_GPE2(3) and EXYNOS4_GPE1(5), but
EXYNOS4_GPE1(5). Is there any reason or policy for it?


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

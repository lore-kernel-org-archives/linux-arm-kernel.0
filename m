From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Mon, 03 Sep 2012 21:26:42 +0200
Subject: [PATCH v2] ARM: S3C24XX: Add WIZnet W5300E01-ARM board support
In-Reply-To: <1346693799.3485.2.camel@taehun-desktop>
References: <1346653236-19728-1-git-send-email-kth3321@gmail.com>
 <1346693799.3485.2.camel@taehun-desktop>
Message-ID: <50450472.5090603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 07:36 PM, Taehun Kim wrote:
> +static void __init w5300e01_init(void)
> +{
> +	s3c_nand_set_platdata(&w5300e01_nand_info);
> +	platform_add_devices(w5300e01_devices, ARRAY_SIZE(w5300e01_devices));
> +
> +	/* W5300 interrupt pin. */
> +	s3c_gpio_cfgpin(S3C2410_GPF(0), S3C2410_GPIO_IRQ);
> +
> +	s3c_gpio_cfgpin(S3C2410_GPF(4), S3C2410_GPIO_OUTPUT);
> +	s3c_gpio_cfgpin(S3C2410_GPF(5), S3C2410_GPIO_OUTPUT);
> +	s3c_gpio_cfgpin(S3C2410_GPF(6), S3C2410_GPIO_OUTPUT);
> +	s3c_gpio_cfgpin(S3C2410_GPF(7), S3C2410_GPIO_OUTPUT);

Please don't use these obsolete S3C2410_GPIO_* defines, they will be
gone soon, if aren't yet.

> +	gpio_set_value(S3C2410_GPF(0), 1);
> +	gpio_set_value(S3C2410_GPF(4), 1);
> +	gpio_set_value(S3C2410_GPF(5), 1);
> +	gpio_set_value(S3C2410_GPF(6), 1);
> +	gpio_set_value(S3C2410_GPF(7), 1);

Instead I would do something like:

8<-----------------------------------------------------------------

static const struct gpio gpios[] = {
	{ S3C2410_GPF(4), GPIOF_OUT_INIT_HIGH, NULL },
	{ S3C2410_GPF(5), GPIOF_OUT_INIT_HIGH, NULL },
	{ S3C2410_GPF(6), GPIOF_OUT_INIT_HIGH, NULL },
	{ S3C2410_GPF(7), GPIOF_OUT_INIT_HIGH, NULL },
};

if (!WARN_ON(gpio_request_array(gpios, ARRAY_SIZE(gpios)))
	gpios_free_array(gpios);

/* W5300 interrupt pin. */
if (!WARN_ON(gpio_request(S3C2410_GPF(0), GPIOF_IN, NULL))) {
	s3c_gpio_cfgpin(S3C2410_GPF(0), S3C_GPIO_SFN(2)); /* EINT0 */
	gpio_free(S3C2410_GPF(0));
}

8<-----------------------------------------------------------------

--

Regards,
Sylwester

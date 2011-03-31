From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 Mar 2011 15:27:00 +0300
Subject: [PATCH] omap: rx51: Platform support for lp5523 led chip
In-Reply-To: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
References: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Message-ID: <20110331122659.GT2267@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 31, 2011 at 03:17:57PM +0300, Ameya Palande wrote:
> +static int rx51_lp5523_setup(void)
> +{
> +	int err;
> +
> +	err = gpio_request(RX51_LP5523_CHIP_EN_GPIO, "lp5523_enable");
> +	if (err < 0) {
> +		pr_err("Unable to get lp5523_enable GPIO\n");
> +		return err;
> +	}
> +
> +	err = gpio_direction_output(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	if (err < 0) {
> +		pr_err("Failed to change direction for %d GPIO\n",
> +				RX51_LP5523_CHIP_EN_GPIO);
> +	}

you can combine these two into

gpio_request_one(RX51_LP5523_CHIP_EN_GPIO, GPIOF_DIR_OUT,
		"lp5523_enable");

> +	return err;
> +}
> +
> +static void rx51_lp5523_release(void)
> +{
> +	gpio_free(RX51_LP5523_CHIP_EN_GPIO);
> +}
> +
> +static void rx51_lp5523_enable(bool state)
> +{
> +	if (state)
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	else
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 0);

how about:

gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, !!state); ??

you drop a useless branch.

> +}
> +
> +static struct lp5523_platform_data rx51_lp5523_platform_data = {

should this be const ??

> +	.led_config		= rx51_lp5523_led_config,
> +	.num_channels		= ARRAY_SIZE(rx51_lp5523_led_config),
> +	.clock_mode		= LP5523_CLOCK_AUTO,
> +	.setup_resources	= rx51_lp5523_setup,
> +	.release_resources 	= rx51_lp5523_release,
			  ^ trailing whitespace

-- 
balbi

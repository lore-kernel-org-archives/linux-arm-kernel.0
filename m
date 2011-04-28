From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 20:09:16 +0100
Subject: [PATCH] pxa/hx4700: Add hx4700 LED support
In-Reply-To: <E1QElXA-0006c4-DQ@outmx08.plus.net>
References: <E1QElXA-0006c4-DQ@outmx08.plus.net>
Message-ID: <20110428190916.GN17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 04:54:42PM +0000, Paul Parsons wrote:
> Add hx4700 LED support. LED hx4700:amber blinks while the battery is charging. LED hx4700:green lights when the battery is full. LED hx4700:blue is a placeholder for absent bluetooth/wlan support. They are enabled via CONFIG_LEDS_ASIC3, and can be tested via /sys/class/leds.

Paul,

In addition to what Philipp said, it would be a good idea to run your
patch through checkpatch.pl (in the kernel source) to check for style
issues.  Beware that it's only a guide.

Eg,

> +	timebase = (value == LED_OFF) ? 0 : led->timebase;
> +	asic3_write_register(asic, (led->base+ASIC3_LED_TimeBase), timebase);

This should have spaces around '+'.  The parens shouldn't be required.
Same for other asic3_write_register() calls.

> +}
> +
> +static int __devinit led_init(
> +	struct platform_device *pdev,
> +	struct asic3 *asic,
> +	struct asic3_led *led)
> +{

static int __devinit led_init(struct platform_device *pdev, struct asic3 *asic,
	struct asic3_led *led)
{

> +	int ret;
> +
> +	led->cdev = kzalloc(sizeof(struct led_classdev), GFP_KERNEL);
> +	if (! led->cdev)
> +		return (-ENOMEM);

	if (!led->cdev)
		return -ENOMEM;

> +
> +	led->cdev->name = led->name;
> +	led->cdev->default_trigger = led->default_trigger;
> +	led->cdev->brightness_set = asic3_led_set;
> +
> +	ret = led_classdev_register(&pdev->dev, led->cdev);
> +	if (ret < 0) {
> +		kfree(led->cdev);
> +		return (ret);

		return ret;

> +	}
> +
> +	asic3_clk_enable(asic, led->clock);
> +
> +	asic3_write_register(asic, (led->base+ASIC3_LED_PeriodTime), led->periodtime);
> +	asic3_write_register(asic, (led->base+ASIC3_LED_DutyTime), led->dutytime);
> +	asic3_write_register(asic, (led->base+ASIC3_LED_AutoStopCount), led->autostopcount);
> +	asic3_write_register(asic, (led->base+ASIC3_LED_TimeBase), 0);	/* disable */
> +
> +	return (0);

	return 0;

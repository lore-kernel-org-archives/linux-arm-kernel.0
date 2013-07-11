From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jul 2013 17:51:16 +0100
Subject: [PATCH v2] rtc: Add MOXA ART RTC driver
In-Reply-To: <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
References: <1373464848-28146-1-git-send-email-jonas.jensen@gmail.com>
 <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130711165116.GT24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 03:51:51PM +0200, Jonas Jensen wrote:
> Add RTC driver for MOXA ART SoCs.

Looks good now.  A couple more minor nits.

> +void moxart_rtc_write_byte(u8 data)
> +{

> +u8 moxart_rtc_read_byte(void)
> +{

These should be static.

> +	gpio_direction_output(GPIO_RTC_DATA, 0);
> +	gpio_set_value(GPIO_RTC_RESET, 1);

I guess I'd expect the GPIOs to be configured by platform data in case
of board changes (it's a bit odd that a SoC RTC is being done with
bitbanging, I guess it's on an external chip?).

> +	devm_gpio_request(&pdev->dev, GPIO_RTC_DATA, "rtc_data");
> +	devm_gpio_request(&pdev->dev, GPIO_RTC_SCLK, "rtc_sclk");
> +	devm_gpio_request(&pdev->dev, GPIO_RTC_RESET, "rtc_reset");

Should check the errors from these.

> +	gpio_direction_output(GPIO_RTC_RESET, 0);
> +	gpio_direction_output(GPIO_RTC_SCLK, 0);

devm_gpio_request_one()?  Though it doesn't make much difference and you
do have a nice block of devm_gpio_request() above not all of which have
a direction assigned immediately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/7019f737/attachment.sig>

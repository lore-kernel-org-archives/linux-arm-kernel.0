From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Apr 2012 13:00:23 -0600
Subject: [PATCH v2 1/2] pinctrl: add pinctrl_provide_dummies interface
 for platforms to use
In-Reply-To: <1335260023-15859-1-git-send-email-b29396@freescale.com>
References: <1335260023-15859-1-git-send-email-b29396@freescale.com>
Message-ID: <4F96F847.508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2012 03:33 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Add a interface pinctrl_provide_dummies for platform to indicate
> whether it needs use pinctrl dummy state and dummy gpio.

> @@ -382,7 +396,12 @@ int pinctrl_request_gpio(unsigned gpio)
>  	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
>  	if (ret) {
>  		mutex_unlock(&pinctrl_mutex);
> -		return -EINVAL;
> +		if (pinctrl_dummy_gpio) {
> +			pr_debug("pinctrl: using dummy gpio(%u)\n", gpio);
> +			return 0;
> +		} else {
> +			return -EINVAL;
> +		}
>  	}

The only thing that should be calling pinctrl_request_gpio() is a GPIO
driver. It should only be calling it for the GPIOs it manages. I'd
expect that if a platform's pinctrl driver was not yet written to
support the GPIO functionality, then the GPIO driver would not be
calling this function.

As such, I'm not sure that this part of the change is necessary.

If it is, then surely all the other pinctrl GPIO APIs need a similar change?

Finally, how does this interact with deferred probe: How does the code
know whether the pinctrl driver and/or GPIO range is simply not yet
registered, or whether it never will be? That'd be the difference
between returning -EPROBE_DEFER or 0 in the if block above.


I'm fine with the other parts of this patch.

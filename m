From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 12 Dec 2017 11:58:45 +0200
Subject: [PATCH 2/4] [v2] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <1512170904-4749-3-git-send-email-timur@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-3-git-send-email-timur@codeaurora.org>
Message-ID: <1513072725.25007.614.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-12-01 at 17:28 -0600, Timur Tabi wrote:
> Add support for specifying that some GPIOs within a range are
> unavailable.
> Some systems have a sparse list of GPIOs, where a range of GPIOs is
> specified (usually 0 to n-1), but some subset within that range is
> absent or unavailable for whatever reason.
> 
> To support this, allow drivers to specify a bitmask of GPIOs that
> are present or absent.  Gpiolib will then block access to those that
> are absent.
 
> -	status = gpiochip_irqchip_init_valid_mask(chip);
> +	status = gpiochip_init_valid_mask(chip);
>  	if (status)
>  		goto err_remove_from_list;
>  
> +	status = gpiochip_irqchip_init_valid_mask(chip);
> +	if (status)
> +		goto err_remove_valid_mask;

Yes, this way it looks good!

> +static bool gpiochip_available(const struct gpio_chip *gpiochip,
> +			   unsigned int offset)
> +{

> +	pr_info("%s:%u offset=%u\n", __func__, __LINE__, offset);

Debug leftover?

> +
> +	/* No mask means all valid */
> +	if (likely(!gpiochip->valid_mask))
> +		return true;
> +
> +	return test_bit(offset, gpiochip->valid_mask);

Not sure which one is better
 return test_bit();
or
 return !!test_bit();

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

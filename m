From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 11:12:29 +0200
Subject: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <1509396602-1936-3-git-send-email-timur@codeaurora.org>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
 <1509396602-1936-3-git-send-email-timur@codeaurora.org>
Message-ID: <1509441149.10233.80.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-10-30 at 15:50 -0500, Timur Tabi wrote:
> Add support for specifying that some GPIOs within a range are
> unavailable.
> Some systems have a sparse list of GPIOs, where a range of GPIOs is
> specified (usually 0 to n-1), but some subset within that range is
> absent or unavailable for whatever reason.
> 
> To support this, allow drivers to specify a bitmask of GPIOs that
> are present or absent.  Gpiolib will then block access to those that
> are absent.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> 

>  
>  static int gpiochip_irqchip_init_valid_mask(struct gpio_chip
> *gpiochip)
>  {


Instead of mangling this function wouldn't be better to introduce a
separate one for line and perhaps a third one which calls them both?

> -	if (!gpiochip->irq_need_valid_mask)
> -		return 0;
> +	if (gpiochip->irq_need_valid_mask) {
> +		gpiochip->irq_valid_mask =
> +			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
> +				sizeof(long), GFP_KERNEL);
> +		if (!gpiochip->irq_valid_mask)
> +			return -ENOMEM;
>  
> -	gpiochip->irq_valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> >ngpio),
> -					   sizeof(long), GFP_KERNEL);
> -	if (!gpiochip->irq_valid_mask)
> -		return -ENOMEM;
> +		/* Assume by default all GPIOs are valid */
> +		bitmap_fill(gpiochip->irq_valid_mask, gpiochip-
> >ngpio);
> +	}
>  
> -	/* Assume by default all GPIOs are valid */
> -	bitmap_fill(gpiochip->irq_valid_mask, gpiochip->ngpio);
> +	if (gpiochip->line_need_valid_mask) {
> +		gpiochip->line_valid_mask =
> +			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
> +				sizeof(long), GFP_KERNEL);
> +		if (!gpiochip->line_valid_mask)
> +			return -ENOMEM;
> +
> +		/* Assume by default all GPIOs are valid */
> +		bitmap_fill(gpiochip->line_valid_mask, gpiochip-
> >ngpio);
> +	}
>  
>  	return 0;
>  }

...for my opinion it will drastically increase readability and reduce
diff as well (better for review).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

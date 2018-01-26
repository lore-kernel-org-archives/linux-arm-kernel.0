From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 26 Jan 2018 11:35:45 +0200
Subject: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
In-Reply-To: <20180126011400.2191-3-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-3-sboyd@codeaurora.org>
Message-ID: <1516959345.7000.1281.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-25 at 17:13 -0800, Stephen Boyd wrote:
> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.  Add
> support for a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.
> 
> For now, we plumb this into the gpiochip irq APIs so that
> GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
> test validity of GPIOs.


> +static void of_gpiochip_init_irq_valid_mask(struct gpio_chip *chip)
> +{

> +	int len, i;
> +	u32 start, count;
> +	struct device_node *np = chip->of_node;

Perhaps reversed tree style? (In the following function as well)

> +	len = of_property_count_u32_elems(np,  "reserved-gpio-
> ranges");
> 

> +	for (i = 0; i < len; i += 2) {
> +		of_property_read_u32_index(np, "reserved-gpio-
> ranges",
> +					   i, &start);
> +		of_property_read_u32_index(np, "reserved-gpio-
> ranges",
> +					   i + 1, &count);

of_find_property() + of_prop_next_u32() ?

> +	if (size > 0 && size % 2 == 0)
> +		gpiochip->irq.need_valid_mask = true;

 ffs(size) >= 2 ?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

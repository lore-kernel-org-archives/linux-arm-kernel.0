From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 21 Mar 2018 19:59:10 +0200
Subject: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
In-Reply-To: <20180321165848.89751-3-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-3-swboyd@chromium.org>
Message-ID: <1521655150.23017.79.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Some qcom platforms make some GPIOs or pins unavailable for use by
> non-secure operating systems, and thus reading or writing the
> registers
> for those pins will cause access control issues. Add support for a DT
> property to describe the set of GPIOs that are available for use so
> that
> higher level OSes are able to know what pins to avoid reading/writing.
> Non-DT platforms can add support by directly updating the
> chip->valid_mask.

> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Hmm...

> +	gpiochip->valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> >ngpio),
> +				       sizeof(long), GFP_KERNEL);

Just noticed that kcalloc is superfluous here.
kmalloc_array() would be enough.

> +	if (!gpiochip->valid_mask)
> +		return -ENOMEM;
> +
> +	/* Assume by default all GPIOs are valid */
> +	bitmap_fill(gpiochip->valid_mask, gpiochip->ngpio);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

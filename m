From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 22:04:32 +0000
Subject: [PATCH v2 3/6] ARM: at91/gpio: add DT support
In-Reply-To: <1325615688-16860-1-git-send-email-nicolas.ferre@atmel.com>
References: <876f676ec80d2db927e379654be76171ca496422.1323975517.git.nicolas.ferre@atmel.com>
 <1325615688-16860-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120104220432.GJ11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 07:34:48PM +0100, Nicolas Ferre wrote:
> +	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
> +	if (!at91_gpio->clock) {
> +		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n",
> +								alias_id);
> +		goto ioremap_err;
> +	}
> +
> +	/* enable PIO controller's clock */
> +	if(clk_enable(at91_gpio->clock)) {
> +		pr_err("at91_gpio.%d, failed to enable clock, ignoring.\n",
> +								alias_id);
> +		goto clk_err;
> +	}

No new code should be added to the kernel which uses clk_enable() without
using clk_prepare() first.  Ditto clk_disable() and clk_unprepare().

> +	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
> +	if (!at91_gpio->clock) {
> +		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
> +		goto ioremap_err;
> +	}
> +
> +	if(clk_enable(at91_gpio->clock)) {
> +		pr_err("at91_gpio.%d, failed to enable clock, ignoring.\n", i);
> +		goto clk_err;
> +	}

I've seen this code somewhere before...  Couldn't this be separated out into
a helper function?

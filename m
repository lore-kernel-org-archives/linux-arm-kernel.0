From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 19 Jul 2017 10:55:16 +0200
Subject: [PATCH] clocksource: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-13-robh@kernel.org>
References: <20170718214339.7774-13-robh@kernel.org>
Message-ID: <b6f4661d-6655-0fb9-f212-2d777a12e11a@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2017 23:42, Rob Herring wrote:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.

Nice. For my own reference:
http://elixir.free-electrons.com/linux/v4.13-rc1/source/Documentation/printk-formats.txt#L349

About removing the full path. Does this mean that ultimately
%pOF will print just the name? And the 'f' spec will disappear?

Is this done to save memory?

> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/clocksource/tango_xtal.c  |  6 +++---
>  drivers/clocksource/timer-of.c    | 11 +++++------
>  drivers/clocksource/timer-probe.c |  3 +--
>  drivers/clocksource/timer-stm32.c |  8 ++++----
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/tango_xtal.c
> index c4e1c2e6046f..6a8d9838ce33 100644
> --- a/drivers/clocksource/tango_xtal.c
> +++ b/drivers/clocksource/tango_xtal.c
> @@ -26,13 +26,13 @@ static int __init tango_clocksource_init(struct device_node *np)
> 
>  	xtal_in_cnt = of_iomap(np, 0);
>  	if (xtal_in_cnt == NULL) {
> -		pr_err("%s: invalid address\n", np->full_name);
> +		pr_err("%pOF: invalid address\n", np);
>  		return -ENXIO;
>  	}
> 
>  	clk = of_clk_get(np, 0);
>  	if (IS_ERR(clk)) {
> -		pr_err("%s: invalid clock\n", np->full_name);
> +		pr_err("%pOF: invalid clock\n", np);
>  		return PTR_ERR(clk);
>  	}
> 
> @@ -43,7 +43,7 @@ static int __init tango_clocksource_init(struct device_node *np)
>  	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
>  				    32, clocksource_mmio_readl_up);
>  	if (ret) {
> -		pr_err("%s: registration failed\n", np->full_name);
> +		pr_err("%pOF: registration failed\n", np);
>  		return ret;
>  	}

For drivers/clocksource/tango_xtal.c

Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Regards.

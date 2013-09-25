From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 25 Sep 2013 20:23:14 -0300
Subject: [PATCH 2/5] clocksource: Add Allwinner SoCs HS timers driver
In-Reply-To: <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52437062.5040705@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 25/09/13 11:03, Maxime Ripard escribi?:
> Most of the Allwinner SoCs (at this time, all but the A10) also have a
> High Speed timers that are not using the 24MHz oscillator as a source
> but rather the AHB clock running much faster.
>
> The IP is slightly different between the A10s/A13 and the one used in
> the A20/A31, since the latter have 4 timers available, while the former
> have only 2 of them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

[...]

> +static void __init sun5i_timer_init(struct device_node *node)
> +{
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret, irq;
> +	u32 val;
> +
> +	timer_base = of_iomap(node, 0);
> +	if (!timer_base)
> +		panic("Can't map registers");
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("Can't parse IRQ");
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk))
> +		panic("Can't get timer clock");

I'm not familiar with clocksources, but does this have to be as fatal as 
it is considering the kernel also supports the slower sun4i timer?

Also, would any special considerations be needed when adjusting the ahb 
clock? A future cpufreq driver will most likely need to.

Cheers,

Emilio

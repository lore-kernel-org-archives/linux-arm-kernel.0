From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 17:14:09 +0200
Subject: [PATCH] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1371549604-7201-1-git-send-email-jonas.jensen@gmail.com>
References: <1371549604-7201-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130618171409.0286fa2c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jonas Jensen,

On Tue, 18 Jun 2013 12:00:04 +0200, Jonas Jensen wrote:

> +static void __init moxart_timer_init(struct device_node *node)
> +{
> +	int ret, irq;
> +
> +	timer_base = of_iomap(node, 0);
> +	if (!timer_base)
> +		panic("%s: failed to map base\n", node->full_name);
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("%s: can't parse IRQ\n", node->full_name);
> +
> +	ret = setup_irq(irq, &moxart_timer_irq);
> +	if (ret)
> +		pr_warn("%s: failed to setup IRQ %d\n", node->full_name, irq);
> +
> +
> +	writel(APB_CLK / HZ, TIMER_1_COUNT(timer_base));
> +	writel(APB_CLK / HZ, TIMER_1_LOAD(timer_base));
> +
> +	writel(1, TIMER_1_CR_ENABLE(timer_base));
> +	writel(0, TIMER_1_CR_EXTCLK(timer_base));
> +	writel(1, TIMER_1_CR_FLOWIN(timer_base));
> +
> +	pr_info("%s: count/load (APB_CLK=%d/HZ=%d) IRQ=%d\n",
> +		node->full_name, APB_CLK, HZ, irq);
> +}
> +CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);

Any reason to not use the clocksource and clockevents infrastructures?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

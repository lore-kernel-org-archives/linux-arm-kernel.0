From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Apr 2015 11:56:06 +0200 (CEST)
Subject: [PATCH 1/5] clocksource: st_lpc: Add LPC timer as a clocksource.
In-Reply-To: <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
 <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <alpine.DEB.2.11.1504211153580.13914@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Apr 2015, Peter Griffin wrote:
> +/* Low Power Timer */
> +#define LPC_LPT_LSB_OFF		0x400
> +#define LPC_LPT_MSB_OFF		0x404
> +#define LPC_LPT_START_OFF	0x408
> +
> +struct st_lpc {
> +	struct clk *clk;
> +	void __iomem *iomem_cs;
> +};
> +
> +static struct st_lpc *st_lpc;
> +
> +static u64 notrace st_lpc_counter_read(void)
> +{
> +	u64 counter;
> +	u32 lower;
> +	u32 upper, old_upper;
> +
> +	upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
> +	do {
> +		old_upper = upper;
> +		lower = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_LSB_OFF);
> +		upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
> +	} while (upper != old_upper);
> +
> +	counter = upper;
> +	counter <<= 32;
> +	counter |= lower;
> +	return counter;


What's the point of this exercise? The kernel can handle 32bit
clocksources nicely. So why do you want to artificially expand them to
64bit by adding useless loops and hoops to a hotpath?

Thanks,

	tglx

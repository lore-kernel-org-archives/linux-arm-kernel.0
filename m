From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 May 2015 17:55:24 +0200 (CEST)
Subject: [PATCH v2 02/12] clocksource: sti: Provide support for the ST
 LPC Clocksource IP
In-Reply-To: <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
 <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
Message-ID: <alpine.DEB.2.11.1505121751560.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 May 2015, Lee Jones wrote:
> +static void st_clksrc_reset(void)

__init

> +static int st_clksrc_setup_clk(struct device_node *np)

__init

> +static void __init st_clksrc_of_register(struct device_node *np)
> +{
> +	int ret;
> +	uint32_t mode;
> +
> +	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> +	if (ret) {
> +		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
> +		return;
> +	}
> +
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> +	if (mode != ST_LPC_MODE_CLKSRC)
> +		return;
> +
> +	ddata.base = of_iomap(np, 0);
> +	if (!ddata.base) {
> +		pr_err("clksrc-st-lpc: Unable to map iomem\n");
> +		return;
> +	}
> +
> +	if (st_clksrc_setup_clk(np)) {
> +		iounmap(ddata.base);
> +		return;
> +	}
> +
> +	if (st_clksrc_init()) {

Keeps the clock enabled.

> +		iounmap(ddata.base);
> +		return;

Thanks,

	tglx

From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 29 Jul 2016 13:06:48 -0700
Subject: [v3,2/6] power: add power sequence library
In-Reply-To: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
References: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
Message-ID: <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for your work on this, a few comments inline


On 07/20/2016 02:40 AM, Peter Chen wrote:

> ...
>
> +static int pwrseq_generic_on(struct device_node *np, struct pwrseq *pwrseq)
> +{
>
> ...
>
> +	if (gpiod_reset) {
> +		u32 duration_us = 50;
> +
> +		of_property_read_u32(np, "reset-duration-us",
> +				&duration_us);
> +		usleep_range(duration_us, duration_us + 10);
The end of the range could allow for more margin. Also consider busy 
looping for very short delays as in 
http://lxr.free-electrons.com/source/drivers/regulator/core.c#L2062
> ...
>
> +static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	enum of_gpio_flags flags;
> +	int reset_gpio, ret = 0;
> +
> +	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
This only gets the first of potentially multiple clocks, is that intended?

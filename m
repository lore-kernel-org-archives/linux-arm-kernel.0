From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Jan 2013 15:03:41 +0000
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <1357568989-16237-1-git-send-email-marex@denx.de>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
Message-ID: <20130107150341.GT21994@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 07 Jan 2013, Marek Vasut wrote:

> In case of a DT-based probe of the stmpe MFD driver, the irq_gpio was zero,
> which resulted in the driver failing to probe.
> 
> Implement DT properties "irq-over-gpio" and "irq-gpios" which are already used
> in "arch/arm/boot/dts/spear320-hmi.dts" to circumvent these problems. 

This must have slipped through the gaps. It should be removed.

> The new
> behaviour is the expected one and copies the behavior of platform_data-based
> probe.

Blindly copying platform data behaviour to DT bindings is seldom a good idea.

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mfd/stmpe.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 4b11202..fb9cd6f 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -1018,6 +1018,11 @@ void stmpe_of_probe(struct stmpe_platform_data *pdata, struct device_node *np)
>  	pdata->id = -1;
>  	pdata->irq_trigger = IRQF_TRIGGER_NONE;
>  
> +	pdata->irq_over_gpio = of_get_property(np, "irq-over-gpio", NULL);

This is a new DT binding and you haven't provided any documentation for it.

Also, there is no reason for the binding to exist.

Lots of drivers use GPIO pins as IRQs.

> +	pdata->irq_gpio = of_get_named_gpio(np, "irq-gpios", 0);
> +	if (!gpio_is_valid(pdata->irq_gpio))
> +		pdata->irq_gpio = -1;
> +
>  	of_property_read_u32(np, "st,autosleep-timeout",
>  			&pdata->autosleep_timeout);
>  
> -- 
> 1.7.10.4
> 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

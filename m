From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 26 Feb 2016 13:27:39 -0600
Subject: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
Message-ID: <56D0A72B.8020100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:
> +	if (action) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			action = 0;
> +			dev_warn(dev, "unable to get ws0 interrupt.\n");
> +		} else {
> +			if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
> +					     pdev->name, gwdt)) {
> +				action = 0;
> +				dev_warn(dev, "unable to request IRQ %d.\n",
> +					 irq);
> +			}
> +		}
> +		if (!action)
> +			dev_warn(dev, "falling back to signle stage mode.\n");
> +	}
> +
> +	/*
> +	 * Get the frequency of system counter from the cp15 interface of ARM
> +	 * Generic timer. We don't need to check it, because if it returns "0",
> +	 * system would panic in very early stage.
> +	 */
> +	gwdt->clk = arch_timer_get_cntfrq();
> +	gwdt->refresh_base = rf_base;
> +	gwdt->control_base = cf_base;

I think you need to ping the watchdog before enabling the interrupt, in 
case there is a pending interrupt.  This just happened to me in testing, 
so I recommend this:

> 	/*
> 	 * Get the frequency of system counter from the cp15 interface of ARM
> 	 * Generic timer. We don't need to check it, because if it returns "0",
> 	 * system would panic in very early stage.
> 	 */
> 	gwdt->clk = arch_timer_get_cntfrq();
> 	gwdt->refresh_base = rf_base;
> 	gwdt->control_base = cf_base;
>
> 	if (action) {
> 		irq = platform_get_irq(pdev, 0);
> 		if (irq < 0) {
> 			action = 0;
> 			dev_warn(dev, "unable to get ws0 interrupt.\n");
> 		} else {
> 			sbsa_gwdt_keepalive(&gwdt->wdd);
> 			if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
> 					     pdev->name, gwdt)) {
> 				action = 0;
> 				dev_warn(dev, "unable to request IRQ %d.\n",
> 					 irq);
> 			}
> 		}
> 		if (!action)
> 			dev_warn(dev, "falling back to single stage mode.\n");
> 	}

In fact, I think you need to move the "if (action) {" block near the end 
of sbsa_gwdt_probe().  We don't want to enable the interrupt until the 
watchdog is fully initialized.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.

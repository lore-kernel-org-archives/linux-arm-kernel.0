From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Dec 2014 13:52:23 +0000
Subject: [STLinux Kernel] [PATCH v2 RESEND 02/11] mtd: st_spi_fsm: Obtain
 and use EMI clock if provided
In-Reply-To: <1417688512-7644-3-git-send-email-lee.jones@linaro.org>
References: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
 <1417688512-7644-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20141208135223.GB29220@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 04 Dec 2014, Lee Jones wrote:

> ST's Common Clk Framework is now available. This patch ensures the FSM
> makes use of it by obtaining and enabling the EMI clock if provided. If
> system fails to provide the EMI clock FSM uses its original default
> rate.

<snip>

I'm not sure I understand this patch. Now that common clock framework
is available for STI platforms, why would the emi clock ever not be available?

If it is to maintain DT compatability then we are already breaking this with the
syscfg 'reg' DT changes which are coming up, and this was deemed OK as the platform
is WIP.

IMO keeping this legacy code which assumes the bootloader / JTAG has enabled and configured
the emi clock correctly is not worth it now that CCF is available for the platform.

> -	/* TODO: Make this dynamic */
> -	emi_freq = STFSM_DEFAULT_EMI_FREQ;
> +	if (!fsm->clk) {
> +		dev_warn(fsm->dev,
> +			 "No EMI clock available. Using default 100MHz.\n");
> +
> +		emi_freq = STFSM_DEFAULT_EMI_FREQ;
> +	} else
> +		emi_freq = clk_get_rate(fsm->clk);
>  
>  	/*
>  	 * Calculate clk_div - values between 2 and 128
> @@ -2057,6 +2064,15 @@ static int stfsm_probe(struct platform_device *pdev)
>  		return PTR_ERR(fsm->base);
>  	}
>  
> +	fsm->clk = devm_clk_get(&pdev->dev, "emi_clk");
> +	if (IS_ERR(fsm->clk)) {
> +		dev_warn(fsm->dev, "Couldn't find EMI clock.\n");
> +		fsm->clk = NULL;
> +	} else if (clk_prepare_enable(fsm->clk)) {
> +		dev_warn(fsm->dev, "Failed to enable EMI clock.\n");

If a clock has been provided and we fail to enable it, then surely that is game over?

As the code currently is it then goes onto assume in stfsm_set_freq() that the rate
is STFSM_DEFAULT_EMI_FREQ which can't be true if it can't enable the clock.

regards,

Peter.

From: joe@perches.com (Joe Perches)
Date: Tue, 25 Oct 2011 09:26:08 -0700
Subject: [PATCH] arm/tegra: clk_get should not be fatal
In-Reply-To: <1319559329-324-1-git-send-email-pdeschrijver@nvidia.com>
References: <1319559329-324-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1319559968.14932.5.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-25 at 19:15 +0300, pdeschrijver at nvidia.com wrote:
> The timer and rtc-timer clocks aren't gated by default, so there is no reason
> to crash the system if the dummy enable call failed.
[]
> diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
[]
> @@ -186,16 +186,20 @@ static void __init tegra_init_timer(void)
>  	int ret;
>  
>  	clk = clk_get_sys("timer", NULL);
> -	BUG_ON(IS_ERR(clk));
> -	clk_enable(clk);
> +	if (IS_ERR(clk))
> +		pr_warning("Unable to get timer clock");
> +	else
> +		clk_enable(clk);
>  
>  	/*
>  	 * rtc registers are used by read_persistent_clock, keep the rtc clock
>  	 * enabled
>  	 */
>  	clk = clk_get_sys("rtc-tegra", NULL);
> -	BUG_ON(IS_ERR(clk));
> -	clk_enable(clk);
> +	if (IS_ERR(clk))
> +		pr_warning("Unable to get rtc-tegra clock");
> +	else
> +		clk_enable(clk);

Are these messages are really necessary?
Maybe just:
	if (!IS_ERR(clk))
		clk_enable(clk)

If these are really necessary, please use
	pr_warn("Unable to get <foo>\n");
pr_warn and with a terminating newline.

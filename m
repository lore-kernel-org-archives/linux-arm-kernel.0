From: stanley.miao@windriver.com (stanley.miao)
Date: Wed, 16 Feb 2011 09:40:41 +0800
Subject: [PATCH V6 13/63] ST SPEAr: Updating Clock Support
In-Reply-To: <6e9275be36b831894e51a2adf3ebbe9984831d16.1297763160.git.viresh.kumar@st.com>
References: <cover.1297763160.git.viresh.kumar@st.com>
	<6e9275be36b831894e51a2adf3ebbe9984831d16.1297763160.git.viresh.kumar@st.com>
Message-ID: <4D5B2B19.5070401@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> <snip>
> -/*
> - * Set pclk as cclk's parent and add clock sibling node to current parents
> - * children list
> +/**
> + * clk_round_rate - adjust a rate to the exact rate a clock can provide
> + * @clk: clock source
> + * @rate: desired clock rate in Hz
> + *
> + * Returns rounded clock rate in Hz, or negative errno.
>   */
> -static void change_parent(struct clk *cclk, struct clk *pclk)
> +long clk_round_rate(struct clk *clk, unsigned long drate)
>  {
> -	unsigned long flags;
> +	long rate = 0;
> +	int index;
> +
> +	/*
> +	 * propagate call to parent who supports calc_rate. Similar approach is
> +	 * used in clk_set_rate.
> +	 */
> +	if (!clk->calc_rate) {
> +		u32 mult;
> +		if (!clk->pclk)
> +			return clk->rate;
> +
> +		mult = clk->div_factor ? clk->div_factor : 1;
> +		return clk_round_rate(clk->pclk, mult * drate) / mult;
> +	}
>   

Now it looks OK.

Reviewed-by: Stanley.Miao <stanley.miao@windriver.com>

Stanley.

>  
>
>   

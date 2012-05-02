From: mturquette@ti.com (Mike Turquette)
Date: Tue, 1 May 2012 18:42:58 -0700
Subject: [PATCH] clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is
 set and clk is enabled
In-Reply-To: <b9cb6ed1e4bf0f777873b142d88cedfc520023b2.1334140283.git.viresh.kumar@st.com>
References: <b9cb6ed1e4bf0f777873b142d88cedfc520023b2.1334140283.git.viresh.kumar@st.com>
Message-ID: <20120502014258.GD17311@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120411-16:03, Viresh Kumar wrote:
> This is well documented but isn't implemented. clk_set_rate() must check if
> flags have CLK_SET_RATE_GATE bit set and is enabled too.
> 
> Untested patch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Tested and pulled into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/clk.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9d11c19..65dc35d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -905,6 +905,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>  	if (rate == clk->rate)
>  		goto out;
>  
> +	if ((clk->flags & CLK_SET_RATE_GATE) && __clk_is_enabled(clk)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	/* calculate new rates and get the topmost changed clock */
>  	top = clk_calc_new_rates(clk, rate);
>  	if (!top) {
> -- 
> 1.7.9
> 

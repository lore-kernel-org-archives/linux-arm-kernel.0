From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:45:12 -0700
Subject: [PATCH 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
In-Reply-To: <1494856763-6543-2-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170620014512.GL4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Dong Aisheng wrote:
> ---
>  drivers/clk/clk-divider.c    | 2 ++
>  include/linux/clk-provider.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 96386ff..f78ba7a 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -125,6 +125,8 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
>  
>  	div = _get_div(table, val, flags, divider->width);
>  	if (!div) {
> +		if (flags & CLK_DIVIDER_ZERO_GATE)
> +			return 0;
>  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),

Why not use the CLK_DIVIDER_ALLOW_ZERO flag? A clk being off
doesn't mean the rate is 0. The divider is just disabled, so we
would consider the rate as whatever the parent is, which is what
this code does before this patch. Similarly, we don't do anything
about gate clocks and return a rate of 0 when they're disabled.

>  			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
>  			clk_hw_get_name(hw));

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

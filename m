From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 10 Jun 2013 08:44:55 +0200
Subject: [PATCH] clk: divider: do not propagate rate change request when
 unnecessary
In-Reply-To: <1370182855-13427-1-git-send-email-shawn.guo@linaro.org>
References: <1370182855-13427-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51B575E7.7040708@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.06.2013 16:20, Shawn Guo wrote:
> If the current rate of parent clock is sufficient to provide child a
> requested rate with a proper divider setting, the rate change request
> should not be propagated.  Instead, changing the divider setting is good
> enough to get child clock run at the requested rate.
>
> On an imx6q clock configuration illustrated below,
>
>    ahb --> ipg --> ipg_per
>    132M    66M     66M
>
> calling clk_set_rate(ipg_per, 22M) with the current
> clk_divider_bestdiv() implementation will result in the rate change up
> to ahb level like the following, because of the unnecessary/incorrect
> rate change propagation.
>
>    ahb --> ipg --> ipg_per
>    66M     22M     22M
>
> Fix the problem by trying to see if the requested rate can be achieved
> by simply changing the divider value, and in that case return the
> divider immediately from function clk_divider_bestdiv() as the best
> one, so that all those unnecessary rate change propagation can be saved.
>
> Reported-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>   drivers/clk/clk-divider.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 6d96741..6024e60 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -150,6 +150,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
>   	struct clk_divider *divider = to_clk_divider(hw);
>   	int i, bestdiv = 0;
>   	unsigned long parent_rate, best = 0, now, maxdiv;
> +	unsigned long parent_rate_saved = *best_parent_rate;
>
>   	if (!rate)
>   		rate = 1;
> @@ -173,6 +174,15 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
>   	for (i = 1; i <= maxdiv; i++) {
>   		if (!_is_valid_div(divider, i))
>   			continue;
> +		if (rate * i == parent_rate_saved) {
> +			/*
> +			 * It's the most ideal case if the requested rate can be
> +			 * divided from parent clock without needing to change
> +			 * parent rate, so return the divider immediately.
> +			 */
> +			*best_parent_rate = parent_rate_saved;
> +			return i;
> +		}
>   		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
>   				MULT_ROUND_UP(rate, i));
>   		now = parent_rate / i;
>

Is this ready to be applied?

Thanks

Dirk

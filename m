From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 7 May 2014 18:50:35 +0200
Subject: [PATCH] clk: divider: Fix overflow in clk_divider_bestdiv
In-Reply-To: <1399479850-25292-1-git-send-email-t.figa@samsung.com>
References: <1399479850-25292-1-git-send-email-t.figa@samsung.com>
Message-ID: <536A645B.9000709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 05/07/2014 06:24 PM, Tomasz Figa wrote:
> Commit c686078 ("clk: divider: Add round to closest divider") introduced
> a helper function to check whether given divisor is the best one instead
> of direct check. However due to int type used instead of unsigned long
> for passing calculated rates to this function in certain cases an
> overflow could occur, for example when trying to obtain maximum possible
> clock rate by calling clk_round_rate(..., UINT_MAX).
>
> This patch fixes this issue by changing the type of rate, now and best
> arguments of the function to unsigned long, which is the type that
> should be used for clock rates.
Good catch.

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>   drivers/clk/clk-divider.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index c572945..e0b360a 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -232,7 +232,7 @@ static int _div_round(struct clk_divider *divider, unsigned long parent_rate,
>   }
>
>   static bool _is_best_div(struct clk_divider *divider,
> -		int rate, int now, int best)
> +		unsigned long rate, unsigned long now, unsigned long best)
>   {
>   	if (divider->flags & CLK_DIVIDER_ROUND_CLOSEST)
>   		return abs(rate - now) < abs(rate - best);
>

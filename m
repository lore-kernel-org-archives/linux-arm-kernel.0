From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 7 May 2014 10:37:42 +0200
Subject: [PATCH] clk: clk-divider: Fix infinite loop for table divider
In-Reply-To: <1399408005-4209-1-git-send-email-festevam@gmail.com>
References: <1399408005-4209-1-git-send-email-festevam@gmail.com>
Message-ID: <5369F0D6.3080503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 05/06/2014 10:26 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit e7489693b3 (clk: divider: Optimize clk_divider_bestdiv loop) we
> notice a system hang on mx6qboard.
>
> The cause for the hang is well explained by Sascha Hauer [1]:
>
> "This cannot work. _round_up_table is implemented like this:
>
> static int _round_up_table(const struct clk_div_table *table, int div)
> {
>          const struct clk_div_table *clkt;
>          int up = _get_table_maxdiv(table);
>
>          for (clkt = table; clkt->div; clkt++) {
>                  if (clkt->div == div)
>                          return clkt->div;
>                  ...
>          }
>          ...
> }
>
> Here when a table entry matches the input div this function will return
> exactly the input div. This means _next_div() will always return the
> same value and clk_divider_bestdiv() has an infinite loop:
>
>          for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
>                  ...
>          }
> "
> [1] http://marc.info/?l=linux-arm-kernel&m=139940658726253&w=2
>
> Remove the 'return _round_up_table' so that the system can work normally again.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   drivers/clk/clk-divider.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index b3c8396..fc3e344 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -246,8 +246,6 @@ static int _next_div(struct clk_divider *divider, int div)
>
>   	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
>   		return __roundup_pow_of_two(div);
> -	if (divider->table)
> -		return _round_up_table(divider->table, div);

Couldn't we initialize "up" variable to INT_MAX in _round_up_table() as 
I just proposed in mail thread reporting the regression?

See http://marc.info/?l=linux-arm-kernel&m=139945172905130&w=2

Regards,
Maxime

>
>   	return div;
>   }
>

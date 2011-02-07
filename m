From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Feb 2011 09:05:55 +0100
Subject: [RFC, PATCH 3/3] clk: add warnings for incorrect
	enable/prepare semantics
In-Reply-To: <1297058877.800990.238556019385.3.gpush@pororo>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
Message-ID: <20110207080555.GC27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jeremy,

On Mon, Feb 07, 2011 at 02:07:57PM +0800, Jeremy Kerr wrote:
> This change adds warnings to check for:
> 
>  1) enabling a clock that hasn't been prepared; and
> 
>  2) unpreparing a clock that is still enabled
> 
> While the correctness can't be guaranteed, these warnings should cover
> most situations.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  drivers/clk/clk.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 51dbd33..2369959 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -35,6 +35,8 @@ void clk_unprepare(struct clk *clk)
>  	if (!clk->ops->unprepare)
>  		return;
>  
> +	WARN_ON(clk->enable_count);
> +
>  	mutex_lock(&clk->prepare_lock);
>  	if (--clk->prepare_count == 0)
>  		clk->ops->unprepare(clk);
> @@ -50,6 +52,8 @@ int clk_enable(struct clk *clk)
>  	if (!clk->ops->enable)
>  		return 0;
>  
> +	WARN_ON(clk->ops->prepare && clk->prepare_count);
> +
This implies the warning is only issued on clocks that have a prepare
callback.  If we want to enforce the new API the warning here shouldn't
depend on clk->ops->prepare.  (clk_prepare and clk_unprepare need to
be changed then to adapt the prepare_count even in the absence of
clk->ops->prepare.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

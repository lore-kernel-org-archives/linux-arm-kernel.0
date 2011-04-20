From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 14:53:23 +0200
Subject: [PATCH 03/10] clk: Make NULL a valid clock again
In-Reply-To: <1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110420125323.GY31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:08:08PM +0200, Sascha Hauer wrote:
> NULL used to be a valid clock. This patch makes the common struct
> clk stuff work with this. Instead of crashing we return sane default
> values for this dummy clock, that is: can always be prepared, enabled,
> rate unkown and no set rate.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> ---
>  drivers/clk/clk.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0da0bb9..264c809 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -15,6 +15,9 @@ int clk_prepare(struct clk *clk)
>  {
>  	int ret = 0;
>  
> +	if (!clk)
> +		return 0;
> +
>  	mutex_lock(&clk->prepare_lock);
>  	if (clk->prepare_count == 0 && clk->ops->prepare)
>  		ret = clk->ops->prepare(clk);
> @@ -29,6 +32,9 @@ EXPORT_SYMBOL_GPL(clk_prepare);
>  
>  void clk_unprepare(struct clk *clk)
>  {
> +	if (!clk)
> +		return;
> +
>  	mutex_lock(&clk->prepare_lock);
>  
>  	WARN_ON(clk->prepare_count == 0);
> @@ -47,6 +53,9 @@ int clk_enable(struct clk *clk)
>  	unsigned long flags;
>  	int ret = 0;
>  
> +	if (!clk)
> +		return 0;
> +
>  	WARN_ON(clk->prepare_count == 0);
>  
>  	spin_lock_irqsave(&clk->enable_lock, flags);
> @@ -65,6 +74,9 @@ void clk_disable(struct clk *clk)
>  {
>  	unsigned long flags;
>  
> +	if (!clk)
> +		return;
> +
>  	spin_lock_irqsave(&clk->enable_lock, flags);
>  
>  	WARN_ON(clk->enable_count == 0);
> @@ -78,6 +90,9 @@ EXPORT_SYMBOL_GPL(clk_disable);
>  
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> +	if (!clk)
> +		return 0;
> +
>  	if (clk->ops->get_rate)
>  		return clk->ops->get_rate(clk);
>  	return 0;
How about writing that as:

	if (clk && clk->ops->get_rate)
		return clk->ops->get_rate(clk);
	return 0;

? Ditto for some of the other functions.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

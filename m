From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Aug 2016 14:06:52 +0200
Subject: [PATCH] clocksource/drivers/time-armada-370-xp: Fix the clock
 reference
In-Reply-To: <1470816548-8750-1-git-send-email-gregory.clement@free-electrons.com>
References: <1470816548-8750-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160810140652.2d59e12b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 10 Aug 2016 10:09:08 +0200, Gregory CLEMENT wrote:
> While converting the init function to return an error, the wrong clock
> was get. This lead to wrong clock rate and slow down the kernel. For
> example, before the patch a typical boot was around 15s after it was 1
> minute slower.
> 
> Fixes: 12549e27c63c ("clocksource/drivers/time-armada-370-xp: Convert init function to return error")
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/clocksource/time-armada-370-xp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 719b478d136e..3c39e6f45971 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -338,7 +338,6 @@ static int __init armada_xp_timer_init(struct device_node *np)
>  	struct clk *clk = of_clk_get_by_name(np, "fixed");
>  	int ret;
>  
> -	clk = of_clk_get(np, 0);

I think to avoid this mistake, we should rewrite the code as:

	struct *clk;
	int ret;

	clk = of_clk_get_by_name(np, "fixed");
	if (IS_ERR(clk)) {
		...
	

Indeed, I find confusing a block that starts with error checking, and
it's probably what lead to this of_clk_get() being added here.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

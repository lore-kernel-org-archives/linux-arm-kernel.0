From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Mar 2010 10:20:44 +0100
Subject: [PATCH 2/2] [ARM] [IMX]: Fix clock usecount counter from
	underflow.
In-Reply-To: <1268809916-6525-2-git-send-email-vzapolskiy@gmail.com>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
	<1268809916-6525-2-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100317092042.GB16150@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:11:56AM +0300, Vladimir Zapolskiy wrote:
> If clk_disable() is called for already disabled clock clk->usecount
> value is decremented anyway. This leads to a problem that sequent
> clk_enable() call doesn't enable the clock as expected.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/clock.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 2daec3c..fd7596c 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c
> @@ -53,10 +53,15 @@ static void __clk_disable(struct clk *clk)
>  	if (clk == NULL || IS_ERR(clk))
>  		return;
>  
> +        if (!clk->usecount) {
> +                printk(KERN_ERR "Trying to disable a clock with 0 usecount\n");
> +                WARN_ON(1);
> +                return;
> +        }
> +
>  	__clk_disable(clk->parent);
>  	__clk_disable(clk->secondary);
>  
> -	WARN_ON(!clk->usecount);
>  	if (!(--clk->usecount) && clk->disable)
>  		clk->disable(clk);
>  }
I'm not sure this is worth it.  IMHO an unbalanced clk_disable is a
severe bug that doesn't need to be handled smoothly.

But maybe move the WARN_ON before the __clk_disable(clk->parent)?  This
way the disabled parent clock cannot stop the message to appear.

Other than that, please use WARN instead of printk + WARN_ON.  Then the
message is printed only after the oops begin marker.

And your indention is broken.  Please use tabs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

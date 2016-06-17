From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Jun 2016 08:33:53 +0200
Subject: [PATCH V2 25/63] clocksource/drivers/mxs_timer: Convert init
 function to return error
In-Reply-To: <1466112442-31105-26-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-26-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160617063353.GT26048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 16, 2016 at 11:26:44PM +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
> 
>   or
> 
>   - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/mps2-timer.c | 10 ++++++----
>  drivers/clocksource/mxs_timer.c  |  2 +-

Did you forget to split here? The changelog only mentions mxs.

>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
> index 3d33a5e..c303fa9 100644
> --- a/drivers/clocksource/mps2-timer.c
> +++ b/drivers/clocksource/mps2-timer.c
> @@ -250,7 +250,7 @@ out:
>  	return ret;
>  }
>  
> -static void __init mps2_timer_init(struct device_node *np)
> +static int __init mps2_timer_init(struct device_node *np)
>  {
>  	static int has_clocksource, has_clockevent;
>  	int ret;
> @@ -259,7 +259,7 @@ static void __init mps2_timer_init(struct device_node *np)
>  		ret = mps2_clocksource_init(np);
>  		if (!ret) {
>  			has_clocksource = 1;
> -			return;
> +			return 0;
>  		}
>  	}
>  
> @@ -267,9 +267,11 @@ static void __init mps2_timer_init(struct device_node *np)
>  		ret = mps2_clockevent_init(np);
>  		if (!ret) {
>  			has_clockevent = 1;
> -			return;
> +			return 0;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
> -CLOCKSOURCE_OF_DECLARE(mps2_timer, "arm,mps2-timer", mps2_timer_init);
> +CLOCKSOURCE_OF_DECLARE_RET(mps2_timer, "arm,mps2-timer", mps2_timer_init);
> diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
> index f5ce296..16cf53b 100644
> --- a/drivers/clocksource/mxs_timer.c
> +++ b/drivers/clocksource/mxs_timer.c
> @@ -226,7 +226,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
>  	return 0;
>  }
>  
> -static void __init mxs_timer_init(struct device_node *np)
> +static int __init mxs_timer_init(struct device_node *np)
>  {
>  	struct clk *timer_clk;
>  	int irq;

I didn't try, but I expect that the "return;" a few lines below results
in at least a warning and the compiler also warns about a missing return
at the end of the function.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

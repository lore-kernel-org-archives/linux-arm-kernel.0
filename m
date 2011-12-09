From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Dec 2011 13:34:47 -0800
Subject: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called
 from invalid context
In-Reply-To: <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
 <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
Message-ID: <20111209213447.GB31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Omar Ramirez Luna <omar.ramirez@ti.com> [111124 19:37]:
> omap_dm_timer_request* holds a spin_lock_irqsave while inner routines call
> clk_get_sys which holds a mutex_lock, given that mutex can be put to sleep
> a BUG message is triggered. This occurs in 2 ocassions.
> 
> 1. When the fck is gotten at the beginning of omap_dm_timer_prepare by using
>    clk_get (which will call clk_get_sys), this was fixed by getting the clock
>    handles on probe.
> 
> 2. When omap_dm_timer_set_source tries to get the clock handles (with clk_get)
>    for the fck and source clock, this was moved to be made after
>    spin_unlock_irqsave when the context is not atomic anymore.
> 
> @@ -168,19 +159,26 @@ struct omap_dm_timer *omap_dm_timer_request(void)
>  		break;
>  	}
>  
> -	if (timer) {
> -		ret = omap_dm_timer_prepare(timer);
> -		if (ret) {
> -			timer->reserved = 0;
> -			timer = NULL;
> -		}
> +	if (!timer) {
> +		spin_unlock_irqrestore(&dm_timer_lock, flags);
> +		goto err_no_timer;
>  	}
> +
> +	omap_dm_timer_prepare(timer);
> +
>  	spin_unlock_irqrestore(&dm_timer_lock, flags);
>  
> -	if (!timer)
> -		pr_debug("%s: timer request failed!\n", __func__);
> +	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +	if (ret) {
> +		timer->reserved = 0;
> +		goto err_no_timer;
> +	}
>  
>  	return timer;
> +
> +err_no_timer:
> +	pr_debug("%s: timer request failed!\n", __func__);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_request);

This does not seem right.. It seems that you're hardcoding the source
clock to 32 KiHz clock while other sources are available too?
  
> @@ -199,19 +197,26 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  		}
>  	}
>  
> -	if (timer) {
> -		ret = omap_dm_timer_prepare(timer);
> -		if (ret) {
> -			timer->reserved = 0;
> -			timer = NULL;
> -		}
> +	if (!timer) {
> +		spin_unlock_irqrestore(&dm_timer_lock, flags);
> +		goto err_no_timer;
>  	}
> +
> +	omap_dm_timer_prepare(timer);
> +
>  	spin_unlock_irqrestore(&dm_timer_lock, flags);
>  
> -	if (!timer)
> -		pr_debug("%s: timer%d request failed!\n", __func__, id);
> +	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +	if (ret) {
> +		timer->reserved = 0;
> +		goto err_no_timer;
> +	}

And here too?

Regards,

Tony

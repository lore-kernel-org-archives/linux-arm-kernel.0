From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Aug 2016 15:04:40 +0200
Subject: [v.1] clocksource:clps711x-timer:- Unmap a region obtained by
 remap
In-Reply-To: <1470937308-9480-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1470937308-9480-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <57B30F68.4080701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arvind,

On 08/11/2016 07:41 PM, Arvind Yadav wrote:
> iounmap frees the mapping when timer id is not matching.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Even if this fix is correct, it does actually rollback a minimalist part
of what was done and only if the clock type is wrong. Can you properly
handle the undo from the different init functions and regarding their
success/error ?

Thanks.

  -- Daniel

>  drivers/clocksource/clps711x-timer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
> index 84aed78..deaca51 100644
> --- a/drivers/clocksource/clps711x-timer.c
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -116,6 +116,7 @@ static int __init clps711x_timer_init(struct device_node *np)
>  	case CLPS711X_CLKSRC_CLOCKEVENT:
>  		return _clps711x_clkevt_init(clock, base, irq);
>  	default:
> +		iounmap(base);
>  		return -EINVAL;
>  	}
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

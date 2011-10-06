From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 13:18:27 -0700
Subject: [PATCH v2] omap: dmtimer: convert printk to pr_err / WARN
In-Reply-To: <1317922204-12512-1-git-send-email-vjaquez@igalia.com>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
	<1317922204-12512-1-git-send-email-vjaquez@igalia.com>
Message-ID: <20111006201827.GT6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* V?ctor Manuel J?quez Leal <vjaquez@igalia.com> [111006 09:56]:
> Convert a printk(KERN_ERR) message in the driver to pr_err(), and
> use WARN() instead of a custom log message with a stack dump.
> 
> Signed-off-by: V?ctor Manuel J?quez Leal <vjaquez@igalia.com>

Looks like this won't apply with the changes we have queued up,
care to refresh this against linux-omap master branch (or dmtimer
branch)?

Regards,

Tony

> ---
>  arch/arm/plat-omap/dmtimer.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index ee9f6eb..dead0f3 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -322,7 +322,7 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
>  	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
>  		c++;
>  		if (c > 100000) {
> -			printk(KERN_ERR "Timer failed to reset\n");
> +			pr_err("Timer failed to reset\n");
>  			return;
>  		}
>  	}
> @@ -397,9 +397,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  	spin_lock_irqsave(&dm_timer_lock, flags);
>  	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
>  		spin_unlock_irqrestore(&dm_timer_lock, flags);
> -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> -		       __FILE__, __LINE__, __func__, id);
> -		dump_stack();
> +		WARN(1, "unable to get timer %d\n", id);
>  		return NULL;
>  	}
>  
> -- 
> 1.7.6.3
> 

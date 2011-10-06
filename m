From: joe@perches.com (Joe Perches)
Date: Thu, 06 Oct 2011 08:19:39 -0700
Subject: [PATCH] omap: dmtimer: convert printk to pr_*
In-Reply-To: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
Message-ID: <1317914379.10495.5.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-10-06 at 12:48 +0200, V?ctor Manuel J?quez Leal wrote:
> Convert all the printk(<level>) messages in the driver to pr_<level>().
[]
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
[]
> @@ -397,8 +397,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  	spin_lock_irqsave(&dm_timer_lock, flags);
>  	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
>  		spin_unlock_irqrestore(&dm_timer_lock, flags);
> -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> -		       __FILE__, __LINE__, __func__, id);
> +		pr_warning("unable to get timer %d\n", id);

For new conversions, please use pr_warn not pr_warning.
It's shorter and similar to other dev_warn/netdev_warn
uses.

>  		dump_stack();

To emit a message then dump stack, please use
	WARN(1, fmt, ...)

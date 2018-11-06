From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 06 Nov 2018 17:29:13 +0100
Subject: [PATCH] arm/twd: avoid waking deeply sleeping CPUs for rate
 change notifier
In-Reply-To: <20180417104627.29643-1-l.stach@pengutronix.de>
References: <20180417104627.29643-1-l.stach@pengutronix.de>
Message-ID: <1541521753.5822.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-17 at 12:46 +0200, Lucas Stach wrote:
[...]
> @@ -326,6 +350,9 @@ static int __init twd_local_timer_common_register(struct device_node *np)
>  {
>  	int err;
>  
> +	if (!zalloc_cpumask_var(&active_twd_mask, GFP_KERNEL))
> +		return -ENOMEM;
> +
>  	twd_evt = alloc_percpu(struct clock_event_device);
>  	if (!twd_evt) {
>  		err = -ENOMEM;

This could free_cpumask_var(active_twd_mask) in the error path.

regards
Philipp

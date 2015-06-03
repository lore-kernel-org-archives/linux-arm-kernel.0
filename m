From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Jun 2015 13:44:08 -0700
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <1433363565-17725-1-git-send-email-balbi@ti.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
Message-ID: <20150603204407.GX30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150603 13:36]:
> 
> AM43xx, even though it's a single processor A9, it still has TWD and global
> timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
> by switching from gptimer to twd/global.
> 
> The only problem is that currently, is_smp() check prevents me from using twd
> with AM43xx (that's why it's commented below, for testing purposes).
> 
> In the hopes that we can start a, hopefully, small thread around the subject,
> I'm sending this HACK which I used to get TWD and global timer enabled so I
> could measure latencies with cyclictest.
> 
> Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
> processors ?

> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -388,8 +389,10 @@ static void __init twd_local_timer_of_register(struct device_node *np)
>  {
>  	int err;
>  
> +#if 0
>  	if (!is_smp() || !setup_max_cpus)
>  		return;
> +#endif
>  
>  	twd_ppi = irq_of_parse_and_map(np, 0);
>  	if (!twd_ppi) {

Why don't you just check for the c-a9 revision here? If it's the
UP processor then allow twd?

Similar to what's done in global_timer_of_register?

Regards,

Tony

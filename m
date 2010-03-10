From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Mar 2010 13:53:22 -0800
Subject: [PATCH 1/2] arm: disable L2 cache in the v7 finish function
In-Reply-To: <1268143623-22361-2-git-send-email-saeed@marvell.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
Message-ID: <20100310215321.GP2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Saeed Bishara <saeed@marvell.com> [100309 06:13]:
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  arch/arm/mm/proc-v7.S |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 7aaf88a..06cc36c 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -52,6 +52,11 @@ ENTRY(cpu_v7_proc_fin)
>  	bic	r0, r0, #0x1000			@ ...i............
>  	bic	r0, r0, #0x0006			@ .............ca.
>  	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
> +#ifdef CONFIG_OUTER_CACHE
> +	mrc	p15, 0, r0, c1, c0, 1
> +	bic	r0, r0, #0x2
> +	mcr	p15, 0, r0, c1, c0, 1		@ disable L2 cache
> +#endif
>  	ldmfd	sp!, {pc}
>  ENDPROC(cpu_v7_proc_fin)

This one is a bit tricky. I know of three different ways
to disable the L2 cache depending on the hardware. One of
them is what you have above. The second is via SMI, and
then the first one won't work. The third is via external
secure monitor calls used on some omaps at least. And in
the third case the first two methods won't work.

AFAIK disabling the c bit should also disable the outer
cache. Anybody know if there's something else to it?

I'm currently thinking we should call outer_clean_range
before hitting cpu_v6_proc_fin, then disable cache.

Regards,

Tony

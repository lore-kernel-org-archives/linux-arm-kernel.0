From: khilman@ti.com (Kevin Hilman)
Date: Wed, 11 Apr 2012 17:34:55 -0700
Subject: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
In-Reply-To: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Wed, 11 Apr 2012 14:04:16 +0530")
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87zkahlrdc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

While cleaning this up, you can remove it from 'struct timer_regs'  in
<plat/dmtimer.h> as well, since the code you remove is the only user.

Kevin

> ---
>  arch/arm/plat-omap/dmtimer.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 652139c..15e7882 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>  
>  static void omap_timer_restore_context(struct omap_dm_timer *timer)
>  {
> -	__raw_writel(timer->context.tiocp_cfg,
> -			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
>  	if (timer->revision == 1)
>  		__raw_writel(timer->context.tistat, timer->sys_stat);

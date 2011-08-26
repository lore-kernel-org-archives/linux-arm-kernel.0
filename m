From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 20:50:58 +0530
Subject: [PATCH v14 REPOST 06/12] OMAP: dmtimer: switch-over to platform
	device driver
In-Reply-To: <1310731501-13078-7-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E57B9DA.4070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Register timer devices by going through hwmod database using
> hwmod API. The driver probes each of the registered devices.
> Functionality which are already performed by hwmod framework
> are removed from timer code. New set of timers present on
> OMAP4 are now supported.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/timer.c               |   48 +++-
>   arch/arm/plat-omap/dmtimer.c              |  356 +++++++++--------------------
>   arch/arm/plat-omap/include/plat/dmtimer.h |   80 ++++---
>   3 files changed, 195 insertions(+), 289 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 1c1e72b..9d47300 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c

[....]

> @@ -238,23 +159,23 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
>
>   struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>   {
> -	struct omap_dm_timer *timer;
> +	struct omap_dm_timer *timer = NULL, *t;
>   	unsigned long flags;
>
>   	spin_lock_irqsave(&dm_timer_lock, flags);
> -	if (id<= 0 || id>  dm_timer_count || dm_timers[id-1].reserved) {
> -		spin_unlock_irqrestore(&dm_timer_lock, flags);
> -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> -		       __FILE__, __LINE__, __func__, id);
> -		dump_stack();
> -		return NULL;
> +	list_for_each_entry(t,&omap_timer_list, node) {
> +		if (t->pdev->id == id&&  !t->reserved) {
> +			timer = t;
> +			timer->reserved = 1;
> +			break;
> +		}
>   	}
> -
> -	timer =&dm_timers[id-1];
> -	timer->reserved = 1;
>   	spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> -	omap_dm_timer_prepare(timer);
> +	if (timer)
> +		omap_dm_timer_prepare(timer);
What if omap_dm_timer_prepare() fails?
This should be handled.


  a/arch/arm/plat-omap/include/plat/dmtimer.h 
b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 833a33b..90a504a 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -234,9 +234,7 @@ struct omap_dm_timer {

[...]

>
> @@ -289,11 +289,11 @@ static inline void __omap_dm_timer_reset(void __iomem *base, int autoidle,
>   	if (wakeup)
>   		l |= 1<<  2;
>
> -	__omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, 0);
> +	__omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, 0, func_offset);
>
>   	/* Match hardware reset default of posted mode */
> -	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG,
> -					OMAP_TIMER_CTRL_POSTED, 0);
> +	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG + func_offset,
> +					OMAP_TIMER_CTRL_POSTED, 0, func_offset);
>   }
>
>   static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
> @@ -315,54 +315,64 @@ static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
>   }
>
>   static inline void __omap_dm_timer_stop(void __iomem *base, int posted,
> -						unsigned long rate)
> +	unsigned long rate, bool is_omap2, u8 intr_offset, u8 func_offset)
>   {
>   	u32 l;
>
> -	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, posted);
> +	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG + func_offset,
> +					posted, func_offset);
As mentioned earlier, if the 'func_offset' isn't populated in
init code, these functions won't work for highlander IPs.

With above fixed, you can add my

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh


Regards
Santosh

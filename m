From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 May 2011 12:58:07 +0200
Subject: [RFC PATCH v4 09/13] ARM: msm: use remapped PPI interrupts for
	=?UTF-8?Q?local=09timer?=
In-Reply-To: <4DDFFBC9.30002@codeaurora.org>
References: <1306513671-12206-1-git-send-email-marc.zyngier@arm.com>
	<1306513671-12206-10-git-send-email-marc.zyngier@arm.com>
	<4DDFFBC9.30002@codeaurora.org>
Message-ID: <1a1e2af761ca29d8e75c9149274ced5f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 27 May 2011 12:30:17 -0700, Stephen Boyd <sboyd@codeaurora.org>
wrote:
> On 05/27/2011 09:27 AM, Marc Zyngier wrote:
>> Use the normal interrupt scheme for the local timers by using
>> a remapped PPI interrupt.
>>
>> MSM already had a very similar scheme, though still mixing both
>> GIC-specific and generic APIs.
>>
>> Fixes and ideas courtesy of Stephen Boyd.
>>
>> Cc: David Brown <davidb@codeaurora.org>
>> Cc: Daniel Walker <dwalker@fifo99.com>
>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> 
> Reviewed-and-Tested-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks Stephen.

>>  
>> +static bool local_timer_inited;
> 
> Except this is unused if SMP=n. Here's a fix:

Thanks, will apply.

> ---8<----
> 
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 186abdf..a242b89 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -84,7 +84,6 @@ enum {
>  
>  
>  static struct msm_clock msm_clocks[];
> -static bool local_timer_inited;
>  
>  static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
>  {
> @@ -259,6 +258,7 @@ int __cpuinit local_timer_setup(struct
> clock_event_device *evt)
>  {
>         struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
>         int res;
> +       static bool local_timer_inited;
>  
>         /* Use existing clock_event for cpu 0 */
>         if (!smp_processor_id())
> 
> 
> 
> ---
> 
> But now I really want to know. Why can't we use system_state ==
> SYSTEM_BOOTING? Perhaps I'm thinking ahead too much, but I'm concerned

I thought of that. Except that system_state is really what it means, an
indication of the state of the system as a whole. On startup, memory
allocation can hardly fail, even when in atomic context. On cpu hotplug,
anything can fail (as far as memory allocation is concerned).

> that if we have more than two cores we're going to have to make a percpu
> variable here just to avoid requesting the irq again. It would be
> simpler to just accept the fact that we can't boot a secondary core for
> the first time after kernel init due to the way the code is written.
> If/when we decide to allow such a thing we can revisit this code and
> make it into a percpu variable.

This is actually what I've done for TWD. And frankly, I hate it.

> Or another idea is to pass a "first_boot" flag or something to
> local_timer_setup() to indicate this is the first boot. Then we could
> extend the percpu_clockevent variable in the localtimer core to have
> this flag.
> 
> Either way it seems like something we should centralize.

Agreed. If this patch series goes in, I plan to keep track of the state at
the core level. Or at least as a generic feature of the ARM implementation
(I already have a bunch of patches to go on top of this). There are other
code paths that may need to may need to track this as well (I have a pair
of ugly hacks in the A15 code...).

Cheers,

        M.
-- 
Fast, cheap, reliable. Pick two.

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 09:52:50 +0100
Subject: [RFC] Shrink sched_clock some more
In-Reply-To: <20110922153611.GC8072@n2100.arm.linux.org.uk>
References: <20110922153611.GC8072@n2100.arm.linux.org.uk>
Message-ID: <4E7C48E2.5040907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/11 16:36, Russell King - ARM Linux wrote:
> ... by getting rid of the fixed-constant optimization, and moving the
> update code into arch/arm/kernel/sched_clock.c.
> 
> Platforms now only have to supply a function to read the sched_clock
> register, and some basic information such as the number of significant
> bits and the tick rate.

This looks similar to a patch I posted a while ago:
http://patchwork.ozlabs.org/patch/112318/

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/sched_clock.h    |   98 +--------------------------------
>  arch/arm/kernel/sched_clock.c         |   91 ++++++++++++++++++++++++++++--
>  arch/arm/mach-ixp4xx/common.c         |   15 +----
>  arch/arm/mach-mmp/time.c              |   15 +----
>  arch/arm/mach-omap1/time.c            |   27 +--------
>  arch/arm/mach-omap2/timer.c           |   21 +------
>  arch/arm/mach-pxa/time.c              |   23 +-------
>  arch/arm/mach-sa1100/time.c           |   27 +--------
>  arch/arm/mach-tegra/timer.c           |   23 +-------
>  arch/arm/mach-u300/timer.c            |   22 +------
>  arch/arm/plat-iop/time.c              |   15 +----
>  arch/arm/plat-mxc/time.c              |   15 +----
>  arch/arm/plat-nomadik/timer.c         |   25 +-------
>  arch/arm/plat-omap/counter_32k.c      |   39 +------------
>  arch/arm/plat-orion/time.c            |   16 +----
>  arch/arm/plat-s5p/s5p-time.c          |   29 +---------
>  arch/arm/plat-versatile/sched-clock.c |   26 +--------
>  17 files changed, 131 insertions(+), 396 deletions(-)

[...]

> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 9a46370..dfee812 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -14,28 +14,107 @@
> 
>  #include <asm/sched_clock.h>
> 
> +struct clock_data {
> +       u64 epoch_ns;
> +       u32 epoch_cyc;
> +       u32 epoch_cyc_copy;
> +       u32 mult;
> +       u32 shift;
> +       u32 mask;
> +};
> +
>  static void sched_clock_poll(unsigned long wrap_ticks);
>  static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
> -static void (*sched_clock_update_fn)(void);
> +static u32 (*sched_clock_read_fn)(void);
> +static struct clock_data sched_clock_data;
> +
> +static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> +{
> +       return (cyc * mult) >> shift;
> +}
> +
> +/*
> + * Atomically update the sched_clock epoch.  Your update callback will
> + * be called from a timer before the counter wraps - read the current
> + * counter value, and call this function to safely move the epochs
> + * forward.  Only use this from the update callback.
> + */
> +static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
> +{
> +       unsigned long flags;
> +       u64 ns = cd->epoch_ns +
> +               cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
> +
> +       /*
> +        * Write epoch_cyc and epoch_ns in a way that the update is
> +        * detectable in cyc_to_sched_clock().
> +        */
> +       raw_local_irq_save(flags);
> +       cd->epoch_cyc = cyc;
> +       smp_wmb();
> +       cd->epoch_ns = ns;
> +       smp_wmb();
> +       cd->epoch_cyc_copy = cyc;
> +       raw_local_irq_restore(flags);
> +}
> +
> +static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
> +       u32 cyc, u32 mask)
> +{
> +       u64 epoch_ns;
> +       u32 epoch_cyc;
> +
> +       /*
> +        * Load the epoch_cyc and epoch_ns atomically.  We do this by
> +        * ensuring that we always write epoch_cyc, epoch_ns and
> +        * epoch_cyc_copy in strict order, and read them in strict order.
> +        * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
> +        * the middle of an update, and we should repeat the load.
> +        */
> +       do {
> +               epoch_cyc = cd->epoch_cyc;
> +               smp_rmb();
> +               epoch_ns = cd->epoch_ns;
> +               smp_rmb();
> +       } while (epoch_cyc != cd->epoch_cyc_copy);
> +
> +       return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask,
> +                       cd->mult, cd->shift);
> +}
> 
>  static void sched_clock_poll(unsigned long wrap_ticks)
>  {
> +       struct clock_data *cd = &sched_clock_data;
>         mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
> -       sched_clock_update_fn();
> +       update_sched_clock(cd, sched_clock_read_fn(), cd->mask);
>  }
> 
> -void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
> +unsigned long long notrace sched_clock(void)
> +{
> +       struct clock_data *cd = &sched_clock_data;
> +       u32 cyc = 0;
> +
> +       if (sched_clock_read_fn)
> +               cyc = sched_clock_read_fn();

In my patch, I tried to avoid having to test the validity of
sched_clock_read_fn by providing a default jiffy based read function (as
suggested by Nicolas). Could we do something similar here?

It otherwise looks good to me.

	M.
-- 
Jazz is not dead. It just smells funny...

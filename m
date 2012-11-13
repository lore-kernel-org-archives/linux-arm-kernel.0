From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 13 Nov 2012 17:17:45 +0000
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
Message-ID: <20121113171745.GA6370@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 04:08:14PM +0000, Etienne CARRIERE wrote:
> From: Etienne Carriere <etienne.carriere@stericsson.com>
> 
>  
> 
> Secure code in TrustZone space may need to perform L2 cache
> 
> maintenance operations. A shared mutex is required to synchronize
> 
> linux l2cc maintenance and TZ l2cc maintenance.

1) Why is this not a denial-of-service risk?  (i.e., why can the Normal
World not simply hold the mutex forever?)

2) The memory types on both sides have to be _exactly_ the same, not
just "cached", otherwise unpredictable behaviour may occur when accessing
the mutex.  It is not obvious how this is ensured.

3) Many people seem to delegate L2 cache maintenence requests via SMC
in these situations.  Can you do that instead?


Cheers
---Dave

> The TZ mutex is an "arch_spinlock": a 32bit DDR cell (ARMv7-A mutex).
> 
> Linux L2 cache driver must lock TZ mutex if enabled.
> 
>  
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@stericsson.com>
> 
> ---
> 
> arch/arm/include/asm/outercache.h |  9 ++++
> 
> arch/arm/mm/cache-l2x0.c          | 87 +++++++++++++++++++++++++++++----------
> 
> 2 files changed, 74 insertions(+), 22 deletions(-)
> 
>  
> 
> diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/
> outercache.h
> 
> index 53426c6..7aa5eac 100644
> 
> --- a/arch/arm/include/asm/outercache.h
> 
> +++ b/arch/arm/include/asm/outercache.h
> 
> @@ -35,6 +35,7 @@ struct outer_cache_fns {
> 
> #endif
> 
>                void (*set_debug)(unsigned long);
> 
>                void (*resume)(void);
> 
> +             bool (*tz_mutex)(unsigned long);
> 
> };
> 
>  #ifdef CONFIG_OUTER_CACHE
> 
> @@ -81,6 +82,13 @@ static inline void outer_resume(void)
> 
>                                outer_cache.resume();
> 
> }
> 
> +static inline bool outer_tz_mutex(unsigned long addr)
> 
> +{
> 
> +             if (outer_cache.tz_mutex)
> 
> +                             return outer_cache.tz_mutex(addr);
> 
> +             return false;
> 
> +}
> 
> +
> 
> #else
> 
>  static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
> 
> @@ -92,6 +100,7 @@ static inline void outer_flush_range(phys_addr_t start,
> phys_addr_t end)
> 
> static inline void outer_flush_all(void) { }
> 
> static inline void outer_inv_all(void) { }
> 
> static inline void outer_disable(void) { }
> 
> +static inline bool outer_tz_mutex(unsigned long addr) { return false; }
> 
>  #endif
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> 
> index a53fd2a..eacdc74 100644
> 
> --- a/arch/arm/mm/cache-l2x0.c
> 
> +++ b/arch/arm/mm/cache-l2x0.c
> 
> @@ -41,6 +41,26 @@ struct l2x0_of_data {
> 
>                void (*resume)(void);
> 
> };
> 
> +/*
> 
> + * arch_spinlock (single 32bit DDR mutex cell) pointer to synchronise
> 
> + * L2CC maintenance between linux world and secure world (ARM TZ).
> 
> + */
> 
> +arch_spinlock_t *l2x0_tz_mutex;
> 
> +
> 
> +#define l2x0_spin_lock_irqsave(flags) \
> 
> +             do
> {                                                                                                       
> \
> 
> +                             raw_spin_lock_irqsave(&l2x0_lock, flags);
>            \
> 
> +                             if (l2x0_tz_mutex)
>                                                            \
> 
> +                                             arch_spin_lock(l2x0_tz_mutex);
>                                \
> 
> +             } while (0)
> 
> +
> 
> +#define l2x0_spin_unlock_irqrestore(flags) \
> 
> +             do
> {                                                                                                       
> \
> 
> +                             if (l2x0_tz_mutex)
>                                                            \
> 
> +                                             arch_spin_unlock(l2x0_tz_mutex);
>          \
> 
> +                             raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>                 \
> 
> +             } while (0)
> 
> +
> 
> static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
> 
> {
> 
>                /* wait for cache operation by line or way to complete */
> 
> @@ -126,9 +146,9 @@ static void l2x0_cache_sync(void)
> 
> {
> 
>                unsigned long flags;
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void __l2x0_flush_all(void)
> 
> @@ -145,9 +165,9 @@ static void l2x0_flush_all(void)
> 
>                unsigned long flags;
> 
>                 /* clean all ways */
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                __l2x0_flush_all();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_clean_all(void)
> 
> @@ -155,11 +175,11 @@ static void l2x0_clean_all(void)
> 
>                unsigned long flags;
> 
>                 /* clean all ways */
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
> 
>                cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_inv_all(void)
> 
> @@ -167,13 +187,13 @@ static void l2x0_inv_all(void)
> 
>                unsigned long flags;
> 
>                 /* invalidate all ways */
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                /* Invalidating when L2 is enabled is a nono */
> 
>                BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);
> 
>                writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
> 
>                cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_inv_range(unsigned long start, unsigned long end)
> 
> @@ -181,7 +201,7 @@ static void l2x0_inv_range(unsigned long start, unsigned
> long end)
> 
>                void __iomem *base = l2x0_base;
> 
>                unsigned long flags;
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                if (start & (CACHE_LINE_SIZE - 1)) {
> 
>                                start &= ~(CACHE_LINE_SIZE - 1);
> 
>                                debug_writel(0x03);
> 
> @@ -206,13 +226,13 @@ static void l2x0_inv_range(unsigned long start, unsigned
> long end)
> 
>                                }
> 
>                                 if (blk_end < end) {
> 
> -                                              raw_spin_unlock_irqrestore(&
> l2x0_lock, flags);
> 
> -                                              raw_spin_lock_irqsave(&
> l2x0_lock, flags);
> 
> +                                             l2x0_spin_unlock_irqrestore
> (flags);
> 
> +                                             l2x0_spin_lock_irqsave(flags);
> 
>                                }
> 
>                }
> 
>                cache_wait(base + L2X0_INV_LINE_PA, 1);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_clean_range(unsigned long start, unsigned long end)
> 
> @@ -225,7 +245,7 @@ static void l2x0_clean_range(unsigned long start, unsigned
> long end)
> 
>                                return;
> 
>                }
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                start &= ~(CACHE_LINE_SIZE - 1);
> 
>                while (start < end) {
> 
>                                unsigned long blk_end = start + min(end - start,
> 4096UL);
> 
> @@ -236,13 +256,13 @@ static void l2x0_clean_range(unsigned long start,
> unsigned long end)
> 
>                                }
> 
>                                 if (blk_end < end) {
> 
> -                                              raw_spin_unlock_irqrestore(&
> l2x0_lock, flags);
> 
> -                                              raw_spin_lock_irqsave(&
> l2x0_lock, flags);
> 
> +                                             l2x0_spin_unlock_irqrestore
> (flags);
> 
> +                                             l2x0_spin_lock_irqsave(flags);
> 
>                                }
> 
>                }
> 
>                cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_flush_range(unsigned long start, unsigned long end)
> 
> @@ -255,7 +275,7 @@ static void l2x0_flush_range(unsigned long start, unsigned
> long end)
> 
>                                return;
> 
>                }
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                start &= ~(CACHE_LINE_SIZE - 1);
> 
>                while (start < end) {
> 
>                                unsigned long blk_end = start + min(end - start,
> 4096UL);
> 
> @@ -268,24 +288,24 @@ static void l2x0_flush_range(unsigned long start,
> unsigned long end)
> 
>                                debug_writel(0x00);
> 
>                                 if (blk_end < end) {
> 
> -                                              raw_spin_unlock_irqrestore(&
> l2x0_lock, flags);
> 
> -                                              raw_spin_lock_irqsave(&
> l2x0_lock, flags);
> 
> +                                             l2x0_spin_unlock_irqrestore
> (flags);
> 
> +                                             l2x0_spin_lock_irqsave(flags);
> 
>                                }
> 
>                }
> 
>                cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> 
>                cache_sync();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_disable(void)
> 
> {
> 
>                unsigned long flags;
> 
> -              raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +             l2x0_spin_lock_irqsave(flags);
> 
>                __l2x0_flush_all();
> 
>                writel_relaxed(0, l2x0_base + L2X0_CTRL);
> 
>                dsb();
> 
> -              raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             l2x0_spin_unlock_irqrestore(flags);
> 
> }
> 
>  static void l2x0_unlock(u32 cache_id)
> 
> @@ -307,6 +327,28 @@ static void l2x0_unlock(u32 cache_id)
> 
>                }
> 
> }
> 
> +/* Enable/disable external mutex shared with TZ code */
> 
> +static bool l2x0_tz_mutex_cfg(unsigned long addr)
> 
> +{
> 
> +             unsigned long flags;
> 
> +
> 
> +             raw_spin_lock_irqsave(&l2x0_lock, flags);
> 
> +
> 
> +             if (addr && l2x0_tz_mutex && (addr != (uint)l2x0_tz_mutex)) {
> 
> +                             raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +                             pr_err("%s: a TZ mutex is already enabled\n",
> __func__);
> 
> +                             return false;
> 
> +             }
> 
> +
> 
> +             l2x0_tz_mutex = (arch_spinlock_t *)addr;
> 
> +             /* insure mutex ptr is updated before lock is released */
> 
> +             smp_wmb();
> 
> +
> 
> +             raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> +             pr_debug("\n%s: %sable TZ mutex\n\n", __func__, (addr) ? "en" :
> "dis");
> 
> +             return true;
> 
> +}
> 
> +
> 
> void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
> 
> {
> 
>                u32 aux;
> 
> @@ -380,6 +422,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32
> aux_mask)
> 
>                outer_cache.inv_all = l2x0_inv_all;
> 
>                outer_cache.disable = l2x0_disable;
> 
>                outer_cache.set_debug = l2x0_set_debug;
> 
> +             outer_cache.tz_mutex = l2x0_tz_mutex_cfg;
> 
>                 printk(KERN_INFO "%s cache controller enabled\n", type);
> 
>                printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL
> 0x%08x, Cache size: %d B\n",
> 
>  
> 
> --
> 
> 1.7.11.3
> 
>  
> 

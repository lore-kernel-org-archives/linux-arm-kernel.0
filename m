From: slash.tmp@free.fr (Mason)
Date: Wed, 01 Apr 2015 13:42:55 +0200
Subject: Cache line size definition in arch/arm/mm/Kconfig
In-Reply-To: <55155EE9.6020600@free.fr>
References: <5512C7A4.3000302@free.fr> <5515423E.4020802@free.fr>
 <20150327120601.GB4019@n2100.arm.linux.org.uk> <55155EE9.6020600@free.fr>
Message-ID: <551BD9BF.8090808@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/2015 14:45, Mason wrote:

> arch/arm/mm/Kconfig
>
> config ARM_L1_CACHE_SHIFT_6
>      bool
>      default y if CPU_V7
>      help
>        Setting ARM L1 cache line size to 64 Bytes.
>
> config ARM_L1_CACHE_SHIFT
>      int
>      default 6 if ARM_L1_CACHE_SHIFT_6
>      default 5
>
> I don't understand why I should not override ARM_L1_CACHE_SHIFT to 5
> in my platform-specific Kconfig, since I know I have a 32-byte cache
> line size?

[large snip]

It seems to me it would make sense to override ARM_L1_CACHE_SHIFT in
the platform Kconfig. Or am I missing something obvious? (Perhaps it
is expected that the gains would be minimal?)

ARM_L1_CACHE_SHIFT = 6
   2 .rodata       0008ea58  c026a000  c026a000  0026a000  2**6
  20 .data         00027aa0  c033a000  c033a000  0034a000  2**6

ARM_L1_CACHE_SHIFT = 5
   2 .rodata       0008e608  c026b000  c026b000  0026b000  2**5
  20 .data         000252c0  c033a000  c033a000  0034a000  2**5

  1104 bytes saved in .rodata (0.2%)
10208 bytes saved in   .data (6.3%)

This is for a minimal kernel (no drivers, only core).
The space optimization seems to be not insignificant.

> Oh and while I have your attention ;-) I have alignment-related
> questions about clocksource_mmio_init() (commit 442c8176d2) wrt
> Thomas Gleixner's 369db4c952 patch. (I think the two patches
> do not play nice.)
>
> 369db4c952 moved some struct clocksource fields around to group
> hot fields in a single cache line at the beginning of the struct,
> and marked the struct as cache aligned. This works as expected
> with static structures.

Example patch for illustration purposes (only compile-tested)

(There is probably a much more elegant way to get 32-byte aligned
memory allocations.)

Regards.


diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index c0e2512..77b91c5 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -10,34 +10,24 @@
  #include <linux/init.h>
  #include <linux/slab.h>
  
-struct clocksource_mmio {
-       void __iomem *reg;
-       struct clocksource clksrc;
-};
-
-static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
-{
-       return container_of(c, struct clocksource_mmio, clksrc);
-}
-
  cycle_t clocksource_mmio_readl_up(struct clocksource *c)
  {
-       return readl_relaxed(to_mmio_clksrc(c)->reg);
+       return readl_relaxed(c->reg);
  }
  
  cycle_t clocksource_mmio_readl_down(struct clocksource *c)
  {
-       return ~readl_relaxed(to_mmio_clksrc(c)->reg);
+       return ~readl_relaxed(c->reg);
  }
  
  cycle_t clocksource_mmio_readw_up(struct clocksource *c)
  {
-       return readw_relaxed(to_mmio_clksrc(c)->reg);
+       return readw_relaxed(c->reg);
  }
  
  cycle_t clocksource_mmio_readw_down(struct clocksource *c)
  {
-       return ~(unsigned)readw_relaxed(to_mmio_clksrc(c)->reg);
+       return ~(unsigned)readw_relaxed(c->reg);
  }
  
  /**
@@ -53,21 +43,22 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
         unsigned long hz, int rating, unsigned bits,
         cycle_t (*read)(struct clocksource *))
  {
-       struct clocksource_mmio *cs;
+       struct clocksource *cs;
  
         if (bits > 32 || bits < 16)
                 return -EINVAL;
  
-       cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);
+       cs = kzalloc(sizeof *cs + 31, GFP_KERNEL);
         if (!cs)
                 return -ENOMEM;
+       cs = PTR_ALIGN(cs, 32);
  
         cs->reg = base;
-       cs->clksrc.name = name;
-       cs->clksrc.rating = rating;
-       cs->clksrc.read = read;
-       cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
-       cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+       cs->name = name;
+       cs->rating = rating;
+       cs->read = read;
+       cs->mask = CLOCKSOURCE_MASK(bits);
+       cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
  
-       return clocksource_register_hz(&cs->clksrc, hz);
+       return clocksource_register_hz(cs, hz);
  }
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 879065d..8b1d689 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -189,6 +189,9 @@ struct clocksource {
         unsigned long flags;
         void (*suspend)(struct clocksource *cs);
         void (*resume)(struct clocksource *cs);
+#ifdef CONFIG_CLKSRC_MMIO
+       void __iomem *reg;
+#endif
  
         /* private: */
  #ifdef CONFIG_CLOCKSOURCE_WATCHDOG

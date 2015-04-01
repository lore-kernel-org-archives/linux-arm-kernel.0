From: slash.tmp@free.fr (Mason)
Date: Wed, 01 Apr 2015 16:06:47 +0200
Subject: Cache line size definition in arch/arm/mm/Kconfig
In-Reply-To: <20150401115013.GA24899@n2100.arm.linux.org.uk>
References: <5512C7A4.3000302@free.fr> <5515423E.4020802@free.fr>
 <20150327120601.GB4019@n2100.arm.linux.org.uk> <55155EE9.6020600@free.fr>
 <551BD9BF.8090808@free.fr> <20150401115013.GA24899@n2100.arm.linux.org.uk>
Message-ID: <551BFB77.50403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2015 13:50, Russell King - ARM Linux wrote:
> On Wed, Apr 01, 2015 at 01:42:55PM +0200, Mason wrote:
>> Example patch for illustration purposes (only compile-tested)
>>
>> (There is probably a much more elegant way to get 32-byte aligned
>> memory allocations.)
>>
>> diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
>> index c0e2512..77b91c5 100644
>> --- a/drivers/clocksource/mmio.c
>> +++ b/drivers/clocksource/mmio.c
>> @@ -10,34 +10,24 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>> -struct clocksource_mmio {
>> -       void __iomem *reg;
>> -       struct clocksource clksrc;
>
> Just swap the order of these.

(Assuming arm32 && ARM_L1_CACHE_SHIFT = 6)

Because struct clocksource has attribute ____cacheline_aligned,
sizeof(struct clocksource) = 128

Thus the layout for
struct { void __iomem *reg; struct clocksource clksrc; }
would be
reg(4) pad1(60) clksrc(80) pad2(48)

and the layout for
struct { struct clocksource clksrc; void __iomem *reg; }
would be
clksrc(80) pad2(48) reg(4) pad1(60)

If kmalloc returns  32-byte aligned pointer (which seems to be
the case) then clksrc is correctly aligned in both cases.

The reason for stuffing reg inside struct clocksource would be
to avoid the 64-byte overhead from the padding. Also (but this
only a matter of taste) it seems the code is marginally clearer
without the "container_of" gymnastics.

Regards.


diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index c0e2512..d6583ed 100644
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
@@ -53,21 +43,21 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
         unsigned long hz, int rating, unsigned bits,
         cycle_t (*read)(struct clocksource *))
  {
-       struct clocksource_mmio *cs;
+       struct clocksource *cs;
  
         if (bits > 32 || bits < 16)
                 return -EINVAL;
  
-       cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);
+       cs = kzalloc(sizeof *cs, GFP_KERNEL);
         if (!cs)
                 return -ENOMEM;
  
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
index 879065d..9fdb5cf 100644
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

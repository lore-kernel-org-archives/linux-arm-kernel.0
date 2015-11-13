From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 13 Nov 2015 13:20:48 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5645D5A0.1000502@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2015 11:58, Daniel Lezcano wrote:

> The current code to initialize, register and read the clocksource is
> already factored out in mmio.c via the clocksource_mmio_init function.
> 
> Factor out the code with the clocksource_mmio_init function.

The reason I didn't like clocksource_mmio_init() is because it exports
4 generic accessors.

I guess this function makes more sense when all platforms are using it,
in an ARCH_MULTIPLATFORM kernel. (Also the accessors are probably quite
small, so the waste is probably minimal.)

In my opinion, defining struct clocksource_mmio with reg "outside"
struct clocksource leads to less efficient(1) and less clear(2) code.
1) because of the padding from ____cacheline_aligned
2) because of the container_of() gymnastics

I tried discussing this in March, but it didn't go anywhere.
Lemme brush up the patch.

Should the reg field be considered "hot-path data"?

One problem with my patch: if some ports define CLKSRC_MMIO but
have lots of static struct clocksource, the extra reg field might
waste memory / worsen cache locality?

Also, maybe the fields should be copied in ascending order?

Regards.



diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index 1593ade2a815..aba5f24ba346 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -10,34 +10,24 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
-struct clocksource_mmio {
-	void __iomem *reg;
-	struct clocksource clksrc;
-};
-
-static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
-{
-	return container_of(c, struct clocksource_mmio, clksrc);
-}
-
 cycle_t clocksource_mmio_readl_up(struct clocksource *c)
 {
-	return (cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg);
+	return (cycle_t)readl_relaxed(c->reg);
 }
 
 cycle_t clocksource_mmio_readl_down(struct clocksource *c)
 {
-	return ~(cycle_t)readl_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
+	return ~(cycle_t)readl_relaxed(c->reg) & c->mask;
 }
 
 cycle_t clocksource_mmio_readw_up(struct clocksource *c)
 {
-	return (cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg);
+	return (cycle_t)readw_relaxed(c->reg);
 }
 
 cycle_t clocksource_mmio_readw_down(struct clocksource *c)
 {
-	return ~(cycle_t)readw_relaxed(to_mmio_clksrc(c)->reg) & c->mask;
+	return ~(cycle_t)readw_relaxed(c->reg) & c->mask;
 }
 
 /**
@@ -53,21 +43,21 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
 	unsigned long hz, int rating, unsigned bits,
 	cycle_t (*read)(struct clocksource *))
 {
-	struct clocksource_mmio *cs;
+	struct clocksource *cs;
 
 	if (bits > 32 || bits < 16)
 		return -EINVAL;
 
-	cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);
+	cs = kzalloc(sizeof *cs, GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
 
 	cs->reg = base;
-	cs->clksrc.name = name;
-	cs->clksrc.rating = rating;
-	cs->clksrc.read = read;
-	cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
-	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->name = name;
+	cs->rating = rating;
+	cs->read = read;
+	cs->mask = CLOCKSOURCE_MASK(bits);
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
-	return clocksource_register_hz(&cs->clksrc, hz);
+	return clocksource_register_hz(cs, hz);
 }
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 278dd279a7a8..03807ca0d54e 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -74,6 +74,9 @@ struct clocksource {
 	u32 shift;
 	u64 max_idle_ns;
 	u32 maxadj;
+#ifdef CONFIG_CLKSRC_MMIO
+	void __iomem *reg;
+#endif
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif

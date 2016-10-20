From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 20 Oct 2016 22:11:52 +0200 (CEST)
Subject: [PATCH] Revert "clocksource/drivers/timer_sun5i: Replace code
 by clocksource_mmio_init"
In-Reply-To: <20161018054918.26855-1-wens@csie.org>
References: <20161018054918.26855-1-wens@csie.org>
Message-ID: <alpine.DEB.2.20.1610202159240.4938@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016, Chen-Yu Tsai wrote:
> Revert the commit for now. clocksource_mmio_init can be made to pass back
> a pointer, but the code churn and usage of an inner struct might not be
> worth it.

You can avoid the churn by making clocksurce_mmio_init() a wrapper around a
new function, which takes a pointer to a struct clocksource_mmio as
argument so you can hand in the structure you need: Something like the
patch below should do the trick.

Thanks,

	tglx

8<--------------------------------
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -10,11 +10,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
-struct clocksource_mmio {
-	void __iomem *reg;
-	struct clocksource clksrc;
-};
-
 static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
 {
 	return container_of(c, struct clocksource_mmio, clksrc);
@@ -41,6 +36,27 @@ cycle_t clocksource_mmio_readw_down(stru
 }
 
 /**
+ * FIXME: Add doc
+ */
+int __init clocksource_mmio_setup(struct clocksource_mmio *cs,
+				  void __iomem *base , const char *name,
+				  unsigned long hz , int rating, unsigned bits,
+				  cycle_t (*read)(struct clocksource *))
+{
+	if (bits > 64 || bits < 16)
+		return -EINVAL;
+
+	cs->reg = base;
+	cs->clksrc.name = name;
+	cs->clksrc.rating = rating;
+	cs->clksrc.read = read;
+	cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
+	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&cs->clksrc, hz);
+}
+
+/**
  * clocksource_mmio_init - Initialize a simple mmio based clocksource
  * @base:	Virtual address of the clock readout register
  * @name:	Name of the clocksource
@@ -62,12 +78,5 @@ int __init clocksource_mmio_init(void __
 	if (!cs)
 		return -ENOMEM;
 
-	cs->reg = base;
-	cs->clksrc.name = name;
-	cs->clksrc.rating = rating;
-	cs->clksrc.read = read;
-	cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
-	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-
-	return clocksource_register_hz(&cs->clksrc, hz);
+	return clocksource_mmio_setup(cs, base, name, hz, rating, bits, read);
 }
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -119,6 +119,14 @@ struct clocksource {
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
 
+/**
+ * FIXME: Add doc
+ */
+struct clocksource_mmio {
+	void __iomem		*reg;
+	struct clocksource	clksrc;
+};
+
 static inline u32 clocksource_freq2mult(u32 freq, u32 shift_constant, u64 from)
 {
 	/*  freq = cyc/from
@@ -241,6 +249,11 @@ extern cycle_t clocksource_mmio_readw_do
 extern int clocksource_mmio_init(void __iomem *, const char *,
 	unsigned long, int, unsigned, cycle_t (*)(struct clocksource *));
 
+extern int clocksource_mmio_setup(struct clocksource_mmio *,
+				  void __iomem *, const char *,
+				  unsigned long, int, unsigned,
+				  cycle_t (*)(struct clocksource *));
+
 extern int clocksource_i8253_init(void);
 
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \

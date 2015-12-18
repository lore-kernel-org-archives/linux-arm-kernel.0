From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:08 +0100
Subject: [PATCH 55/69] h8300: Rename ctlr_out/in[bwl] to raw_read/write[bwl]
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-55-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the sake of consistency, let rename all ctrl_out/in calls to the write/read
calls so we have the same API consistent with the other architectures hence
open the door for the increasing of the test compilation coverage.

The unsigned long coercive cast is removed because all variables are set to
the right type "void __iomem *".

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/h8300/include/asm/io.h          | 39 +++++++++++++++++++++---------------
 arch/h8300/kernel/setup.c            |  8 ++++----
 drivers/clocksource/h8300_timer16.c  | 28 +++++++++++++-------------
 drivers/clocksource/h8300_timer8.c   | 34 +++++++++++++++----------------
 drivers/clocksource/h8300_tpu.c      | 28 +++++++++++++-------------
 drivers/irqchip/irq-renesas-h8300h.c |  8 ++++----
 6 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/arch/h8300/include/asm/io.h b/arch/h8300/include/asm/io.h
index bb837cd..f0e14f3 100644
--- a/arch/h8300/include/asm/io.h
+++ b/arch/h8300/include/asm/io.h
@@ -3,40 +3,45 @@
 
 #ifdef __KERNEL__
 
-#include <asm-generic/io.h>
-
 /* H8/300 internal I/O functions */
-static inline unsigned char ctrl_inb(unsigned long addr)
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
-	return *(volatile unsigned char *)addr;
+	return *(volatile u8 *)addr;
 }
 
-static inline unsigned short ctrl_inw(unsigned long addr)
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
-	return *(volatile unsigned short *)addr;
+	return *(volatile u16 *)addr;
 }
 
-static inline unsigned long ctrl_inl(unsigned long addr)
+#define __raw_readl __raw_readl
+static inline u32  __raw_readl(const volatile void __iomem *addr)
 {
-	return *(volatile unsigned long *)addr;
+	return *(volatile u32 *)addr;
 }
 
-static inline void ctrl_outb(unsigned char b, unsigned long addr)
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 b, const volatile void __iomem *addr)
 {
-	*(volatile unsigned char *)addr = b;
+	*(volatile u8 *)addr = b;
 }
 
-static inline void ctrl_outw(unsigned short b, unsigned long addr)
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 b, const volatile void __iomem *addr)
 {
-	*(volatile unsigned short *)addr = b;
+	*(volatile u16 *)addr = b;
 }
 
-static inline void ctrl_outl(unsigned long b, unsigned long addr)
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 b, const volatile void __iomem *addr)
 {
-	*(volatile unsigned long *)addr = b;
+	*(volatile u32 *)addr = b;
 }
 
-static inline void ctrl_bclr(int b, unsigned char *addr)
+static inline void ctrl_bclr(int b, void __iomem *addr)
 {
 	if (__builtin_constant_p(b))
 		__asm__("bclr %1,%0" : "+WU"(*addr): "i"(b));
@@ -44,7 +49,7 @@ static inline void ctrl_bclr(int b, unsigned char *addr)
 		__asm__("bclr %w1,%0" : "+WU"(*addr): "r"(b));
 }
 
-static inline void ctrl_bset(int b, unsigned char *addr)
+static inline void ctrl_bset(int b, void __iomem *addr)
 {
 	if (__builtin_constant_p(b))
 		__asm__("bset %1,%0" : "+WU"(*addr): "i"(b));
@@ -52,6 +57,8 @@ static inline void ctrl_bset(int b, unsigned char *addr)
 		__asm__("bset %w1,%0" : "+WU"(*addr): "r"(b));
 }
 
+#include <asm-generic/io.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _H8300_IO_H */
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index c772abe..e4985df 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -207,14 +207,14 @@ device_initcall(device_probe);
 #define get_wait(base, addr) ({		\
 	int baddr;			\
 	baddr = ((addr) / 0x200000 * 2);			     \
-	w *= (ctrl_inw((unsigned long)(base) + 2) & (3 << baddr)) + 1;	\
+	w *= (readw((base) + 2) & (3 << baddr)) + 1;		     \
 	})
 #endif
 #if defined(CONFIG_CPU_H8S)
 #define get_wait(base, addr) ({		\
 	int baddr;			\
 	baddr = ((addr) / 0x200000 * 16);			     \
-	w *= (ctrl_inl((unsigned long)(base) + 2) & (7 << baddr)) + 1;	\
+	w *= (readl((base) + 2) & (7 << baddr)) + 1;	\
 	})
 #endif
 
@@ -228,8 +228,8 @@ static __init int access_timing(void)
 
 	bsc = of_find_compatible_node(NULL, NULL, "renesas,h8300-bsc");
 	base = of_iomap(bsc, 0);
-	w = (ctrl_inb((unsigned long)base + 0) & bit)?2:1;
-	if (ctrl_inb((unsigned long)base + 1) & bit)
+	w = (readb(base + 0) & bit)?2:1;
+	if (readb(base + 1) & bit)
 		w *= get_wait(base, addr);
 	else
 		w *= 2;
diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index f396605..fc14a3f 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -23,8 +23,8 @@
 struct timer16_priv {
 	struct clocksource cs;
 	unsigned long total_cycles;
-	unsigned long mapbase;
-	unsigned long mapcommon;
+	void __iomem *mapbase;
+	void __iomem *mapcommon;
 	unsigned short cs_enabled;
 	unsigned char enb;
 	unsigned char imfa;
@@ -38,15 +38,15 @@ static unsigned long timer16_get_counter(struct timer16_priv *p)
 	unsigned long v1, v2, v3;
 	int o1, o2;
 
-	o1 = ctrl_inb(p->mapcommon + TISRC) & p->ovf;
+	o1 = readb(p->mapcommon + TISRC) & p->ovf;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
 		o2 = o1;
-		v1 = ctrl_inw(p->mapbase + TCNT);
-		v2 = ctrl_inw(p->mapbase + TCNT);
-		v3 = ctrl_inw(p->mapbase + TCNT);
-		o1 = ctrl_inb(p->mapcommon + TISRC) & p->ovf;
+		v1 = readw(p->mapbase + TCNT);
+		v2 = readw(p->mapbase + TCNT);
+		v3 = readw(p->mapbase + TCNT);
+		o1 = readb(p->mapcommon + TISRC) & p->ovf;
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
@@ -59,7 +59,7 @@ static irqreturn_t timer16_interrupt(int irq, void *dev_id)
 {
 	struct timer16_priv *p = (struct timer16_priv *)dev_id;
 
-	ctrl_outb(ctrl_inb(p->mapcommon + TISRA) & ~p->imfa,
+	writeb(readb(p->mapcommon + TISRA) & ~p->imfa,
 		  p->mapcommon + TISRA);
 	p->total_cycles += 0x10000;
 
@@ -89,9 +89,9 @@ static int timer16_enable(struct clocksource *cs)
 	WARN_ON(p->cs_enabled);
 
 	p->total_cycles = 0;
-	ctrl_outw(0x0000, p->mapbase + TCNT);
-	ctrl_outb(0x83, p->mapbase + TCR);
-	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) | p->enb,
+	writew(0x0000, p->mapbase + TCNT);
+	writeb(0x83, p->mapbase + TCR);
+	writeb(readb(p->mapcommon + TSTR) | p->enb,
 		  p->mapcommon + TSTR);
 
 	p->cs_enabled = true;
@@ -104,7 +104,7 @@ static void timer16_disable(struct clocksource *cs)
 
 	WARN_ON(!p->cs_enabled);
 
-	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) & ~p->enb,
+	writeb(readb(p->mapcommon + TSTR) & ~p->enb,
 		  p->mapcommon + TSTR);
 
 	p->cs_enabled = false;
@@ -158,8 +158,8 @@ static void __init h8300_16timer_init(struct device_node *node)
 
 	of_property_read_u32(node, "renesas,channel", &ch);
 
-	timer16_priv.mapbase = (unsigned long)base[REG_CH];
-	timer16_priv.mapcommon = (unsigned long)base[REG_COMM];
+	timer16_priv.mapbase = base[REG_CH];
+	timer16_priv.mapcommon = base[REG_COMM];
 	timer16_priv.enb = 1 << ch;
 	timer16_priv.imfa = 1 << ch;
 	timer16_priv.imiea = 1 << (4 + ch);
diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 187c416..aa4b2a98 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -30,7 +30,7 @@
 
 struct timer8_priv {
 	struct clock_event_device ced;
-	unsigned long mapbase;
+	void __iomem *mapbase;
 	unsigned long flags;
 	unsigned int rate;
 	unsigned int tcora;
@@ -41,15 +41,15 @@ static unsigned long timer8_get_counter(struct timer8_priv *p)
 	unsigned long v1, v2, v3;
 	int o1, o2;
 
-	o1 = ctrl_inb(p->mapbase + _8TCSR) & 0x20;
+	o1 = readb(p->mapbase + _8TCSR) & 0x20;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
 		o2 = o1;
-		v1 = ctrl_inw(p->mapbase + _8TCNT);
-		v2 = ctrl_inw(p->mapbase + _8TCNT);
-		v3 = ctrl_inw(p->mapbase + _8TCNT);
-		o1 = ctrl_inb(p->mapbase + _8TCSR) & 0x20;
+		v1 = readw(p->mapbase + _8TCNT);
+		v2 = readw(p->mapbase + _8TCNT);
+		v3 = readw(p->mapbase + _8TCNT);
+		o1 = readb(p->mapbase + _8TCSR) & 0x20;
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
@@ -61,13 +61,13 @@ static irqreturn_t timer8_interrupt(int irq, void *dev_id)
 {
 	struct timer8_priv *p = dev_id;
 
-	ctrl_outb(ctrl_inb(p->mapbase + _8TCSR) & ~0x40,
+	writeb(readb(p->mapbase + _8TCSR) & ~0x40,
 		  p->mapbase + _8TCSR);
 
-	ctrl_outw(p->tcora, p->mapbase + TCORA);
+	writew(p->tcora, p->mapbase + TCORA);
 
 	if (clockevent_state_oneshot(&p->ced))
-		ctrl_outw(0x0000, p->mapbase + _8TCR);
+		writew(0x0000, p->mapbase + _8TCR);
 
 	p->ced.event_handler(&p->ced);
 
@@ -82,18 +82,18 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 		pr_warn("delta out of range\n");
 	now = timer8_get_counter(p);
 	p->tcora = delta;
-	ctrl_outb(ctrl_inb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
+	writeb(readb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
 	if (delta > now)
-		ctrl_outw(delta, p->mapbase + TCORA);
+		writew(delta, p->mapbase + TCORA);
 	else
-		ctrl_outw(now + 1, p->mapbase + TCORA);
+		writew(now + 1, p->mapbase + TCORA);
 }
 
 static int timer8_enable(struct timer8_priv *p)
 {
-	ctrl_outw(0xffff, p->mapbase + TCORA);
-	ctrl_outw(0x0000, p->mapbase + _8TCNT);
-	ctrl_outw(0x0c02, p->mapbase + _8TCR);
+	writew(0xffff, p->mapbase + TCORA);
+	writew(0x0000, p->mapbase + _8TCNT);
+	writew(0x0c02, p->mapbase + _8TCR);
 
 	return 0;
 }
@@ -114,7 +114,7 @@ static int timer8_start(struct timer8_priv *p)
 
 static void timer8_stop(struct timer8_priv *p)
 {
-	ctrl_outw(0x0000, p->mapbase + _8TCR);
+	writew(0x0000, p->mapbase + _8TCR);
 }
 
 static inline struct timer8_priv *ced_to_priv(struct clock_event_device *ced)
@@ -213,7 +213,7 @@ static void __init h8300_8timer_init(struct device_node *node)
 		goto unmap_reg;
 	}
 
-	timer8_priv.mapbase = (unsigned long)base;
+	timer8_priv.mapbase = base;
 
 	rate = clk_get_rate(clk) / SCALE;
 	if (!rate) {
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index c1eef42..91bf1992 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -21,8 +21,8 @@
 
 struct tpu_priv {
 	struct clocksource cs;
-	unsigned long mapbase1;
-	unsigned long mapbase2;
+	void __iomem *mapbase1;
+	void __iomem *mapbase2;
 	raw_spinlock_t lock;
 	unsigned int cs_enabled;
 };
@@ -31,8 +31,8 @@ static inline unsigned long read_tcnt32(struct tpu_priv *p)
 {
 	unsigned long tcnt;
 
-	tcnt = ctrl_inw(p->mapbase1 + TCNT) << 16;
-	tcnt |= ctrl_inw(p->mapbase2 + TCNT);
+	tcnt = readw(p->mapbase1 + TCNT) << 16;
+	tcnt |= readw(p->mapbase2 + TCNT);
 	return tcnt;
 }
 
@@ -41,7 +41,7 @@ static int tpu_get_counter(struct tpu_priv *p, unsigned long long *val)
 	unsigned long v1, v2, v3;
 	int o1, o2;
 
-	o1 = ctrl_inb(p->mapbase1 + TSR) & 0x10;
+	o1 = readb(p->mapbase1 + TSR) & 0x10;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
@@ -49,7 +49,7 @@ static int tpu_get_counter(struct tpu_priv *p, unsigned long long *val)
 		v1 = read_tcnt32(p);
 		v2 = read_tcnt32(p);
 		v3 = read_tcnt32(p);
-		o1 = ctrl_inb(p->mapbase1 + TSR) & 0x10;
+		o1 = readb(p->mapbase1 + TSR) & 0x10;
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
@@ -82,10 +82,10 @@ static int tpu_clocksource_enable(struct clocksource *cs)
 
 	WARN_ON(p->cs_enabled);
 
-	ctrl_outw(0, p->mapbase1 + TCNT);
-	ctrl_outw(0, p->mapbase2 + TCNT);
-	ctrl_outb(0x0f, p->mapbase1 + TCR);
-	ctrl_outb(0x03, p->mapbase2 + TCR);
+	writew(0, p->mapbase1 + TCNT);
+	writew(0, p->mapbase2 + TCNT);
+	writeb(0x0f, p->mapbase1 + TCR);
+	writeb(0x03, p->mapbase2 + TCR);
 
 	p->cs_enabled = true;
 	return 0;
@@ -97,8 +97,8 @@ static void tpu_clocksource_disable(struct clocksource *cs)
 
 	WARN_ON(!p->cs_enabled);
 
-	ctrl_outb(0, p->mapbase1 + TCR);
-	ctrl_outb(0, p->mapbase2 + TCR);
+	writeb(0, p->mapbase1 + TCR);
+	writeb(0, p->mapbase2 + TCR);
 	p->cs_enabled = false;
 }
 
@@ -139,8 +139,8 @@ static void __init h8300_tpu_init(struct device_node *node)
 		goto unmap_L;
 	}
 
-	tpu_priv.mapbase1 = (unsigned long)base[CH_L];
-	tpu_priv.mapbase2 = (unsigned long)base[CH_H];
+	tpu_priv.mapbase1 = base[CH_L];
+	tpu_priv.mapbase2 = base[CH_H];
 
 	clocksource_register_hz(&tpu_priv.cs, clk_get_rate(clk) / 64);
 
diff --git a/drivers/irqchip/irq-renesas-h8300h.c b/drivers/irqchip/irq-renesas-h8300h.c
index 6fd30d5..c378768 100644
--- a/drivers/irqchip/irq-renesas-h8300h.c
+++ b/drivers/irqchip/irq-renesas-h8300h.c
@@ -21,9 +21,9 @@ static const char ipr_bit[] = {
 	10, 10, 10, 10,  9,  9,  9,  9,
 };
 
-static void *intc_baseaddr;
+static void __iomem *intc_baseaddr;
 
-#define IPR ((unsigned long)intc_baseaddr + 6)
+#define IPR (intc_baseaddr + 6)
 
 static void h8300h_disable_irq(struct irq_data *data)
 {
@@ -81,8 +81,8 @@ static int __init h8300h_intc_of_init(struct device_node *intc,
 	BUG_ON(!intc_baseaddr);
 
 	/* All interrupt priority low */
-	ctrl_outb(0x00, IPR + 0);
-	ctrl_outb(0x00, IPR + 1);
+	writeb(0x00, IPR + 0);
+	writeb(0x00, IPR + 1);
 
 	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
-- 
1.9.1

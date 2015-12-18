From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:22 +0100
Subject: [PATCH 69/69] clocksource/drivers/h8300: Use ioread / iowrite
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-69-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 43 ++++++++++++++++++-------------------
 drivers/clocksource/h8300_timer8.c  | 28 ++++++++++++++----------
 drivers/clocksource/h8300_tpu.c     | 22 ++++++++++---------
 3 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index 934ed0b..75c4407 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -19,6 +19,9 @@
 #define TCR	0
 #define TCNT	2
 
+#define bset(b, a) iowrite8(ioread8(a) | (1 << (b)), (a))
+#define bclr(b, a) iowrite8(ioread8(a) & ~(1 << (b)), (a))
+
 struct timer16_priv {
 	struct clocksource cs;
 	unsigned long total_cycles;
@@ -28,23 +31,22 @@ struct timer16_priv {
 	unsigned char enb;
 	unsigned char ovf;
 	unsigned char ovie;
-	struct clk *clk;
 };
 
 static unsigned long timer16_get_counter(struct timer16_priv *p)
 {
-	unsigned long v1, v2, v3;
-	int o1, o2;
+	unsigned short v1, v2, v3;
+	unsigned char  o1, o2;
 
-	o1 = readb(p->mapcommon + TISRC) & p->ovf;
+	o1 = ioread8(p->mapcommon + TISRC) & p->ovf;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
 		o2 = o1;
-		v1 = readw(p->mapbase + TCNT);
-		v2 = readw(p->mapbase + TCNT);
-		v3 = readw(p->mapbase + TCNT);
-		o1 = readb(p->mapcommon + TISRC) & p->ovf;
+		v1 = ioread16be(p->mapbase + TCNT);
+		v2 = ioread16be(p->mapbase + TCNT);
+		v3 = ioread16be(p->mapbase + TCNT);
+		o1 = ioread8(p->mapcommon + TISRC) & p->ovf;
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
@@ -59,8 +61,7 @@ static irqreturn_t timer16_interrupt(int irq, void *dev_id)
 {
 	struct timer16_priv *p = (struct timer16_priv *)dev_id;
 
-	writeb(readb(p->mapcommon + TISRC) & ~p->ovf,
-		  p->mapcommon + TISRC);
+	bclr(p->ovf, p->mapcommon + TISRC);
 	p->total_cycles += 0x10000;
 
 	return IRQ_HANDLED;
@@ -89,12 +90,10 @@ static int timer16_enable(struct clocksource *cs)
 	WARN_ON(p->cs_enabled);
 
 	p->total_cycles = 0;
-	writew(0x0000, p->mapbase + TCNT);
-	writeb(0x83, p->mapbase + TCR);
-	writeb(readb(p->mapcommon + TSTR) | p->enb,
-		  p->mapcommon + TSTR);
-	writeb(readb(p->mapcommon + TISRC) | p->ovie,
-		  p->mapcommon + TSTR);
+	iowrite16be(0x0000, p->mapbase + TCNT);
+	iowrite8(0x83, p->mapbase + TCR);
+	bset(p->ovie, p->mapcommon + TISRC);
+	bset(p->enb, p->mapcommon + TSTR);
 
 	p->cs_enabled = true;
 	return 0;
@@ -106,8 +105,8 @@ static void timer16_disable(struct clocksource *cs)
 
 	WARN_ON(!p->cs_enabled);
 
-	writeb(readb(p->mapcommon + TSTR) & ~p->enb,
-		  p->mapcommon + TSTR);
+	bclr(p->ovie, p->mapcommon + TISRC);
+	bclr(p->enb, p->mapcommon + TSTR);
 
 	p->cs_enabled = false;
 }
@@ -162,9 +161,9 @@ static void __init h8300_16timer_init(struct device_node *node)
 
 	timer16_priv.mapbase = base[REG_CH];
 	timer16_priv.mapcommon = base[REG_COMM];
-	timer16_priv.enb = 1 << ch;
-	timer16_priv.ovf = 1 << ch;
-	timer16_priv.ovie = 1 << (4 + ch);
+	timer16_priv.enb = ch;
+	timer16_priv.ovf = ch;
+	timer16_priv.ovie = 4 + ch;
 
 	ret = request_irq(irq, timer16_interrupt,
 			  IRQF_TIMER, timer16_priv.cs.name, &timer16_priv);
@@ -174,7 +173,7 @@ static void __init h8300_16timer_init(struct device_node *node)
 	}
 
 	clocksource_register_hz(&timer16_priv.cs,
-				clk_get_rate(timer16_priv.clk) / 8);
+				clk_get_rate(clk) / 8);
 	return;
 
 unmap_comm:
diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 9087dd2..c151941 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -24,10 +24,16 @@
 #define TCORB	6
 #define _8TCNT	8
 
+#define CMIEA	6
+#define CMFA	6
+
 #define FLAG_STARTED (1 << 3)
 
 #define SCALE 64
 
+#define bset(b, a) iowrite8(ioread8(a) | (1 << (b)), (a))
+#define bclr(b, a) iowrite8(ioread8(a) & ~(1 << (b)), (a))
+
 struct timer8_priv {
 	struct clock_event_device ced;
 	void __iomem *mapbase;
@@ -40,12 +46,11 @@ static irqreturn_t timer8_interrupt(int irq, void *dev_id)
 	struct timer8_priv *p = dev_id;
 
 	if (clockevent_state_oneshot(&p->ced))
-		writew(0x0000, p->mapbase + _8TCR);
+		iowrite16be(0x0000, p->mapbase + _8TCR);
 
 	p->ced.event_handler(&p->ced);
 
-	writeb(readb(p->mapbase + _8TCSR) & ~0x40,
-		  p->mapbase + _8TCSR);
+	bclr(CMFA, p->mapbase + _8TCSR);
 
 	return IRQ_HANDLED;
 }
@@ -54,17 +59,18 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 {
 	if (delta >= 0x10000)
 		pr_warn("delta out of range\n");
-	writeb(readb(p->mapbase + _8TCR) & ~0x40, p->mapbase + _8TCR);
-	writew(0, p->mapbase + _8TCNT);
-	writew(delta, p->mapbase + TCORA);
-	writeb(readb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
+	bclr(CMIEA, p->mapbase + _8TCR);
+	iowrite16be(delta, p->mapbase + TCORA);
+	iowrite16be(0x0000, p->mapbase + _8TCNT);
+	bclr(CMFA, p->mapbase + _8TCSR);
+	bset(CMIEA, p->mapbase + _8TCR);
 }
 
 static int timer8_enable(struct timer8_priv *p)
 {
-	writew(0xffff, p->mapbase + TCORA);
-	writew(0x0000, p->mapbase + _8TCNT);
-	writew(0x0c02, p->mapbase + _8TCR);
+	iowrite16be(0xffff, p->mapbase + TCORA);
+	iowrite16be(0x0000, p->mapbase + _8TCNT);
+	iowrite16be(0x0c02, p->mapbase + _8TCR);
 
 	return 0;
 }
@@ -85,7 +91,7 @@ static int timer8_start(struct timer8_priv *p)
 
 static void timer8_stop(struct timer8_priv *p)
 {
-	writew(0x0000, p->mapbase + _8TCR);
+	iowrite16be(0x0000, p->mapbase + _8TCR);
 }
 
 static inline struct timer8_priv *ced_to_priv(struct clock_event_device *ced)
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index 91bf1992..d4c1a28 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -19,6 +19,8 @@
 #define TSR	0x5
 #define TCNT	0x6
 
+#define TCFV	0x10
+
 struct tpu_priv {
 	struct clocksource cs;
 	void __iomem *mapbase1;
@@ -31,8 +33,8 @@ static inline unsigned long read_tcnt32(struct tpu_priv *p)
 {
 	unsigned long tcnt;
 
-	tcnt = readw(p->mapbase1 + TCNT) << 16;
-	tcnt |= readw(p->mapbase2 + TCNT);
+	tcnt = ioread16be(p->mapbase1 + TCNT) << 16;
+	tcnt |= ioread16be(p->mapbase2 + TCNT);
 	return tcnt;
 }
 
@@ -41,7 +43,7 @@ static int tpu_get_counter(struct tpu_priv *p, unsigned long long *val)
 	unsigned long v1, v2, v3;
 	int o1, o2;
 
-	o1 = readb(p->mapbase1 + TSR) & 0x10;
+	o1 = ioread8(p->mapbase1 + TSR) & TCFV;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
@@ -49,7 +51,7 @@ static int tpu_get_counter(struct tpu_priv *p, unsigned long long *val)
 		v1 = read_tcnt32(p);
 		v2 = read_tcnt32(p);
 		v3 = read_tcnt32(p);
-		o1 = readb(p->mapbase1 + TSR) & 0x10;
+		o1 = ioread8(p->mapbase1 + TSR) & TCFV;
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
@@ -82,10 +84,10 @@ static int tpu_clocksource_enable(struct clocksource *cs)
 
 	WARN_ON(p->cs_enabled);
 
-	writew(0, p->mapbase1 + TCNT);
-	writew(0, p->mapbase2 + TCNT);
-	writeb(0x0f, p->mapbase1 + TCR);
-	writeb(0x03, p->mapbase2 + TCR);
+	iowrite16be(0, p->mapbase1 + TCNT);
+	iowrite16be(0, p->mapbase2 + TCNT);
+	iowrite8(0x0f, p->mapbase1 + TCR);
+	iowrite8(0x03, p->mapbase2 + TCR);
 
 	p->cs_enabled = true;
 	return 0;
@@ -97,8 +99,8 @@ static void tpu_clocksource_disable(struct clocksource *cs)
 
 	WARN_ON(!p->cs_enabled);
 
-	writeb(0, p->mapbase1 + TCR);
-	writeb(0, p->mapbase2 + TCR);
+	iowrite8(0, p->mapbase1 + TCR);
+	iowrite8(0, p->mapbase2 + TCR);
 	p->cs_enabled = false;
 }
 
-- 
1.9.1

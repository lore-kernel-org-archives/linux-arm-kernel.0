From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 20 Nov 2009 15:00:48 -0700
Subject: [GIT PULL] iop clocksource support for 2.6.33
Message-ID: <1258754448.4011.9.camel@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/xscaleiop.git next

...to receive Mikael's conversion of the plat-iop time implementation to
clocksource.  This caught a difference between proc-xscale.S and
proc-xsc3.S in that the latter is not enabling cp6 access by default.  

Thanks,
Dan

Mikael Pettersson (4):
      iop: clocksource support
      iop: clockevent support
      iop: enable generic time
      iop: implement sched_clock()

 arch/arm/Kconfig                          |    2 +
 arch/arm/include/asm/hardware/iop3xx.h    |   18 +++-
 arch/arm/mach-iop13xx/include/mach/time.h |   18 +++-
 arch/arm/mach-iop13xx/iq81340mc.c         |    1 -
 arch/arm/mach-iop13xx/iq81340sc.c         |    1 -
 arch/arm/mach-iop32x/em7210.c             |    1 -
 arch/arm/mach-iop32x/glantank.c           |    1 -
 arch/arm/mach-iop32x/iq31244.c            |    1 -
 arch/arm/mach-iop32x/iq80321.c            |    1 -
 arch/arm/mach-iop32x/n2100.c              |    1 -
 arch/arm/mach-iop33x/iq80331.c            |    1 -
 arch/arm/mach-iop33x/iq80332.c            |    1 -
 arch/arm/mm/proc-xsc3.S                   |    2 +-
 arch/arm/plat-iop/time.c                  |  176 +++++++++++++++++++++++------
 14 files changed, 178 insertions(+), 47 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..455284e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -810,6 +810,8 @@ config ARCH_ACORN
 
 config PLAT_IOP
 	bool
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_TIME
 
 config PLAT_ORION
 	bool
diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 8d60ad2..5daea29 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -234,7 +234,13 @@ extern int iop3xx_get_init_atu(void);
 void iop3xx_map_io(void);
 void iop_init_cp6_handler(void);
 void iop_init_time(unsigned long tickrate);
-unsigned long iop_gettimeoffset(void);
+
+static inline u32 read_tmr0(void)
+{
+	u32 val;
+	asm volatile("mrc p6, 0, %0, c0, c1, 0" : "=r" (val));
+	return val;
+}
 
 static inline void write_tmr0(u32 val)
 {
@@ -253,6 +259,11 @@ static inline u32 read_tcr0(void)
 	return val;
 }
 
+static inline void write_tcr0(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c2, c1, 0" : : "r" (val));
+}
+
 static inline u32 read_tcr1(void)
 {
 	u32 val;
@@ -260,6 +271,11 @@ static inline u32 read_tcr1(void)
 	return val;
 }
 
+static inline void write_tcr1(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c3, c1, 0" : : "r" (val));
+}
+
 static inline void write_trr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c4, c1, 0" : : "r" (val));
diff --git a/arch/arm/mach-iop13xx/include/mach/time.h b/arch/arm/mach-iop13xx/include/mach/time.h
index d6d5252..f1c00d6 100644
--- a/arch/arm/mach-iop13xx/include/mach/time.h
+++ b/arch/arm/mach-iop13xx/include/mach/time.h
@@ -20,7 +20,6 @@
 #define IOP13XX_CORE_FREQ_1200		(5 << 16)
 
 void iop_init_time(unsigned long tickrate);
-unsigned long iop_gettimeoffset(void);
 
 static inline unsigned long iop13xx_core_freq(void)
 {
@@ -66,6 +65,13 @@ static inline unsigned long iop13xx_xsi_bus_ratio(void)
 	return 2;
 }
 
+static inline u32 read_tmr0(void)
+{
+	u32 val;
+	asm volatile("mrc p6, 0, %0, c0, c9, 0" : "=r" (val));
+	return val;
+}
+
 static inline void write_tmr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c0, c9, 0" : : "r" (val));
@@ -83,6 +89,11 @@ static inline u32 read_tcr0(void)
 	return val;
 }
 
+static inline void write_tcr0(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c2, c9, 0" : : "r" (val));
+}
+
 static inline u32 read_tcr1(void)
 {
 	u32 val;
@@ -90,6 +101,11 @@ static inline u32 read_tcr1(void)
 	return val;
 }
 
+static inline void write_tcr1(u32 val)
+{
+	asm volatile("mcr p6, 0, %0, c3, c9, 0" : : "r" (val));
+}
+
 static inline void write_trr0(u32 val)
 {
 	asm volatile("mcr p6, 0, %0, c4, c9, 0" : : "r" (val));
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 5051c03..f91f315 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -87,7 +87,6 @@ static void __init iq81340mc_timer_init(void)
 
 static struct sys_timer iq81340mc_timer = {
        .init       = iq81340mc_timer_init,
-       .offset     = iop_gettimeoffset,
 };
 
 MACHINE_START(IQ81340MC, "Intel IQ81340MC")
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index bc44307..ddb7a34 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -89,7 +89,6 @@ static void __init iq81340sc_timer_init(void)
 
 static struct sys_timer iq81340sc_timer = {
        .init       = iq81340sc_timer_init,
-       .offset     = iop_gettimeoffset,
 };
 
 MACHINE_START(IQ81340SC, "Intel IQ81340SC")
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 3ad4696..2bef9b6 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -42,7 +42,6 @@ static void __init em7210_timer_init(void)
 
 static struct sys_timer em7210_timer = {
 	.init		= em7210_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 /*
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index a9c2dfd..93370a4 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -47,7 +47,6 @@ static void __init glantank_timer_init(void)
 
 static struct sys_timer glantank_timer = {
 	.init		= glantank_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index dd1cd99..a7a08dd 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -78,7 +78,6 @@ static void __init iq31244_timer_init(void)
 
 static struct sys_timer iq31244_timer = {
 	.init		= iq31244_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index fbe2779..0200f80 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -46,7 +46,6 @@ static void __init iq80321_timer_init(void)
 
 static struct sys_timer iq80321_timer = {
 	.init		= iq80321_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index d2e4278..2a5c637 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -53,7 +53,6 @@ static void __init n2100_timer_init(void)
 
 static struct sys_timer n2100_timer = {
 	.init		= n2100_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index d51e10c..394e95a 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -48,7 +48,6 @@ static void __init iq80331_timer_init(void)
 
 static struct sys_timer iq80331_timer = {
 	.init		= iq80331_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 92fb44c..a40badf 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -48,7 +48,6 @@ static void __init iq80332_timer_init(void)
 
 static struct sys_timer iq80332_timer = {
 	.init		= iq80332_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 2028f37..fab134e 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -396,7 +396,7 @@ __xsc3_setup:
 	orr	r4, r4, #0x18			@ cache the page table in L2
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
 
-	mov	r0, #0				@ don't allow CP access
+	mov	r0, #1 << 6			@ cp6 access for early sched_clock
 	mcr	p15, 0, r0, c15, c1, 0		@ write CP access register
 
 	mrc	p15, 0, r0, c1, c0, 1		@ get auxiliary control reg
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 8da95d5..6c8a02a 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/io.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -26,45 +28,136 @@
 #include <asm/mach/time.h>
 #include <mach/time.h>
 
+/*
+ * IOP clocksource (free-running timer 1).
+ */
+static cycle_t iop_clocksource_read(struct clocksource *unused)
+{
+	return 0xffffffffu - read_tcr1();
+}
+
+static struct clocksource iop_clocksource = {
+	.name 		= "iop_timer1",
+	.rating		= 300,
+	.read		= iop_clocksource_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find shift and mult values for hz. */
+	shift = 32;
+	do {
+		temp = (u64) NSEC_PER_SEC << shift;
+		do_div(temp, hz);
+		if ((temp >> 32) == 0)
+			break;
+	} while (--shift != 0);
+
+	cs->shift = shift;
+	cs->mult = (u32) temp;
+
+	printk(KERN_INFO "clocksource: %s uses shift %u mult %#x\n",
+	       cs->name, cs->shift, cs->mult);
+}
+
+/*
+ * IOP sched_clock() implementation via its clocksource.
+ */
+unsigned long long sched_clock(void)
+{
+	cycle_t cyc = iop_clocksource_read(NULL);
+	struct clocksource *cs = &iop_clocksource;
+
+	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
+}
+
+/*
+ * IOP clockevents (interrupting timer 0).
+ */
+static int iop_set_next_event(unsigned long delta,
+			      struct clock_event_device *unused)
+{
+	u32 tmr = IOP_TMR_PRIVILEGED | IOP_TMR_RATIO_1_1;
+
+	BUG_ON(delta == 0);
+	write_tmr0(tmr & ~(IOP_TMR_EN | IOP_TMR_RELOAD));
+	write_tcr0(delta);
+	write_tmr0((tmr & ~IOP_TMR_RELOAD) | IOP_TMR_EN);
+
+	return 0;
+}
+
 static unsigned long ticks_per_jiffy;
-static unsigned long ticks_per_usec;
-static unsigned long next_jiffy_time;
 
-unsigned long iop_gettimeoffset(void)
+static void iop_set_mode(enum clock_event_mode mode,
+			 struct clock_event_device *unused)
 {
-	unsigned long offset, temp;
+	u32 tmr = read_tmr0();
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		write_tmr0(tmr & ~IOP_TMR_EN);
+		write_tcr0(ticks_per_jiffy - 1);
+		tmr |= (IOP_TMR_RELOAD | IOP_TMR_EN);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* ->set_next_event sets period and enables timer */
+		tmr &= ~(IOP_TMR_RELOAD | IOP_TMR_EN);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		tmr |= IOP_TMR_EN;
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	default:
+		tmr &= ~IOP_TMR_EN;
+		break;
+	}
 
-	/* enable cp6, if necessary, to avoid taking the overhead of an
-	 * undefined instruction trap
-	 */
-	asm volatile (
-	"mrc	p15, 0, %0, c15, c1, 0\n\t"
-	"tst	%0, #(1 << 6)\n\t"
-	"orreq	%0, %0, #(1 << 6)\n\t"
-	"mcreq	p15, 0, %0, c15, c1, 0\n\t"
-#ifdef CONFIG_CPU_XSCALE
-	"mrceq	p15, 0, %0, c15, c1, 0\n\t"
-	"moveq	%0, %0\n\t"
-	"subeq	pc, pc, #4\n\t"
-#endif
-	: "=r"(temp) : : "cc");
-
-	offset = next_jiffy_time - read_tcr1();
-
-	return offset / ticks_per_usec;
+	write_tmr0(tmr);
+}
+
+static struct clock_event_device iop_clockevent = {
+	.name		= "iop_timer0",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating         = 300,
+	.set_next_event	= iop_set_next_event,
+	.set_mode	= iop_set_mode,
+};
+
+static void __init iop_clockevent_set_hz(struct clock_event_device *ce, unsigned int hz)
+{
+	u64 temp;
+	u32 shift;
+
+	/* Find shift and mult values for hz. */
+	shift = 32;
+	do {
+		temp = (u64) hz << shift;
+		do_div(temp, NSEC_PER_SEC);
+		if ((temp >> 32) == 0)
+			break;
+	} while (--shift != 0);
+
+	ce->shift = shift;
+	ce->mult = (u32) temp;
+
+	printk(KERN_INFO "clockevent: %s uses shift %u mult %#lx\n",
+	       ce->name, ce->shift, ce->mult);
 }
 
 static irqreturn_t
 iop_timer_interrupt(int irq, void *dev_id)
 {
-	write_tisr(1);
-
-	while ((signed long)(next_jiffy_time - read_tcr1())
-		>= ticks_per_jiffy) {
-		timer_tick();
-		next_jiffy_time -= ticks_per_jiffy;
-	}
+	struct clock_event_device *evt = dev_id;
 
+	write_tisr(1);
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -72,6 +165,7 @@ static struct irqaction iop_timer_irq = {
 	.name		= "IOP Timer Tick",
 	.handler	= iop_timer_interrupt,
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.dev_id		= &iop_clockevent,
 };
 
 static unsigned long iop_tick_rate;
@@ -86,21 +180,33 @@ void __init iop_init_time(unsigned long tick_rate)
 	u32 timer_ctl;
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
-	ticks_per_usec = tick_rate / 1000000;
-	next_jiffy_time = 0xffffffff;
 	iop_tick_rate = tick_rate;
 
 	timer_ctl = IOP_TMR_EN | IOP_TMR_PRIVILEGED |
 			IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
 
 	/*
-	 * We use timer 0 for our timer interrupt, and timer 1 as
-	 * monotonic counter for tracking missed jiffies.
+	 * Set up interrupting clockevent timer 0.
 	 */
+	write_tmr0(timer_ctl & ~IOP_TMR_EN);
+	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
+	iop_clockevent_set_hz(&iop_clockevent, tick_rate);
+	iop_clockevent.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &iop_clockevent);
+	iop_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xf, &iop_clockevent);
+	iop_clockevent.cpumask = cpumask_of(0);
+	clockevents_register_device(&iop_clockevent);
 	write_trr0(ticks_per_jiffy - 1);
+	write_tcr0(ticks_per_jiffy - 1);
 	write_tmr0(timer_ctl);
+
+	/*
+	 * Set up free-running clocksource timer 1.
+	 */
 	write_trr1(0xffffffff);
+	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
-
-	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
+	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
+	clocksource_register(&iop_clocksource);
 }

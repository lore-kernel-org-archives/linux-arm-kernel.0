From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:51:28 +0200
Subject: [PATCH v2 3/4] iop: enable generic time
Message-ID: <19134.28864.965002.213430@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the IOP platform to use the kernel's generic time
framework. With clockevent support in place, this reduces to
selecting GENERIC_TIME and removing the platform's private timer
->offset() operation (iop_gettimeoffset).

Tested on n2100, compile-tested for all plat-iop machines.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v1 -> v2:
* rebased on 2.6.31 and v2 of the iop clockevents patch

 arch/arm/Kconfig                          |    1 +
 arch/arm/include/asm/hardware/iop3xx.h    |    1 -
 arch/arm/mach-iop13xx/include/mach/time.h |    1 -
 arch/arm/mach-iop13xx/iq81340mc.c         |    1 -
 arch/arm/mach-iop13xx/iq81340sc.c         |    1 -
 arch/arm/mach-iop32x/em7210.c             |    1 -
 arch/arm/mach-iop32x/glantank.c           |    1 -
 arch/arm/mach-iop32x/iq31244.c            |    1 -
 arch/arm/mach-iop32x/iq80321.c            |    1 -
 arch/arm/mach-iop32x/n2100.c              |    1 -
 arch/arm/mach-iop33x/iq80331.c            |    1 -
 arch/arm/mach-iop33x/iq80332.c            |    1 -
 arch/arm/plat-iop/time.c                  |   29 -----------------------------
 13 files changed, 1 insertion(+), 40 deletions(-)

diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/Kconfig linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/Kconfig
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/Kconfig	2009-09-21 10:27:20.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/Kconfig	2009-09-21 10:28:27.000000000 +0200
@@ -737,6 +737,7 @@ config ARCH_ACORN
 config PLAT_IOP
 	bool
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_TIME
 
 config PLAT_ORION
 	bool
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/include/asm/hardware/iop3xx.h linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/include/asm/hardware/iop3xx.h
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/include/asm/hardware/iop3xx.h	2009-09-21 10:27:20.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/include/asm/hardware/iop3xx.h	2009-09-21 10:28:27.000000000 +0200
@@ -233,7 +233,6 @@ extern int iop3xx_get_init_atu(void);
 void iop3xx_map_io(void);
 void iop_init_cp6_handler(void);
 void iop_init_time(unsigned long tickrate);
-unsigned long iop_gettimeoffset(void);
 
 static inline u32 read_tmr0(void)
 {
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/include/mach/time.h linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/include/mach/time.h
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/include/mach/time.h	2009-09-21 10:27:20.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/include/mach/time.h	2009-09-21 10:28:27.000000000 +0200
@@ -20,7 +20,6 @@
 #define IOP13XX_CORE_FREQ_1200		(5 << 16)
 
 void iop_init_time(unsigned long tickrate);
-unsigned long iop_gettimeoffset(void);
 
 static inline unsigned long iop13xx_core_freq(void)
 {
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/iq81340mc.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/iq81340mc.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/iq81340mc.c	2008-10-11 10:43:49.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/iq81340mc.c	2009-09-21 10:28:27.000000000 +0200
@@ -87,7 +87,6 @@ static void __init iq81340mc_timer_init(
 
 static struct sys_timer iq81340mc_timer = {
        .init       = iq81340mc_timer_init,
-       .offset     = iop_gettimeoffset,
 };
 
 MACHINE_START(IQ81340MC, "Intel IQ81340MC")
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/iq81340sc.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/iq81340sc.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop13xx/iq81340sc.c	2008-10-11 10:43:49.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop13xx/iq81340sc.c	2009-09-21 10:28:27.000000000 +0200
@@ -89,7 +89,6 @@ static void __init iq81340sc_timer_init(
 
 static struct sys_timer iq81340sc_timer = {
        .init       = iq81340sc_timer_init,
-       .offset     = iop_gettimeoffset,
 };
 
 MACHINE_START(IQ81340SC, "Intel IQ81340SC")
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/em7210.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/em7210.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/em7210.c	2008-10-11 10:43:49.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/em7210.c	2009-09-21 10:28:27.000000000 +0200
@@ -42,7 +42,6 @@ static void __init em7210_timer_init(voi
 
 static struct sys_timer em7210_timer = {
 	.init		= em7210_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 /*
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/glantank.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/glantank.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/glantank.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/glantank.c	2009-09-21 10:28:27.000000000 +0200
@@ -47,7 +47,6 @@ static void __init glantank_timer_init(v
 
 static struct sys_timer glantank_timer = {
 	.init		= glantank_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/iq31244.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/iq31244.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/iq31244.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/iq31244.c	2009-09-21 10:28:27.000000000 +0200
@@ -78,7 +78,6 @@ static void __init iq31244_timer_init(vo
 
 static struct sys_timer iq31244_timer = {
 	.init		= iq31244_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/iq80321.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/iq80321.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/iq80321.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/iq80321.c	2009-09-21 10:28:27.000000000 +0200
@@ -46,7 +46,6 @@ static void __init iq80321_timer_init(vo
 
 static struct sys_timer iq80321_timer = {
 	.init		= iq80321_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/n2100.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/n2100.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop32x/n2100.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop32x/n2100.c	2009-09-21 10:28:27.000000000 +0200
@@ -53,7 +53,6 @@ static void __init n2100_timer_init(void
 
 static struct sys_timer n2100_timer = {
 	.init		= n2100_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop33x/iq80331.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop33x/iq80331.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop33x/iq80331.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop33x/iq80331.c	2009-09-21 10:28:27.000000000 +0200
@@ -48,7 +48,6 @@ static void __init iq80331_timer_init(vo
 
 static struct sys_timer iq80331_timer = {
 	.init		= iq80331_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop33x/iq80332.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop33x/iq80332.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/mach-iop33x/iq80332.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/mach-iop33x/iq80332.c	2009-09-21 10:28:27.000000000 +0200
@@ -48,7 +48,6 @@ static void __init iq80332_timer_init(vo
 
 static struct sys_timer iq80332_timer = {
 	.init		= iq80332_timer_init,
-	.offset		= iop_gettimeoffset,
 };
 
 
diff -rupN linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/plat-iop/time.c linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c
--- linux-2.6.31.arm-iop-2-clockevents-v2/arch/arm/plat-iop/time.c	2009-09-21 10:27:20.000000000 +0200
+++ linux-2.6.31.arm-iop-3-generictime-v2/arch/arm/plat-iop/time.c	2009-09-21 10:28:27.000000000 +0200
@@ -140,33 +140,6 @@ static void __init iop_clockevent_set_hz
 	       ce->name, ce->shift, ce->mult);
 }
 
-static unsigned long ticks_per_usec;
-static unsigned long next_jiffy_time;
-
-unsigned long iop_gettimeoffset(void)
-{
-	unsigned long offset, temp;
-
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
-}
-
 static irqreturn_t
 iop_timer_interrupt(int irq, void *dev_id)
 {
@@ -196,8 +169,6 @@ void __init iop_init_time(unsigned long 
 	u32 timer_ctl;
 
 	ticks_per_jiffy = (tick_rate + HZ/2) / HZ;
-	ticks_per_usec = tick_rate / 1000000;
-	next_jiffy_time = 0xffffffff;
 	iop_tick_rate = tick_rate;
 
 	timer_ctl = IOP_TMR_EN | IOP_TMR_PRIVILEGED |

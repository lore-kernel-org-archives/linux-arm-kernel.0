From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Feb 2014 12:09:01 +0400
Subject: [PATCH v2 RESEND 3/3] ARM: clps711x: Migrate CLPS711X subarch to the
 new irqchip driver
Message-ID: <1391328541-30961-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove old code and migrate Cirrus Logic CLPS711X subarch
to the new irqchip driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c        |   2 -
 arch/arm/mach-clps711x/board-cdb89712.c        |   2 -
 arch/arm/mach-clps711x/board-clep7312.c        |   2 -
 arch/arm/mach-clps711x/board-edb7211.c         |   2 -
 arch/arm/mach-clps711x/board-p720t.c           |   2 -
 arch/arm/mach-clps711x/common.c                | 201 +------------------------
 arch/arm/mach-clps711x/common.h                |   2 -
 arch/arm/mach-clps711x/include/mach/clps711x.h |  16 --
 8 files changed, 3 insertions(+), 226 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f8d71a8..eb945b2 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -265,14 +265,12 @@ static void __init autcpu12_init_late(void)
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
 	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= autcpu12_init,
 	.init_late	= autcpu12_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index a9e38c6..e261a47 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -139,12 +139,10 @@ static void __init cdb89712_init(void)
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
 	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index b476424..221b9de 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -36,12 +36,10 @@ fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
 	.atag_offset	= 0x0100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
 	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index fe6184e..0776098 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -177,7 +177,6 @@ static void __init edb7211_init_late(void)
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
 	.atag_offset	= VIDEORAM_SIZE + 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= clps711x_map_io,
@@ -186,6 +185,5 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
 	.init_late	= edb7211_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index dd81b06..67b7337 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -363,7 +363,6 @@ static void __init p720t_init_late(void)
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_p720t,
 	.map_io		= clps711x_map_io,
 	.init_early	= clps711x_init_early,
@@ -371,6 +370,5 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
 	.init_late	= p720t_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index a193591..aee81fa 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -31,14 +31,14 @@
 #include <linux/clk-provider.h>
 #include <linux/sched_clock.h>
 
-#include <asm/exception.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 
+#include "common.h"
+
 static struct clk *clk_pll, *clk_bus, *clk_uart, *clk_timerl, *clk_timerh,
 		  *clk_tint, *clk_spi;
 
@@ -59,204 +59,9 @@ void __init clps711x_map_io(void)
 	iotable_init(clps711x_io_desc, ARRAY_SIZE(clps711x_io_desc));
 }
 
-static void int1_mask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-}
-
-static void int1_eoi(struct irq_data *d)
-{
-	switch (d->irq) {
-	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
-	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
-	case IRQ_TC2OI:  clps_writel(0, TC2EOI); break;
-	case IRQ_RTCMI:  clps_writel(0, RTCEOI); break;
-	case IRQ_TINT:   clps_writel(0, TEOI);   break;
-	case IRQ_UMSINT: clps_writel(0, UMSEOI); break;
-	}
-}
-
-static void int1_unmask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 |= 1 << d->irq;
-	clps_writel(intmr1, INTMR1);
-}
-
-static struct irq_chip int1_chip = {
-	.name		= "Interrupt Vector 1",
-	.irq_eoi	= int1_eoi,
-	.irq_mask	= int1_mask,
-	.irq_unmask	= int1_unmask,
-};
-
-static void int2_mask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-}
-
-static void int2_eoi(struct irq_data *d)
-{
-	switch (d->irq) {
-	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
-	}
-}
-
-static void int2_unmask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 |= 1 << (d->irq - 16);
-	clps_writel(intmr2, INTMR2);
-}
-
-static struct irq_chip int2_chip = {
-	.name		= "Interrupt Vector 2",
-	.irq_eoi	= int2_eoi,
-	.irq_mask	= int2_mask,
-	.irq_unmask	= int2_unmask,
-};
-
-static void int3_mask(struct irq_data *d)
-{
-	u32 intmr3;
-
-	intmr3 = clps_readl(INTMR3);
-	intmr3 &= ~(1 << (d->irq - 32));
-	clps_writel(intmr3, INTMR3);
-}
-
-static void int3_unmask(struct irq_data *d)
-{
-	u32 intmr3;
-
-	intmr3 = clps_readl(INTMR3);
-	intmr3 |= 1 << (d->irq - 32);
-	clps_writel(intmr3, INTMR3);
-}
-
-static struct irq_chip int3_chip = {
-	.name		= "Interrupt Vector 3",
-	.irq_mask	= int3_mask,
-	.irq_unmask	= int3_unmask,
-};
-
-static struct {
-	int			nr;
-	struct irq_chip		*chip;
-	irq_flow_handler_t	handle;
-} clps711x_irqdescs[] __initdata = {
-	{ IRQ_CSINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_EINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_EINT2,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_EINT3,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_TC1OI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_TC2OI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_RTCMI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_TINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_UTXINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_URXINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_UMSINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_SSEOTI,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_KBDINT,	&int2_chip,	handle_fasteoi_irq,	},
-	{ IRQ_SS2RX,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_SS2TX,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_UTXINT2,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_URXINT2,	&int2_chip,	handle_level_irq,	},
-};
-
 void __init clps711x_init_irq(void)
 {
-	unsigned int i;
-
-	/* Disable interrupts */
-	clps_writel(0, INTMR1);
-	clps_writel(0, INTMR2);
-	clps_writel(0, INTMR3);
-
-	/* Clear down any pending interrupts */
-	clps_writel(0, BLEOI);
-	clps_writel(0, MCEOI);
-	clps_writel(0, COEOI);
-	clps_writel(0, TC1EOI);
-	clps_writel(0, TC2EOI);
-	clps_writel(0, RTCEOI);
-	clps_writel(0, TEOI);
-	clps_writel(0, UMSEOI);
-	clps_writel(0, KBDEOI);
-	clps_writel(0, SRXEOF);
-	clps_writel(0xffffffff, DAISR);
-
-	for (i = 0; i < ARRAY_SIZE(clps711x_irqdescs); i++) {
-		irq_set_chip_and_handler(clps711x_irqdescs[i].nr,
-					 clps711x_irqdescs[i].chip,
-					 clps711x_irqdescs[i].handle);
-		set_irq_flags(clps711x_irqdescs[i].nr,
-			      IRQF_VALID | IRQF_PROBE);
-	}
-
-	if (IS_ENABLED(CONFIG_FIQ)) {
-		init_FIQ(0);
-		irq_set_chip_and_handler(IRQ_DAIINT, &int3_chip,
-					 handle_bad_irq);
-		set_irq_flags(IRQ_DAIINT,
-			      IRQF_VALID | IRQF_PROBE | IRQF_NOAUTOEN);
-	}
-}
-
-static inline u32 fls16(u32 x)
-{
-	u32 r = 15;
-
-	if (!(x & 0xff00)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf000)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc000)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x8000))
-		r--;
-
-	return r;
-}
-
-asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
-{
-	do {
-		u32 irqstat;
-		void __iomem *base = CLPS711X_VIRT_BASE;
-
-		irqstat = readw_relaxed(base + INTSR1) &
-			  readw_relaxed(base + INTMR1);
-		if (irqstat)
-			handle_IRQ(fls16(irqstat), regs);
-
-		irqstat = readw_relaxed(base + INTSR2) &
-			  readw_relaxed(base + INTMR2);
-		if (irqstat) {
-			handle_IRQ(fls16(irqstat) + 16, regs);
-			continue;
-		}
-
-		break;
-	} while (1);
+	clps711x_intc_init(CLPS711X_PHYS_BASE, SZ_16K);
 }
 
 static u64 notrace clps711x_sched_clock_read(void)
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index f6b43a9..7489139 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -6,14 +6,12 @@
 
 #include <linux/reboot.h>
 
-#define CLPS711X_NR_IRQS	(33)
 #define CLPS711X_NR_GPIO	(4 * 8 + 3)
 #define CLPS711X_GPIO(prt, bit)	((prt) * 8 + (bit))
 
 extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
-extern void clps711x_handle_irq(struct pt_regs *regs);
 extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
 extern void clps711x_init_early(void);
 
diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index 0286f4b..eb052a1 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -40,8 +40,6 @@
 #define MEMCFG1		(0x0180)
 #define MEMCFG2		(0x01c0)
 #define DRFPR		(0x0200)
-#define INTSR1		(0x0240)
-#define INTMR1		(0x0280)
 #define LCDCON		(0x02c0)
 #define TC1D		(0x0300)
 #define TC2D		(0x0340)
@@ -55,28 +53,16 @@
 #define PALLSW		(0x0540)
 #define PALMSW		(0x0580)
 #define STFCLR		(0x05c0)
-#define BLEOI		(0x0600)
-#define MCEOI		(0x0640)
-#define TEOI		(0x0680)
-#define TC1EOI		(0x06c0)
-#define TC2EOI		(0x0700)
-#define RTCEOI		(0x0740)
-#define UMSEOI		(0x0780)
-#define COEOI		(0x07c0)
 #define HALT		(0x0800)
 #define STDBY		(0x0840)
 
 #define FBADDR		(0x1000)
 #define SYSCON2		(0x1100)
 #define SYSFLG2		(0x1140)
-#define INTSR2		(0x1240)
-#define INTMR2		(0x1280)
 #define UARTDR2		(0x1480)
 #define UBRLCR2		(0x14c0)
 #define SS2DR		(0x1500)
-#define SRXEOF		(0x1600)
 #define SS2POP		(0x16c0)
-#define KBDEOI		(0x1700)
 
 #define DAIR		(0x2000)
 #define DAIDR0		(0x2040)
@@ -84,8 +70,6 @@
 #define DAIDR2		(0x20c0)
 #define DAISR		(0x2100)
 #define SYSCON3		(0x2200)
-#define INTSR3		(0x2240)
-#define INTMR3		(0x2280)
 #define LEDFLSH		(0x22c0)
 #define SDCONF		(0x2300)
 #define SDRFPR		(0x2340)
-- 
1.8.3.2

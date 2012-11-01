From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:39 +0400
Subject: [PATCH 09/15] ARM: clps711x: Implement usage "MULTI_IRQ_HANDLER"
 kernel option for a platform
In-Reply-To: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
Message-ID: <1351762006-27368-9-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                                  |    1 +
 arch/arm/mach-clps711x/autcpu12.c                 |    1 +
 arch/arm/mach-clps711x/cdb89712.c                 |    1 +
 arch/arm/mach-clps711x/clep7312.c                 |    1 +
 arch/arm/mach-clps711x/common.c                   |   39 ++++++++++++++++
 arch/arm/mach-clps711x/common.h                   |    3 +-
 arch/arm/mach-clps711x/edb7211.c                  |    1 +
 arch/arm/mach-clps711x/fortunet.c                 |    1 +
 arch/arm/mach-clps711x/include/mach/entry-macro.S |   51 ---------------------
 arch/arm/mach-clps711x/p720t.c                    |    1 +
 10 files changed, 48 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34ca399..2ee4b14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -375,6 +375,7 @@ config ARCH_CLPS711X
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 6a4752b..8f9b2e0 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -78,6 +78,7 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	.init_machine	= autcpu12_init,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index a526715..88de144 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -144,6 +144,7 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	.init_machine	= cdb89712_init,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index c76363f..a6b808c 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -47,6 +47,7 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.init_machine	= clep7312_init,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 286d6e6..3cc0380 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -29,6 +29,7 @@
 #include <linux/clockchips.h>
 #include <linux/clk-provider.h>
 
+#include <asm/exception.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
@@ -191,6 +192,44 @@ void __init clps711x_init_irq(void)
 	}
 }
 
+inline u32 fls16(u32 x)
+{
+	u32 r = 15;
+
+	if (!(x & 0xff00)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf000)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc000)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x8000))
+		r--;
+
+	return r;
+}
+
+asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat;
+	void __iomem *base = CLPS711X_VIRT_BASE;
+
+	irqstat = readl_relaxed(base + INTSR1) & readl_relaxed(base + INTMR1);
+	if (irqstat) {
+		handle_IRQ(fls16(irqstat), regs);
+		return;
+	}
+
+	irqstat = readl_relaxed(base + INTSR2) & readl_relaxed(base + INTMR2);
+	if (likely(irqstat))
+		handle_IRQ(fls16(irqstat) + 16, regs);
+}
+
 static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
 					 struct clock_event_device *evt)
 {
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 9757b3e..9d3e9db 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -12,5 +12,6 @@ struct sys_timer;
 
 extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
-extern struct sys_timer clps711x_timer;
+extern void clps711x_handle_irq(struct pt_regs *regs);
 extern void clps711x_restart(char mode, const char *cmd);
+extern struct sys_timer clps711x_timer;
diff --git a/arch/arm/mach-clps711x/edb7211.c b/arch/arm/mach-clps711x/edb7211.c
index 43a502b..5a43160 100644
--- a/arch/arm/mach-clps711x/edb7211.c
+++ b/arch/arm/mach-clps711x/edb7211.c
@@ -100,6 +100,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.init_machine	= edb7211_init,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index dca69c3..72c3745 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -85,6 +85,7 @@ MACHINE_START(FORTUNET, "ARM-FortuNet")
 	.init_machine	= fortunet_init,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/include/mach/entry-macro.S b/arch/arm/mach-clps711x/include/mach/entry-macro.S
deleted file mode 100644
index 56e5c2c..0000000
--- a/arch/arm/mach-clps711x/include/mach/entry-macro.S
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * arch/arm/mach-clps711x/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for CLPS711X-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <mach/hardware.h>
-
-		.macro	get_irqnr_preamble, base, tmp
-		.endm
-
-#if (INTSR2 - INTSR1) != (INTMR2 - INTMR1)
-#error INTSR stride != INTMR stride
-#endif
-
-		.macro	get_irqnr_and_base, irqnr, stat, base, mask
-		mov	\base, #CLPS711X_VIRT_BASE
-		ldr	\stat, [\base, #INTSR1]
-		ldr	\mask, [\base, #INTMR1]
-		mov	\irqnr, #4
-		mov	\mask, \mask, lsl #16
-		and	\stat, \stat, \mask, lsr #16
-		movs	\stat, \stat, lsr #4
-		bne	1001f
-
-		add	\base, \base, #INTSR2 - INTSR1
-		ldr	\stat, [\base, #INTSR1]
-		ldr	\mask, [\base, #INTMR1]
-		mov	\irqnr, #16
-		mov	\mask, \mask, lsl #16
-		and	\stat, \stat, \mask, lsr #16
-
-1001:		tst	\stat, #255
-		addeq	\irqnr, \irqnr, #8
-		moveq	\stat, \stat, lsr #8
-		tst	\stat, #15
-		addeq	\irqnr, \irqnr, #4
-		moveq	\stat, \stat, lsr #4
-		tst	\stat, #3
-		addeq	\irqnr, \irqnr, #2
-		moveq	\stat, \stat, lsr #2
-		tst	\stat, #1
-		addeq	\irqnr, \irqnr, #1
-		moveq	\stat, \stat, lsr #1
-		tst	\stat, #1			@ bit 0 should be set
-		.endm
-
-
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 4383ad8..0b329c3 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -149,6 +149,7 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.init_late	= p720t_init_late,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.init_irq	= clps711x_init_irq,
+	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
 MACHINE_END
-- 
1.7.8.6

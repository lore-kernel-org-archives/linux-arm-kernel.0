From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 May 2011 23:08:53 +0200
Subject: [PATCH 2/3] mach-u300: fix compilaton warning in IO accessors
Message-ID: <1306876133-6744-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The IO accessors for U300 were using u32 rather than the nominal
void __iomem * type, rectify this by properly defining the
virtual base for statically mapped peripherals to be
void __iomem *. Requires fixing a field in struct clk as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/clock.h                  |    2 +-
 arch/arm/mach-u300/include/mach/u300-regs.h |   22 ++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-u300/clock.h b/arch/arm/mach-u300/clock.h
index c34f3ea..4f50ca8 100644
--- a/arch/arm/mach-u300/clock.h
+++ b/arch/arm/mach-u300/clock.h
@@ -31,7 +31,7 @@ struct clk {
 	bool reset;
 	__u16 clk_val;
 	__s8 usecount;
-	__u32 res_reg;
+	void __iomem * res_reg;
 	__u16 res_mask;
 
 	bool hw_ctrld;
diff --git a/arch/arm/mach-u300/include/mach/u300-regs.h b/arch/arm/mach-u300/include/mach/u300-regs.h
index 8b85df4..00fe620 100644
--- a/arch/arm/mach-u300/include/mach/u300-regs.h
+++ b/arch/arm/mach-u300/include/mach/u300-regs.h
@@ -18,6 +18,12 @@
  * the defines are used for setting up the I/O memory mapping.
  */
 
+#ifdef __ASSEMBLER__
+#define IOADD(a) (a)
+#else
+#define IOADD(a) (void __iomem *) a
+#endif
+
 /* NAND Flash CS0 */
 #define U300_NAND_CS0_PHYS_BASE		0x80000000
 
@@ -48,13 +54,6 @@
 #endif
 
 /*
- * All the following peripherals are specified at their PHYSICAL address,
- * so if you need to access them (in the kernel), you MUST use the macros
- * defined in <asm/io.h> to map to the IO_ADDRESS_AHB() IO_ADDRESS_FAST()
- * etc.
- */
-
-/*
  * AHB peripherals
  */
 
@@ -63,11 +62,11 @@
 
 /* Vectored Interrupt Controller 0, servicing 32 interrupts */
 #define U300_INTCON0_BASE		(U300_AHB_PER_PHYS_BASE+0x1000)
-#define U300_INTCON0_VBASE		(U300_AHB_PER_VIRT_BASE+0x1000)
+#define U300_INTCON0_VBASE		IOADD(U300_AHB_PER_VIRT_BASE+0x1000)
 
 /* Vectored Interrupt Controller 1, servicing 32 interrupts */
 #define U300_INTCON1_BASE		(U300_AHB_PER_PHYS_BASE+0x2000)
-#define U300_INTCON1_VBASE		(U300_AHB_PER_VIRT_BASE+0x2000)
+#define U300_INTCON1_VBASE		IOADD(U300_AHB_PER_VIRT_BASE+0x2000)
 
 /* Memory Stick Pro (MSPRO) controller */
 #define U300_MSPRO_BASE			(U300_AHB_PER_PHYS_BASE+0x3000)
@@ -115,7 +114,7 @@
 
 /* SYSCON */
 #define U300_SYSCON_BASE		(U300_SLOW_PER_PHYS_BASE+0x1000)
-#define U300_SYSCON_VBASE		(U300_SLOW_PER_VIRT_BASE+0x1000)
+#define U300_SYSCON_VBASE		IOADD(U300_SLOW_PER_VIRT_BASE+0x1000)
 
 /* Watchdog */
 #define U300_WDOG_BASE			(U300_SLOW_PER_PHYS_BASE+0x2000)
@@ -125,7 +124,7 @@
 
 /* APP side special timer */
 #define U300_TIMER_APP_BASE		(U300_SLOW_PER_PHYS_BASE+0x4000)
-#define U300_TIMER_APP_VBASE		(U300_SLOW_PER_VIRT_BASE+0x4000)
+#define U300_TIMER_APP_VBASE		IOADD(U300_SLOW_PER_VIRT_BASE+0x4000)
 
 /* Keypad */
 #define U300_KEYPAD_BASE		(U300_SLOW_PER_PHYS_BASE+0x5000)
@@ -181,5 +180,4 @@
  * Virtual accessor macros for static devices
  */
 
-
 #endif
-- 
1.7.3.2

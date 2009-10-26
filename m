From: pjohn@in.mvista.com (Philby John)
Date: Mon, 26 Oct 2009 15:52:07 +0530
Subject: [PATCH 1/1] reboot: Fix Realview ARM1176PB board reboot
In-Reply-To: <1256230510.8608.50.camel@pc1117.cambridge.arm.com>
References: <1256216280.6515.13.camel@localhost.localdomain>
	<1256230510.8608.50.camel@pc1117.cambridge.arm.com>
Message-ID: <1256552527.14462.5.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 5232cef61052a2d25fa7301d06397811365ad65d Mon Sep 17 00:00:00 2001
From: pjohn <pjohn@in.mvista.com>
Date: Wed, 8 Jul 2009 17:53:01 +0530
Subject: [PATCH] Fix Realview ARM1176PB board reboot

This is the fix for proper reboot of Realview ARM1176PB board
when issuing the reboot command. Setting the eighth bit of
control register SYS_RESETCTL to 1 to force a soft reset.
arch_reset() is modified for realview machines to call machine
specific reset function pointers.

Signed-off-by: Philby John <pjohn@in.mvista.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.h                      |    2 +-
 arch/arm/mach-realview/include/mach/board-pb1176.h |    5 +++++
 arch/arm/mach-realview/include/mach/board-pb11mp.h |   12 ++++++++++++
 arch/arm/mach-realview/include/mach/platform.h     |   15 +--------------
 arch/arm/mach-realview/include/mach/system.h       |   10 ++++------
 arch/arm/mach-realview/realview_pb1176.c           |   11 +++++++++++
 arch/arm/mach-realview/realview_pb11mp.c           |   16 ++++++++++++++++
 7 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 59a337b..ae9891c 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -61,5 +61,5 @@ extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
 extern int realview_eth_register(const char *name, struct resource *res);
 extern int realview_usb_register(struct resource *res);
-
+extern void (*realview_reset)(char);
 #endif
diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 98f8e7e..34b80b7 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -73,4 +73,9 @@
 #define REALVIEW_PB1176_GIC_DIST_BASE		0x10041000 /* GIC distributor, on FPGA */
 #define REALVIEW_PB1176_L220_BASE		0x10110000 /* L220 registers */
 
+/*
+ * Control register SYS_RESETCTL is set to 1 to force a soft reset
+ */
+#define REALVIEW_PB1176_SYS_LOCKVAL_RSTCTL    0x0100
+
 #endif	/* __ASM_ARCH_BOARD_PB1176_H */
diff --git a/arch/arm/mach-realview/include/mach/board-pb11mp.h b/arch/arm/mach-realview/include/mach/board-pb11mp.h
index f0d68e0..7abf918 100644
--- a/arch/arm/mach-realview/include/mach/board-pb11mp.h
+++ b/arch/arm/mach-realview/include/mach/board-pb11mp.h
@@ -81,4 +81,16 @@
 #define REALVIEW_TC11MP_GIC_DIST_BASE		0x1F001000	/* Test chip interrupt controller distributor */
 #define REALVIEW_TC11MP_L220_BASE		0x1F002000	/* L220 registers */
 
+ /*
+ * Values for REALVIEW_SYS_RESET_CTRL
+ */
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_CONFIGCLR    0x01
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_CONFIGINIT   0x02
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_DLLRESET     0x03
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_PLLRESET     0x04
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_POR          0x05
+#define REALVIEW_PB11MP_SYS_CTRL_RESET_DoC          0x06
+
+#define REALVIEW_PB11MP_SYS_CTRL_LED         (1 << 0)
+
 #endif	/* __ASM_ARCH_BOARD_PB11MP_H */
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index c8f5083..4f46bf7 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -119,19 +119,6 @@
 #define REALVIEW_SYS_TEST_OSC3               (REALVIEW_SYS_BASE + REALVIEW_SYS_TEST_OSC3_OFFSET)
 #define REALVIEW_SYS_TEST_OSC4               (REALVIEW_SYS_BASE + REALVIEW_SYS_TEST_OSC4_OFFSET)
 
-/* 
- * Values for REALVIEW_SYS_RESET_CTRL
- */
-#define REALVIEW_SYS_CTRL_RESET_CONFIGCLR    0x01
-#define REALVIEW_SYS_CTRL_RESET_CONFIGINIT   0x02
-#define REALVIEW_SYS_CTRL_RESET_DLLRESET     0x03
-#define REALVIEW_SYS_CTRL_RESET_PLLRESET     0x04
-#define REALVIEW_SYS_CTRL_RESET_POR          0x05
-#define REALVIEW_SYS_CTRL_RESET_DoC          0x06
-
-#define REALVIEW_SYS_CTRL_LED         (1 << 0)
-
-
 /* ------------------------------------------------------------------------
  *  RealView control registers
  * ------------------------------------------------------------------------
@@ -153,7 +140,7 @@
  *     SYS_CLD, SYS_BOOTCS
  */
 #define REALVIEW_SYS_LOCK_LOCKED    (1 << 16)
-#define REALVIEW_SYS_LOCKVAL_MASK	0xFFFF		/* write 0xA05F to enable write access */
+#define REALVIEW_SYS_LOCKVAL_MASK	0xA05F	       /* Enable write access */
 
 /*
  * REALVIEW_SYS_FLASH
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
index 1a15a44..a30f2e3 100644
--- a/arch/arm/mach-realview/include/mach/system.h
+++ b/arch/arm/mach-realview/include/mach/system.h
@@ -25,6 +25,8 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
+void (*realview_reset)(char mode);
+
 static inline void arch_idle(void)
 {
 	/*
@@ -36,16 +38,12 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_RESETCTL_OFFSET;
-	unsigned int val;
-
 	/*
 	 * To reset, we hit the on-board reset register
 	 * in the system FPGA
 	 */
-	val = __raw_readl(hdr_ctrl);
-	val |= REALVIEW_SYS_CTRL_RESET_CONFIGCLR;
-	__raw_writel(val, hdr_ctrl);
+	if (realview_reset)
+		realview_reset(mode);
 }
 
 #endif
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 25efe71..38fa89e 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -274,6 +274,16 @@ static struct sys_timer realview_pb1176_timer = {
 	.init		= realview_pb1176_timer_init,
 };
 
+static void realview_pb1176_reset(char mode)
+{
+	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
+		REALVIEW_SYS_RESETCTL_OFFSET;
+	void __iomem *rst_hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
+		REALVIEW_SYS_LOCK_OFFSET;
+	__raw_writel(REALVIEW_SYS_LOCKVAL_MASK, rst_hdr_ctrl);
+	__raw_writel(REALVIEW_PB1176_SYS_LOCKVAL_RSTCTL, hdr_ctrl);
+}
+
 static void __init realview_pb1176_init(void)
 {
 	int i;
@@ -297,6 +307,7 @@ static void __init realview_pb1176_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
+	realview_reset = realview_pb1176_reset;
 }
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index dc4b169..a47881b 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -283,6 +283,21 @@ static struct sys_timer realview_pb11mp_timer = {
 	.init		= realview_pb11mp_timer_init,
 };
 
+static void realview_pb11mp_reset(char mode)
+{
+	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
+		REALVIEW_SYS_RESETCTL_OFFSET;
+	unsigned int val;
+
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	val = __raw_readl(hdr_ctrl);
+	val |= REALVIEW_PB11MP_SYS_CTRL_RESET_CONFIGCLR;
+	__raw_writel(val, hdr_ctrl);
+}
+
 static void __init realview_pb11mp_init(void)
 {
 	int i;
@@ -308,6 +323,7 @@ static void __init realview_pb11mp_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
+	realview_reset = realview_pb11mp_reset;
 }
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
-- 
1.6.3.3.MVISTA

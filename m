From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:25 +0200
Subject: [PATCH v4 12/17] arm: plat-orion: use void __iomem pointers for time
 functions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions for time management now take void __iomem pointers, so
we remove the temporary "unsigned long" casts from the mach-*/common.c
files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c             |    5 ++---
 arch/arm/mach-kirkwood/common.c         |    5 ++---
 arch/arm/mach-mv78xx0/common.c          |    5 ++---
 arch/arm/mach-orion5x/common.c          |    5 ++---
 arch/arm/plat-orion/include/plat/time.h |    4 ++--
 arch/arm/plat-orion/time.c              |    8 ++++----
 6 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index ba55f63..cb65599 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -185,7 +185,7 @@ void __init dove_i2c_init(void)
  ****************************************************************************/
 void __init dove_init_early(void)
 {
-	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 static int get_tclk(void)
@@ -196,8 +196,7 @@ static int get_tclk(void)
 
 static void __init dove_timer_init(void)
 {
-	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
-			BRIDGE_INT_TIMER1_CLR,
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
 			IRQ_DOVE_BRIDGE, get_tclk());
 }
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index defceca..55bf919 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -514,7 +514,7 @@ void __init kirkwood_wdt_init(void)
  ****************************************************************************/
 void __init kirkwood_init_early(void)
 {
-	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
+	orion_time_set_base(TIMER_VIRT_BASE);
 
 	/*
 	 * Some Kirkwood devices allocate their coherent buffers from atomic
@@ -543,8 +543,7 @@ static void __init kirkwood_timer_init(void)
 {
 	kirkwood_tclk = kirkwood_find_tclk();
 
-	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
-			BRIDGE_INT_TIMER1_CLR,
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
 			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
 }
 
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index fcda4a4..f123517 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -338,13 +338,12 @@ void __init mv78xx0_uart3_init(void)
  ****************************************************************************/
 void __init mv78xx0_init_early(void)
 {
-	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 static void mv78xx0_timer_init(void)
 {
-	orion_time_init((unsigned long) BRIDGE_VIRT_BASE,
-			BRIDGE_INT_TIMER1_CLR,
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
 			IRQ_MV78XX0_TIMER_1, get_tclk());
 }
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 79f9ffb..58b754f 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -203,7 +203,7 @@ void __init orion5x_wdt_init(void)
  ****************************************************************************/
 void __init orion5x_init_early(void)
 {
-	orion_time_set_base((unsigned long) TIMER_VIRT_BASE);
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 int orion5x_tclk;
@@ -224,8 +224,7 @@ static void __init orion5x_timer_init(void)
 {
 	orion5x_tclk = orion5x_find_tclk();
 
-	orion_time_init((unsigned long) ORION5X_BRIDGE_VIRT_BASE,
-			BRIDGE_INT_TIMER1_CLR,
+	orion_time_init(ORION5X_BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
 			IRQ_ORION5X_BRIDGE, orion5x_tclk);
 }
 
diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orion/include/plat/time.h
index 4d5f1f6..07527e4 100644
--- a/arch/arm/plat-orion/include/plat/time.h
+++ b/arch/arm/plat-orion/include/plat/time.h
@@ -11,9 +11,9 @@
 #ifndef __PLAT_TIME_H
 #define __PLAT_TIME_H
 
-void orion_time_set_base(u32 timer_base);
+void orion_time_set_base(void __iomem *timer_base);
 
-void orion_time_init(u32 bridge_base, u32 bridge_timer1_clr_mask,
+void orion_time_init(void __iomem *bridge_base, u32 bridge_timer1_clr_mask,
 		     unsigned int irq, unsigned int tclk);
 
 
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 1ed8d13..0f4fa86 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -180,13 +180,13 @@ static struct irqaction orion_timer_irq = {
 };
 
 void __init
-orion_time_set_base(u32 _timer_base)
+orion_time_set_base(void __iomem *_timer_base)
 {
-	timer_base = (void __iomem *)_timer_base;
+	timer_base = _timer_base;
 }
 
 void __init
-orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
+orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 		unsigned int irq, unsigned int tclk)
 {
 	u32 u;
@@ -194,7 +194,7 @@ orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Set SoC-specific data.
 	 */
-	bridge_base = (void __iomem *)_bridge_base;
+	bridge_base = _bridge_base;
 	bridge_timer1_clr_mask = _bridge_timer1_clr_mask;
 
 	ticks_per_jiffy = (tclk + HZ/2) / HZ;
-- 
1.7.9.5

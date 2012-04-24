From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 11:20:08 +0530
Subject: [PATCH V3 1/2] ARM: SMP_TWD: WDOG: Start registers from 0x00 instead
 of 0x20
Message-ID: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TWD_WDOG is at offset 0x20 from TWD base address. Current register offsets
contain this extra 0x20 offset, i.e. users were required to pass base address of
TWD instead of WDOG to WDOG driver.

Change this, so that users can pass base address of WDOG to WDOG driver instead
of TWD module. For this, subtract 0x20 from offsets of WDOG registers.

This could break any current users of TWD_WDOG, but i couldn't find any users of
this driver in current Linux tree. So, haven't fixed any platform code. If some
platforms are broken please report to me, so that we can get them fixed in this
patch only.

This also moves these register macros to mpcore_wdt.c, as there wouldn't be any
more users of these macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V2->V3:
- Move register offsets from header file to source file.

 arch/arm/include/asm/smp_twd.h |   19 -------------------
 drivers/watchdog/mpcore_wdt.c  |   24 +++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 57857d1..62640cf 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -6,30 +6,11 @@
 #define TWD_TIMER_CONTROL		0x08
 #define TWD_TIMER_INTSTAT		0x0C
 
-#define TWD_WDOG_LOAD			0x20
-#define TWD_WDOG_COUNTER		0x24
-#define TWD_WDOG_CONTROL		0x28
-#define TWD_WDOG_INTSTAT		0x2C
-#define TWD_WDOG_RESETSTAT		0x30
-#define TWD_WDOG_DISABLE		0x34
-
-#define TWD_WDOG_LOAD_MIN		0x00000000
-#define TWD_WDOG_LOAD_MAX		0xFFFFFFFF
-
 #define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
 #define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-#define TWD_WDOG_CONTROL_ENABLE		(1 << 0)
-#define TWD_WDOG_CONTROL_IRQ_ENABLE	(1 << 2)
-#define TWD_WDOG_CONTROL_WDT_MODE	(1 << 3)
-#define TWD_WDOG_CONTROL_WDT_PRESCALE(x)	((x) << 8)
-#define TWD_WDOG_CONTROL_PRESCALE_MIN	0x00
-#define TWD_WDOG_CONTROL_PRESCALE_MAX	0xFF
-
-#define TWD_WDOG_RESETSTAT_MASK		0x1
-
 #include <linux/ioport.h>
 
 struct twd_local_timer {
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c00455..13197c7 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -34,7 +34,29 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
-#include <asm/smp_twd.h>
+/*
+ * TWD_WDOG is at offset 0x20 from TWD base address. Following register offsets
+ * doesn't contain this extra 0x20 offset, i.e. users of TWD_WDOG must pass base
+ * address of WDOG to WDOG driver instead of TWD module.
+ */
+#define TWD_WDOG_LOAD				0x00
+#define TWD_WDOG_COUNTER			0x04
+#define TWD_WDOG_CONTROL			0x08
+#define TWD_WDOG_INTSTAT			0x0C
+#define TWD_WDOG_RESETSTAT			0x10
+#define TWD_WDOG_DISABLE			0x14
+
+#define TWD_WDOG_LOAD_MIN			0x00000000
+#define TWD_WDOG_LOAD_MAX			0xFFFFFFFF
+
+#define TWD_WDOG_CONTROL_ENABLE			(1 << 0)
+#define TWD_WDOG_CONTROL_IRQ_ENABLE		(1 << 2)
+#define TWD_WDOG_CONTROL_WDT_MODE		(1 << 3)
+#define TWD_WDOG_CONTROL_WDT_PRESCALE(x)	((x) << 8)
+#define TWD_WDOG_CONTROL_PRESCALE_MIN		0x00
+#define TWD_WDOG_CONTROL_PRESCALE_MAX		0xFF
+
+#define TWD_WDOG_RESETSTAT_MASK			0x1
 
 struct mpcore_wdt {
 	struct watchdog_device wdd;
-- 
1.7.9

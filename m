From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:27 +0000
Subject: [PATCH 11/18] ARM: PNX4008: remove platform definitions from
	mach/timex.h
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <a332a82bc4b982f18db43f32c7e978e10befcc9f.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is only supposed to contain a definition for
CLOCK_TICK_RATE.  Remove additional includes, and move private
definitions to a private header file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/include/mach/timex.h |   54 ---------------------
 arch/arm/mach-pnx4008/pm.c                 |    2 +
 arch/arm/mach-pnx4008/time.c               |    2 +
 arch/arm/mach-pnx4008/time.h               |   70 ++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/mach-pnx4008/time.h

diff --git a/arch/arm/mach-pnx4008/include/mach/timex.h b/arch/arm/mach-pnx4008/include/mach/timex.h
index 5ff0196..b383c7d 100644
--- a/arch/arm/mach-pnx4008/include/mach/timex.h
+++ b/arch/arm/mach-pnx4008/include/mach/timex.h
@@ -14,60 +14,6 @@
 #ifndef __PNX4008_TIMEX_H
 #define __PNX4008_TIMEX_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-
 #define CLOCK_TICK_RATE		1000000
 
-#define TICKS2USECS(x)	(x)
-
-/* MilliSecond Timer - Chapter 21 Page 202 */
-
-#define MSTIM_INT     IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x0))
-#define MSTIM_CTRL    IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x4))
-#define MSTIM_COUNTER IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x8))
-#define MSTIM_MCTRL   IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x14))
-#define MSTIM_MATCH0  IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x18))
-#define MSTIM_MATCH1  IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x1c))
-
-/* High Speed Timer - Chpater 22, Page 205 */
-
-#define HSTIM_INT     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x0))
-#define HSTIM_CTRL    IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x4))
-#define HSTIM_COUNTER IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x8))
-#define HSTIM_PMATCH  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0xC))
-#define HSTIM_PCOUNT  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x10))
-#define HSTIM_MCTRL   IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x14))
-#define HSTIM_MATCH0  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x18))
-#define HSTIM_MATCH1  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x1c))
-#define HSTIM_MATCH2  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x20))
-#define HSTIM_CCR     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x28))
-#define HSTIM_CR0     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x2C))
-#define HSTIM_CR1     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x30))
-
-/* IMPORTANT: both timers are UPCOUNTING */
-
-/* xSTIM_MCTRL bit definitions */
-#define MR0_INT        1
-#define RESET_COUNT0   (1<<1)
-#define STOP_COUNT0    (1<<2)
-#define MR1_INT        (1<<3)
-#define RESET_COUNT1   (1<<4)
-#define STOP_COUNT1    (1<<5)
-#define MR2_INT        (1<<6)
-#define RESET_COUNT2   (1<<7)
-#define STOP_COUNT2    (1<<8)
-
-/* xSTIM_CTRL bit definitions */
-#define COUNT_ENAB     1
-#define RESET_COUNT    (1<<1)
-#define DEBUG_EN       (1<<2)
-
-/* xSTIM_INT bit definitions */
-#define MATCH0_INT     1
-#define MATCH1_INT     (1<<1)
-#define MATCH2_INT     (1<<2)
-#define RTC_TICK0      (1<<4)
-#define RTC_TICK1      (1<<5)
-
 #endif
diff --git a/arch/arm/mach-pnx4008/pm.c b/arch/arm/mach-pnx4008/pm.c
index b3d8d53..1f05853 100644
--- a/arch/arm/mach-pnx4008/pm.c
+++ b/arch/arm/mach-pnx4008/pm.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+
+#include <mach/hardware.h>
 #include <mach/pm.h>
 #include <mach/clock.h>
 
diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index fc0ba18..0c8aad4 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -30,6 +30,8 @@
 #include <asm/mach/time.h>
 #include <asm/errno.h>
 
+#include "time.h"
+
 /*! Note: all timers are UPCOUNTING */
 
 /*!
diff --git a/arch/arm/mach-pnx4008/time.h b/arch/arm/mach-pnx4008/time.h
new file mode 100644
index 0000000..75e88c5
--- /dev/null
+++ b/arch/arm/mach-pnx4008/time.h
@@ -0,0 +1,70 @@
+/*
+ * arch/arm/mach-pnx4008/include/mach/timex.h
+ *
+ * PNX4008 timers header file
+ *
+ * Author: Dmitry Chigirev <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef PNX_TIME_H
+#define PNX_TIME_H
+
+#include <linux/io.h>
+#include <mach/hardware.h>
+
+#define TICKS2USECS(x)	(x)
+
+/* MilliSecond Timer - Chapter 21 Page 202 */
+
+#define MSTIM_INT     IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x0))
+#define MSTIM_CTRL    IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x4))
+#define MSTIM_COUNTER IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x8))
+#define MSTIM_MCTRL   IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x14))
+#define MSTIM_MATCH0  IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x18))
+#define MSTIM_MATCH1  IO_ADDRESS((PNX4008_MSTIMER_BASE + 0x1c))
+
+/* High Speed Timer - Chpater 22, Page 205 */
+
+#define HSTIM_INT     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x0))
+#define HSTIM_CTRL    IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x4))
+#define HSTIM_COUNTER IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x8))
+#define HSTIM_PMATCH  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0xC))
+#define HSTIM_PCOUNT  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x10))
+#define HSTIM_MCTRL   IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x14))
+#define HSTIM_MATCH0  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x18))
+#define HSTIM_MATCH1  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x1c))
+#define HSTIM_MATCH2  IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x20))
+#define HSTIM_CCR     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x28))
+#define HSTIM_CR0     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x2C))
+#define HSTIM_CR1     IO_ADDRESS((PNX4008_HSTIMER_BASE + 0x30))
+
+/* IMPORTANT: both timers are UPCOUNTING */
+
+/* xSTIM_MCTRL bit definitions */
+#define MR0_INT        1
+#define RESET_COUNT0   (1<<1)
+#define STOP_COUNT0    (1<<2)
+#define MR1_INT        (1<<3)
+#define RESET_COUNT1   (1<<4)
+#define STOP_COUNT1    (1<<5)
+#define MR2_INT        (1<<6)
+#define RESET_COUNT2   (1<<7)
+#define STOP_COUNT2    (1<<8)
+
+/* xSTIM_CTRL bit definitions */
+#define COUNT_ENAB     1
+#define RESET_COUNT    (1<<1)
+#define DEBUG_EN       (1<<2)
+
+/* xSTIM_INT bit definitions */
+#define MATCH0_INT     1
+#define MATCH1_INT     (1<<1)
+#define MATCH2_INT     (1<<2)
+#define RTC_TICK0      (1<<4)
+#define RTC_TICK1      (1<<5)
+
+#endif
-- 
1.6.2.5

From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 17 Aug 2017 09:39:20 +0100
Subject: [PATCH v2 2/2] arm64: use WFE for long delays
In-Reply-To: <1502959160-30900-1-git-send-email-julien.thierry@arm.com>
References: <1502959160-30900-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1502959160-30900-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current delay implementation uses the yield instruction, which is a hint
that it is beneficial to schedule another thread. As this is a hint, it may be
implemented as a NOP, causing all delays to be busy loops. This is the case for
many existing CPUs.

Taking advantage of the generic timer sending periodic events to all cores, we
can use WFE during delays to reduce power consumption. This is beneficial only
for delays longer than the period of the timer event stream.

If timer event stream is not enabled, delays will behave as yield/busy loops.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/lib/delay.c      | 25 ++++++++++++++++++++-----
 include/asm-generic/delay.h |  9 +++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index dad4ec9..ada7005 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -24,10 +24,28 @@
 #include <linux/module.h>
 #include <linux/timex.h>

+#include <clocksource/arm_arch_timer.h>
+
+#define USECS_TO_CYCLES(TIME_USECS)			\
+	(xloops_to_cycles(usecs_to_xloops(TIME_USECS)))
+
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
 void __delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();

+	if (arch_timer_evtstrm_available()) {
+		const cycles_t timer_evt_period =
+			USECS_TO_CYCLES(1000000 / ARCH_TIMER_EVT_STREAM_FREQ);
+
+		while (get_cycles() - start + timer_evt_period < cycles)
+			wfe();
+	}
+
 	while ((get_cycles() - start) < cycles)
 		cpu_relax();
 }
@@ -35,16 +53,13 @@ void __delay(unsigned long cycles)

 inline void __const_udelay(unsigned long xloops)
 {
-	unsigned long loops;
-
-	loops = xloops * loops_per_jiffy * HZ;
-	__delay(loops >> 32);
+	__delay(xloops_to_cycles(xloops));
 }
 EXPORT_SYMBOL(__const_udelay);

 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs_to_xloops(usecs));
 }
 EXPORT_SYMBOL(__udelay);

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 0f79054..1538e58 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -10,19 +10,24 @@
 extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);

+/* 0x10c7 is 2**32 / 1000000 (rounded up) */
+static inline unsigned long usecs_to_xloops(unsigned long usecs)
+{
+	return usecs * 0x10C7UL;
+}
+
 /*
  * The weird n/20000 thing suppresses a "comparison is always false due to
  * limited range of data type" warning with non-const 8-bit arguments.
  */

-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
 #define udelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
 			if ((n) / 20000 >= 1)				\
 				 __bad_udelay();			\
 			else						\
-				__const_udelay((n) * 0x10c7ul);		\
+				__const_udelay(usecs_to_xloops(n));	\
 		} else {						\
 			__udelay(n);					\
 		}							\
--
1.9.1

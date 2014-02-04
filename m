From: joe@perches.com (Joe Perches)
Date: Tue, 04 Feb 2014 08:36:36 -0800
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <1391483274-20331-2-git-send-email-sujith@msujith.org>
 <1391484878.2538.11.camel@joe-AO722>
 <21232.24855.201543.400943@gargle.gargle.HOWL>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
Message-ID: <1391531796.2538.21.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-04 at 08:03 +0100, Holger Schurig wrote:
> Joe, look in linux/arch/arm/include/asm/delay.h. The macro udelay
> cannot handle large values because of lost-of-precision.
> 
> IMHO udelay on ARM is broken, because it also cannot work with fast
> ARM processors (where bogomips >= 3355, which is in sight now). It's
> just not broken enought that someone did something against it ...   so
> the current kludge is good enought.

Maybe something like this would be better?

---
 arch/arm/include/asm/delay.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index dff714d..ac33c56 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -15,6 +15,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/printk.h>
+
 struct delay_timer {
 	unsigned long (*read_current_timer)(void);
 	unsigned long freq;
@@ -51,11 +53,34 @@ extern void __bad_udelay(void);
 #define __udelay(n)		arm_delay_ops.udelay(n)
 #define __const_udelay(n)	arm_delay_ops.const_udelay(n)
 
+#ifdef DEBUG
+#define __udelay_debug_max_delay(n)					\
+do {									\
+	if (n > MAX_UDELAY_MS * 1000) {					\
+		pr_debug("udelay(%d) too large - Convert to mdelay\n", n); \
+		dump_stack();						\
+	}								\
+} while (0)
+#else
+#define __udelay_debug_max_delay(n)					\
+	do {} while (0)
+#endif
+
 #define udelay(n)							\
-	(__builtin_constant_p(n) ?					\
-	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
-			__const_udelay((n) * UDELAY_MULT)) :		\
-	  __udelay(n))
+({									\
+	if (__builtin_constant_p(n)) {					\
+		typeof n _n = n;					\
+		while (_n > MAX_UDELAY_MS * 1000) {			\
+			__const_udelay(MAX_UDELAY_MS * 1000 * UDELAY_MULT); \
+			_n -= MAX_UDELAY_MS * 1000;			\
+		}							\
+		if (_n)							\
+			__const_udelay(_n * 1000 * UDELAY_MULT);	\
+	} else {							\
+		__udelay_debug_max_delay(n);				\
+		__udelay(n);						\
+	}								\
+})
 
 /* Loop-based definitions for assembly code. */
 extern void __loop_delay(unsigned long loops);

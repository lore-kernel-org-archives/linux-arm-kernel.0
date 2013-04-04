From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:00 +0200
Subject: [PATCH v4 03/14] clocksource: samsung-time: Use local register
 definitions
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch copies PWM timer register definitions to samsung-time.c. The
original header in plat is being kept for now, since it is also used by
other code that also needs to be reworked to be multiplatform-friendly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung-time.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index d4d7e3e..bccc291 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -24,9 +24,43 @@
 
 #include <mach/map.h>
 #include <plat/devs.h>
-#include <plat/regs-timer.h>
 #include <plat/samsung-time.h>
 
+#define S3C_TIMERREG(x) (S3C_VA_TIMER + (x))
+#define S3C_TIMERREG2(tmr,reg) S3C_TIMERREG((reg)+0x0c+((tmr)*0x0c))
+
+#define S3C2410_TCON	      S3C_TIMERREG(0x08)
+#define S3C64XX_TINT_CSTAT    S3C_TIMERREG(0x44)
+
+/* for each timer, we have an count buffer, an compare buffer and
+ * an observation buffer
+*/
+
+/* WARNING - timer 4 has no buffer reg, and it's observation is at +4 */
+
+#define S3C2410_TCNTB(tmr)    S3C_TIMERREG2(tmr, 0x00)
+#define S3C2410_TCMPB(tmr)    S3C_TIMERREG2(tmr, 0x04)
+
+#define S3C2410_TCON_T4RELOAD	  (1<<22)
+#define S3C2410_TCON_T4MANUALUPD  (1<<21)
+#define S3C2410_TCON_T4START	  (1<<20)
+
+#define S3C2410_TCON_T3RELOAD	  (1<<19)
+#define S3C2410_TCON_T3MANUALUPD  (1<<17)
+#define S3C2410_TCON_T3START	  (1<<16)
+
+#define S3C2410_TCON_T2RELOAD	  (1<<15)
+#define S3C2410_TCON_T2MANUALUPD  (1<<13)
+#define S3C2410_TCON_T2START	  (1<<12)
+
+#define S3C2410_TCON_T1RELOAD	  (1<<11)
+#define S3C2410_TCON_T1MANUALUPD  (1<<9)
+#define S3C2410_TCON_T1START	  (1<<8)
+
+#define S3C2410_TCON_T0RELOAD	  (1<<3)
+#define S3C2410_TCON_T0MANUALUPD  (1<<1)
+#define S3C2410_TCON_T0START	  (1<<0)
+
 static struct clk *tin_event;
 static struct clk *tin_source;
 static struct clk *tdiv_event;
-- 
1.8.1.5

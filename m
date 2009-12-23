From: eltshanli@gmail.com (Li Jie)
Date: Wed, 23 Dec 2009 17:33:28 +0800
Subject: [PATCH] ARM: NUC900: Implement arch_reset() via WDT
Message-ID: <8fb2581d0912230133g59e77898he857061911eab449@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan:

This patch implements the arch_reset() via WDT.
reboot from shell become possible :)

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-w90x900/include/mach/system.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/include/mach/system.h
b/arch/arm/mach-w90x900/include/mach/system.h
index 9406400..ce228bd 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -15,7 +15,15 @@
  *
  */

+#include <linux/io.h>
 #include <asm/proc-fns.h>
+#include <mach/map.h>
+#include <mach/regs-timer.h>
+
+#define	WTCR	(TMR_BA + 0x1C)
+#define	WTCLK	(1 << 10)
+#define	WTE	(1 << 7)
+#define	WTRE	(1 << 1)

 static void arch_idle(void)
 {
@@ -23,6 +31,11 @@ static void arch_idle(void)

 static void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
+	if (mode == 's') {
+		/* Jump into ROM@address 0 */
+		cpu_reset(0);
+	} else {
+		__raw_writel(WTE | WTRE | WTCLK, WTCR);
+	}
 }

-- 
1.6.5.4

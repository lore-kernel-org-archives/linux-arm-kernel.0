From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:23:14 +0100
Subject: [PATCH 03/11] ARM: mvebu: add workaround for data abort issue on
 Armada 375
In-Reply-To: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392053002-19831-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early versions of Armada 375 SoC have a bug where the BootROM leaves
an external data abort pending. The kernel is hit by this data abort
as soon as it enters userspace, because it unmasks the data aborts at
this moment. We register a custom abort handler below to ignore the
first data abort to work around this problem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-375.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-375.c b/arch/arm/mach-mvebu/armada-375.c
index f13c9de..d772ae2 100644
--- a/arch/arm/mach-mvebu/armada-375.c
+++ b/arch/arm/mach-mvebu/armada-375.c
@@ -22,14 +22,37 @@
 #include <linux/mbus.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
+#include <asm/signal.h>
 #include "common.h"
 
+/*
+ * Early versions of Armada 375 SoC have a bug where the BootROM
+ * leaves an external data abort pending. The kernel is hit by this
+ * data abort as soon as it enters userspace, because it unmasks the
+ * data aborts at this moment. We register a custom abort handler
+ * below to ignore the first data abort to work around this problem.
+ */
+static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
+					struct pt_regs *regs)
+{
+	static int ignore_first;
+
+	if (!ignore_first) {
+		ignore_first = 1;
+		return 0;
+	}
+
+	return 1;
+}
+
 static void __init armada_375_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
 	clocksource_of_init();
 	BUG_ON(mvebu_mbus_dt_init());
 	l2x0_of_init(0, ~0UL);
+	hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
+			"imprecise external abort");
 }
 
 static const char * const armada_375_dt_compat[] = {
-- 
1.8.3.2

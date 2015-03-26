From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 11:45:51 +0000
Subject: [RFC 3/6] clocksource: tcb_clksrc: use atmel_io.h to provide on-chip
 IO
In-Reply-To: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427370354-21247-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use <linux/atmel_io.h> to provide IO accessors which work on both
AVR32 and ARM for on-chip peripherals.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/clocksource/tcb_clksrc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 0f819dd3..b25416d 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -9,6 +9,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/atmel_io.h>
 #include <linux/atmel_tc.h>
 
 
@@ -41,13 +42,8 @@
 
 static void __iomem *tcaddr;
 
-#ifdef CONFIG_AVR32
-#define tcb_readl	__raw_readl
-#define tcb_writel	__raw_writel
-#else
-#define tcb_readl	readl_relaxed
-#define tcb_writel	writel_relaxed
-#endif
+#define tcb_readl	atmel_oc_readl
+#define tcb_writel	atmel_oc_writel
 
 static cycle_t tc_get_cycles(struct clocksource *cs)
 {
-- 
2.1.4

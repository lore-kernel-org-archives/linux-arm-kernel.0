From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 20:54:52 +0530
Subject: [PATCH] irqchip: exynos-combiner: Fix compilation error on ARM64
Message-ID: <1409671492-7725-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following compilation error occurs on 64-bit Exynos7 SoC:

drivers/irqchip/exynos-combiner.c: In function ?combiner_irq_domain_map?:
drivers/irqchip/exynos-combiner.c:162:2: error: implicit declaration of function ?set_irq_flags? [-Werror=implicit-function-declaration]
  set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
  ^
drivers/irqchip/exynos-combiner.c:162:21: error: ?IRQF_VALID? undeclared (first use in this function)
  set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
                     ^
drivers/irqchip/exynos-combiner.c:162:21: note: each undeclared identifier is reported only once for each function it appears in
drivers/irqchip/exynos-combiner.c:162:34: error: ?IRQF_PROBE? undeclared (first use in this function)
  set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);

Fix the build error by including asm/hardirq.h.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/exynos-combiner.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index f8636a6..7fbedcc 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -18,6 +18,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/hardirq.h>
+
 #include "irqchip.h"
 
 #define COMBINER_ENABLE_SET	0x0
-- 
1.7.9.5

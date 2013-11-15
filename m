From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:59 +0400
Subject: [PATCH 8/9] ARM: sa1100: move per-IRQ PWER settings to core code
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-9-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In attempt to limit register access from non-core code, move PWER access
to generic.c, having irqchip code call sa11x0_sc_set_wake() function
to set wake status.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 59c1617..d96f65f 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -18,8 +18,6 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #include "generic.h"
@@ -43,14 +41,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (d->irq == IRQ_RTCAlrm) {
-		if (on)
-			PWER |= PWER_RTC;
-		else
-			PWER &= ~PWER_RTC;
-		return 0;
-	}
-	return -EINVAL;
+	return sa11x0_sc_set_wake(d->irq, on);
 }
 
 static struct irq_chip sa1100_normal_chip = {
-- 
1.8.4.2

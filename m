From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 10:31:50 +0900
Subject: [PATCH] ARM: S5PV310: Optimize interrupt source searching code
Message-ID: <1285637510-16740-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

It is reported by Junseok Jung that using clz instruction is
better instead of using for-loop to find the interrupt source.
This patch modifies interrupt source searching code using __fls().
The __fls() is implemented using clz instruction.

Suggested-by: Junseok Jung <jundols.jung@samsung.com>
Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/irq-combiner.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
index 0f70521..39e3647 100644
--- a/arch/arm/mach-s5pv310/irq-combiner.c
+++ b/arch/arm/mach-s5pv310/irq-combiner.c
@@ -66,11 +66,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	if (status == 0)
 		goto out;
 
-	for (combiner_irq = 0; combiner_irq < 32; combiner_irq++) {
-		if (status & 0x1)
-			break;
-		status >>= 1;
-	}
+	combiner_irq = __fls(status);
 
 	cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
 	if (unlikely(cascade_irq >= NR_IRQS))
-- 
1.6.2.5

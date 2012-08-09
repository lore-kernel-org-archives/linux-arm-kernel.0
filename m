From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:53:54 +0100
Subject: [PATCH 7/8] mfd: Use the AB8500's IRQ domain to convert hwirq to virq
In-Reply-To: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527635-6163-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the AB8500 had its own IRQ domain, the IRQ handler would take
the fired local IRQ (hwirq) and add it to the irq_base to convert it
to an IRQ number which Linux would understand (virq). However, the
IRQ base is not always used anymore since we can make use of Linear
domains. It's better to use the AB8500 hwirq -> virq mapping helper
function to convert them instead. That's what we do here.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 0c5b70f..71a7757 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -501,8 +501,9 @@ static irqreturn_t ab8500_irq(int irq, void *dev)
 		do {
 			int bit = __ffs(value);
 			int line = i * 8 + bit;
+			int virq = ab8500_irq_get_virq(ab8500, line);
 
-			handle_nested_irq(ab8500->irq_base + line);
+			handle_nested_irq(virq);
 			value &= ~(1 << bit);
 
 		} while (value);
-- 
1.7.9.5

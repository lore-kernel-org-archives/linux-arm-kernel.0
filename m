From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 23 Sep 2014 14:34:58 +0800
Subject: [PATCH 1/3] irqchip: dw-apb-ictl: always use use
 {readl|writel}_relaxed
In-Reply-To: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
Message-ID: <1411454100-6814-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

relaxed version and non-relaxed version are mixed, this patch always
use the relaxed version to unify the memory access usage.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 31e231e..fcc3385 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -94,16 +94,16 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	 */
 
 	/* mask and enable all interrupts */
-	writel(~0, iobase + APB_INT_MASK_L);
-	writel(~0, iobase + APB_INT_MASK_H);
-	writel(~0, iobase + APB_INT_ENABLE_L);
-	writel(~0, iobase + APB_INT_ENABLE_H);
+	writel_relaxed(~0, iobase + APB_INT_MASK_L);
+	writel_relaxed(~0, iobase + APB_INT_MASK_H);
+	writel_relaxed(~0, iobase + APB_INT_ENABLE_L);
+	writel_relaxed(~0, iobase + APB_INT_ENABLE_H);
 
-	reg = readl(iobase + APB_INT_ENABLE_H);
+	reg = readl_relaxed(iobase + APB_INT_ENABLE_H);
 	if (reg)
 		nrirqs = 32 + fls(reg);
 	else
-		nrirqs = fls(readl(iobase + APB_INT_ENABLE_L));
+		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
 
 	domain = irq_domain_add_linear(np, nrirqs,
 				       &irq_generic_chip_ops, NULL);
-- 
2.1.0

From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 May 2014 16:05:58 +0800
Subject: [PATCH v6 02/15] irq: gic: use mask field in GICC_IAR
In-Reply-To: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399795571-17231-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit[9:0] is interrupt ID field in GICC_IAR. Bit[12:10] is CPU ID field,
and others are reserved.

So we should use GICC_IAR_INT_ID_MASK to get interrupt ID. It's not a good way
to use ~0x1c00 (CPU ID field) to get interrupt ID.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 2 +-
 include/linux/irqchip/arm-gic.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4300b66..f711fb6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -287,7 +287,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 
 	do {
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
-		irqnr = irqstat & ~0x1c00;
+		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (likely(irqnr > 15 && irqnr < 1021)) {
 			irqnr = irq_find_mapping(gic->domain, irqnr);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 7ed92d0..45e2d8c 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -21,6 +21,8 @@
 #define GIC_CPU_ACTIVEPRIO		0xd0
 #define GIC_CPU_IDENT			0xfc
 
+#define GICC_IAR_INT_ID_MASK		0x3ff
+
 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
 #define GIC_DIST_IGROUP			0x080
-- 
1.9.1

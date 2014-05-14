From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 May 2014 16:58:44 +0100
Subject: [RFC 7/8] ARM: VIC: Add vic_set_fiq function to select if an
 interrupt should generate an IRQ or FIQ
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1400083125-1464-8-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arve Hj?nnev?g <arve@android.com>

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/irqchip/irq-vic.c       | 23 +++++++++++++++++++++++
 include/linux/irqchip/arm-vic.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 7d35287..3eaa2e4 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -337,6 +337,29 @@ static void vic_unmask_irq(struct irq_data *d)
 	writel(1 << irq, base + VIC_INT_ENABLE);
 }
 
+static DEFINE_SPINLOCK(vic_intselect_lock);
+int vic_set_fiq(unsigned int irq, bool enable)
+{
+	u32 int_select;
+	u32 mask;
+	unsigned long irq_flags;
+	void __iomem *base = irq_get_chip_data(irq);
+	irq &= 31;
+	mask = 1 << irq;
+
+	spin_lock_irqsave(&vic_intselect_lock, irq_flags);
+	int_select = readl(base + VIC_INT_SELECT);
+	if (enable)
+		int_select |= mask;
+	else
+		int_select &= ~mask;
+	writel(int_select, base + VIC_INT_SELECT);
+	spin_unlock_irqrestore(&vic_intselect_lock, irq_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(vic_set_fiq);
+
 #if defined(CONFIG_PM)
 static struct vic_device *vic_from_irq(unsigned int irq)
 {
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index ba46c79..61ee4c9 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -34,5 +34,6 @@ void __vic_init(void __iomem *base, int parent_irq, int irq_start,
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
 int vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
 		      u32 vic_sources, u32 resume_sources);
+int vic_set_fiq(unsigned int irq, bool enable);
 
 #endif
-- 
1.9.0

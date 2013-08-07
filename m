From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  7 Aug 2013 12:43:31 +0100
Subject: [PATCH v3 1/3] drivers: irq-chip: irq-gic: introduce gic_cpu_if_down()
In-Reply-To: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1375875813-13358-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

When processors are about to hit low power states, the assertion of
standbywfi signal, triggered by the wfi instruction, is essential to
entering low power modes. If an IRQ is pending on the processor at the
time wfi is issued, the wfi instruction completes and the processor
restarts execution without asserting the standbywfi signal. Depending
on the platform power controller HW this behaviour can be acceptable or
not; if this behaviour must be prevented software should be provided
with a way to disable the routing of interrupts to the core IRQ pins.

On systems where raw GIC distributor interrupts are connected to the power
controller as wake-up events (hence the power controller still senses
IRQs and can wake up cores upon IRQ pending), the GIC CPU interface can
be disabled on power down, so that the GIC CPU IF output is gated and wfi
cannot complete, thereby preventing the standbywfi issue.

This patch adds a simple function to the GIC driver that allows to
disable the GIC CPU IF from power down procedures.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
[rewrote commit log]
---
 drivers/irqchip/irq-gic.c       | 6 ++++++
 include/linux/irqchip/arm-gic.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ee7c503..d0e9480 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -453,6 +453,12 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	writel_relaxed(1, base + GIC_CPU_CTRL);
 }
 
+void gic_cpu_if_down(void)
+{
+	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
+	writel_relaxed(0, cpu_base + GIC_CPU_CTRL);
+}
+
 #ifdef CONFIG_CPU_PM
 /*
  * Saves the GIC distributor registers during suspend or idle.  Must be called
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 3e203eb..0e5d9ec 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -66,6 +66,7 @@ extern struct irq_chip gic_arch_extn;
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
+void gic_cpu_if_down(void);
 
 static inline void gic_init(unsigned int nr, int start,
 			    void __iomem *dist , void __iomem *cpu)
-- 
1.8.2.2

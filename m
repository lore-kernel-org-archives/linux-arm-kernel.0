From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 09 Jan 2013 19:20:43 -0500
Subject: [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of a
 dying CPU is disabled
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise there might be some interrupts or IPIs becoming pending and the
CPU will not enter low power mode when doing a WFI.  The effect of this
is a CPU that loops back into the kernel, go through the first man
election, signals itself as alive,  and prevent the cluster from being
shut down.

This could benefit from a better solution.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_platsmp.c        | 1 +
 arch/arm/common/gic.c               | 6 ++++++
 arch/arm/include/asm/hardware/gic.h | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
index 0ae44123bf..6a3b251b97 100644
--- a/arch/arm/common/bL_platsmp.c
+++ b/arch/arm/common/bL_platsmp.c
@@ -68,6 +68,7 @@ static void __ref bL_cpu_die(unsigned int cpu)
 	pcpu = mpidr & 0xff;
 	pcluster = (mpidr >> 8) & 0xff;
 	bL_set_entry_vector(pcpu, pcluster, NULL);
+	gic_cpu_if_down();
 	bL_cpu_power_down();
 }
 
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a3f5..760e8f4ca1 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -428,6 +428,12 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
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
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6cd47..2a7605492d 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -46,6 +46,8 @@ void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
+void gic_cpu_if_down(void);
+
 static inline void gic_init(unsigned int nr, int start,
 			    void __iomem *dist , void __iomem *cpu)
 {
-- 
1.8.0

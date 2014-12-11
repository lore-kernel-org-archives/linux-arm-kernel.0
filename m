From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 11 Dec 2014 14:23:07 +0000
Subject: [PATCH 3/4] arm64: GICv3: Specialize readq and writeq accesses
In-Reply-To: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <1418307788-17977-4-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 32bit platforms, we cannot assure that an I/O ldrd or strd will be
done atomically. Besides, an hypervisor would be unable to emulate such
accesses.
In order to allow the AArch32 version of the driver to split them into
two 32bit accesses while keeping the requirement for atomic writes, this
patch specializes the IROUTER and TYPER accesses.
Since the latter is an ID register, it won't need to be read atomically,
but we still avoid future confusion by using gic_read_typer instead of a
generic gic_readq.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 3 +++
 drivers/irqchip/irq-gic-v3.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index a0ea9de..622f08a 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -134,5 +134,8 @@ static inline void __maybe_unused gic_write_sre(u32 val)
 	isb();
 }
 
+#define gic_read_typer(c)		readq_relaxed(c)
+#define gic_write_irouter(v, c)		writeq_relaxed(v, c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e2cd5ac..d8f30ee 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -282,7 +282,7 @@ static void __init gic_dist_init(void)
 	 */
 	affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
 	for (i = 32; i < gic_data.irq_nr; i++)
-		writeq_relaxed(affinity, base + GICD_IROUTER + i * 8);
+		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
 }
 
 static int __init gic_populate_rdist(void)
@@ -313,7 +313,7 @@ static int __init gic_populate_rdist(void)
 		}
 
 		do {
-			typer = readq_relaxed(ptr + GICR_TYPER);
+			typer = gic_read_typer(ptr + GICR_TYPER);
 			if ((typer >> 32) == aff) {
 				gic_data_rdist_rd_base() = ptr;
 				pr_info("CPU%d: found redistributor %lx @%p\n",
@@ -498,7 +498,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	reg = gic_dist_base(d) + GICD_IROUTER + (gic_irq(d) * 8);
 	val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
 
-	writeq_relaxed(val, reg);
+	gic_write_irouter(val, reg);
 
 	/*
 	 * If the interrupt was enabled, enabled it again. Otherwise,
-- 
2.2.0.rc1

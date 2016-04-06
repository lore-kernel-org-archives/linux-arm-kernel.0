From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:12 +0100
Subject: [PATCH 3/5] irqchip/gic: Restore CPU interface checking
In-Reply-To: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459941854-5190-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When introducing the whole CPU feature detection framework,
we lost the capability to detect a mismatched GIC configuration
(using the GICv2 MMIO interface, but having the system register
interface enabled).

In order to solve this, use the new this_cpu_has_cap() helper.
Also move the check to the CPU interface path in order to catch
systems where the first CPU has been correctly configured,
but the secondaries are not.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/irqchip/irq-gic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 282344b..095bb5b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -55,7 +55,7 @@
 
 static void gic_check_cpu_features(void)
 {
-	WARN_TAINT_ONCE(cpus_have_cap(ARM64_HAS_SYSREG_GIC_CPUIF),
+	WARN_TAINT_ONCE(this_cpu_has_cap(ARM64_HAS_SYSREG_GIC_CPUIF),
 			TAINT_CPU_OUT_OF_SPEC,
 			"GICv3 system registers enabled, broken firmware!\n");
 }
@@ -490,6 +490,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 		 * Get what the GIC says our CPU mask is.
 		 */
 		BUG_ON(cpu >= NR_GIC_CPU_IF);
+		gic_check_cpu_features();
 		cpu_mask = gic_get_cpumask(gic);
 		gic_cpu_map[cpu] = cpu_mask;
 
@@ -1021,8 +1022,6 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 
 	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
 
-	gic_check_cpu_features();
-
 	gic = &gic_data[gic_nr];
 
 	/* Initialize irq_chip */
-- 
1.7.9.5

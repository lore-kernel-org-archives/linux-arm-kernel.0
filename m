From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:53 +0100
Subject: [PATCH 4/5] irqchip/gic: Warn if GICv3 system registers are enabled
In-Reply-To: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443803874-9566-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using a GICv3 in compatibility (v2) mode, having GICv3 system
register access enabled is not really compliant with the architecture.

Warn if the firmware (or the hypervisor) has been lazy.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 982c09c..92da78f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -51,6 +51,19 @@
 
 #include "irq-gic-common.h"
 
+#ifdef CONFIG_ARM64
+#include <asm/cpufeature.h>
+
+static void gic_check_cpu_features(void)
+{
+	WARN_TAINT_ONCE(cpus_have_cap(ARM64_HAS_SYSREG_GIC_CPUIF),
+			TAINT_CPU_OUT_OF_SPEC,
+			"GICv3 system registers enabled, broken firmware!\n");
+}
+#else
+#define gic_check_cpu_features()	do { } while(0)
+#endif
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu * __iomem *percpu_base;
@@ -987,6 +1000,8 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
+	gic_check_cpu_features();
+
 	gic = &gic_data[gic_nr];
 #ifdef CONFIG_GIC_NON_BANKED
 	if (percpu_offset) { /* Frankein-GIC without banked registers... */
-- 
2.1.4

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 16 Dec 2013 21:29:55 -0800
Subject: [PATCH v5 04/10] irqchip: arm-gic: Define additional MMIO offsets and
 masks
In-Reply-To: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
References: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1387258201-8738-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define CPU interface offsets for the GICC_ABPR, GICC_APR, and GICC_IIDR
registers.  Define distributor registers for the GICD_SPENDSGIR and the
GICD_CPENDSGIR.  KVM/ARM needs to know about these definitions to fully
support save/restore of the VGIC.

Also define some masks and shifts for the various GICH_VMCR fields.

Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/linux/irqchip/arm-gic.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index cac496b..0ceb389 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -17,6 +17,9 @@
 #define GIC_CPU_EOI			0x10
 #define GIC_CPU_RUNNINGPRI		0x14
 #define GIC_CPU_HIGHPRI			0x18
+#define GIC_CPU_ALIAS_BINPOINT		0x1c
+#define GIC_CPU_ACTIVEPRIO		0xd0
+#define GIC_CPU_IDENT			0xfc
 
 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
@@ -56,6 +59,15 @@
 #define GICH_LR_ACTIVE_BIT		(1 << 29)
 #define GICH_LR_EOI			(1 << 19)
 
+#define GICH_VMCR_CTRL_SHIFT		0
+#define GICH_VMCR_CTRL_MASK		(0x21f << GICH_VMCR_CTRL_SHIFT)
+#define GICH_VMCR_PRIMASK_SHIFT		27
+#define GICH_VMCR_PRIMASK_MASK		(0x1f << GICH_VMCR_PRIMASK_SHIFT)
+#define GICH_VMCR_BINPOINT_SHIFT	21
+#define GICH_VMCR_BINPOINT_MASK		(0x7 << GICH_VMCR_BINPOINT_SHIFT)
+#define GICH_VMCR_ALIAS_BINPOINT_SHIFT	18
+#define GICH_VMCR_ALIAS_BINPOINT_MASK	(0x7 << GICH_VMCR_ALIAS_BINPOINT_SHIFT)
+
 #define GICH_MISR_EOI			(1 << 0)
 #define GICH_MISR_U			(1 << 1)
 
-- 
1.8.5

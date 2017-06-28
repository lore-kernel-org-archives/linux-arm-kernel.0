From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:41 +0100
Subject: [PATCH v2 22/52] irqchip/gic-v3-its: Add VPENDBASER/VPROPBASER
 accessors
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-23-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V{PEND,PROP}BASER being 64bit registers, they need some ad-hoc
accessors on 32bit, specially given that VPENDBASER contains
a Valid bit, making the access a bit convoluted.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 28 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h |  5 +++++
 include/linux/irqchip/arm-gic-v3.h  |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 27475904e096..8d45e88feac9 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -291,5 +291,33 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
  */
 #define gits_write_cwriter(v, c)	__gic_writeq_nonatomic(v, c)
 
+/*
+ * GITS_VPROPBASER - hi and lo bits may be accessed independently.
+ */
+#define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
+
+/*
+ * GITS_VPENDBASER - the Valid bit must be cleared before changing
+ * anything else.
+ */
+static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
+{
+	u32 tmp;
+
+	tmp = readl_relaxed(addr + 4);
+	if (tmp & (GICR_VPENDBASER_Valid >> 32)) {
+		tmp &= ~(GICR_VPENDBASER_Valid >> 32);
+		writel_relaxed(tmp, addr + 4);
+	}
+
+	/*
+	 * Use the fact that __gic_writeq_nonatomic writes the second
+	 * half of the 64bit quantity after the first.
+	 */
+	__gic_writeq_nonatomic(val, addr);
+}
+
+#define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 8cef47fa2218..0d2a53457c30 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -133,5 +133,10 @@ static inline void gic_write_bpr1(u32 val)
 #define gicr_write_pendbaser(v, c)	writeq_relaxed(v, c)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
+#define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+
+#define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
+#define gits_read_vpendbaser(c)		readq_relaxed(c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 7c6fd8f3e36c..17ba0d732f12 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -212,6 +212,11 @@
 #define LPI_PROP_GROUP1			(1 << 1)
 #define LPI_PROP_ENABLED		(1 << 0)
 
+#define GICR_VPENDBASER_Dirty		(1ULL << 60)
+#define GICR_VPENDBASER_PendingLast	(1ULL << 61)
+#define GICR_VPENDBASER_IDAI		(1ULL << 62)
+#define GICR_VPENDBASER_Valid		(1ULL << 63)
+
 /*
  * ITS registers, offsets from ITS_base
  */
-- 
2.11.0

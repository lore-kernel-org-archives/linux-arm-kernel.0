From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:44 +0000
Subject: [RFC PATCH 23/33] irqchip/gic-v3-its: Add VPENDBASER/VPROPBASER
 accessors
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-24-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V{PEND,PROP}BASER being 64bit registers, they need some ad-hoc
accessors on 32bit, specially given that VPENDBASER contains
a Valid bit, making the access a bit convoluted.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 28 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 2747590..3f18832 100644
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
+	if (tmp & GICR_PENDBASER_Valid) {
+		tmp &= ~GICR_PENDBASER_Valid;
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
index f37e3a2..9420b7a 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -188,5 +188,10 @@ static inline void gic_write_bpr1(u32 val)
 #define gicr_write_pendbaser(v, c)	writeq_relaxed(v, c)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
+#define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+
+#define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
+#define gits_read_vpendbaser(c)		readq_relaxed(c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
-- 
2.1.4

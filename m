From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:23 +0100
Subject: [PATCH v5 13/27] arm/arm64: gic-v3: Add helper functions to manage
 IRQ priorities
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-14-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to check if priority masking is supported and accessors
for PMR/RPR.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 21 +++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0bd5307..58d5d3e 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -34,6 +34,7 @@
 #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
+#define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)

 #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
 #define ICC_AP0R0			__ICC_AP0Rx(0)
@@ -245,6 +246,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg(val, ICC_BPR1);
 }

+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg(ICC_PMR);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg(val, ICC_PMR);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg(ICC_RPR);
+}
+
 /*
  * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
  * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
@@ -347,5 +363,10 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)

 #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)

+static inline bool gic_prio_masking_enabled(void)
+{
+	return false;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index e278f94..19a5b1f 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -114,6 +114,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
 }

+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg_s(SYS_ICC_PMR_EL1);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg_s(val, SYS_ICC_PMR_EL1);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg_s(SYS_ICC_RPR_EL1);
+}
+
 #define gic_read_typer(c)		readq_relaxed(c)
 #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
 #define gic_read_lpir(c)		readq_relaxed(c)
@@ -140,5 +155,11 @@ static inline void gic_write_bpr1(u32 val)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)

+static inline bool gic_prio_masking_enabled(void)
+{
+	return IS_ENABLED(CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS)
+	       && cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
--
1.9.1

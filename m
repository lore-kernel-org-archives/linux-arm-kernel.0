From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:04 +0100
Subject: [PATCH 5/6] irqchip/gic-v3: Convert arm64 GIC accessors to {read,
 write}_sysreg_s
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC system registers are accessed using open-coded wrappers around
the mrs_s/msr_s asm macros.

This patch moves the code over to the {read,wrote}_sysreg_s accessors
instead, reducing the amount of explicit asm blocks in the arch headers.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 45 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index ae7dbd79e257..0d41944d965d 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -79,18 +79,8 @@
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 
-#define read_gicreg(r)							\
-	({								\
-		u64 reg;						\
-		asm volatile("mrs_s %0, " __stringify(r) : "=r" (reg));	\
-		reg;							\
-	})
-
-#define write_gicreg(v,r)						\
-	do {								\
-		u64 __val = (v);					\
-		asm volatile("msr_s " __stringify(r) ", %0" : : "r" (__val));\
-	} while (0)
+#define read_gicreg			read_sysreg_s
+#define write_gicreg			write_sysreg_s
 
 /*
  * Low-level accessors
@@ -101,13 +91,13 @@
 
 static inline void gic_write_eoir(u32 irq)
 {
-	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" ((u64)irq));
+	write_sysreg_s(irq, ICC_EOIR1_EL1);
 	isb();
 }
 
 static inline void gic_write_dir(u32 irq)
 {
-	asm volatile("msr_s " __stringify(ICC_DIR_EL1) ", %0" : : "r" ((u64)irq));
+	write_sysreg_s(irq, ICC_DIR_EL1);
 	isb();
 }
 
@@ -115,7 +105,7 @@ static inline u64 gic_read_iar_common(void)
 {
 	u64 irqstat;
 
-	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
+	irqstat = read_sysreg_s(ICC_IAR1_EL1);
 	dsb(sy);
 	return irqstat;
 }
@@ -133,10 +123,12 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 
 	asm volatile(
 		"nop;nop;nop;nop\n\t"
-		"nop;nop;nop;nop\n\t"
-		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"
-		"nop;nop;nop;nop"
-		: "=r" (irqstat));
+		"nop;nop;nop;nop");
+
+	irqstat = read_sysreg_s(ICC_IAR1_EL1);
+
+	asm volatile(
+		"nop;nop;nop;nop");
 	mb();
 
 	return irqstat;
@@ -144,37 +136,34 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 
 static inline void gic_write_pmr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_PMR_EL1);
 }
 
 static inline void gic_write_ctlr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_CTLR_EL1);
 	isb();
 }
 
 static inline void gic_write_grpen1(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_GRPEN1_EL1);
 	isb();
 }
 
 static inline void gic_write_sgi1r(u64 val)
 {
-	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
+	write_sysreg_s(val, ICC_SGI1R_EL1);
 }
 
 static inline u32 gic_read_sre(void)
 {
-	u64 val;
-
-	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
-	return val;
+	return read_sysreg_s(ICC_SRE_EL1);
 }
 
 static inline void gic_write_sre(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" ((u64)val));
+	write_sysreg_s(val, ICC_SRE_EL1);
 	isb();
 }
 
-- 
2.1.4

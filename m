From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:47 +0100
Subject: [PATCH 2/8] arm64: Introduce sysreg_clear_set()
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622124953.12355-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Currently we have a couple of helpers to manipulate bits in particular
sysregs:

 * config_sctlr_el1(u32 clear, u32 set)

 * change_cpacr(u64 val, u64 mask)

The parameters of these differ in naming convention, order, and size,
which is unfortunate. They also differ slightly in behaviour, as
change_cpacr() skips the sysreg write if the bits are unchanged, which
is a useful optimization when sysreg writes are expensive.

Before we gain yet another sysreg manipulation function, let's
unify these with a common helper, providing a consistent order for
clear/set operands, and the write skipping behaviour from
change_cpacr(). Code will be migrated to the new helper in subsequent
patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178075dc..a8f84812c6e8 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -728,6 +728,17 @@ asm(
 	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
 } while (0)
 
+/*
+ * Modify bits in a sysreg. Bits in the clear mask are zeroed, then bits in the
+ * set mask are set. Other bits are left as-is.
+ */
+#define sysreg_clear_set(sysreg, clear, set) do {			\
+	u64 __scs_val = read_sysreg(sysreg);				\
+	u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);		\
+	if (__scs_new != __scs_val)					\
+		write_sysreg(__scs_new, sysreg);			\
+} while (0)
+
 static inline void config_sctlr_el1(u32 clear, u32 set)
 {
 	u32 val;
-- 
2.17.1

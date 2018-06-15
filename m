From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 16:47:23 +0100
Subject: [PATCH v2 1/4] arm64: introduce sysreg_clear_set()
In-Reply-To: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
References: <1529077646-2848-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1529077646-2848-2-git-send-email-Dave.Martin@arm.com>
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

Before we gain more yet another sysreg manipulation function, let's
unify these with a common helper, providing a consistent order for
clear/set operands, and the write skipping behaviour from
change_cpacr(). Code will be migrated to the new helper in subsequent
patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178..a8f8481 100644
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
2.1.4

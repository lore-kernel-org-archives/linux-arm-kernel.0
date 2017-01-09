From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:24 +0000
Subject: [PATCH v4 1/9] arm64: cpufeature: treat unknown fields as RES0
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483982912-27215-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Any fields not defined in an arm64_ftr_bits entry are propagated to the
system-wide register value in init_cpu_ftr_reg(), and while we require
that these strictly match for the sanity checks, we don't update them in
update_cpu_ftr_reg().

Generally, the lack of an arm64_ftr_bits entry indicates that the bits
are currently RES0 (as is the case for the upper 32 bits of all
supposedly 32-bit registers).

A better default would be to use zero for the system-wide value of
unallocated bits, making all register checking consistent, and allowing
for subsequent simplifications to the arm64_ftr_bits arrays.

This patch updates init_cpu_ftr_reg() to treat unallocated bits as RES0
for the purpose of the system-wide safe value. These bits will still be
sanity checked with strict match requirements, as is currently the case.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fdf8f04..ea02201 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -410,23 +410,33 @@ static void __init sort_ftr_regs(void)
 /*
  * Initialise the CPU feature register from Boot CPU values.
  * Also initiliases the strict_mask for the register.
+ * Any bits that are not covered by an arm64_ftr_bits entry are considered
+ * RES0 for the system-wide value, and must strictly match.
  */
 static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
+	u64 valid_mask = 0;
+
 	const struct arm64_ftr_bits *ftrp;
 	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
 
 	BUG_ON(!reg);
 
 	for (ftrp  = reg->ftr_bits; ftrp->width; ftrp++) {
+		u64 ftr_mask = arm64_ftr_mask(ftrp);
 		s64 ftr_new = arm64_ftr_value(ftrp, new);
 
 		val = arm64_ftr_set_value(ftrp, val, ftr_new);
+
+		valid_mask |= ftr_mask;
 		if (!ftrp->strict)
-			strict_mask &= ~arm64_ftr_mask(ftrp);
+			strict_mask &= ~ftr_mask;
 	}
+
+	val &= valid_mask;
+
 	reg->sys_val = val;
 	reg->strict_mask = strict_mask;
 }
-- 
2.7.4

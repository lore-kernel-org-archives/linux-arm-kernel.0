From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  4 Oct 2018 09:33:15 +0100
Subject: [PATCH 3/3] arm64: cpufeature: Trap CTR_EL0 access only where it is
 necessary
In-Reply-To: <20181004083315.31174-1-suzuki.poulose@arm.com>
References: <20181004083315.31174-1-suzuki.poulose@arm.com>
Message-ID: <20181004083315.31174-4-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there is a mismatch in the CTR_EL0 field, we trap
access to CTR from EL0 on all CPUs to expose the safe
value. However, we could skip trapping on a CPU which
matches the safe value.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 31551f444ce3..e07ba717860e 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -84,7 +84,12 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 static void
 cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
 {
-	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
+	u64 mask = arm64_ftr_reg_ctrel0.strict_mask;
+
+	/* Trap CTR_EL0 access on this CPU, only if it has a mismatch */
+	if ((read_cpuid_cachetype() & mask) !=
+	    (arm64_ftr_reg_ctrel0.sys_val & mask))
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
 }
 
 atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
-- 
2.19.0

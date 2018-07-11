From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:38 +0100
Subject: [PATCHv5 03/21] arm64: kill config_sctlr_el1()
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have sysreg_clear_set(), we can consistently use this
instead of config_sctlr_el1().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h      | 10 ----------
 arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
 arch/arm64/kernel/cpu_errata.c       |  3 +--
 arch/arm64/kernel/traps.c            |  2 +-
 arch/arm64/mm/fault.c                |  2 +-
 5 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index fefc17dae8ee..e205ec8489e9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -742,16 +742,6 @@ asm(
 		write_sysreg(__scs_new, sysreg);			\
 } while (0)
 
-static inline void config_sctlr_el1(u32 clear, u32 set)
-{
-	u32 val;
-
-	val = read_sysreg(sctlr_el1);
-	val &= ~clear;
-	val |= set;
-	write_sysreg(val, sctlr_el1);
-}
-
 #endif
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index d4707abb2f16..d01c7fc0463c 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -511,9 +511,9 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 static int cp15_barrier_set_hw_mode(bool enable)
 {
 	if (enable)
-		config_sctlr_el1(0, SCTLR_EL1_CP15BEN);
+		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_CP15BEN);
 	else
-		config_sctlr_el1(SCTLR_EL1_CP15BEN, 0);
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_CP15BEN, 0);
 	return 0;
 }
 
@@ -548,9 +548,9 @@ static int setend_set_hw_mode(bool enable)
 		return -EINVAL;
 
 	if (enable)
-		config_sctlr_el1(SCTLR_EL1_SED, 0);
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_SED, 0);
 	else
-		config_sctlr_el1(0, SCTLR_EL1_SED);
+		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_SED);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1d2b6d768efe..92128ea53102 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -76,8 +76,7 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 static void
 cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
 {
-	/* Clear SCTLR_EL1.UCT */
-	config_sctlr_el1(SCTLR_EL1_UCT, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
 }
 
 atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d459397b..c27292703bd1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -411,7 +411,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
-	config_sctlr_el1(SCTLR_EL1_UCI, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCI, 0);
 }
 
 #define __user_cache_maint(insn, address, res)			\
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7b9531..ea591c9e5144 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -879,7 +879,7 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
-	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
 	asm(SET_PSTATE_PAN(1));
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
2.11.0

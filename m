From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 30 Aug 2017 10:01:27 +0100
Subject: [PATCH 2/3] arm64: Fix single stepping in kernel traps
In-Reply-To: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1504083688-48334-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Software Step exception is missing after stepping a trapped instruction.

Ensure SPSR.SS gets set to 0 after emulating/skipping a trapped instruction
before doing ERET.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>

---
 arch/arm64/include/asm/traps.h       |  2 ++
 arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 02e9035..dfeb489 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,6 +37,8 @@ struct undef_hook {

 void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);

+void arm64_skip_trapped_instr(struct pt_regs *regs, unsigned long size);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index f0e6d71..1f38208 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -431,7 +431,7 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
 			current->comm, (unsigned long)current->pid, regs->pc);

-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, 4);
 	return 0;

 fault:
@@ -512,7 +512,7 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 	pr_warn_ratelimited("\"%s\" (%ld) uses deprecated CP15 Barrier instruction at 0x%llx\n",
 			current->comm, (unsigned long)current->pid, regs->pc);

-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, 4);
 	return 0;
 }

@@ -586,14 +586,14 @@ static int compat_setend_handler(struct pt_regs *regs, u32 big_endian)
 static int a32_setend_handler(struct pt_regs *regs, u32 instr)
 {
 	int rc = compat_setend_handler(regs, (instr >> 9) & 1);
-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, 4);
 	return rc;
 }

 static int t16_setend_handler(struct pt_regs *regs, u32 instr)
 {
 	int rc = compat_setend_handler(regs, (instr >> 3) & 1);
-	regs->pc += 2;
+	arm64_skip_trapped_instr(regs, 2);
 	return rc;
 }

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f9e0064..06c9d5f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1274,7 +1274,7 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
 	if (!rc) {
 		dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
 		pt_regs_write_reg(regs, dst, val);
-		regs->pc += 4;
+		arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 	}

 	return rc;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8a62648..1f37bc1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -314,6 +314,17 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }

+void arm64_skip_trapped_instr(struct pt_regs *regs, unsigned long size)
+{
+	regs->pc += size;
+
+	/*
+	 * If we were single stepping, we want to get the step exception after
+	 * we return from the skipped exception
+	 */
+	regs->pstate &= ~DBG_SPSR_SS;
+}
+
 static LIST_HEAD(undef_hook);
 static DEFINE_RAW_SPINLOCK(undef_lock);

@@ -498,7 +509,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	if (ret)
 		arm64_notify_segfault(regs, address);
 	else
-		regs->pc += 4;
+		arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 }

 static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
@@ -508,7 +519,7 @@ static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)

 	pt_regs_write_reg(regs, rt, val);

-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 }

 static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
@@ -516,7 +527,7 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;

 	pt_regs_write_reg(regs, rt, arch_counter_get_cntvct());
-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 }

 static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
@@ -524,7 +535,7 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;

 	pt_regs_write_reg(regs, rt, arch_timer_get_rate());
-	regs->pc += 4;
+	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 }

 struct sys64_hook {
@@ -742,7 +753,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 	}

 	/* If thread survives, skip over the BUG instruction and continue: */
-	regs->pc += AARCH64_INSN_SIZE;	/* skip BRK and resume */
+	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }

--
1.9.1

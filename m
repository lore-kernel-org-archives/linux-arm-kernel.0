From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 09:31:18 +0100
Subject: [PATCH v2 4/4] arm64: insn: Don't fallback on nosync path for general
 insn patching
In-Reply-To: <1529656278-878-1-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
Message-ID: <1529656278-878-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patching kernel instructions at runtime requires other CPUs to undergo
a context synchronisation event via an explicit ISB or an IPI in order
to ensure that the new instructions are visible. This is required even
for "hotpatch" instructions such as NOP and BL, so avoid optimising in
this case and always go via stop_machine() when performing general
patching.

ftrace isn't quite as strict, so it can continue to call the nosync
code directly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/insn.h |  2 --
 arch/arm64/kernel/insn.c      | 56 +------------------------------------------
 2 files changed, 1 insertion(+), 57 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f62c56b1793f..c6802dea6cab 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -446,8 +446,6 @@ u32 aarch64_insn_gen_prefetch(enum aarch64_insn_register base,
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
-bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
-
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 0f6a2e0cfde0..2b3413549734 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -149,20 +149,6 @@ int __kprobes aarch64_insn_write(void *addr, u32 insn)
 	return __aarch64_insn_write(addr, cpu_to_le32(insn));
 }
 
-static bool __kprobes __aarch64_insn_hotpatch_safe(u32 insn)
-{
-	if (aarch64_get_insn_class(insn) != AARCH64_INSN_CLS_BR_SYS)
-		return false;
-
-	return	aarch64_insn_is_b(insn) ||
-		aarch64_insn_is_bl(insn) ||
-		aarch64_insn_is_svc(insn) ||
-		aarch64_insn_is_hvc(insn) ||
-		aarch64_insn_is_smc(insn) ||
-		aarch64_insn_is_brk(insn) ||
-		aarch64_insn_is_nop(insn);
-}
-
 bool __kprobes aarch64_insn_uses_literal(u32 insn)
 {
 	/* ldr/ldrsw (literal), prfm */
@@ -189,22 +175,6 @@ bool __kprobes aarch64_insn_is_branch(u32 insn)
 		aarch64_insn_is_bcond(insn);
 }
 
-/*
- * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
- * Section B2.6.5 "Concurrent modification and execution of instructions":
- * Concurrent modification and execution of instructions can lead to the
- * resulting instruction performing any behavior that can be achieved by
- * executing any sequence of instructions that can be executed from the
- * same Exception level, except where the instruction before modification
- * and the instruction after modification is a B, BL, NOP, BKPT, SVC, HVC,
- * or SMC instruction.
- */
-bool __kprobes aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn)
-{
-	return __aarch64_insn_hotpatch_safe(old_insn) &&
-	       __aarch64_insn_hotpatch_safe(new_insn);
-}
-
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
@@ -239,11 +209,6 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
 		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
 			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
 							     pp->new_insns[i]);
-		/*
-		 * aarch64_insn_patch_text_nosync() calls flush_icache_range(),
-		 * which ends with "dsb; isb" pair guaranteeing global
-		 * visibility.
-		 */
 		/* Notify other processors with an additional increment. */
 		atomic_inc(&pp->cpu_count);
 	} else {
@@ -255,8 +220,7 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
 	return ret;
 }
 
-static
-int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
+int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 {
 	struct aarch64_insn_patch patch = {
 		.text_addrs = addrs,
@@ -272,24 +236,6 @@ int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
 				       cpu_online_mask);
 }
 
-int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
-{
-	int ret;
-	u32 insn;
-
-	/* Unsafe to patch multiple instructions without synchronizaiton */
-	if (cnt == 1) {
-		ret = aarch64_insn_read(addrs[0], &insn);
-		if (ret)
-			return ret;
-
-		if (aarch64_insn_hotpatch_safe(insn, insns[0]))
-			return aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
-	}
-
-	return aarch64_insn_patch_text_sync(addrs, insns, cnt);
-}
-
 static int __kprobes aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
 						u32 *maskp, int *shiftp)
 {
-- 
2.1.4

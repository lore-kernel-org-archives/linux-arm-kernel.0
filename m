From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Jun 2017 17:00:21 +0000
Subject: [PATCH v3 1/2] arm64: ftrace: don't validate branch via PLT in
 ftrace_make_nop()
In-Reply-To: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
References: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
Message-ID: <20170606170022.11461-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When turning branch instructions into NOPs, we attempt to validate the
action by comparing the old value at the call site with the opcode of
a direct relative branch instruction pointing at the old target.

However, these call sites are statically initialized to call _mcount(),
and may be redirected via a PLT entry if the module is loaded far away
from the kernel text, leading to false negatives and spurious errors.

So skip the validation if CONFIG_ARM64_MODULE_PLTS is configured.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/ftrace.c | 46 ++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 40ad08ac569a..4cb576374b82 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -84,12 +84,52 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned long pc = rec->ip;
-	u32 old, new;
+	long offset = (long)pc - (long)addr;
+	bool validate = true;
+	u32 old = 0, new;
+
+	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
+	    (offset < -SZ_128M || offset >= SZ_128M)) {
+		u32 replaced;
+
+		/*
+		 * 'mod' is only set at module load time, but if we end up
+		 * dealing with an out-of-range condition, we can assume it
+		 * is due to a module being loaded far away from the kernel.
+		 */
+		if (!mod) {
+			preempt_disable();
+			mod = __module_text_address(pc);
+			preempt_enable();
+
+			if (WARN_ON(!mod))
+				return -EINVAL;
+		}
+
+		/*
+		 * The instruction we are about to patch may be a branch and
+		 * link instruction that was redirected via a PLT entry. In
+		 * this case, the normal validation will fail, but we can at
+		 * least check that we are dealing with a branch and link
+		 * instruction that points into the right module.
+		 */
+		if (aarch64_insn_read((void *)pc, &replaced))
+			return -EFAULT;
+
+		if (!aarch64_insn_is_bl(replaced) ||
+		    !within_module(pc + aarch64_get_branch_offset(replaced),
+				   mod))
+			return -EINVAL;
+
+		validate = false;
+	} else {
+		old = aarch64_insn_gen_branch_imm(pc, addr,
+						  AARCH64_INSN_BRANCH_LINK);
+	}
 
-	old = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 	new = aarch64_insn_gen_nop();
 
-	return ftrace_modify_code(pc, old, new, true);
+	return ftrace_modify_code(pc, old, new, validate);
 }
 
 void arch_ftrace_update_code(int command)
-- 
2.9.3

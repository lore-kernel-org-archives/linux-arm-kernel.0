From: dave.long@linaro.org (David Long)
Date: Sun, 15 Dec 2013 23:08:43 -0500
Subject: [PATCH v4 09/16] ARM: Make the kprobes condition_check symbol names
 more generic
In-Reply-To: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
References: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
Message-ID: <1387166930-13182-10-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

In preparation for sharing the ARM kprobes instruction interpreting
code with uprobes, make the symbols names less kprobes-specific.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/probes.h   | 4 ++--
 arch/arm/kernel/kprobes-thumb.c | 4 ++--
 arch/arm/kernel/probes-arm.c    | 2 +-
 arch/arm/kernel/probes-thumb.c  | 2 +-
 arch/arm/kernel/probes.c        | 2 +-
 arch/arm/kernel/probes.h        | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
index 8032591..81b05b0 100644
--- a/arch/arm/include/asm/probes.h
+++ b/arch/arm/include/asm/probes.h
@@ -8,7 +8,7 @@ struct arch_specific_insn;
 typedef void (kprobe_insn_handler_t)(probes_opcode_t,
 				     struct arch_specific_insn *,
 				     struct pt_regs *);
-typedef unsigned long (kprobe_check_cc)(unsigned long);
+typedef unsigned long (probes_check_cc)(unsigned long);
 typedef void (kprobe_insn_singlestep_t)(probes_opcode_t,
 					struct arch_specific_insn *,
 					struct pt_regs *);
@@ -18,7 +18,7 @@ typedef void (kprobe_insn_fn_t)(void);
 struct arch_specific_insn {
 	probes_opcode_t			*insn;
 	kprobe_insn_handler_t		*insn_handler;
-	kprobe_check_cc			*insn_check_cc;
+	probes_check_cc			*insn_check_cc;
 	kprobe_insn_singlestep_t	*insn_singlestep;
 	kprobe_insn_fn_t		*insn_fn;
 };
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index c648c31..da1e24b 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -70,7 +70,7 @@ t32_decode_cond_branch(probes_opcode_t insn, struct arch_specific_insn *asi,
 		struct decode_header *d)
 {
 	int cc = (insn >> 22) & 0xf;
-	asi->insn_check_cc = kprobe_condition_checks[cc];
+	asi->insn_check_cc = probes_condition_checks[cc];
 	asi->insn_handler = t32_simulate_cond_branch;
 	return INSN_GOOD_NO_SLOT;
 }
@@ -424,7 +424,7 @@ t16_decode_cond_branch(probes_opcode_t insn, struct arch_specific_insn *asi,
 		struct decode_header *d)
 {
 	int cc = (insn >> 8) & 0xf;
-	asi->insn_check_cc = kprobe_condition_checks[cc];
+	asi->insn_check_cc = probes_condition_checks[cc];
 	asi->insn_handler = t16_simulate_cond_branch;
 	return INSN_GOOD_NO_SLOT;
 }
diff --git a/arch/arm/kernel/probes-arm.c b/arch/arm/kernel/probes-arm.c
index e50fb03..95ef3e3 100644
--- a/arch/arm/kernel/probes-arm.c
+++ b/arch/arm/kernel/probes-arm.c
@@ -726,7 +726,7 @@ arm_kprobe_decode_insn(probes_opcode_t insn, struct arch_specific_insn *asi,
 		       struct decode_header *actions)
 {
 	asi->insn_singlestep = arm_singlestep;
-	asi->insn_check_cc = kprobe_condition_checks[insn>>28];
+	asi->insn_check_cc = probes_condition_checks[insn>>28];
 	return kprobe_decode_insn(insn, asi, kprobe_decode_arm_table, false,
 				  (const union decode_item *) actions);
 }
diff --git a/arch/arm/kernel/probes-thumb.c b/arch/arm/kernel/probes-thumb.c
index e6dbbc3..055faf0 100644
--- a/arch/arm/kernel/probes-thumb.c
+++ b/arch/arm/kernel/probes-thumb.c
@@ -837,7 +837,7 @@ EXPORT_SYMBOL_GPL(kprobe_decode_thumb16_table);
 static unsigned long __kprobes thumb_check_cc(unsigned long cpsr)
 {
 	if (unlikely(in_it_block(cpsr)))
-		return kprobe_condition_checks[current_cond(cpsr)](cpsr);
+		return probes_condition_checks[current_cond(cpsr)](cpsr);
 	return true;
 }
 
diff --git a/arch/arm/kernel/probes.c b/arch/arm/kernel/probes.c
index 7354448..36fafd2 100644
--- a/arch/arm/kernel/probes.c
+++ b/arch/arm/kernel/probes.c
@@ -163,7 +163,7 @@ static unsigned long __kprobes __check_al(unsigned long cpsr)
 	return true;
 }
 
-kprobe_check_cc * const kprobe_condition_checks[16] = {
+probes_check_cc * const probes_condition_checks[16] = {
 	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
 	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
 	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
diff --git a/arch/arm/kernel/probes.h b/arch/arm/kernel/probes.h
index c0536b1..e7c7a92 100644
--- a/arch/arm/kernel/probes.h
+++ b/arch/arm/kernel/probes.h
@@ -394,7 +394,7 @@ extern const union decode_item kprobe_decode_arm_table[];
 extern const union decode_item kprobes_arm_actions[];
 #endif
 
-extern kprobe_check_cc * const kprobe_condition_checks[16];
+extern probes_check_cc * const probes_condition_checks[16];
 
 
 int kprobe_decode_insn(probes_opcode_t insn, struct arch_specific_insn *asi,
-- 
1.8.1.2

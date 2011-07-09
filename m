From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:04 +0100
Subject: [PATCH 17/51] ARM: kprobes: Add hooks to override singlestep()
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-18-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

When a probe fires we must single-step the instruction which was
replaced by a breakpoint. As the steps to do this vary between ARM and
Thumb instructions we need a way to customise single-stepping.

This is done by adding a new hook called insn_singlestep to
arch_specific_insn which is initialised by the instruction decoding
functions.

These single-step hooks must update PC and call the instruction handler.
For Thumb instructions an additional step of updating ITSTATE is needed.
We do this after calling the handler because some handlers will need to
test if they are running in an IT block.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/kprobes.h  |    9 +++++----
 arch/arm/kernel/kprobes-arm.c   |    7 +++++++
 arch/arm/kernel/kprobes-thumb.c |   16 ++++++++++++++++
 arch/arm/kernel/kprobes.c       |    8 +++-----
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 57d37d5..1e9ff56 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -32,14 +32,15 @@ typedef u32 kprobe_opcode_t;
 
 struct kprobe;
 typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
-
 typedef unsigned long (kprobe_check_cc)(unsigned long);
+typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
 
 /* Architecture specific copy of original instruction. */
 struct arch_specific_insn {
-	kprobe_opcode_t		*insn;
-	kprobe_insn_handler_t	*insn_handler;
-	kprobe_check_cc		*insn_check_cc;
+	kprobe_opcode_t			*insn;
+	kprobe_insn_handler_t		*insn_handler;
+	kprobe_check_cc			*insn_check_cc;
+	kprobe_insn_singlestep_t	*insn_singlestep;
 };
 
 struct prev_kprobe {
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 0262b29..a1143e8 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1494,6 +1494,12 @@ space_cccc_11xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_REJECTED;
 }
 
+static void __kprobes arm_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_pc += 4;
+	p->ainsn.insn_handler(p, regs);
+}
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD         If instruction is supported and uses instruction slot,
@@ -1509,6 +1515,7 @@ space_cccc_11xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 enum kprobe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	asi->insn_singlestep = arm_singlestep;
 	asi->insn_check_cc = kprobe_condition_checks[insn>>28];
 	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
 
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 24a188b..973c3eb 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -33,9 +33,24 @@ static unsigned long __kprobes thumb_check_cc(unsigned long cpsr)
 	return true;
 }
 
+static void __kprobes thumb16_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_pc += 2;
+	p->ainsn.insn_handler(p, regs);
+	regs->ARM_cpsr = it_advance(regs->ARM_cpsr);
+}
+
+static void __kprobes thumb32_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_pc += 4;
+	p->ainsn.insn_handler(p, regs);
+	regs->ARM_cpsr = it_advance(regs->ARM_cpsr);
+}
+
 enum kprobe_insn __kprobes
 thumb16_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	asi->insn_singlestep = thumb16_singlestep;
 	asi->insn_check_cc = thumb_check_cc;
 	return INSN_REJECTED;
 }
@@ -43,6 +58,7 @@ thumb16_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 enum kprobe_insn __kprobes
 thumb32_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	asi->insn_singlestep = thumb32_singlestep;
 	asi->insn_check_cc = thumb_check_cc;
 	return INSN_REJECTED;
 }
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 9104b03..3c5ed77 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -227,12 +227,10 @@ singlestep_skip(struct kprobe *p, struct pt_regs *regs)
 #endif
 }
 
-static void __kprobes singlestep(struct kprobe *p, struct pt_regs *regs,
-				 struct kprobe_ctlblk *kcb)
+static inline void __kprobes
+singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
-	regs->ARM_pc += 4;
-	if (p->ainsn.insn_check_cc(regs->ARM_cpsr))
-		p->ainsn.insn_handler(p, regs);
+	p->ainsn.insn_singlestep(p, regs);
 }
 
 /*
-- 
1.7.2.5

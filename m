From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:02 +0100
Subject: [PATCH 15/51] ARM: kprobes: Don't trigger probes on conditional
	instructions when condition is false
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-16-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This patch changes the behavior of kprobes on ARM so that:

    Kprobes on conditional instructions don't trigger when the
    condition is false. For conditional branches, this means that
    they don't trigger in the branch not taken case.

Rationale:

When probes are placed onto conditionally executed instructions in a
Thumb IT block, they may not fire if the condition is not met. This
is because we use invalid instructions for breakpoints and "it is
IMPLEMENTATION DEFINED whether the instruction executes as a NOP or
causes an Undefined Instruction exception". Therefore, for consistency,
we will ignore all probes on any conditional instructions when the
condition is false. Alternative solutions seem to be too complex to
implement or inconsistent.

This issue was discussed on linux.arm.kernel in the thread titled
"[RFC] kprobes with thumb2 conditional code" See
http://comments.gmane.org/gmane.linux.linaro.devel/2985

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index b8f5b3b..7a9be60 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -207,6 +207,20 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
 	__get_cpu_var(current_kprobe) = p;
 }
 
+static void __kprobes
+singlestep_skip(struct kprobe *p, struct pt_regs *regs)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	regs->ARM_cpsr = it_advance(regs->ARM_cpsr);
+	if (is_wide_instruction(p->opcode))
+		regs->ARM_pc += 4;
+	else
+		regs->ARM_pc += 2;
+#else
+	regs->ARM_pc += 4;
+#endif
+}
+
 static void __kprobes singlestep(struct kprobe *p, struct pt_regs *regs,
 				 struct kprobe_ctlblk *kcb)
 {
@@ -262,7 +276,8 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				/* impossible cases */
 				BUG();
 			}
-		} else {
+		} else if (p->ainsn.insn_check_cc(regs->ARM_cpsr)) {
+			/* Probe hit and conditional execution check ok. */
 			set_current_kprobe(p);
 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
@@ -282,6 +297,13 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				}
 				reset_current_kprobe();
 			}
+		} else {
+			/*
+			 * Probe hit but conditional execution check failed,
+			 * so just skip the instruction and continue as if
+			 * nothing had happened.
+			 */
+			singlestep_skip(p, regs);
 		}
 	} else if (cur) {
 		/* We probably hit a jprobe.  Call its break handler. */
-- 
1.7.2.5

From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:59 +0100
Subject: [PATCH 10/24] ARM: kprobes: Add emulate_rd12rn16rm0_rwflags_nopc()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-11-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is the emulation function for the instruction format used by the
ARM media instructions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index f2eed03..eb11a56 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -957,6 +957,33 @@ emulate_rd12rn16rm0rs8_rwflags(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
 }
 
+static void __kprobes
+emulate_rd12rn16rm0_rwflags_nopc(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rdv asm("r0") = regs->uregs[rd];
+	register unsigned long rnv asm("r2") = regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		BLX("%[fn]")
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdv), [cpsr] "=r" (cpsr)
+		: "0" (rdv), "r" (rnv), "r" (rmv),
+		  "1" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
 /*
  * For the instruction masking and comparisons in all the "space_*"
  * functions below, Do _not_ rearrange the order of tests unless
-- 
1.7.2.5

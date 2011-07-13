From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:53 +0100
Subject: [PATCH 04/24] ARM: kprobes: Add emulate_rd12rn16rm0rs8_rwflags()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is the emulation function for the instruction format used by the
ARM data-processing instructions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 80a9411..6e38bd4 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -893,6 +893,41 @@ prep_emulate_rdhi16rdlo12rs8rm0_wflags(kprobe_opcode_t insn,
 	return INSN_GOOD;
 }
 
+static void __kprobes
+emulate_rd12rn16rm0rs8_rwflags(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = (unsigned long)p->addr + 8;
+	int rd = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+	int rs = (insn >> 8) & 0xf;
+
+	register unsigned long rdv asm("r0") = regs->uregs[rd];
+	register unsigned long rnv asm("r2") = (rn == 15) ? pc
+							  : regs->uregs[rn];
+	register unsigned long rmv asm("r3") = (rm == 15) ? pc
+							  : regs->uregs[rm];
+	register unsigned long rsv asm("r1") = regs->uregs[rs];
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		BLX("%[fn]")
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdv), [cpsr] "=r" (cpsr)
+		: "0" (rdv), "r" (rnv), "r" (rmv), "r" (rsv),
+		  "1" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	if (rd == 15)
+		alu_write_pc(rdv, regs);
+	else
+		regs->uregs[rd] = rdv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
 /*
  * For the instruction masking and comparisons in all the "space_*"
  * functions below, Do _not_ rearrange the order of tests unless
-- 
1.7.2.5

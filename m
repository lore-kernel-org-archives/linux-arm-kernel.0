From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:09 +0100
Subject: [PATCH 20/24] ARM: kprobes: Add new versions of emulate_ldr() and
	emulate_str()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-21-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These use the register calling conventions required by the new decoding
table framework for calling simulated instructions.

We rename the old versions of these functions to *_old for now.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   63 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index bb38ae3..d252e78 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -502,7 +502,7 @@ static void __kprobes emulate_strd(struct kprobe *p, struct pt_regs *regs)
 		regs->uregs[rn] = rnv_wb;
 }
 
-static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes emulate_ldr_old(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_llret_3arg_fn_t *i_fn = (insn_llret_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
@@ -535,7 +535,7 @@ static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = rdv;
 }
 
-static void __kprobes emulate_str(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes emulate_str_old(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
@@ -795,7 +795,7 @@ prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		insn |= 2;	/* Rm = r2 */
 	}
 	asi->insn[0] = insn;
-	asi->insn_handler = (insn & (1 << 20)) ? emulate_ldr : emulate_str;
+	asi->insn_handler = (insn & (1 << 20)) ? emulate_ldr_old : emulate_str_old;
 	return INSN_GOOD;
 }
 
@@ -923,6 +923,63 @@ emulate_ldrdstrd(struct kprobe *p, struct pt_regs *regs)
 }
 
 static void __kprobes
+emulate_ldr(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = (unsigned long)p->addr + 8;
+	int rt = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rtv asm("r0");
+	register unsigned long rnv asm("r2") = (rn == 15) ? pc
+							  : regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		BLX("%[fn]")
+		: "=r" (rtv), "=r" (rnv)
+		: "1" (rnv), "r" (rmv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	if (rt == 15)
+		load_write_pc(rtv, regs);
+	else
+		regs->uregs[rt] = rtv;
+
+	if (is_writeback(insn))
+		regs->uregs[rn] = rnv;
+}
+
+static void __kprobes
+emulate_str(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long rtpc = (unsigned long)p->addr + str_pc_offset;
+	unsigned long rnpc = (unsigned long)p->addr + 8;
+	int rt = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rtv asm("r0") = (rt == 15) ? rtpc
+							  : regs->uregs[rt];
+	register unsigned long rnv asm("r2") = (rn == 15) ? rnpc
+							  : regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		BLX("%[fn]")
+		: "=r" (rnv)
+		: "r" (rtv), "0" (rnv), "r" (rmv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	if (is_writeback(insn))
+		regs->uregs[rn] = rnv;
+}
+
+static void __kprobes
 emulate_rd12rn16rm0rs8_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	kprobe_opcode_t insn = p->opcode;
-- 
1.7.2.5

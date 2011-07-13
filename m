From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:55 +0100
Subject: [PATCH 06/24] ARM: kprobes: Add emulate_ldrdstrd()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is an emulation function for the LDRD and STRD instructions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 8e4b718..2b43d05 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -894,6 +894,35 @@ prep_emulate_rdhi16rdlo12rs8rm0_wflags(kprobe_opcode_t insn,
 }
 
 static void __kprobes
+emulate_ldrdstrd(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = (unsigned long)p->addr + 8;
+	int rt = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rtv asm("r0") = regs->uregs[rt];
+	register unsigned long rt2v asm("r1") = regs->uregs[rt+1];
+	register unsigned long rnv asm("r2") = (rn == 15) ? pc
+							  : regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		BLX("%[fn]")
+		: "=r" (rtv), "=r" (rt2v), "=r" (rnv)
+		: "0" (rtv), "1" (rt2v), "2" (rnv), "r" (rmv),
+		  [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rt] = rtv;
+	regs->uregs[rt+1] = rt2v;
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

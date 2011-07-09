From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:27 +0100
Subject: [PATCH 40/51] ARM: kprobes: Decode 32-bit Thumb table branch
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-41-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 299dc3a..dfaea25 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -37,6 +37,26 @@ static inline unsigned long __kprobes thumb_probe_pc(struct kprobe *p)
 	return (unsigned long)p->addr - 1 + 4;
 }
 
+static void __kprobes
+t32_simulate_table_branch(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	unsigned long rnv = (rn == 15) ? pc : regs->uregs[rn];
+	unsigned long rmv = regs->uregs[rm];
+	unsigned int halfwords;
+
+	if (insn & 0x10)
+		halfwords = ((u16 *)rnv)[rmv];
+	else
+		halfwords = ((u8 *)rnv)[rmv];
+
+	regs->ARM_pc = pc + 2 * halfwords;
+}
+
 static enum kprobe_insn __kprobes
 t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -117,6 +137,11 @@ static const union decode_item t32_table_1110_100x_x1xx[] = {
 	DECODE_EMULATEX	(0xff400000, 0xe9400000, t32_emulate_ldrdstrd,
 						 REGS(NOPCWB, NOSPPC, NOSPPC, 0, 0)),
 
+	/* TBB			1110 1000 1101 xxxx xxxx xxxx 0000 xxxx */
+	/* TBH			1110 1000 1101 xxxx xxxx xxxx 0001 xxxx */
+	DECODE_SIMULATEX(0xfff000e0, 0xe8d00000, t32_simulate_table_branch,
+						 REGS(NOSP, 0, 0, 0, NOSPPC)),
+
 	/* STREX		1110 1000 0100 xxxx xxxx xxxx xxxx xxxx */
 	/* LDREX		1110 1000 0101 xxxx xxxx xxxx xxxx xxxx */
 	/* STREXB		1110 1000 1100 xxxx xxxx xxxx 0100 xxxx */
-- 
1.7.2.5

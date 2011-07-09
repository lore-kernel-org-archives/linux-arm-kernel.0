From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:26 +0100
Subject: [PATCH 39/51] ARM: kprobes: Decode 32-bit Thumb load/store dual and
	load/store exclusive instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-40-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

We reject probing of load/store exclusive instructions because any
emulation routine could never succeed in gaining exclusive access as the
exception framework clears the exclusivity monitor when a probes
breakpoint is hit.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   56 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index d25e5cb..299dc3a 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -50,6 +50,33 @@ t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return ret;
 }
 
+static void __kprobes
+t32_emulate_ldrdstrd(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p) & ~3;
+	int rt1 = (insn >> 12) & 0xf;
+	int rt2 = (insn >> 8) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+
+	register unsigned long rt1v asm("r0") = regs->uregs[rt1];
+	register unsigned long rt2v asm("r1") = regs->uregs[rt2];
+	register unsigned long rnv asm("r2") = (rn == 15) ? pc
+							  : regs->uregs[rn];
+
+	__asm__ __volatile__ (
+		"blx    %[fn]"
+		: "=r" (rt1v), "=r" (rt2v), "=r" (rnv)
+		: "0" (rt1v), "1" (rt2v), "2" (rnv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	if (rn != 15)
+		regs->uregs[rn] = rnv; /* Writeback base register */
+	regs->uregs[rt1] = rt1v;
+	regs->uregs[rt2] = rt2v;
+}
+
 static const union decode_item t32_table_1110_100x_x0xx[] = {
 	/* Load/store multiple instructions */
 
@@ -79,6 +106,29 @@ static const union decode_item t32_table_1110_100x_x0xx[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1110_100x_x1xx[] = {
+	/* Load/store dual, load/store exclusive, table branch */
+
+	/* STRD (immediate)	1110 1000 x110 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRD (immediate)	1110 1000 x111 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_OR	(0xff600000, 0xe8600000),
+	/* STRD (immediate)	1110 1001 x1x0 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRD (immediate)	1110 1001 x1x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xff400000, 0xe9400000, t32_emulate_ldrdstrd,
+						 REGS(NOPCWB, NOSPPC, NOSPPC, 0, 0)),
+
+	/* STREX		1110 1000 0100 xxxx xxxx xxxx xxxx xxxx */
+	/* LDREX		1110 1000 0101 xxxx xxxx xxxx xxxx xxxx */
+	/* STREXB		1110 1000 1100 xxxx xxxx xxxx 0100 xxxx */
+	/* STREXH		1110 1000 1100 xxxx xxxx xxxx 0101 xxxx */
+	/* STREXD		1110 1000 1100 xxxx xxxx xxxx 0111 xxxx */
+	/* LDREXB		1110 1000 1101 xxxx xxxx xxxx 0100 xxxx */
+	/* LDREXH		1110 1000 1101 xxxx xxxx xxxx 0101 xxxx */
+	/* LDREXD		1110 1000 1101 xxxx xxxx xxxx 0111 xxxx */
+	/* And unallocated instructions...				*/
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* Branches and miscellaneous control				*/
 
@@ -103,6 +153,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe400000, 0xe8000000, t32_table_1110_100x_x0xx),
 
 	/*
+	 * Load/store dual, load/store exclusive, table branch
+	 *			1110 100x x1xx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfe400000, 0xe8400000, t32_table_1110_100x_x1xx),
+
+	/*
 	 * Branches and miscellaneous control
 	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5

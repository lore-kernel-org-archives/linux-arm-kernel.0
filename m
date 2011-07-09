From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:37 +0100
Subject: [PATCH 50/51] ARM: kprobes: Decode 32-bit Thumb long multiply and
	divide instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-51-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   55 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 7c32e5b..4ef12d1 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -289,6 +289,32 @@ t32_emulate_rd8rn16_noflags(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = rdv;
 }
 
+static void __kprobes
+t32_emulate_rdlo12rdhi8rn16rm0_noflags(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rdlo = (insn >> 12) & 0xf;
+	int rdhi = (insn >> 8) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rdlov asm("r0") = regs->uregs[rdlo];
+	register unsigned long rdhiv asm("r1") = regs->uregs[rdhi];
+	register unsigned long rnv asm("r2") = regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		"blx    %[fn]"
+		: "=r" (rdlov), "=r" (rdhiv)
+		: "0" (rdlov), "1" (rdhiv), "r" (rnv), "r" (rmv),
+		  [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rdlo] = rdlov;
+	regs->uregs[rdhi] = rdhiv;
+}
+
 static const union decode_item t32_table_1110_100x_x0xx[] = {
 	/* Load/store multiple instructions */
 
@@ -763,6 +789,29 @@ static const union decode_item t32_table_1111_1010___1111[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_1011_1[] = {
+	/* Long multiply, long multiply accumulate, and divide		*/
+
+	/* UMAAL		1111 1011 1110 xxxx xxxx xxxx 0110 xxxx */
+	DECODE_OR	(0xfff000f0, 0xfbe00060),
+	/* SMLALxy		1111 1011 1100 xxxx xxxx xxxx 10xx xxxx */
+	DECODE_OR	(0xfff000c0, 0xfbc00080),
+	/* SMLALD{X}		1111 1011 1100 xxxx xxxx xxxx 110x xxxx */
+	/* SMLSLD{X}		1111 1011 1101 xxxx xxxx xxxx 110x xxxx */
+	DECODE_OR	(0xffe000e0, 0xfbc000c0),
+	/* SMULL		1111 1011 1000 xxxx xxxx xxxx 0000 xxxx */
+	/* UMULL		1111 1011 1010 xxxx xxxx xxxx 0000 xxxx */
+	/* SMLAL		1111 1011 1100 xxxx xxxx xxxx 0000 xxxx */
+	/* UMLAL		1111 1011 1110 xxxx xxxx xxxx 0000 xxxx */
+	DECODE_EMULATEX	(0xff9000f0, 0xfb800000, t32_emulate_rdlo12rdhi8rn16rm0_noflags,
+						 REGS(NOSPPC, NOSPPC, NOSPPC, 0, NOSPPC)),
+
+	/* SDIV			1111 1011 1001 xxxx xxxx xxxx 1111 xxxx */
+	/* UDIV			1111 1011 1011 xxxx xxxx xxxx 1111 xxxx */
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
+
 const union decode_item kprobe_decode_thumb32_table[] = {
 
 	/*
@@ -834,6 +883,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xff00f000, 0xfa00f000, t32_table_1111_1010___1111),
 
 	/*
+	 * Long multiply, long multiply accumulate, and divide
+	 *			1111 1011 1xxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xff800000, 0xfb800000, t32_table_1111_1011_1),
+
+	/*
 	 * Coprocessor instructions
 	 *			1111 11xx xxxx xxxx xxxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5

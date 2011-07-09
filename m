From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:15 +0100
Subject: [PATCH 28/51] ARM: kprobes: Decode 16-bit Thumb CBZ and bit
	manipulation instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-29-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 2b30828..a5bdb2d 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -96,6 +96,20 @@ t16_simulate_add_sp_imm(struct kprobe *p, struct pt_regs *regs)
 		regs->ARM_sp += imm * 4;
 }
 
+static void __kprobes
+t16_simulate_cbz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rn = insn & 0x7;
+	kprobe_opcode_t nonzero = regs->uregs[rn] ? insn : ~insn;
+	if (nonzero & 0x800) {
+		long i = insn & 0x200;
+		long imm5 = insn & 0xf8;
+		unsigned long pc = thumb_probe_pc(p);
+		regs->ARM_pc = pc + (i >> 3) + (imm5 >> 2);
+	}
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -180,6 +194,21 @@ static const union decode_item t16_table_1011[] = {
 	/* SUB (SP minus immediate)	1011 0000 1xxx xxxx */
 	DECODE_SIMULATE	(0xff00, 0xb000, t16_simulate_add_sp_imm),
 
+	/* CBZ				1011 00x1 xxxx xxxx */
+	/* CBNZ				1011 10x1 xxxx xxxx */
+	DECODE_SIMULATE	(0xf500, 0xb100, t16_simulate_cbz),
+
+	/* SXTH				1011 0010 00xx xxxx */
+	/* SXTB				1011 0010 01xx xxxx */
+	/* UXTH				1011 0010 10xx xxxx */
+	/* UXTB				1011 0010 11xx xxxx */
+	/* REV				1011 1010 00xx xxxx */
+	/* REV16			1011 1010 01xx xxxx */
+	/* ???				1011 1010 10xx xxxx */
+	/* REVSH			1011 1010 11xx xxxx */
+	DECODE_REJECT	(0xffc0, 0xba80),
+	DECODE_EMULATE	(0xf500, 0xb000, t16_emulate_loregs_rwflags),
+
 	/*
 	 * If-Then, and hints
 	 *				1011 1111 xxxx xxxx
-- 
1.7.2.5

From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:32 +0100
Subject: [PATCH 45/51] ARM: kprobes: Decode 32-bit Thumb branch instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-46-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   65 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index c07c247..1677234 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -49,9 +49,9 @@ t32_simulate_table_branch(struct kprobe *p, struct pt_regs *regs)
 	unsigned long rmv = regs->uregs[rm];
 	unsigned int halfwords;
 
-	if (insn & 0x10)
+	if (insn & 0x10) /* TBH */
 		halfwords = ((u16 *)rnv)[rmv];
-	else
+	else /* TBB */
 		halfwords = ((u8 *)rnv)[rmv];
 
 	regs->ARM_pc = pc + 2 * halfwords;
@@ -66,6 +66,58 @@ t32_simulate_mrs(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = regs->ARM_cpsr & mask;
 }
 
+static void __kprobes
+t32_simulate_cond_branch(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+
+	long offset = insn & 0x7ff;		/* imm11 */
+	offset += (insn & 0x003f0000) >> 5;	/* imm6 */
+	offset += (insn & 0x00002000) << 4;	/* J1 */
+	offset += (insn & 0x00000800) << 7;	/* J2 */
+	offset -= (insn & 0x04000000) >> 7;	/* Apply sign bit */
+
+	regs->ARM_pc = pc + (offset * 2);
+}
+
+static enum kprobe_insn __kprobes
+t32_decode_cond_branch(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	int cc = (insn >> 22) & 0xf;
+	asi->insn_check_cc = kprobe_condition_checks[cc];
+	asi->insn_handler = t32_simulate_cond_branch;
+	return INSN_GOOD_NO_SLOT;
+}
+
+static void __kprobes
+t32_simulate_branch(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+
+	long offset = insn & 0x7ff;		/* imm11 */
+	offset += (insn & 0x03ff0000) >> 5;	/* imm10 */
+	offset += (insn & 0x00002000) << 9;	/* J1 */
+	offset += (insn & 0x00000800) << 10;	/* J2 */
+	if (insn & 0x04000000)
+		offset -= 0x00800000; /* Apply sign bit */
+	else
+		offset ^= 0x00600000; /* Invert J1 and J2 */
+
+	if (insn & (1 << 14)) {
+		/* BL or BLX */
+		regs->ARM_lr = (unsigned long)p->addr + 4;
+		if (!(insn & (1 << 12))) {
+			/* BLX so switch to ARM mode */
+			regs->ARM_cpsr &= ~PSR_T_BIT;
+			pc &= ~3;
+		}
+	}
+
+	regs->ARM_pc = pc + (offset * 2);
+}
+
 static enum kprobe_insn __kprobes
 t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -425,6 +477,15 @@ static const union decode_item t32_table_1111_0xxx___1[] = {
 	 */
 	DECODE_REJECT	(0xfb80d000, 0xf3808000),
 
+	/* Bcc			1111 0xxx xxxx xxxx 10x0 xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0xf800d000, 0xf0008000, t32_decode_cond_branch),
+
+	/* BLX			1111 0xxx xxxx xxxx 11x0 xxxx xxxx xxx0 */
+	DECODE_OR	(0xf800d001, 0xf000c000),
+	/* B			1111 0xxx xxxx xxxx 10x1 xxxx xxxx xxxx */
+	/* BL			1111 0xxx xxxx xxxx 11x1 xxxx xxxx xxxx */
+	DECODE_SIMULATE	(0xf8009000, 0xf0009000, t32_simulate_branch),
+
 	DECODE_END
 };
 
-- 
1.7.2.5

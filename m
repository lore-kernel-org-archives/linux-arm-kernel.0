From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:31 +0100
Subject: [PATCH 44/51] ARM: kprobes: Decode 32-bit miscellaneous control
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-45-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 1fbeba8..c07c247 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -57,6 +57,15 @@ t32_simulate_table_branch(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_pc = pc + 2 * halfwords;
 }
 
+static void __kprobes
+t32_simulate_mrs(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 8) & 0xf;
+	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
+	regs->uregs[rd] = regs->ARM_cpsr & mask;
+}
+
 static enum kprobe_insn __kprobes
 t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -394,6 +403,28 @@ static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* WFI			1111 0011 1010 xxxx 10x0 x000 0000 0011 */
 	DECODE_SIMULATE	(0xfff0d7fc, 0xf3a08000, kprobe_simulate_nop),
 
+	/* MRS Rd, CPSR		1111 0011 1110 xxxx 10x0 xxxx xxxx xxxx */
+	DECODE_SIMULATEX(0xfff0d000, 0xf3e08000, t32_simulate_mrs,
+						 REGS(0, 0, NOSPPC, 0, 0)),
+
+	/*
+	 * Unsupported instructions
+	 *			1111 0x11 1xxx xxxx 10x0 xxxx xxxx xxxx
+	 *
+	 * MSR			1111 0011 100x xxxx 10x0 xxxx xxxx xxxx
+	 * DBG hint		1111 0011 1010 xxxx 10x0 x000 1111 xxxx
+	 * Unallocated hints	1111 0011 1010 xxxx 10x0 x000 xxxx xxxx
+	 * CPS			1111 0011 1010 xxxx 10x0 xxxx xxxx xxxx
+	 * CLREX/DSB/DMB/ISB	1111 0011 1011 xxxx 10x0 xxxx xxxx xxxx
+	 * BXJ			1111 0011 1100 xxxx 10x0 xxxx xxxx xxxx
+	 * SUBS PC,LR,#<imm8>	1111 0011 1101 xxxx 10x0 xxxx xxxx xxxx
+	 * MRS Rd, SPSR		1111 0011 1111 xxxx 10x0 xxxx xxxx xxxx
+	 * SMC			1111 0111 1111 xxxx 1000 xxxx xxxx xxxx
+	 * UNDEFINED		1111 0111 1111 xxxx 1010 xxxx xxxx xxxx
+	 * ???			1111 0111 1xxx xxxx 1010 xxxx xxxx xxxx
+	 */
+	DECODE_REJECT	(0xfb80d000, 0xf3808000),
+
 	DECODE_END
 };
 
-- 
1.7.2.5

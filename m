From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:21 +0100
Subject: [PATCH 34/51] ARM: kprobes: Decode 32-bit Thumb hint instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-35-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

For hints which may have observable effects, like SEV (send event), we
use kprobe_emulate_none which emulates the hint by executing the
original instruction.

For NOP we simulate the instruction using kprobe_simulate_nop, which
does nothing. As probes execute with interrupts disabled this is also
used for hints which may block for an indefinite time, like WFE (wait
for event).

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 554578b..27f83a3 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -37,6 +37,32 @@ static inline unsigned long __kprobes thumb_probe_pc(struct kprobe *p)
 	return (unsigned long)p->addr - 1 + 4;
 }
 
+static const union decode_item t32_table_1111_0xxx___1[] = {
+	/* Branches and miscellaneous control				*/
+
+	/* YIELD		1111 0011 1010 xxxx 10x0 x000 0000 0001 */
+	DECODE_OR	(0xfff0d7ff, 0xf3a08001),
+	/* SEV			1111 0011 1010 xxxx 10x0 x000 0000 0100 */
+	DECODE_EMULATE	(0xfff0d7ff, 0xf3a08004, kprobe_emulate_none),
+	/* NOP			1111 0011 1010 xxxx 10x0 x000 0000 0000 */
+	/* WFE			1111 0011 1010 xxxx 10x0 x000 0000 0010 */
+	/* WFI			1111 0011 1010 xxxx 10x0 x000 0000 0011 */
+	DECODE_SIMULATE	(0xfff0d7fc, 0xf3a08000, kprobe_simulate_nop),
+
+	DECODE_END
+};
+
+const union decode_item kprobe_decode_thumb32_table[] = {
+
+	/*
+	 * Branches and miscellaneous control
+	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xf8008000, 0xf0008000, t32_table_1111_0xxx___1),
+
+	DECODE_END
+};
+
 static void __kprobes
 t16_simulate_bxblx(struct kprobe *p, struct pt_regs *regs)
 {
@@ -551,5 +577,5 @@ thumb32_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	asi->insn_singlestep = thumb32_singlestep;
 	asi->insn_check_cc = thumb_check_cc;
-	return INSN_REJECTED;
+	return kprobe_decode_insn(insn, asi, kprobe_decode_thumb32_table, true);
 }
-- 
1.7.2.5

From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:11 +0100
Subject: [PATCH 24/51] ARM: kprobes: Decode 16-bit Thumb BX and BLX
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-25-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index e1cef82..b457da0 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -26,6 +26,31 @@
  */
 #define current_cond(cpsr)	((cpsr >> 12) & 0xf)
 
+/*
+ * Return the PC value for a probe in thumb code.
+ * This is the address of the probed instruction plus 4.
+ * We subtract one because the address will have bit zero set to indicate
+ * a pointer to thumb code.
+ */
+static inline unsigned long __kprobes thumb_probe_pc(struct kprobe *p)
+{
+	return (unsigned long)p->addr - 1 + 4;
+}
+
+static void __kprobes
+t16_simulate_bxblx(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	int rm = (insn >> 3) & 0xf;
+	unsigned long rmv = (rm == 15) ? pc : regs->uregs[rm];
+
+	if (insn & (1 << 7)) /* BLX ? */
+		regs->ARM_lr = (unsigned long)p->addr + 2;
+
+	bx_write_pc(rmv, regs);
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -132,6 +157,18 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	DECODE_EMULATE	(0xfc00, 0x4000, t16_emulate_loregs_noitrwflags),
 
 	/*
+	 * Special data instructions and branch and exchange
+	 *				0100 01xx xxxx xxxx
+	 */
+
+	/* BLX pc			0100 0111 1111 1xxx */
+	DECODE_REJECT	(0xfff8, 0x47f8),
+
+	/* BX (register)		0100 0111 0xxx xxxx */
+	/* BLX (register)		0100 0111 1xxx xxxx */
+	DECODE_SIMULATE (0xff00, 0x4700, t16_simulate_bxblx),
+
+	/*
 	 * Miscellaneous 16-bit instructions
 	 *				1011 xxxx xxxx xxxx
 	 */
-- 
1.7.2.5

From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:05 +0100
Subject: [PATCH 18/51] ARM: kprobes: Extend arch_specific_insn to add pointer
	to emulated instruction
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-19-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

When we come to emulating Thumb instructions then, to interwork
correctly, the code on in the instruction slot must be invoked with a
function pointer which has the least significant bit set. Rather that
set this by hand in every Thumb emulation function we will add a new
field for this purpose to arch_specific_insn, called insn_fn.

This also enables us to seamlessly share emulation functions between ARM
and Thumb code.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/kprobes.h |    2 ++
 arch/arm/kernel/kprobes.c      |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index 1e9ff56..feec867 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -34,6 +34,7 @@ struct kprobe;
 typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
 typedef unsigned long (kprobe_check_cc)(unsigned long);
 typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
+typedef void (kprobe_insn_fn_t)(void);
 
 /* Architecture specific copy of original instruction. */
 struct arch_specific_insn {
@@ -41,6 +42,7 @@ struct arch_specific_insn {
 	kprobe_insn_handler_t		*insn_handler;
 	kprobe_check_cc			*insn_check_cc;
 	kprobe_insn_singlestep_t	*insn_singlestep;
+	kprobe_insn_fn_t		*insn_fn;
 };
 
 struct prev_kprobe {
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 3c5ed77..2de3a08 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -51,6 +51,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	kprobe_opcode_t insn;
 	kprobe_opcode_t tmp_insn[MAX_INSN_SIZE];
 	unsigned long addr = (unsigned long)p->addr;
+	bool thumb;
 	kprobe_decode_insn_t *decode_insn;
 	int is;
 
@@ -58,6 +59,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		return -EINVAL;
 
 #ifdef CONFIG_THUMB2_KERNEL
+	thumb = 1;
 	addr &= ~1; /* Bit 0 would normally be set to indicate Thumb code */
 	insn = ((u16 *)addr)[0];
 	if (is_wide_instruction(insn)) {
@@ -67,6 +69,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	} else
 		decode_insn = thumb16_kprobe_decode_insn;
 #else /* !CONFIG_THUMB2_KERNEL */
+	thumb = 0;
 	if (addr & 0x3)
 		return -EINVAL;
 	insn = *p->addr;
@@ -88,6 +91,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 			p->ainsn.insn[is] = tmp_insn[is];
 		flush_insns(p->ainsn.insn,
 				sizeof(p->ainsn.insn[0]) * MAX_INSN_SIZE);
+		p->ainsn.insn_fn = (kprobe_insn_fn_t *)
+					((uintptr_t)p->ainsn.insn | thumb);
 		break;
 
 	case INSN_GOOD_NO_SLOT:	/* instruction doesn't need insn slot */
-- 
1.7.2.5

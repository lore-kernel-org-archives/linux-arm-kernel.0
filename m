From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:57 +0100
Subject: [PATCH 10/51] ARM: kprobes: Add Thumb instruction decoding stubs
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-11-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Extend arch_prepare_kprobe to support probing of Thumb code. For
the actual decoding of Thumb instructions, stub functions are
added which currently just reject the probe.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/Makefile        |    4 ++++
 arch/arm/kernel/kprobes.h       |   13 +++++++++++++
 arch/arm/kernel/kprobes-thumb.c |   26 ++++++++++++++++++++++++++
 arch/arm/kernel/kprobes.c       |   20 ++++++++++++++++++--
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a22b8f1..f7887dc 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -38,7 +38,11 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o
+ifdef CONFIG_THUMB2_KERNEL
+obj-$(CONFIG_KPROBES)		+= kprobes-thumb.o
+else
 obj-$(CONFIG_KPROBES)		+= kprobes-arm.o
+endif
 obj-$(CONFIG_ATAGS_PROC)	+= atags.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 406bb2d..86abfab 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -29,8 +29,21 @@ enum kprobe_insn {
 	INSN_GOOD_NO_SLOT
 };
 
+typedef enum kprobe_insn (kprobe_decode_insn_t)(kprobe_opcode_t,
+						struct arch_specific_insn *);
+
+#ifdef CONFIG_THUMB2_KERNEL
+
+enum kprobe_insn thumb16_kprobe_decode_insn(kprobe_opcode_t,
+						struct arch_specific_insn *);
+enum kprobe_insn thumb32_kprobe_decode_insn(kprobe_opcode_t,
+						struct arch_specific_insn *);
+
+#else /* !CONFIG_THUMB2_KERNEL */
+
 enum kprobe_insn arm_kprobe_decode_insn(kprobe_opcode_t,
 					struct arch_specific_insn *);
+#endif
 
 void __init arm_kprobe_decode_init(void);
 
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
new file mode 100644
index 0000000..ac6b2d1
--- /dev/null
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/kernel/kprobes-thumb.c
+ *
+ * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+
+#include "kprobes.h"
+
+enum kprobe_insn __kprobes
+thumb16_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	return INSN_REJECTED;
+}
+
+enum kprobe_insn __kprobes
+thumb32_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	return INSN_REJECTED;
+}
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 0e47d3d..0df2d6d 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -51,16 +51,32 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	kprobe_opcode_t insn;
 	kprobe_opcode_t tmp_insn[MAX_INSN_SIZE];
 	unsigned long addr = (unsigned long)p->addr;
+	kprobe_decode_insn_t *decode_insn;
 	int is;
 
-	if (addr & 0x3 || in_exception_text(addr))
+	if (in_exception_text(addr))
 		return -EINVAL;
 
+#ifdef CONFIG_THUMB2_KERNEL
+	addr &= ~1; /* Bit 0 would normally be set to indicate Thumb code */
+	insn = ((u16 *)addr)[0];
+	if (is_wide_instruction(insn)) {
+		insn <<= 16;
+		insn |= ((u16 *)addr)[1];
+		decode_insn = thumb32_kprobe_decode_insn;
+	} else
+		decode_insn = thumb16_kprobe_decode_insn;
+#else /* !CONFIG_THUMB2_KERNEL */
+	if (addr & 0x3)
+		return -EINVAL;
 	insn = *p->addr;
+	decode_insn = arm_kprobe_decode_insn;
+#endif
+
 	p->opcode = insn;
 	p->ainsn.insn = tmp_insn;
 
-	switch (arm_kprobe_decode_insn(insn, &p->ainsn)) {
+	switch ((*decode_insn)(insn, &p->ainsn)) {
 	case INSN_REJECTED:	/* not supported */
 		return -EINVAL;
 
-- 
1.7.2.5

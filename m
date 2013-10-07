From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  7 Oct 2013 14:12:28 +0200
Subject: [RFC PATCH 2/5] ARM64: add quick-n-dirty emulation for AES
 instructions
In-Reply-To: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381147951-7609-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile            |   1 +
 arch/arm64/crypto/Makefile     |  11 ++
 arch/arm64/crypto/aesce-emu.c  | 221 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/traps.h |  10 ++
 arch/arm64/kernel/entry.S      |   4 +-
 arch/arm64/kernel/traps.c      |  49 +++++++++
 6 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aesce-emu.c

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d90cf79..c864bb5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -39,6 +39,7 @@ export	TEXT_OFFSET GZFLAGS
 core-y		+= arch/arm64/kernel/ arch/arm64/mm/
 core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
+core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
new file mode 100644
index 0000000..f87ec80
--- /dev/null
+++ b/arch/arm64/crypto/Makefile
@@ -0,0 +1,11 @@
+#
+# linux/arch/arm64/crypto/Makefile
+#
+# Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+obj-y += aesce-emu.o
diff --git a/arch/arm64/crypto/aesce-emu.c b/arch/arm64/crypto/aesce-emu.c
new file mode 100644
index 0000000..4cc7ee9
--- /dev/null
+++ b/arch/arm64/crypto/aesce-emu.c
@@ -0,0 +1,221 @@
+/*
+ * aesce-emu-c - emulate aese/aesd/aesmc/aesimc instructions
+ *
+ * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <asm/traps.h>
+
+union AES_STATE {
+	u8	bytes[16];
+	u64	l[2];
+} __aligned(8);
+
+static void add_sub_shift(union AES_STATE *st, union AES_STATE *rk, int inv);
+static void mix_columns(union AES_STATE *out, union AES_STATE *in);
+static void inv_mix_columns_pre(union AES_STATE *out);
+
+#define REG_ACCESS(op, r, mem) \
+	do { case r: asm(#op " {v" #r ".16b}, [%0]" : : "r"(mem)); goto out; \
+	} while (0)
+
+#define REG_SWITCH(reg, op, m) do { switch (reg) { \
+	REG_ACCESS(op,  0, m);	REG_ACCESS(op,  1, m);	REG_ACCESS(op,  2, m); \
+	REG_ACCESS(op,  3, m);	REG_ACCESS(op,  4, m);	REG_ACCESS(op,  5, m); \
+	REG_ACCESS(op,  6, m);	REG_ACCESS(op,  7, m);	REG_ACCESS(op,  8, m); \
+	REG_ACCESS(op,  9, m);	REG_ACCESS(op, 10, m);	REG_ACCESS(op, 11, m); \
+	REG_ACCESS(op, 12, m);	REG_ACCESS(op, 13, m);	REG_ACCESS(op, 14, m); \
+	REG_ACCESS(op, 15, m);	REG_ACCESS(op, 16, m);	REG_ACCESS(op, 17, m); \
+	REG_ACCESS(op, 18, m);	REG_ACCESS(op, 19, m);	REG_ACCESS(op, 20, m); \
+	REG_ACCESS(op, 21, m);	REG_ACCESS(op, 22, m);	REG_ACCESS(op, 23, m); \
+	REG_ACCESS(op, 24, m);	REG_ACCESS(op, 25, m);	REG_ACCESS(op, 26, m); \
+	REG_ACCESS(op, 27, m);	REG_ACCESS(op, 28, m);	REG_ACCESS(op, 29, m); \
+	REG_ACCESS(op, 30, m);	REG_ACCESS(op, 31, m); \
+	} out:; } while (0)
+
+static void load_neon_reg(union AES_STATE *st, int reg)
+{
+	REG_SWITCH(reg, st1, st->bytes);
+}
+
+static void save_neon_reg(union AES_STATE *st, int reg, struct pt_regs *regs)
+{
+	REG_SWITCH(reg, ld1, st->bytes);
+
+#ifdef CONFIG_STACK_NEON_REGS_ON_EXCEPTION
+	if (reg < 4)
+		/* update the stacked reg as well */
+		memcpy((u8 *)&regs->qregs[reg], st->bytes, 16);
+#endif
+}
+
+static void aesce_do_emulate(unsigned int instr, struct pt_regs *regs)
+{
+	enum { AESE, AESD, AESMC, AESIMC } kind = (instr >> 12) & 3;
+	int rn = (instr >> 5) & 0x1f;
+	int rd = instr & 0x1f;
+	union AES_STATE in, out;
+
+	load_neon_reg(&in, rn);
+
+	switch (kind) {
+	case AESE:
+	case AESD:
+		load_neon_reg(&out, rd);
+		add_sub_shift(&out, &in, kind);
+		break;
+	case AESIMC:
+		inv_mix_columns_pre(&in);
+	case AESMC:
+		mix_columns(&out, &in);
+	}
+	save_neon_reg(&out, rd, regs);
+}
+
+static int aesce_emu_instr(struct pt_regs *regs, unsigned int instr);
+
+static struct undef_hook aesce_emu_uh = {
+	.instr_val	= 0x4e284800,
+	.instr_mask	= 0xffffcc00,
+	.fn		= aesce_emu_instr,
+};
+
+static int aesce_emu_instr(struct pt_regs *regs, unsigned int instr)
+{
+	do {
+		aesce_do_emulate(instr, regs);
+		regs->pc += 4;
+		get_user(instr, (u32 __user *)regs->pc);
+	} while ((instr & aesce_emu_uh.instr_mask) == aesce_emu_uh.instr_val);
+
+	return 0;
+}
+
+static int aesce_emu_init(void)
+{
+	register_undef_hook(&aesce_emu_uh);
+	return 0;
+}
+
+arch_initcall(aesce_emu_init);
+
+#define gf8_mul_x(a) \
+	(((a) << 1) ^ (((a) & 0x80) ? 0x1b : 0))
+
+static void mix_columns(union AES_STATE *out, union AES_STATE *in)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		out->bytes[i] =
+			gf8_mul_x(in->bytes[i]) ^
+			gf8_mul_x(in->bytes[((i + 1) % 4) | (i & ~3)]) ^
+				in->bytes[((i + 1) % 4) | (i & ~3)] ^
+				in->bytes[((i + 2) % 4) | (i & ~3)] ^
+				in->bytes[((i + 3) % 4) | (i & ~3)];
+}
+
+#define gf8_mul_x2(a) \
+	(((a) << 2) ^ (((a) & 0x80) ? 0x36 : 0) ^ (((a) & 0x40) ? 0x1b : 0))
+
+static void inv_mix_columns_pre(union AES_STATE *out)
+{
+	union AES_STATE in = *out;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		out->bytes[i] = gf8_mul_x2(in.bytes[i]) ^ in.bytes[i] ^
+				gf8_mul_x2(in.bytes[i ^ 2]);
+}
+
+static void add_sub_shift(union AES_STATE *st, union AES_STATE *rk, int inv)
+{
+	static u8 const sbox[][256] = { {
+		0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
+		0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
+		0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+		0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
+		0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
+		0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
+		0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
+		0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
+		0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+		0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
+		0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
+		0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
+		0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
+		0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
+		0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+		0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
+		0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
+		0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
+		0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
+		0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
+		0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+		0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
+		0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
+		0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
+		0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
+		0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
+		0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+		0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
+		0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
+		0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
+		0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
+		0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
+	}, {
+		0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38,
+		0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
+		0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87,
+		0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
+		0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d,
+		0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
+		0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2,
+		0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
+		0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16,
+		0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
+		0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda,
+		0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
+		0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a,
+		0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
+		0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02,
+		0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
+		0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea,
+		0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
+		0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85,
+		0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
+		0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89,
+		0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
+		0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20,
+		0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
+		0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31,
+		0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
+		0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d,
+		0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
+		0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0,
+		0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
+		0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26,
+		0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
+	} };
+	static u8 const permute[][16] = { {
+		0,  5, 10, 15, 4, 9, 14,  3, 8, 13, 2,  7, 12, 1, 6, 11
+	}, {
+		0, 13, 10,  7, 4, 1, 14, 11, 8,  5, 2, 15, 12, 9, 6,  3
+	} };
+	int i;
+
+	rk->l[0] ^= st->l[0];
+	rk->l[1] ^= st->l[1];
+
+	for (i = 0; i < 16; i++)
+		st->bytes[i] = sbox[inv][rk->bytes[permute[inv][i]]];
+}
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 10ca8ff..781e50cb2 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -27,4 +27,14 @@ static inline int in_exception_text(unsigned long ptr)
 	       ptr < (unsigned long)&__exception_text_end;
 }
 
+struct undef_hook {
+	struct list_head node;
+	u32 instr_mask;
+	u32 instr_val;
+	int (*fn)(struct pt_regs *regs, unsigned int instr);
+};
+
+void register_undef_hook(struct undef_hook *hook);
+void unregister_undef_hook(struct undef_hook *hook);
+
 #endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c74dcca..e4d89df 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -291,7 +291,9 @@ el1_undef:
 	 * Undefined instruction
 	 */
 	mov	x0, sp
-	b	do_undefinstr
+	bl	do_undefinstr
+
+	kernel_exit 1
 el1_dbg:
 	/*
 	 * Debug exception handling
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffaddd..3cc4c91 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -257,11 +257,60 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		die(str, regs, err);
 }
 
+static LIST_HEAD(undef_hook);
+static DEFINE_RAW_SPINLOCK(undef_lock);
+
+void register_undef_hook(struct undef_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_add(&hook->node, &undef_hook);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+}
+
+void unregister_undef_hook(struct undef_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_del(&hook->node);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+}
+
+static int call_undef_hook(struct pt_regs *regs, void __user *pc)
+{
+	struct undef_hook *hook;
+	unsigned long flags;
+	int (*fn)(struct pt_regs *regs, unsigned int instr) = NULL;
+	unsigned int instr;
+	mm_segment_t fs;
+	int ret;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	get_user(instr, (u32 __user *)pc);
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_for_each_entry(hook, &undef_hook, node)
+		if ((instr & hook->instr_mask) == hook->instr_val)
+			fn = hook->fn;
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+
+	ret = fn ? fn(regs, instr) : 1;
+	set_fs(fs);
+	return ret;
+}
+
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 {
 	siginfo_t info;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
+	if (call_undef_hook(regs, pc) == 0)
+		return;
+
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
-- 
1.8.1.2

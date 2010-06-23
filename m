From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jun 2010 10:36:02 +0100
Subject: [PATCH 1/2] ARM: Add kprobe-based event tracer
In-Reply-To: <1277285763-16213-1-git-send-email-will.deacon@arm.com>
References: <1277285763-16213-1-git-send-email-will.deacon@arm.com>
Message-ID: <1277285763-16213-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the HAVE_REGS_AND_STACK_ACCESS_API option
for ARM which is required by the kprobe events tracer. Code based
on the PowerPC port.

Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/ptrace.h |   36 +++++++++++++++
 arch/arm/kernel/ptrace.c      |   96 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e57cb24..e0e7de6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 9dcb11e..c974be8 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -184,6 +184,42 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 #define predicate(x)		((x) & 0xf0000000)
 #define PREDICATE_ALWAYS	0xe0000000
 
+/*
+ * kprobe-based event tracer support
+ */
+#include <linux/stddef.h>
+#include <linux/types.h>
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, ARM_ORIG_r0))
+
+extern int regs_query_register_offset(const char *name);
+extern const char *regs_query_register_name(unsigned int offset);
+extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
+extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+					       unsigned int n);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	   pt_regs from which register value is gotten
+ * @offset:    offset number of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					      unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->ARM_sp;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3f562a7..f99d489 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -52,6 +52,102 @@
 #define BREAKINST_THUMB	0xde01
 #endif
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) \
+	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(r0),
+	REG_OFFSET_NAME(r1),
+	REG_OFFSET_NAME(r2),
+	REG_OFFSET_NAME(r3),
+	REG_OFFSET_NAME(r4),
+	REG_OFFSET_NAME(r5),
+	REG_OFFSET_NAME(r6),
+	REG_OFFSET_NAME(r7),
+	REG_OFFSET_NAME(r8),
+	REG_OFFSET_NAME(r9),
+	REG_OFFSET_NAME(r10),
+	REG_OFFSET_NAME(fp),
+	REG_OFFSET_NAME(ip),
+	REG_OFFSET_NAME(sp),
+	REG_OFFSET_NAME(lr),
+	REG_OFFSET_NAME(pc),
+	REG_OFFSET_NAME(cpsr),
+	REG_OFFSET_NAME(ORIG_r0),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_query_register_name() - query register name from its offset
+ * @offset:	the offset of a register in struct pt_regs.
+ *
+ * regs_query_register_name() returns the name of a register from its
+ * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
+ */
+const char *regs_query_register_name(unsigned int offset)
+{
+	const struct pt_regs_offset *roff;
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (roff->offset == offset)
+			return roff->name;
+	return NULL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return ((addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 /*
  * this routine will get a word off of the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
-- 
1.6.3.3

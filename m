From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 11 Oct 2009 09:26:51 +0300
Subject: [PATCH] ARM: ELF: Add register information of threads to coredump
Message-ID: <1255242411-16025-1-git-send-email-dedekind1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>

Defines ELF_CORE_COPY_TASK_REGS so that CPU register information
of every thread is included in coredump. Without this, only the faulting
thread is coredumped.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/elf.h |    3 +++
 arch/arm/kernel/process.c  |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index c3b911e..6aac3f5 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -98,6 +98,9 @@ extern int elf_check_arch(const struct elf32_hdr *);
 extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
 #define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
 
+int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
+#define ELF_CORE_COPY_TASK_REGS dump_task_regs
+
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 790fbee..0d96d01 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -328,6 +328,15 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 }
 
 /*
+ * Fill in the task's elfregs structure for a core dump.
+ */
+int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs)
+{
+	elf_core_copy_regs(elfregs, task_pt_regs(t));
+	return 1;
+}
+
+/*
  * fill in the fpe structure for a core dump...
  */
 int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
-- 
1.6.2.5

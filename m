From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:41 -0400
Subject: [PATCH v2 2/8] arm_elf_read_implies_exec(): remove unused argument
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-3-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first argument to elf_read_implies_exec() is either the actual
header structure or a pointer to that structure whether one looks
at fs/binfmt_elf.c or fs/binfmt_elf_fdpic.c. This ought to be fixed
of course, but in the mean time let's sidestep the issue by removing
that first argument from arm_elf_read_implies_exec() as it is unused
anyway.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/elf.h | 4 ++--
 arch/arm/kernel/elf.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index f13ae153fb..e2786acf82 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -102,8 +102,8 @@ extern int elf_check_arch(const struct elf32_hdr *);
 
 #define vmcore_elf64_check_arch(x) (0)
 
-extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
-#define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
+extern int arm_elf_read_implies_exec(int);
+#define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(stk)
 
 struct task_struct;
 int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index d0d1e83150..52fb98358d 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL(elf_set_personality);
  *  - the binary requires an executable stack
  *  - we're running on a CPU which doesn't support NX.
  */
-int arm_elf_read_implies_exec(const struct elf32_hdr *x, int executable_stack)
+int arm_elf_read_implies_exec(int executable_stack)
 {
 	if (executable_stack != EXSTACK_DISABLE_X)
 		return 1;
-- 
2.9.5

From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 11 Mar 2010 11:01:43 +0100
Subject: [PATCH 2.6.34-rc1] fix warning in kernel/elfcore.c from ARM's elf.h
Message-ID: <19352.49031.176324.151185@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2.6.34-rc1 added kernel/elfcore.c which includes <asm/elf.h>.
On ARM, this results in:

In file included from include/linux/elf.h:7,
                 from kernel/elfcore.c:1:
/tmp/linux-2.6.34-rc1/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
/tmp/linux-2.6.34-rc1/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want

Including <linux/sched.h> seems a bit heavyweight, so this patch just
adds a tentative declaration of struct task_struct in <asm/elf.h>.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
diff -rupN linux-2.6.34-rc1/arch/arm/include/asm/elf.h linux-2.6.34-rc1.arm-elf-task_struct/arch/arm/include/asm/elf.h
--- linux-2.6.34-rc1/arch/arm/include/asm/elf.h	2010-02-25 14:45:00.000000000 +0100
+++ linux-2.6.34-rc1.arm-elf-task_struct/arch/arm/include/asm/elf.h	2010-03-11 10:55:39.000000000 +0100
@@ -98,6 +98,7 @@ extern int elf_check_arch(const struct e
 extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
 #define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
 
+struct task_struct;
 int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 #define ELF_CORE_COPY_TASK_REGS dump_task_regs
 

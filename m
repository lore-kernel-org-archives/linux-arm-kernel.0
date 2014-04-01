From: rabin@rab.in (Rabin Vincent)
Date: Wed, 2 Apr 2014 01:08:45 +0200
Subject: [PATCH] arm: don't allow CONFIG_DEBUG_SET_MODULE_RONX if
 CONFIG_JUMP_LABEL is enabled
In-Reply-To: <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
References: <1396346657-7166-1-git-send-email-holler@ahsoftware.de>
 <533AFF77.5030106@codeaurora.org>
 <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
Message-ID: <CAH+eYFDkYczZXYF3be6tTRg7kkGhK2zyukDTo+N8mwEKcG89LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-01 20:36 GMT+02:00 Kees Cook <keescook@chromium.org>:
> Is there something "sticky" about PMD sections that I'm not aware of?
> Even after calling set_kernel_text_rw(), any writes to kernel memory
> fault. :(

section_update() updates init_mm, but each mm has a copy of the first
level page tables.  So your updates to init_mm won't be visibile to
currently running processes.  (Have a look at arch/arm/mm/ioremap.c's
vmalloc_seq stuff for some background on how section support is
handled on non-SMP; the vmalloc code doesn't use sections on SMP.)

Here's a patch (probably whitespace damaged, hence also attached) with
which dynamic ftrace works for me on top your other paches.  Tested on
a non-LPAE SMP.

Notes:
- I commented out the other entries in section_perm except from the
kernel text only because I didn't want to figure out the mask values
to use
- I didn't/couldn't call set_kernel_text_rw in
ftrace_arch_code_modify_prepare() because that is called outside of
stop_machine(), and stop_machine() triggers another thread which
actually runs ftrace_modify_all_code() with the machine stopped.


>From 91d92b8e241835013cefaca0c5121b9d6df9d500 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Wed, 2 Apr 2014 00:57:09 +0200
Subject: [PATCH] ftrace

---
 arch/arm/kernel/ftrace.c | 21 +++++++++++++
 arch/arm/mm/init.c       | 77 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 34e5664..61cb8ef 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -14,6 +14,7 @@

 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/stop_machine.h>

 #include <asm/cacheflush.h>
 #include <asm/opcodes.h>
@@ -34,6 +35,26 @@

 #define OLD_NOP 0xe1a00000 /* mov r0, r0 */

+static int __ftrace_modify_code(void *data)
+{
+ extern void set_kernel_text_rw(struct mm_struct *mm);
+ extern void set_kernel_text_ro(struct mm_struct *mm);
+
+ struct mm_struct *mm = current->active_mm;
+ int *command = data;
+
+ set_kernel_text_rw(mm);
+ ftrace_modify_all_code(*command);
+ set_kernel_text_ro(mm);
+
+ return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+ stop_machine(__ftrace_modify_code, &command, NULL);
+}
+
 static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
 {
  return rec->arch.old_mcount ? OLD_NOP : NOP;
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5b1b049..c4da92d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -630,22 +630,24 @@ void __init mem_init(void)
 struct section_perm {
  unsigned long start;
  unsigned long end;
+ pmdval_t mask;
  pmdval_t prot;
+ pmdval_t clear;
 };

-struct section_perm __initdata section_perms[] = {
+struct section_perm section_perms[] = {
  /* Make pages tables, etc before _stext RW (set NX). */
- {
- .start = PAGE_OFFSET,
- .end = (unsigned long)_stext,
- .prot = PMD_SECT_XN,
- },
- /* Make init RW (set NX). */
- {
- .start = (unsigned long)__init_begin,
- .end = (unsigned long)_sdata,
- .prot = PMD_SECT_XN,
- },
+ // {
+ // .start = PAGE_OFFSET,
+ // .end = (unsigned long)_stext,
+ // .prot = PMD_SECT_XN,
+ // },
+ // /* Make init RW (set NX). */
+ // {
+ // .start = (unsigned long)__init_begin,
+ // .end = (unsigned long)_sdata,
+ // .prot = PMD_SECT_XN,
+ // },
  /* Make kernel code and rodata RX (set RO). */
  {
  .start = (unsigned long)_stext,
@@ -653,30 +655,37 @@ struct section_perm __initdata section_perms[] = {
 #ifdef CONFIG_ARM_LPAE
  .prot = PMD_SECT_RDONLY,
 #else
+ .mask       = ~(PMD_SECT_APX | PMD_SECT_AP_WRITE),
  .prot = PMD_SECT_APX | PMD_SECT_AP_WRITE,
+ .clear       = PMD_SECT_AP_WRITE,
 #endif
  },
 #ifdef CONFIG_DEBUG_RODATA
  /* Make rodata RO (set NX). */
- {
- .start = (unsigned long)__start_rodata,
- .end = (unsigned long)__init_begin,
- .prot = PMD_SECT_XN,
- }
+ // {
+ // .start = (unsigned long)__start_rodata,
+ // .end = (unsigned long)__init_begin,
+ // .prot = PMD_SECT_XN,
+ // }
 #endif
 };

-static inline void section_update(unsigned long addr, pmdval_t prot)
+static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long virt)
+{
+ return pmd_offset(pud_offset(pgd_offset(mm, virt), virt), virt);
+}
+
+static inline void section_update(struct mm_struct *mm, unsigned long
addr, pmdval_t mask, pmdval_t prot)
 {
- pmd_t *pmd = pmd_off_k(addr);
+ pmd_t *pmd = pmd_off(mm, addr);

 #ifdef CONFIG_ARM_LPAE
  pmd[0] = __pmd(pmd_val(pmd[0]) | prot);
 #else
  if (addr & SECTION_SIZE)
- pmd[1] = __pmd(pmd_val(pmd[1]) | prot);
+ pmd[1] = __pmd((pmd_val(pmd[1]) & mask) | prot);
  else
- pmd[0] = __pmd(pmd_val(pmd[0]) | prot);
+ pmd[0] = __pmd((pmd_val(pmd[0]) & mask) | prot);
 #endif
  flush_pmd_entry(pmd);
 }
@@ -702,13 +711,37 @@ static inline void fix_kernmem_perms(void)
  for (addr = section_perms[i].start;
      addr < section_perms[i].end;
      addr += SECTION_SIZE)
- section_update(addr, section_perms[i].prot);
+ section_update(&init_mm, addr, section_perms[i].mask, section_perms[i].prot);
  }
 }
 #else
 static inline void fix_kernmem_perms(void) { }
 #endif /* CONFIG_ARM_KERNMEM_PERMS */

+void set_kernel_text_rw(struct mm_struct *mm)
+{
+       unsigned long addr;
+
+       for (addr = section_perms[0].start;
+            addr < section_perms[0].end;
+            addr += SECTION_SIZE)
+              section_update(mm, addr, section_perms[0].mask,
+                            section_perms[0].clear);
+
+       flush_tlb_all();
+}
+
+void set_kernel_text_ro(struct mm_struct *mm)
+{
+       unsigned long addr;
+
+       for (addr = section_perms[0].start;
+            addr < section_perms[0].end;
+            addr += SECTION_SIZE)
+              section_update(mm, addr, section_perms[0].mask,
+                            section_perms[0].prot);
+}
+
 void free_initmem(void)
 {
 #ifdef CONFIG_HAVE_TCM
-- 
1.9.0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ftrace.patch
Type: text/x-patch
Size: 4803 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/a3b57122/attachment.bin>

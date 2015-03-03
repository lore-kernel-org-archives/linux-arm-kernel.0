From: keescook@chromium.org (Kees Cook)
Date: Mon,  2 Mar 2015 16:19:46 -0800
Subject: [PATCH 3/5] mm: move randomize_et_dyn into ELF_ET_DYN_BASE
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Message-ID: <1425341988-1599-4-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for moving ET_DYN randomization into the ELF loader
(which requires a static ELF_ET_DYN_BASE), this redefines s390's existing
ET_DYN randomization away from a separate function (randomize_et_dyn)
and into ELF_ET_DYN_BASE and a call to arch_mmap_rnd(). This refactoring
results in the same ET_DYN randomization on s390. Additionally removes
a copy/pasted unused arm64 extern.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/elf.h |  1 -
 arch/s390/include/asm/elf.h  |  9 +++++----
 arch/s390/mm/mmap.c          | 11 -----------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 1f65be393139..f724db00b235 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -125,7 +125,6 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  * the loader.  We need to make sure that it is out of the way of the program
  * that it will "exec", and that there is sufficient room for the brk.
  */
-extern unsigned long randomize_et_dyn(unsigned long base);
 #define ELF_ET_DYN_BASE	(2 * TASK_SIZE_64 / 3)
 
 /*
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index c9df40b5c0ac..9ed68e7ee856 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -161,10 +161,11 @@ extern unsigned int vdso_enabled;
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-extern unsigned long randomize_et_dyn(void);
-#define ELF_ET_DYN_BASE		randomize_et_dyn()
+   that it will "exec", and that there is sufficient room for the brk. 64-bit
+   tasks are aligned to 4GB. */
+#define ELF_ET_DYN_BASE (arch_mmap_rnd() + (is_32bit_task() ? \
+				(STACK_TOP / 3 * 2) : \
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 77759e35671b..ec4c20448aef 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -179,17 +179,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-unsigned long randomize_et_dyn(void)
-{
-	unsigned long base;
-
-	base = STACK_TOP / 3 * 2;
-	if (!is_32bit_task())
-		/* Align to 4GB */
-		base &= ~((1UL << 32) - 1);
-	return base + arch_mmap_rnd();
-}
-
 #ifndef CONFIG_64BIT
 
 /*
-- 
1.9.1

From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:52 -0800
Subject: [PATCH v4 08/10] s390: redefine randomize_et_dyn for ELF_ET_DYN_BASE
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <1425503454-7531-9-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for moving ET_DYN randomization into the ELF loader (which
requires a static ELF_ET_DYN_BASE), this redefines s390's existing ET_DYN
randomization in a call to arch_mmap_rnd(). This refactoring results in
the same ET_DYN randomization on s390.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/include/asm/elf.h |  8 +++++---
 arch/s390/mm/mmap.c         | 11 ++---------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index c9df40b5c0ac..2e63de8aac7c 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -161,10 +161,12 @@ extern unsigned int vdso_enabled;
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
+   that it will "exec", and that there is sufficient room for the brk. 64-bit
+   tasks are aligned to 4GB. */
 extern unsigned long randomize_et_dyn(void);
-#define ELF_ET_DYN_BASE		randomize_et_dyn()
+#define ELF_ET_DYN_BASE (randomize_et_dyn() + (is_32bit_task() ? \
+				(STACK_TOP / 3 * 2) : \
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index a94504d99c47..8c11536f972d 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -179,17 +179,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 unsigned long randomize_et_dyn(void)
 {
-	unsigned long base;
-
-	base = STACK_TOP / 3 * 2;
-	if (!is_32bit_task())
-		/* Align to 4GB */
-		base &= ~((1UL << 32) - 1);
-
 	if (current->flags & PF_RANDOMIZE)
-		base += arch_mmap_rnd();
+		return arch_mmap_rnd();
 
-	return base;
+	return 0UL;
 }
 
 #ifndef CONFIG_64BIT
-- 
1.9.1

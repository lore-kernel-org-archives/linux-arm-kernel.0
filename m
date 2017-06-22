From: keescook@chromium.org (Kees Cook)
Date: Thu, 22 Jun 2017 11:06:29 -0700
Subject: [PATCH 1/4] arm: Reduce ELF_ET_DYN_BASE
In-Reply-To: <1498154792-49952-1-git-send-email-keescook@chromium.org>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
Message-ID: <1498154792-49952-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that explicitly executed loaders are loaded in the mmap region,
position PIE binaries lower in the address space to avoid possible
collisions with mmap or stack regions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/elf.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d2315ffd8f12..f13ae153fb24 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -112,12 +112,8 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	4096
 
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-#define ELF_ET_DYN_BASE	(TASK_SIZE / 3 * 2)
+/* This is the base location for PIE (ET_DYN with INTERP) loads. */
+#define ELF_ET_DYN_BASE		0x400000UL
 
 /* When the program starts, a1 contains a pointer to a function to be 
    registered with atexit, as per the SVR4 ABI.  A value of 0 means we 
-- 
2.7.4

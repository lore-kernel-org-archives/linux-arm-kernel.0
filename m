From: keescook@chromium.org (Kees Cook)
Date: Thu, 22 Jun 2017 11:06:31 -0700
Subject: [PATCH 3/4] powerpc: Reduce ELF_ET_DYN_BASE
In-Reply-To: <1498154792-49952-1-git-send-email-keescook@chromium.org>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
Message-ID: <1498154792-49952-4-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that explicitly executed loaders are loaded in the mmap region,
position PIE binaries lower in the address space to avoid possible
collisions with mmap or stack regions. For 64-bit, align to 4GB to
allow runtimes to use the entire 32-bit address space for 32-bit
pointers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/include/asm/elf.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 09bde6e34f5d..548d9a411a0d 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -23,12 +23,13 @@
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-#define ELF_ET_DYN_BASE	0x20000000
+/*
+ * This is the base location for PIE (ET_DYN with INTERP) loads. On
+ * 64-bit, this is raised to 4GB to leave the entire 32-bit address
+ * space open for things that want to use the area for 32-bit pointers.
+ */
+#define ELF_ET_DYN_BASE		(is_32bit_task() ? 0x000400000UL : \
+						   0x100000000UL)
 
 #define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
 
-- 
2.7.4

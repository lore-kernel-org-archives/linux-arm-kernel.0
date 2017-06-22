From: keescook@chromium.org (Kees Cook)
Date: Thu, 22 Jun 2017 11:06:32 -0700
Subject: [PATCH 4/4] s390: Reduce ELF_ET_DYN_BASE
In-Reply-To: <1498154792-49952-1-git-send-email-keescook@chromium.org>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
Message-ID: <1498154792-49952-5-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that explicitly executed loaders are loaded in the mmap region,
position PIE binaries lower in the address space to avoid possible
collisions with mmap or stack regions. For 64-bit, align to 4GB to
allow runtimes to use the entire 32-bit address space for 32-bit
pointers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/include/asm/elf.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index e8f623041769..7c58d599f91b 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -161,14 +161,13 @@ extern unsigned int vdso_enabled;
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	4096
 
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk. 64-bit
-   tasks are aligned to 4GB. */
-#define ELF_ET_DYN_BASE (is_compat_task() ? \
-				(STACK_TOP / 3 * 2) : \
-				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1))
+/*
+ * This is the base location for PIE (ET_DYN with INTERP) loads. On
+ * 64-bit, this is raised to 4GB to leave the entire 32-bit address
+ * space open for things that want to use the area for 32-bit pointers.
+ */
+#define ELF_ET_DYN_BASE		(is_compat_task() ? 0x000400000UL : \
+						    0x100000000UL)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
-- 
2.7.4

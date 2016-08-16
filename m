From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 16 Aug 2016 14:32:29 -0400
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
Message-ID: <20160816183231.21179-1-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some userspace applications need to know the maximum virtual address they can
use (TASK_SIZE). There are several possible values for TASK_SIZE with the arm64
kernel, and such applications are either making bad hard-coded assumptions, or
are guessing and checking using system calls like munmap(), which may have
other reasons for returning an error than TASK_SIZE being exceeded. To make
correct functioning easy for userspace applications that need to know the
maximum virtual address they can use, communicate TASK_SIZE via the ELF
auxiliary vector, just like PAGE_SIZE is currently communicated.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
Tested with the following commands:
LD_SHOW_AUXV=1 sleep 1 # GNU dynamic ld-linux*.so
hexdump -v -e '4/4 "%08x " "\n"' /proc/self/auxv | \
  sed -r 's/0*([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/\1 0x\4\3/
    s/^0 /    NULL: /
    s/^3 /    PHDR: /
    s/^4 /   PHENT: /
    s/^5 /   PHNUM: /
    s/^6 /  PAGESZ: /
    s/^7 /    BASE: /
    s/^8 /   FLAGS: /
    s/^9 /   ENTRY: /
    s/^b /     UID: /
    s/^c /    EUID: /
    s/^d /     GID: /
    s/^e /    EGID: /
    s/^f /PLATFORM: /
    s/^10 /   HWCAP: /
    s/^11 /  CLKTCK: /
    s/^17 /  SECURE: /
    s/^19 /  RANDOM: /
    s/^1f /  EXECFN: /
    s/^21 /    VDSO: /
    s/^22 /  TASKSZ: /' # compatible with static busybox
---
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a55384f..3811795 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -145,6 +145,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
 		    (elf_addr_t)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_TASKSZ, TASK_SIZE);				\
 } while (0)
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 4cf0c17..595bfda 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -18,7 +18,8 @@
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
+#define AT_TASKSZ	34
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
 
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.

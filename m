From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 21 Sep 2015 18:00:33 +0100
Subject: [PATCH] arm: wire up userfaultfd and membarrier syscalls
Message-ID: <1442854833-10592-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the syscall numbers to the ARM syscall table. Both have
been briefly tested using the provided selftests from the tools
directory.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi Russell,

I saw that Thierry sent something similar beginning of August already
(which is now outdated), is there any issue with enabling syscalls?

Cheers,
Andre.

 arch/arm/include/asm/unistd.h      | 2 +-
 arch/arm/include/uapi/asm/unistd.h | 2 ++
 arch/arm/kernel/calls.S            | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 32640c4..7cba573 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -19,7 +19,7 @@
  * This may need to be greater than __NR_last_syscall+1 in order to
  * account for the padding in the syscall table
  */
-#define __NR_syscalls  (388)
+#define __NR_syscalls  (392)
 
 /*
  * *NOTE*: This is a ghost syscall private to the kernel.  Only the
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index 0c3f5a0..7a2a32a 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -414,6 +414,8 @@
 #define __NR_memfd_create		(__NR_SYSCALL_BASE+385)
 #define __NR_bpf			(__NR_SYSCALL_BASE+386)
 #define __NR_execveat			(__NR_SYSCALL_BASE+387)
+#define __NR_userfaultfd		(__NR_SYSCALL_BASE+388)
+#define __NR_membarrier			(__NR_SYSCALL_BASE+389)
 
 /*
  * The following SWIs are ARM private.
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 05745eb..fde6c88 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -397,6 +397,8 @@
 /* 385 */	CALL(sys_memfd_create)
 		CALL(sys_bpf)
 		CALL(sys_execveat)
+		CALL(sys_userfaultfd)
+		CALL(sys_membarrier)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
2.5.1

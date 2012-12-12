From: steve.capper@arm.com (Steve Capper)
Date: Wed, 12 Dec 2012 17:40:49 +0000
Subject: [RFC PATCH 3/3] ARM: syscall: wire up sys_migrate_pages.
In-Reply-To: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
References: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
Message-ID: <1355334049-10247-4-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For NUMA support, the sys_migrate_pages syscall is required by
userspace. This patch allocates #379 for this syscall and plumbs
it in.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/uapi/asm/unistd.h |    1 +
 arch/arm/kernel/calls.S            |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ac03bdb..23e3d59 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -405,6 +405,7 @@
 #define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
 #define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
 					/* 378 for kcmp */
+#define __NR_migrate_pages		(__NR_SYSCALL_BASE+379)
 
 /*
  * This may need to be greater than __NR_last_syscall+1 in order to
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 831cd38..a96af99 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -388,6 +388,7 @@
 		CALL(sys_process_vm_readv)
 		CALL(sys_process_vm_writev)
 		CALL(sys_ni_syscall)	/* reserved for sys_kcmp */
+		CALL(sys_migrate_pages)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
1.7.9.5

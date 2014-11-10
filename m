From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Nov 2014 14:59:56 +0100
Subject: [PATCH] ARM: Wire up bpf syscall
Message-ID: <1415627996-27395-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the bpf syscall to ARM.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that I haven't tested whether this new syscall actually works on ARM,
but it certainly gets rid of the annoying "syscall bpf not implemented"
warning.

 arch/arm/include/uapi/asm/unistd.h | 1 +
 arch/arm/kernel/calls.S            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index 3aaa75cae90c..705bb7620673 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -412,6 +412,7 @@
 #define __NR_seccomp			(__NR_SYSCALL_BASE+383)
 #define __NR_getrandom			(__NR_SYSCALL_BASE+384)
 #define __NR_memfd_create		(__NR_SYSCALL_BASE+385)
+#define __NR_bpf			(__NR_SYSCALL_BASE+386)
 
 /*
  * The following SWIs are ARM private.
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 9f899d8fdcca..e51833f8cc38 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -395,6 +395,7 @@
 		CALL(sys_seccomp)
 		CALL(sys_getrandom)
 /* 385 */	CALL(sys_memfd_create)
+		CALL(sys_bpf)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
2.1.3

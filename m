From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 25 Feb 2016 09:52:46 +0000
Subject: [PATCH v2 6/8] arm64: Add a wrapper for personality() syscall
In-Reply-To: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456393968-17386-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent setting PER_LINUX32 on systems without
32bit EL0 support, add a wrapper for personality() syscall.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/sys.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 75151aa..817d860 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -36,11 +36,17 @@ asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 	return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
+SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
+{
+	return sys_personality(personality);
+}
+
 /*
  * Wrappers to pass the pt_regs argument.
  */
 asmlinkage long sys_rt_sigreturn_wrapper(void);
 #define sys_rt_sigreturn	sys_rt_sigreturn_wrapper
+#define sys_personality		sys_arm64_personality
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
-- 
1.7.9.5

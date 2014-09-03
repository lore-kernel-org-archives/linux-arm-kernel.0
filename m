From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:19:02 -0700
Subject: [PATCH 08/24] Allow a 32bit ABI to use the naming of the 64bit ABI
 syscalls to avoid confusion of not splitting the registers
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-9-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the ARM64 ILP32 case, we want to say the syscalls that normally would pass
64bit as two arguments are now passing as one so want to use the 64bit
naming scheme.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 include/uapi/asm-generic/unistd.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 11d11bc..a7984a0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -881,8 +881,12 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
  * they take different names.
  * Here we map the numbers so that both versions
  * use the same syscall table layout.
+ * For 32bit abis where 64bit can be passed via one
+ * register, use the same naming as the 64bit ones
+ * as they will only have a 64 bit off_t.
  */
-#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
+#if (__BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)) || \
+	defined(__ARCH_WANT_64BIT_SYSCALLS)
 #define __NR_fcntl __NR3264_fcntl
 #define __NR_statfs __NR3264_statfs
 #define __NR_fstatfs __NR3264_fstatfs
-- 
1.7.2.5

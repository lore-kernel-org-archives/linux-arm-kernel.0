From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:18 +0200
Subject: [PATCH v4 08/24] arm64:ilp32: use 64bit syscall-names for ILP32 when
 passing 64bit registers
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <8227a3e65df06e9d06121acc99eae66c27200162.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

In the ARM64 ILP32 case, we want to say the syscalls that normally would pass
64bit as two arguments are now passing as one so want to use the 64bit
naming scheme.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 include/uapi/asm-generic/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index e016bd9..398a890 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -885,8 +885,11 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
  * they take different names.
  * Here we map the numbers so that both versions
  * use the same syscall table layout.
+ * For 32bit abis where 64bit can be passed via one
+ * register, use the same naming as the 64bit ones
+ * as they will only have a 64 bit off_t.
  */
-#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
+#if (__BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)) || defined(__SYSCALL_NONCOMPAT)
 #define __NR_fcntl __NR3264_fcntl
 #define __NR_statfs __NR3264_statfs
 #define __NR_fstatfs __NR3264_fstatfs
-- 
1.9.1

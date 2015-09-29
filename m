From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:13:58 +0300
Subject: [PATCH v5 01/23] arm64:ilp32: add documentation on the ILP32 ABI for
 ARM64
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-2-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Based on Andrew Pinski's original patch-series and adapted with changes
to reduce the duplication of code-paths and resolve issue found during
LTP testing.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..1049510
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,64 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+Written by Andrew Pinski <apinski@cavium.com>
+Updated by Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
+
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic linux syscall interface.
+
+ILP32 sets __kernel_long_t and __kernel_ulong_t both to 64bit.  This
+affects the following type definitions for ILP32 client programs:
+ * time_t          unsigned long long
+ * clock_t         unsigned long long
+ * fsword_t        long long
+ * suseconds_t     long long
+ * swblk_t         long long
+ * fd_mask_t       long long
+
+Some structures are changed to reduce the difference in the code path
+for both ILP32 and LP64 ABIs for signal handling.
+
+The following structures have been changed so the layout of the
+structures are the same between ILP32 and LP64 ABIs, including:
+ * timespec        uses time_t and suseconds_t
+ * timeval         uses time_t and suseconds_t
+ * stat            uses timespec/time_t
+ * semid64_ds      uses time_t.
+ * msqid64_ds      uses time_t.
+ * shmid64_ds      uses time_t.
+ * rt_sigframe     uses siginfo and ucontext.
+ * siginfo_t       uses clock_t and sigval_t
+ * ucontext        uses stack_t and sigset_t
+ * sigval_t        contains pointers
+ * sigevent        Uses sigval_t which causes it to be the same.  Special
+                   handing is needed for reading; in the mq_notify syscall
+ * sigaction       Conversion is handled in the userland (glibc), as the
+		    userland data structures are defined in glibc anyway.
+ * fd_set          This is done to avoid endian issues between ILP32 and
+		   LP64. Syscalls consuming fd_set use timespec.
+
+A number of structures differ between ILP32 and LP64, including:
+ * struct msgbuf   The specification of 'struct msgbuf' defines the 'mtype'
+                   field as a 'long' (i.e. 32bit for ILP32, but 64bit for
+		   LP64).  Functions that operate on 'struct msgbuf' need
+		   to be passed through the compat-syscalls to resolve
+		   this.
+ * stack_t         contains pointers (handled in the compatibility layer)
+
+Also the syscalls which normally would pass 64bit values as two arguments;
+now pass the 64bit value as one argument.  Also they have been renamed
+(removing the 64 from the name) to avoid confusion.
+The list of these LP64 syscalls reused by ILP32 clients is:
+ * fcntl
+ * statfs
+ * fstatfs
+ * truncate
+ * ftruncate
+ * lseek
+ * sendfile
+ * newfstatat
+ * fstat
+ * mmap
+ * fadvise64
+
-- 
2.1.4

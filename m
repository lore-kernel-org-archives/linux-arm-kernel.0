From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 18 Jun 2016 02:54:12 +0300
Subject: [PATCH 03/19] arm64: ilp32: add documentation on the ILP32 ABI for
 ARM64
In-Reply-To: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1466207668-10549-4-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..d5faa31
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,54 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic compat linux syscall interface.
+
+AARCH64/ILP32 userspace can potentially access top halves of registers that
+are passed as syscall arguments, so such registers (w0-w7) are deloused.
+
+AARCH64/ILP32 provides next types turned to 64-bit (comparing to AARCH32):
+ino_t       is u64 type.
+off_t       is s64 type.
+blkcnt_t    is s64 type.
+fsblkcnt_t  is u64 type.
+fsfilcnt_t  is u64 type.
+
+AARCH64/ILP32 ABI uses standard syscall table which can be found at
+include/uapi/asm-generic/unistd.h, with the exceptions listed below.
+
+Syscalls which pass 64bit values are handled by the code shared from
+AARCH32 and pass that value as a pair. Next syscalls are affected:
+fadvise64_64()
+fallocate()
+ftruncate64()		
+pread64	()
+pwrite64()
+readahead()
+sync_file_range()
+truncate64()
+sys_mmap()
+
+ptrace() syscall is handled by compat version.
+
+fcntl64() syscall is handled by non-compat handler as struct flock for ilp32
+is the same as for lp64
+
+shmat() syscall is handled by non-compat handler as aarch64/ilp32 has no
+limitation on 4-pages alignement for shared memory.
+
+Syscalls which take a pointer to stat, stat64, statfs, statfs64
+structures are now routed to native handlers directly, as aarch64/ilp32
+defines userspace ino_t, off_t, blkcnt_t, fsblkcnt_t, fsfilcnt_t types
+as 64-bit and it makes that structures have same layout as lp64.
+Next syscalls are affected:
+fstatat64()
+fstat64()
+statfs64()
+fstatfs64()
+
+struct rt_sigframe is redefined and contains struct compat_siginfo,
+as compat syscalls expects, and struct ilp32_sigframe, to handle
+AARCH64 register set and 32-bit userspace register representation.h
+
+elf_gregset_t is taken from lp64 to handle registers properly.
-- 
2.7.4

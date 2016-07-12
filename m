From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 10:41:59 +0900
Subject: [RFC 1/3] syscall: add kexec_file_load to generic unistd.h
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
Message-ID: <20160712014201.11456-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently kexec_file_load is supported only on x86, but it will be
supported on powerpc and arm64 in near future. Since both archs
use asm-generic/unistd.h, this patch adds the entry to this file.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/uapi/asm-generic/unistd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a26415b..9ead10f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -724,9 +724,15 @@ __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
 __SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
 #define __NR_pwritev2 287
 __SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
+#define __NR_kexec_file_load 288
+#ifdef CONFIG_KEXEC_FILE
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
+#else
+__SYSCALL(__NR_kexec_file_load, sys_ni_syscall)
+#endif /* CONFIG_KEXEC_FILE */
 
 #undef __NR_syscalls
-#define __NR_syscalls 288
+#define __NR_syscalls 289
 
 /*
  * All syscalls below here should go away really,
-- 
2.9.0

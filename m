From: rabin.vincent@axis.com (Rabin Vincent)
Date: Mon, 14 Nov 2016 14:03:45 +0100
Subject: [PATCH] ARM: ftrace: fix syscall name matching
Message-ID: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabinv@axis.com>

ARM has a few system calls (most notably mmap) for which the names of
the functions which are referenced in the syscall table do not match the
names of the syscall tracepoints.  As a consequence of this, these
tracepoints are not made available.  Implement
arch_syscall_match_sym_name to fix this and allow tracing even these
system calls.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/arm/include/asm/ftrace.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index bfe2a2f..8467909 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -54,6 +54,27 @@ static inline void *return_address(unsigned int level)
 
 #define ftrace_return_address(n) return_address(n)
 
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	/* Skip sys_ */
+	sym += 4;
+	name += 4;
+
+	if (!strcmp(sym, "mmap2"))
+		sym = "mmap_pgoff";
+	else if (!strcmp(sym, "statfs64_wrapper"))
+		sym = "statfs64";
+	else if (!strcmp(sym, "fstatfs64_wrapper"))
+		sym = "fstatfs64";
+	else if (!strcmp(sym, "arm_fadvise64_64"))
+		sym = "fadvise64_64";
+
+	return !strcmp(sym, name);
+}
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* _ASM_ARM_FTRACE */
-- 
2.1.4

From: rabin.vincent@axis.com (Rabin Vincent)
Date: Tue, 15 Nov 2016 11:17:09 +0100
Subject: [PATCHv2] ARM: ftrace: fix syscall name matching
In-Reply-To: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
References: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
Message-ID: <1479205029-14498-1-git-send-email-rabin.vincent@axis.com>
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
v2: get rid of unsafe-looking pointer adjustment

 arch/arm/include/asm/ftrace.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index bfe2a2f..22b7311 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -54,6 +54,24 @@ static inline void *return_address(unsigned int level)
 
 #define ftrace_return_address(n) return_address(n)
 
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	if (!strcmp(sym, "sys_mmap2"))
+		sym = "sys_mmap_pgoff";
+	else if (!strcmp(sym, "sys_statfs64_wrapper"))
+		sym = "sys_statfs64";
+	else if (!strcmp(sym, "sys_fstatfs64_wrapper"))
+		sym = "sys_fstatfs64";
+	else if (!strcmp(sym, "sys_arm_fadvise64_64"))
+		sym = "sys_fadvise64_64";
+
+	/* Ignore case since sym may start with "SyS" instead of "sys" */
+	return !strcasecmp(sym, name);
+}
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* _ASM_ARM_FTRACE */
-- 
2.1.4

From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:00 +0100
Subject: [PATCH 1/6] arm64: sysreg: replace open-coded mrs_s/msr_s with {read,
 write}_sysreg_s
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to our {read,write}_sysreg accessors for architected, named
system registers, this patch introduces {read,write}_sysreg_s variants
that can take arbitrary sys_reg output and therefore access IMPDEF
registers or registers that unsupported by binutils.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cputype.h |  6 +-----
 arch/arm64/include/asm/sysreg.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 9d9fd4b9a72e..26a68ddb11c1 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -93,11 +93,7 @@
 
 #include <asm/sysreg.h>
 
-#define read_cpuid(reg) ({						\
-	u64 __val;							\
-	asm("mrs_s	%0, " __stringify(SYS_ ## reg) : "=r" (__val));	\
-	__val;								\
-})
+#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
 /*
  * The CPU ID never changes at run time, so we might as well tell the
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index cc06794b7346..10d76d417d17 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -279,6 +279,22 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 		     : : "r" (__val));				\
 } while (0)
 
+/*
+ * For registers without architectural names, or simply unsupported by
+ * GAS.
+ */
+#define read_sysreg_s(r) ({					\
+	u64 __val;						\
+	asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));	\
+	__val;							\
+})
+
+#define write_sysreg_s(v, r) do {					\
+	u64 __val = (u64)v;					\
+	asm volatile("msr_s " __stringify(r) ", %0"		\
+		     : : "r" (__val));				\
+} while (0)
+
 #endif
 
 #endif	/* __ASM_SYSREG_H */
-- 
2.1.4

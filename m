From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 19 Oct 2016 14:40:54 +0100
Subject: [PATCH v2] arm64: Cortex-A53 errata workaround: check for kernel
 addresses
Message-ID: <20161019134054.20413-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on
errata-affected core") adds code to execute cache maintenance instructions
in the kernel on behalf of userland on CPUs with certain ARM CPU errata.
It turns out that the address hasn't been checked to be a valid user
space address, allowing userland to clean cache lines in kernel space.
Fix this by introducing an access_ok() check before executing the
instructions on behalf of userland. We have to take care of tagged
pointers here, since the address is not coming in via a syscall (which
requires the tag to be 0).

Fixes: 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on errata-affected core")
Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changelog v1 .. v2:
- use PAGE_SIZE instead of cache_line_size() for access check
- merge extra function into original macro
- replace access_ok_tagged() with untagged_addr() macro

 arch/arm64/include/asm/uaccess.h |  8 ++++++++
 arch/arm64/kernel/traps.c        | 35 +++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index bcaf6fb..55d0adb 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -21,6 +21,7 @@
 /*
  * User space memory access functions
  */
+#include <linux/bitops.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 #include <linux/thread_info.h>
@@ -102,6 +103,13 @@ static inline void set_fs(mm_segment_t fs)
 	flag;								\
 })
 
+/*
+ * When dealing with data aborts or instruction traps we may end up with
+ * a tagged userland pointer. Clear the tag to get a sane pointer to pass
+ * on to access_ok(), for instance.
+ */
+#define untagged_addr(addr)		sign_extend64(addr, 55)
+
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5ff020f..1e81328 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -433,19 +433,30 @@ void cpu_enable_cache_maint_trap(void *__unused)
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
 }
 
+/*
+ * Technically the access_ok() check should be done on a cache line size
+ * granularity, but it's tedious the get the right one (dcache vs. icache,
+ * per-core vs. system wide). Since permission checks are based on pages
+ * anyway, just use PAGE_SIZE instead.
+ */
 #define __user_cache_maint(insn, address, res)			\
-	asm volatile (						\
-		"1:	" insn ", %1\n"				\
-		"	mov	%w0, #0\n"			\
-		"2:\n"						\
-		"	.pushsection .fixup,\"ax\"\n"		\
-		"	.align	2\n"				\
-		"3:	mov	%w0, %w2\n"			\
-		"	b	2b\n"				\
-		"	.popsection\n"				\
-		_ASM_EXTABLE(1b, 3b)				\
-		: "=r" (res)					\
-		: "r" (address), "i" (-EFAULT) )
+	if (!access_ok(VERIFY_READ,				\
+		       untagged_addr(address & PAGE_MASK),	\
+	               PAGE_SIZE)) 				\
+		res = -EFAULT;					\
+	else							\
+		asm volatile (					\
+			"1:	" insn ", %1\n"			\
+			"	mov	%w0, #0\n"		\
+			"2:\n"					\
+			"	.pushsection .fixup,\"ax\"\n"	\
+			"	.align	2\n"			\
+			"3:	mov	%w0, %w2\n"		\
+			"	b	2b\n"			\
+			"	.popsection\n"			\
+			_ASM_EXTABLE(1b, 3b)			\
+			: "=r" (res)				\
+			: "r" (address), "i" (-EFAULT) )
 
 static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 {
-- 
2.9.0

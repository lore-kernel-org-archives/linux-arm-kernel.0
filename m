From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 13:55:36 +0100
Subject: [PATCH 3/6] arm64: dcc: simplify accessors
In-Reply-To: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
References: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473339339-32334-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A while back we added {read,write}_sysreg accessors to handle accesses
to system registers, without the usual boilerplate asm volatile,
temporary variable, etc.

This patch makes use of these in the arm64 DCC accessors to make the
code shorter and clearer.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/dcc.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
index 65e0190..836b056 100644
--- a/arch/arm64/include/asm/dcc.h
+++ b/arch/arm64/include/asm/dcc.h
@@ -21,21 +21,16 @@
 #define __ASM_DCC_H
 
 #include <asm/barrier.h>
+#include <asm/sysreg.h>
 
 static inline u32 __dcc_getstatus(void)
 {
-	u32 ret;
-
-	asm volatile("mrs %0, mdccsr_el0" : "=r" (ret));
-
-	return ret;
+	return read_sysreg(mdccsr_el0);
 }
 
 static inline char __dcc_getchar(void)
 {
-	char c;
-
-	asm volatile("mrs %0, dbgdtrrx_el0" : "=r" (c));
+	char c = read_sysreg(dbgdtrrx_el0);
 	isb();
 
 	return c;
@@ -47,8 +42,7 @@ static inline void __dcc_putchar(char c)
 	 * The typecast is to make absolutely certain that 'c' is
 	 * zero-extended.
 	 */
-	asm volatile("msr dbgdtrtx_el0, %0"
-			: : "r" ((unsigned long)(unsigned char)c));
+	write_sysreg((unsigned char)c, dbgdtrtx_el0);
 	isb();
 }
 
-- 
1.9.1

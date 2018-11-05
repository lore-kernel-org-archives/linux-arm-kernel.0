From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:43 +0000
Subject: [PATCH 04/10] arm64: tishift: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the tishift exports
to the assembly file the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 7 -------
 arch/arm64/lib/tishift.S       | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 73237dc8a994..d80e9cfc3062 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -68,10 +68,3 @@ NOKPROBE_SYMBOL(_mcount);
 EXPORT_SYMBOL(__arm_smccc_smc);
 EXPORT_SYMBOL(__arm_smccc_hvc);
 
-	/* tishift.S */
-extern long long __ashlti3(long long a, int b);
-EXPORT_SYMBOL(__ashlti3);
-extern long long __ashrti3(long long a, int b);
-EXPORT_SYMBOL(__ashrti3);
-extern long long __lshrti3(long long a, int b);
-EXPORT_SYMBOL(__lshrti3);
diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
index 0fdff97794de..981ff4496b7a 100644
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -5,6 +5,8 @@
 
 #include <linux/linkage.h>
 
+#include <asm/export.h>
+
 ENTRY(__ashlti3)
 	cbz	x2, 1f
 	mov	x3, #64
@@ -25,6 +27,7 @@ ENTRY(__ashlti3)
 	mov	x0, x2
 	ret
 ENDPROC(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
 
 ENTRY(__ashrti3)
 	cbz	x2, 1f
@@ -46,6 +49,7 @@ ENTRY(__ashrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
 
 ENTRY(__lshrti3)
 	cbz	x2, 1f
@@ -67,3 +71,4 @@ ENTRY(__lshrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
-- 
2.11.0

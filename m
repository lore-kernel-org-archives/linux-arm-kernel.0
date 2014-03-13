From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 18:15:48 +0000
Subject: [PATCH 1/5] arm: Move asm macro get_thread_info to asm/assembler.h
In-Reply-To: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1394734552-4704-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/assembler.h is a better place for this macro since it is used by
asm files outside arch/arm/kernel/

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/assembler.h | 10 ++++++++++
 arch/arm/kernel/entry-header.S   | 11 -----------
 arch/arm/vfp/entry.S             |  5 ++++-
 arch/arm/vfp/vfphw.S             |  5 ++++-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 5c2285160575..7380a3ecffa2 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -174,6 +174,16 @@
 	restore_irqs_notrace \oldcpsr
 	.endm
 
+/*
+ * Get current thread_info.
+ */
+	.macro	get_thread_info, rd
+ ARM(	mov	\rd, sp, lsr #13	)
+ THUMB(	mov	\rd, sp			)
+ THUMB(	lsr	\rd, \rd, #13		)
+	mov	\rd, \rd, lsl #13
+	.endm
+
 #define USER(x...)				\
 9999:	x;					\
 	.pushsection __ex_table,"a";		\
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 39f89fbd5111..1420725142ca 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -236,11 +236,6 @@
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
 
-	.macro	get_thread_info, rd
-	mov	\rd, sp, lsr #13
-	mov	\rd, \rd, lsl #13
-	.endm
-
 	@
 	@ 32-bit wide "mov pc, reg"
 	@
@@ -306,12 +301,6 @@
 	.endm
 #endif	/* ifdef CONFIG_CPU_V7M / else */
 
-	.macro	get_thread_info, rd
-	mov	\rd, sp
-	lsr	\rd, \rd, #13
-	mov	\rd, \rd, lsl #13
-	.endm
-
 	@
 	@ 32-bit wide "mov pc, reg"
 	@
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 46e17492fd1f..9cc290ae4e3b 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -8,9 +8,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
-#include "../kernel/entry-header.S"
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 
 @ VFP entry point.
 @
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 3e5d3115a2a6..98f6246c9002 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -14,10 +14,13 @@
  * r10 points at the start of the private FP workspace in the thread structure
  * sp points to a struct pt_regs (as defined in include/asm/proc/ptrace.h)
  */
+#include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
 #include <linux/kern_levels.h>
-#include "../kernel/entry-header.S"
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 
 	.macro	DBGSTR, str
 #ifdef DEBUG

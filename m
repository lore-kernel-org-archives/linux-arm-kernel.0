From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:32 -0400
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-6-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

The get_thread_info assembler macro is currently defined in
arch/arm/kernel/entry-header.S and used in the following
files:

	arch/arm/kernel/entry-armv.S
	arch/arm/kernel/entry-common.S
	arch/arm/vfp/vfphw.S
	arch/arm/vfp/entry.S

The first two cases above use #include "entry-header.S" while
the later two cases use #include "../kernel/entry-header.S"
to obtain the get_thread_info assembler macro definition.

Move the get_thread_info assembler macro definition into
arch/arm/include/asm/assember.h and clean up inclusion
of this macro definition to use #include <asm/assember.h>.

This change facilitates use of the get_thread_info assembler
macro in other assembler functions without more of the same
path relative include directives.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/include/asm/assembler.h |   13 +++++++++++++
 arch/arm/kernel/entry-header.S   |   11 -----------
 arch/arm/vfp/entry.S             |    5 ++++-
 arch/arm/vfp/vfphw.S             |    5 ++++-
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 29035e8..78397d0 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -23,6 +23,19 @@
 #include <asm/ptrace.h>
 #include <asm/domain.h>
 
+#ifndef CONFIG_THUMB2_KERNEL
+	.macro	get_thread_info, rd
+	mov	\rd, sp, lsr #13
+	mov	\rd, \rd, lsl #13
+	.endm
+#else   /* CONFIG_THUMB2_KERNEL */
+	.macro	get_thread_info, rd
+	mov	\rd, sp
+	lsr	\rd, \rd, #13
+	mov	\rd, \rd, lsl #13
+	.endm
+#endif  /* !CONFIG_THUMB2_KERNEL */
+
 /*
  * Endian independent macros for shifting bytes within registers.
  */
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..d03b6a9 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -108,11 +108,6 @@
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
@@ -148,12 +143,6 @@
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
 
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
index 4fa9903..e475a5a 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -15,9 +15,12 @@
  *  r10 = thread_info structure
  *  lr  = failure return
  */
+#include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
-#include "../kernel/entry-header.S"
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 
 ENTRY(do_vfp)
 #ifdef CONFIG_PREEMPT
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 2d30c7f..68ca5af 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -14,9 +14,12 @@
  * r10 points at the start of the private FP workspace in the thread structure
  * sp points to a struct pt_regs (as defined in include/asm/proc/ptrace.h)
  */
+#include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
-#include "../kernel/entry-header.S"
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 
 	.macro	DBGSTR, str
 #ifdef DEBUG
-- 
1.7.4.4

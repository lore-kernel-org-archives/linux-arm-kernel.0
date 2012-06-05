From: joe@perches.com (Joe Perches)
Date: Tue,  5 Jun 2012 02:46:32 -0700
Subject: [PATCH 3/8] arch: Remove direct definitions of KERN_<LEVEL> uses
In-Reply-To: <cover.1338889066.git.joe@perches.com>
References: <cover.1338889066.git.joe@perches.com>
Message-ID: <282f5ce989b713c749966dcefbc4b306f0fa909a.1338889066.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add #include <linux/kern_levels.h> so that the #define KERN_<LEVEL>
macros don't have to be duplicated.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/lib/io-acorn.S         |    3 ++-
 arch/arm/vfp/vfphw.S            |    7 ++++---
 arch/frv/kernel/kernel_thread.S |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/io-acorn.S b/arch/arm/lib/io-acorn.S
index 1b197ea..69719ba 100644
--- a/arch/arm/lib/io-acorn.S
+++ b/arch/arm/lib/io-acorn.S
@@ -11,13 +11,14 @@
  *
  */
 #include <linux/linkage.h>
+#include <linux/kern_levels.h>
 #include <asm/assembler.h>
 
 		.text
 		.align
 
 .Liosl_warning:
-		.ascii	"<4>insl/outsl not implemented, called from %08lX\0"
+		.ascii	KERN_WARNING "insl/outsl not implemented, called from %08lX\0"
 		.align
 
 /*
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 2d30c7f..d50f0e4 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -16,6 +16,7 @@
  */
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
+#include <linux/kern_levels.h>
 #include "../kernel/entry-header.S"
 
 	.macro	DBGSTR, str
@@ -24,7 +25,7 @@
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
@@ -37,7 +38,7 @@
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
@@ -52,7 +53,7 @@
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
diff --git a/arch/frv/kernel/kernel_thread.S b/arch/frv/kernel/kernel_thread.S
index 4531c83..f0e5294 100644
--- a/arch/frv/kernel/kernel_thread.S
+++ b/arch/frv/kernel/kernel_thread.S
@@ -10,10 +10,10 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/kern_levels.h>
 #include <asm/unistd.h>
 
 #define CLONE_VM	0x00000100	/* set if VM shared between processes */
-#define	KERN_ERR	"<3>"
 
 	.section .rodata
 kernel_thread_emsg:
-- 
1.7.8.111.gad25c.dirty

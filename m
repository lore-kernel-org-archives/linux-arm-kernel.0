From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 23 May 2012 17:34:13 -0700
Subject: [PATCH] Consolidate stack size information into THREAD_SIZE_ORDER
Message-ID: <4FBD8205.3010904@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reduces the number of magic values in the code, as well as
makes it easier to experiment with larger or smaller stack sizes.

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
PATCH FOLLOWS
---
 arch/arm/include/asm/thread_info.h |    2 +-
 arch/arm/kernel/entry-header.S     |    8 ++++----
 arch/arm/mm/proc-macros.S          |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 0f04d84..5172c36 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -16,7 +16,7 @@
 #include <asm/fpstate.h>

 #define THREAD_SIZE_ORDER	1
-#define THREAD_SIZE		8192
+#define THREAD_SIZE		(4096 << THREAD_SIZE_ORDER)
 #define THREAD_START_SP		(THREAD_SIZE - 8)

 #ifndef __ASSEMBLY__
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..f94216b 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -109,8 +109,8 @@
 	.endm

 	.macro	get_thread_info, rd
-	mov	\rd, sp, lsr #13
-	mov	\rd, \rd, lsl #13
+	mov	\rd, sp, lsr #12 + THREAD_SIZE_ORDER
+	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
 	.endm

 	@
@@ -150,8 +150,8 @@

 	.macro	get_thread_info, rd
 	mov	\rd, sp
-	lsr	\rd, \rd, #13
-	mov	\rd, \rd, lsl #13
+	lsr	\rd, \rd, #12 + THREAD_SIZE_ORDER
+	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
 	.endm

 	@
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..7006c88 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -30,8 +30,8 @@
  * act_mm - get current->active_mm
  */
 	.macro	act_mm, rd
-	bic	\rd, sp, #8128
-	bic	\rd, \rd, #63
+	mov	\rd, sp, lsr #12 + THREAD_SIZE_ORDER
+	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
 	ldr	\rd, [\rd, #TI_TASK]
 	ldr	\rd, [\rd, #TSK_ACTIVE_MM]
 	.endm
-- 
1.7.9.5

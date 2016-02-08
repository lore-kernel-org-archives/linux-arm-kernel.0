From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:25:57 +0100
Subject: [PATCH 2/3] ARM: fix copypage-*.c building with clang
In-Reply-To: <1454941613-2775081-1-git-send-email-arnd@arndb.de>
References: <1454941613-2775081-1-git-send-email-arnd@arndb.de>
Message-ID: <1454941613-2775081-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang does not allow inline assembly in __naked functions to
have any register parameters and throws an error:

arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not allowed in naked functions
        : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));

Fortunately, all of these functions are trivial to convert to
using the registers directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/copypage-feroceon.c |  4 ++--
 arch/arm/mm/copypage-v4mc.c     | 26 +++++++++++++-------------
 arch/arm/mm/copypage-v4wb.c     |  4 ++--
 arch/arm/mm/copypage-v4wt.c     |  4 ++--
 arch/arm/mm/copypage-xsc3.c     |  4 ++--
 arch/arm/mm/copypage-xscale.c   |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 49ee0c1a7209..e69bf2f15f32 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -18,7 +18,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4-r9, lr}		\n\
-	mov	ip, %2				\n\
+	mov	ip, %0				\n\
 1:	mov	lr, r1				\n\
 	ldmia	r1!, {r2 - r9}			\n\
 	pld	[lr, #32]			\n\
@@ -64,7 +64,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
 	ldmfd	sp!, {r4-r9, pc}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
+	: "I" (PAGE_SIZE));
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 1267e64133b9..ea89722c00db 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -45,23 +45,23 @@ mc_copy_user_page(void *from, void *to)
 {
 	asm volatile(
 	"stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r4, %2				@ 1\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4+1\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	mov	r4, %0				@ 1\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
+1:	mcr	p15, 0, r1, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4+1\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
+	mcr	p15, 0, r1, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	r4, r4, #1			@ 1\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmneia	r0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 067d0fdd630c..7ea9cf07bd5c 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,7 +27,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
+	mov	r2, %0				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
@@ -44,7 +44,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
 	ldmfd	 sp!, {r4, pc}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index b85c5da2e510..c742ab24efd6 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,7 +25,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
+	mov	r2, %0				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -40,7 +40,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 03a2042aced5..17e4e11c4612 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -34,7 +34,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
+	mov	lr, %0				\n\
 						\n\
 	pld	[r1, #0]			\n\
 	pld	[r1, #32]			\n\
@@ -67,7 +67,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 						\n\
 	ldmfd	sp!, {r4, r5, pc}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	: "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 0fb85025344d..1034b4ce80cc 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -45,7 +45,7 @@ mc_copy_user_page(void *from, void *to)
 	 */
 	asm volatile(
 	"stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
+	mov	lr, %0				\n\
 	pld	[r0, #0]			\n\
 	pld	[r0, #32]			\n\
 	pld	[r1, #0]			\n\
@@ -81,7 +81,7 @@ mc_copy_user_page(void *from, void *to)
 	beq	2b				\n\
 	ldmfd	sp!, {r4, r5, pc}		"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
+	: "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
-- 
2.7.0

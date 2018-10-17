From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Oct 2018 11:04:17 +0200
Subject: [PATCH] [ALTERNATIVE] ARM: fix copypage functions for clang
In-Reply-To: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
References: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
Message-ID: <20181017090417.833924-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang points out that a naked function should not pass
the function arguments into the inline assembly:

arch/arm/mm/copypage-feroceon.c:67:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4mc.c:64:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4wt.c:43:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-xsc3.c:70:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-xscale.c:84:9: error: parameter references not allowed in naked functions

The constraints were originally added in commit 9a40ac86152c ("ARM:
6164/1: Add kto and kfrom to input operands list.") as a gcc-4.5
workaround. Another workaround for the same problem was added in commit
9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone and noinline
on __naked functions") and should have obsoleted the first one. That
workaroud was subsequently reverted in commit d124b44f09ca ("Compiler
Attributes: naked was fixed in gcc 4.6") as we raised the minimum compiler
level to gcc-4.6.

Remove the extraneous references and use the register numbers
consistently as required by clang.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've used this on my randconfig build setup, and it makes all
configurations build without warnings, but I have not done
any runtime testing on it.
---
 arch/arm/mm/copypage-feroceon.c |  4 ++--
 arch/arm/mm/copypage-v4mc.c     | 26 +++++++++++++-------------
 arch/arm/mm/copypage-v4wb.c     |  4 ++--
 arch/arm/mm/copypage-v4wt.c     |  4 ++--
 arch/arm/mm/copypage-xsc3.c     |  6 +++---
 arch/arm/mm/copypage-xscale.c   |  4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)

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
index 0224416cba3c..5c70e48ad833 100644
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
index 03a2042aced5..9944bdb4721d 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -34,8 +34,8 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-						\n\
+	mov	lr, %0				\n\
+					\n\
 	pld	[r1, #0]			\n\
 	pld	[r1, #32]			\n\
 1:	pld	[r1, #64]			\n\
@@ -67,7 +67,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 						\n\
 	ldmfd	sp!, {r4, r5, pc}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	: "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 97972379f4d6..ef52a052d9bb 100644
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
2.18.0

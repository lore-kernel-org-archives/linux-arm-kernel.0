From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Oct 2018 00:26:21 +0200
Subject: [PATCH 2/2] ARM: copypage: do not use naked functions
Message-ID: <20181015222621.14673-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC documentation says naked functions should only use basic ASM
syntax. The extended ASM or mixture of basic ASM and "C" code is
not guaranteed. Currently it seems to work though.

Furthermore with Clang using parameters in extended asm in a
naked function is not supported:
  arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
  allowed in naked functions
        : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
               ^

Use a regular function to be more portable. Also use volatile asm
to avoid unsolicited optimizations.

Tested with qemu versatileab machine and versatile_defconfig and
qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
and Clang 7.0.

Link: https://github.com/ClangBuiltLinux/linux/issues/90
Reported-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
 arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
 arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
 arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
 arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
 arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
 arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
 7 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index ec6501308c60..33ccd396bf99 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -17,11 +17,16 @@
 /*
  * Faraday optimised copy_user_page
  */
-static void __naked
-fa_copy_user_page(void *kto, const void *kfrom)
+static void fa_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
+	register void *r0 asm("r0") = kto;
+	register const void *r1 asm("r1") = kfrom;
+
+	asm(
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"\
+	stmfd	sp!, {r4}			@ 2\n\
 	mov	r2, %2				@ 1\n\
 1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
@@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
 	subs	r2, r2, #1			@ 1\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
+	ldmfd	sp!, {r4}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));
 }
 
 void fa_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 49ee0c1a7209..71c3b938493a 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -13,11 +13,16 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 
-static void __naked
-feroceon_copy_user_page(void *kto, const void *kfrom)
+static void feroceon_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4-r9, lr}		\n\
+	register void *r0 asm("r0") = kto;
+	register const void *r1 asm("r1") = kfrom;
+
+	asm volatile(
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"\
+	stmfd	sp!, {r4-r9}			\n\
 	mov	ip, %2				\n\
 1:	mov	lr, r1				\n\
 	ldmia	r1!, {r2 - r9}			\n\
@@ -62,9 +67,9 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 	add	r0, r0, #32			\n\
 	bne	1b				\n\
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
-	ldmfd	sp!, {r4-r9, pc}"
+	ldmfd	sp!, {r4-r9}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE));
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 0224416cba3c..85a81bc67912 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -40,11 +40,15 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
+	register void *r0 asm("r0") = from;
+	register void *r1 asm("r1") = to;
+
 	asm volatile(
-	"stmfd	sp!, {r4, lr}			@ 2\n\
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"stmfd	sp!, {r4}			@ 2\n\
 	mov	r4, %2				@ 1\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
@@ -59,9 +63,9 @@ mc_copy_user_page(void *from, void *to)
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
 	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
+	ldmfd	sp!, {r4}			@ 3"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 64));
 }
 
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 067d0fdd630c..dd518bf30a97 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -22,11 +22,16 @@
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-v4wb_copy_user_page(void *kto, const void *kfrom)
+static void v4wb_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
+	register void *r0 asm("r0") = kto;
+	register const void *r1 asm("r1") = kfrom;
+
+	asm volatile(
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"\
+	stmfd	sp!, {r4}			@ 2\n\
 	mov	r2, %2				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
@@ -42,9 +47,9 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	 sp!, {r4, pc}			@ 3"
+	ldmfd	 sp!, {r4}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 64));
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index b85c5da2e510..d397ac123300 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -20,11 +20,16 @@
  * dirty data in the cache.  However, we do have to ensure that
  * subsequent reads are up to date.
  */
-static void __naked
-v4wt_copy_user_page(void *kto, const void *kfrom)
+static void v4wt_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
+	register void *r0 asm("r0") = kto;
+	register const void *r1 asm("r1") = kfrom;
+
+	asm volatile(
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"\
+	stmfd	sp!, {r4}			@ 2\n\
 	mov	r2, %2				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
@@ -38,9 +43,9 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
+	ldmfd	sp!, {r4}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 64));
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 03a2042aced5..6a60465b52e1 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -29,11 +29,16 @@
  * if we eventually end up using our copied page.
  *
  */
-static void __naked
-xsc3_mc_copy_user_page(void *kto, const void *kfrom)
+static void xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, r5, lr}		\n\
+	register void *r0 asm("r0") = kto;
+	register const void *r1 asm("r1") = kfrom;
+
+	asm volatile(
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"\
+	stmfd	sp!, {r4, r5}			\n\
 	mov	lr, %2				\n\
 						\n\
 	pld	[r1, #0]			\n\
@@ -65,9 +70,9 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 	bgt	1b				\n\
 	beq	2b				\n\
 						\n\
-	ldmfd	sp!, {r4, r5, pc}"
+	ldmfd	sp!, {r4, r5}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 97972379f4d6..e508e99311a0 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -36,15 +36,18 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
  * and merged as appropriate.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
+	register void *r0 asm("r0") = from;
+	register void *r1 asm("r1") = to;
 	/*
 	 * Strangely enough, best performance is achieved
 	 * when prefetching destination as well.  (NP)
 	 */
 	asm volatile(
-	"stmfd	sp!, {r4, r5, lr}		\n\
+	__asmeq("%0", "r0")
+	__asmeq("%1", "r1")
+	"stmfd	sp!, {r4, r5}			\n\
 	mov	lr, %2				\n\
 	pld	[r0, #0]			\n\
 	pld	[r0, #32]			\n\
@@ -79,9 +82,9 @@ mc_copy_user_page(void *from, void *to)
 	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
 	bgt	1b				\n\
 	beq	2b				\n\
-	ldmfd	sp!, {r4, r5, pc}		"
+	ldmfd	sp!, {r4, r5}		"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
+	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
-- 
2.19.1

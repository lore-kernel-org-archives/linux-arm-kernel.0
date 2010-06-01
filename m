From: raj.khem@gmail.com (Khem Raj)
Date: Tue,  1 Jun 2010 01:06:40 -0700
Subject: [PATCH] Add kto and kfrom to input operands list.
Message-ID: <1275379600-23498-1-git-send-email-raj.khem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When functions incoming parameters are not in input operands list gcc 4.5 does not
load the parameters into registers before calling this function but the
inline assembly assumes valid addresses inside this function. This
breaks the code because r0 and r1 are invalid when execution enters
v4wb_copy_user_page ()

Also the constant needs to be used as third input operand so account for that
as well.

Tested on qemu arm.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 arch/arm/mm/copypage-feroceon.c |    4 ++--
 arch/arm/mm/copypage-v4wb.c     |    4 ++--
 arch/arm/mm/copypage-v4wt.c     |    4 ++--
 arch/arm/mm/copypage-xsc3.c     |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 5eb4fd9..ac163de 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -18,7 +18,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4-r9, lr}		\n\
-	mov	ip, %0				\n\
+	mov	ip, %2				\n\
 1:	mov	lr, r1				\n\
 	ldmia	r1!, {r2 - r9}			\n\
 	pld	[lr, #32]			\n\
@@ -64,7 +64,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
 	ldmfd	sp!, {r4-r9, pc}"
 	:
-	: "I" (PAGE_SIZE));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 7c2eb55..cb589cb 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,7 +27,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
+	mov	r2, %2				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
@@ -44,7 +44,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
 	ldmfd	 sp!, {r4, pc}			@ 3"
 	:
-	: "I" (PAGE_SIZE / 64));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 172e6a5..30c7d04 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,7 +25,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
+	mov	r2, %2				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -40,7 +40,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "I" (PAGE_SIZE / 64));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 747ad41..f9cde07 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -34,7 +34,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %0				\n\
+	mov	lr, %2				\n\
 						\n\
 	pld	[r1, #0]			\n\
 	pld	[r1, #32]			\n\
@@ -67,7 +67,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 						\n\
 	ldmfd	sp!, {r4, r5, pc}"
 	:
-	: "I" (PAGE_SIZE / 64 - 1));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
-- 
1.7.0.4

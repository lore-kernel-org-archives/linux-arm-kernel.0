From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Oct 2018 00:16:29 +0200
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands list
Message-ID: <20181015221629.13924-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When functions incoming parameters are not in input operands list gcc
4.5 does not load the parameters into registers before calling this
function but the inline assembly assumes valid addresses inside this
function. This breaks the code because r0 and r1 are invalid when
execution enters v4wb_copy_user_page ()

Also the constant needs to be used as third input operand so account
for that as well.

This fixes copypage-fa.c what has previously done before for the other
copypage implementations in commit 9a40ac86152c ("ARM: 6164/1: Add kto
and kfrom to input operands list.").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mm/copypage-fa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index d130a5ece5d5..ec6501308c60 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -22,7 +22,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
+	mov	r2, %2				@ 1\n\
 1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
 	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
@@ -36,7 +36,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "I" (PAGE_SIZE / 32));
+	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
 }
 
 void fa_copy_user_highpage(struct page *to, struct page *from,
-- 
2.19.1

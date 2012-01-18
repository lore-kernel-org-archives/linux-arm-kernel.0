From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Wed, 18 Jan 2012 17:52:25 +0800
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
Message-ID: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

If we are only about to clear a hardware pte entry, then pte makeup code is
unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/mm/proc-macros.S    |   10 +++++-----
 arch/arm/mm/proc-v7-2level.S |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..11288b3 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -138,6 +138,10 @@
 	.macro	armv6_set_pte_ext pfx
 	str	r1, [r0], #2048			@ linux version
 
+	tst	r1, #L_PTE_YOUNG
+	tstne	r1, #L_PTE_PRESENT
+	moveq	r3, #0
+	moveq	set_pte
 	bic	r3, r1, #0x000003fc
 	bic	r3, r3, #PTE_TYPE_MASK
 	orr	r3, r3, r2
@@ -163,11 +167,7 @@
 	orrne	r3, r3, #PTE_EXT_XN
 
 	orr	r3, r3, r2
-
-	tst	r1, #L_PTE_YOUNG
-	tstne	r1, #L_PTE_PRESENT
-	moveq	r3, #0
-
+set_pte:
 	str	r3, [r0]
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
 	.endm
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 3a4b3e7..3e17ec2 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -76,6 +76,10 @@ ENTRY(cpu_v7_set_pte_ext)
 #ifdef CONFIG_MMU
 	str	r1, [r0]			@ linux version
 
+	tst	r1, #L_PTE_YOUNG
+	tstne	r1, #L_PTE_PRESENT
+	moveq	r3, #0
+	beq		set_pte
 	bic	r3, r1, #0x000003f0
 	bic	r3, r3, #PTE_TYPE_MASK
 	orr	r3, r3, r2
@@ -98,11 +102,7 @@ ENTRY(cpu_v7_set_pte_ext)
 
 	tst	r1, #L_PTE_XN
 	orrne	r3, r3, #PTE_EXT_XN
-
-	tst	r1, #L_PTE_YOUNG
-	tstne	r1, #L_PTE_PRESENT
-	moveq	r3, #0
-
+set_pte:
  ARM(	str	r3, [r0, #2048]! )
  THUMB(	add	r0, r0, #2048 )
  THUMB(	str	r3, [r0] )
-- 
1.7.1

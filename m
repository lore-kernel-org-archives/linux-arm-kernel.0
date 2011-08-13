From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 13 Aug 2011 15:58:19 +0300
Subject: [PATCH] Fix non-LPAE boot regression.
In-Reply-To: <201108131556.27301.anarsoul@gmail.com>
References: <201108131556.27301.anarsoul@gmail.com>
Message-ID: <1313240299-24712-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was introduced by  407f8b4cb07cbc5c1c7cc386f231224e2524ccea
ARM: LPAE: MMU setup for the 3-level page table format

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/kernel/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 0bdafc4..5add5f5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -206,7 +206,7 @@ __create_page_tables:
 1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
 	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
 	cmp	r5, r6
-	addlo	r5, r5, #SECTION_SHIFT >> 20	@ next section
+	addlo	r5, r5, #1			@ next section
 	blo	1b
 
 	/*
@@ -217,7 +217,7 @@ __create_page_tables:
 	mov	r3, r3, lsr #SECTION_SHIFT
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
 	add	r0, r4,  #(KERNEL_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #(KERNEL_START & 0x00e00000) >> (SECTION_SHIFT - PMD_ORDER)]!
+	str	r3, [r0, #(KERNEL_START & 0x00f00000) >> (SECTION_SHIFT - PMD_ORDER)]!
 	ldr	r6, =(KERNEL_END - 1)
 	add	r0, r0, #1 << PMD_ORDER
 	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-- 
1.7.5.rc3

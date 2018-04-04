From: l.stelmach@samsung.com (=?UTF-8?q?=C5=81ukasz=20Stelmach?=)
Date: Wed, 04 Apr 2018 09:46:58 +0200
Subject: [PATCH] ARM: decompressor: restore r1 and r2 just before jumping to
 the kernel
References: <CGME20180404074700eucas1p12cdb8b0de3da46c433e505555129c7e6@eucas1p1.samsung.com>
Message-ID: <20180404074658.28288-1-l.stelmach@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hypervisor setup before __enter_kernel destroys the value sotred in
r1. The value needs to be restored just before the jump.

Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 182bf6add0b9..517e0e18f0b8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -561,8 +561,6 @@ not_relocated:	mov	r0, #0
 		bl	decompress_kernel
 		bl	cache_clean_flush
 		bl	cache_off
-		mov	r1, r7			@ restore architecture number
-		mov	r2, r8			@ restore atags pointer
 
 #ifdef CONFIG_ARM_VIRT_EXT
 		mrs	r0, spsr		@ Get saved CPU boot mode
@@ -1365,6 +1363,8 @@ __hyp_reentry_vectors:
 
 __enter_kernel:
 		mov	r0, #0			@ must be 0
+		mov	r1, r7			@ restore architecture number
+		mov	r2, r8			@ restore atags pointer
  ARM(		mov	pc, r4		)	@ call kernel
  M_CLASS(	add	r4, r4, #1	)	@ enter in Thumb mode for M class
  THUMB(		bx	r4		)	@ entry point is always ARM for A/R classes
-- 
2.11.0

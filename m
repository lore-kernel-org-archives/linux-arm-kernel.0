From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 17:59:46 +0100
Subject: [PATCH] ARM: Avoid undefined Thumb-2 instructions using PC in
	compressed/head.S
Message-ID: <20100929165946.12566.7971.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADD and AND instructions using PC as one of the registers is not
supported by the Thumb-2 instruction set. This patch adds the THUMB()
variants in the compressed/head.S file.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/boot/compressed/head.S |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6825c34..a00055d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -174,7 +174,9 @@ not_angel:
 		ldr	sp, [r0, #28]
 #ifdef CONFIG_AUTO_ZRELADDR
 		@ determine final kernel image address
-		and	r4, pc, #0xf8000000
+ ARM(		and	r4, pc, #0xf8000000	)
+ THUMB(		mov	r4, pc			)
+ THUMB(		and	r4, r4, #0xf8000000	)
 		add	r4, r4, #TEXT_OFFSET
 #else
 		ldr	r4, =zreladdr
@@ -445,7 +447,9 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
  */
 		mov	r1, #0x1e
 		orr	r1, r1, #3 << 10
-		mov	r2, pc, lsr #20
+ ARM(		mov	r2, pc, lsr #20		)
+ THUMB(		mov	r2, pc			)
+ THUMB(		lsr	r2, r2, #20		)
 		orr	r1, r1, r2, lsl #20
 		add	r0, r3, r2, lsl #2
 		str	r1, [r0], #4

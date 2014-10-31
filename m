From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 31 Oct 2014 16:02:46 +0100
Subject: [RFT] ARM: shmobile: rcar-gen2: Fix build breakage
Message-ID: <1414767766-19967-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build breakage when building allmodconfig or allyesconfig introduced
by adding ISB instruction to rcar_gen2_timer_init() function
(9ce3fa6816c2 "ARM: shmobile: rcar-gen2: Add CA7 arch_timer
initialization for r8a7794"):

  CC      arch/arm/mach-shmobile/setup-rcar-gen2.o
/tmp/cc770qt0.s: Assembler messages:
/tmp/cc770qt0.s:378: Error: selected processor does not support ARM mode `isb'
/tmp/cc770qt0.s:381: Error: selected processor does not support ARM mode `isb'
/tmp/cc770qt0.s:383: Error: selected processor does not support ARM mode `isb'
make[1]: *** [arch/arm/mach-shmobile/setup-rcar-gen2.o] Error 1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3dd6edd9bd1d..47f85643785f 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -68,6 +68,7 @@ void __init rcar_gen2_timer_init(void)
 		 * secure code.
 		 */
 		asm volatile(
+		"	.arch	armv7-a\n"
 		"	cps	0x16\n"
 		"	mrc	p15, 0, r1, c1, c1, 0\n"
 		"	orr	r0, r1, #1\n"
-- 
1.9.1

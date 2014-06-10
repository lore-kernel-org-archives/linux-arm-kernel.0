From: wangweidong1@huawei.com (Wang Weidong)
Date: Tue, 10 Jun 2014 15:00:01 +0800
Subject: [PATCH] ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in,
 proc-macros.S
Message-ID: <5396ACF1.1020107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STR Instruction Encoding T4 points that the <imm> is in the
range 0-255.So split the instruction into two for Thumb-2. Just
like commit 874d5d3ccc("ARM: 6623/1: Thumb-2: Fix out-of-range
offset for Thumb-2 in proc-v7.S").

Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
---
 arch/arm/mm/proc-macros.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index ee1d805..63f710c 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -252,7 +252,9 @@
 	tst	r3, #L_PTE_PRESENT | L_PTE_YOUNG	@ present and young?
 	movne	r2, #0				@ no -> fault
 
-	str	r2, [r0, #2048]!		@ hardware version
+ ARM(	str	r2, [r0, #2048]! 		) @ hardware version
+ THUMB( add	r0, r0, #2048 			)
+ THUMB( str	r2, [r0] 			)
 	mov	ip, #0
 	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
 	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
-- 
1.7.12

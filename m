From: robherring2@gmail.com (Rob Herring)
Date: Tue, 25 Feb 2014 12:16:33 -0600
Subject: [PATCH] ARM: move __fixup_smp out of init section
Message-ID: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

With large kernel builds such as allyesconfig exceeding maximum relative
branch offsets, the init section will be too far away to branch to
directly. This causes veneers to be added by the compiler, but veneers
don't work before the MMU is enabled. Fix this by moving __fixup_smp to
the .head.text section as it is not very big.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 914616e..78e1443 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -475,7 +475,7 @@ ENDPROC(__turn_mmu_on)
 
 
 #ifdef CONFIG_SMP_ON_UP
-	__INIT
+	__HEAD
 __fixup_smp:
 	and	r3, r9, #0x000f0000	@ architecture version
 	teq	r3, #0x000f0000		@ CPU ID supported?
-- 
1.8.3.2

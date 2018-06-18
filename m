From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Jun 2018 10:48:32 +0100
Subject: [PATCH] ARM: NOMMU: Use instr_sync instead of plain isb in common code
Message-ID: <1529315312-35517-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg reported that commit 3c24121039c9d ("ARM: 8756/1: NOMMU: Postpone
MPU activation till __after_proc_init") is causing breakage for the
old Versatile platform in no-MMU mode (with out-of-tree patches):

  AS      arch/arm/kernel/head-nommu.o
arch/arm/kernel/head-nommu.S: Assembler messages:
arch/arm/kernel/head-nommu.S:180: Error: selected processor does not support `isb' in ARM mode
scripts/Makefile.build:417: recipe for target 'arch/arm/kernel/head-nommu.o' failed
make[2]: *** [arch/arm/kernel/head-nommu.o] Error 1
Makefile:1034: recipe for target 'arch/arm/kernel' failed
make[1]: *** [arch/arm/kernel] Error 2

Since the code is common for all NOMMU builds usage of the isb was a
bad idea (please, note that isb also used in MPU related code which is
fine because MPU has dependency on CPU_V7/CPU_V7M), instead use more
robust instr_sync assembler macro.

Fixes: 3c24121039c9 ("ARM: 8756/1: NOMMU: Postpone MPU activation till __after_proc_init")
Reported-by: Greg Ungerer <gerg@kernel.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index dd546d6..7a9b869 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -177,7 +177,7 @@ M_CLASS(streq	r3, [r12, #PMSAv8_MAIR1])
 	bic	r0, r0, #CR_I
 #endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
-	isb
+	instr_sync
 #elif defined (CONFIG_CPU_V7M)
 #ifdef CONFIG_ARM_MPU
 	ldreq	r3, [r12, MPU_CTRL]
-- 
1.9.1

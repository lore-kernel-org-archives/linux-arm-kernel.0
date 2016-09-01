From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu,  1 Sep 2016 14:35:59 +0100
Subject: [PATCH] arm64: kernel: do not need to reset UAO on exception entry
Message-ID: <1472736959-25686-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e19a6ee2460b ("arm64: kernel: Save and restore UAO and
addr_limit on exception entry") states that exception handler inherits
the original PSTATE.UAO value, so UAO needes to be reset
explicitly. However, ARM 8.2 Extension documentation says:

PSTATE.UAO is copied to SPSR_ELx.UAO and is then set to 0 on an
exception taken from AArch64 to AArch64

so hardware already does the right thing.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 441420c..7c9bb43 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -104,7 +104,7 @@
 	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
 	mov	x20, #TASK_SIZE_64
 	str	x20, [tsk, #TI_ADDR_LIMIT]
-	ALTERNATIVE(nop, SET_PSTATE_UAO(0), ARM64_HAS_UAO, CONFIG_ARM64_UAO)
+	/* No need to reset PSTATE.UAO, hardware's already set it to 0 for us */
 	.endif /* \el == 0 */
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
-- 
1.7.9.5

From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 30 Mar 2017 09:09:51 +0100
Subject: [PATCH] ARM: V7M: Preserve registers across switch from Thread to
 Handler mode
In-Reply-To: <1490861391-35484-1-git-send-email-vladimir.murzin@arm.com>
References: <1490861391-35484-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1490861391-35484-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ARMv7 ARM, when exception is taken content of r0-r3, r12
is unknown (see ExceptionTaken() pseudocode). Even though existent
implementations keep these register unchanged, preserve them to be in
line with architecture.

Reported-by: Dobromir Stefanov <dobromir.stefanov@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/proc-v7m.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 5049777..47a5acc 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -135,9 +135,11 @@ __v7m_setup_cont:
 	dsb
 	mov	r6, lr			@ save LR
 	ldr	sp, =init_thread_union + THREAD_START_SP
+	stmia	sp, {r0-r3, r12}
 	cpsie	i
 	svc	#0
 1:	cpsid	i
+	ldmia	sp, {r0-r3, r12}
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
 
-- 
1.9.1

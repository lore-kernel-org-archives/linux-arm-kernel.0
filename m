From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Aug 2010 14:03:28 -0700
Subject: [PATCH 5/6] ARM: Don't set TLB ops broadcasting on UP ARMv7
Message-ID: <mailman.224.1283444542.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't set TLB ops broadcasting on UP ARMv7. Looks like these bits
are also different on A8 and A9.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/proc-v7.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 07fc660..51a063d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -191,7 +191,8 @@ __v7_setup:
 	UP(mov	r0, #(1 << 6))			@ fake it for UP
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
-	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
+	SMP(mcreq	p15, 0, r0, c1, c0, 1)	@ TLB ops broadcasting
+	UP(nop)					@ Don't enable on UP 
 #endif
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
-- 
1.7.1

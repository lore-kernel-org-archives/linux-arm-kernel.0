From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:26:01 +0100
Subject: [PATCH] ARMv7: Check whether the SMP/nAMP mode was already enabled
Message-ID: <20091015122601.1025.67524.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tony Thompson <Anthony.Thompson@arm.com>

If running in non-secure mode, enabling this register will fault.

Signed-off-by: Tony Thompson <Anthony.Thompson@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/proc-v7.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 23ebcf6..119a322 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -184,9 +184,10 @@ cpu_v7_name:
  */
 __v7_setup:
 #ifdef CONFIG_SMP
-	mrc	p15, 0, r0, c1, c0, 1		@ Enable SMP/nAMP mode and
-	orr	r0, r0, #(1 << 6) | (1 << 0)	@ TLB ops broadcasting
-	mcr	p15, 0, r0, c1, c0, 1
+	mrc	p15, 0, r0, c1, c0, 1
+	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
+	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
+	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
 #endif
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}

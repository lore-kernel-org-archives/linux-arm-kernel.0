From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu, 16 Jul 2015 10:37:13 -0400
Subject: [PATCH 1/2] ARM: xip: Can't use text area as stack
In-Reply-To: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
References: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <1437057434-1616-2-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For an XIP_KERNEL build, ROM and RAM are separated, so we can't reserve
code space to serve as a temporary stack.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/mm/proc-v7.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0716bbe..8559449 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -412,7 +412,11 @@ __v7_pj4b_setup:
 #endif /* CONFIG_CPU_PJ4B */
 
 __v7_setup:
+#ifndef CONFIG_XIP_KERNEL
 	adr	r12, __v7_setup_stack		@ the local stack
+#else
+	ldr	r12, =PLAT_PHYS_OFFSET		@ the local stack
+#endif
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
 	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
-- 
1.7.9.5

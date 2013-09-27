From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Sep 2013 08:37:59 +0200
Subject: [PATCH v2] ARM: at91: sam9g45: shutdown ddr1 too when rebooting
Message-ID: <1380263879-16325-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as on ddr0 we need to cleanly shutdown ddr1 if used before rebooting

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
v2:

	use ldr     r5, [r5, #4]

Best Regards,
J.
 arch/arm/mach-at91/at91sam9g45_reset.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
index 721a1a3..c40c1e2 100644
--- a/arch/arm/mach-at91/at91sam9g45_reset.S
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -16,11 +16,17 @@
 #include "at91_rstc.h"
 			.arm
 
+/*
+ * at91_ramc_base is an array void*
+ * init at NULL if only one DDR controler is present in or DT
+ */
 			.globl	at91sam9g45_restart
 
 at91sam9g45_restart:
 			ldr	r5, =at91_ramc_base		@ preload constants
 			ldr	r0, [r5]
+			ldr	r5, [r5, #4]			@ ddr1
+			cmp	r5, #0
 			ldr	r4, =at91_rstc_base
 			ldr	r1, [r4]
 
@@ -30,6 +36,8 @@ at91sam9g45_restart:
 
 			.balign	32				@ align to cache line
 
+			strne	r2, [r5, #AT91_DDRSDRC_RTR]	@ disable DDR1 access
+			strne	r3, [r5, #AT91_DDRSDRC_LPR]	@ power down DDR1
 			str	r2, [r0, #AT91_DDRSDRC_RTR]	@ disable DDR0 access
 			str	r3, [r0, #AT91_DDRSDRC_LPR]	@ power down DDR0
 			str	r4, [r1, #AT91_RSTC_CR]		@ reset processor
-- 
1.8.4.rc3

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Aug 2013 13:00:44 +0200
Subject: [PATCH 1/1] ARM: at91: sam9g45: shutdown ddr1 too when rebooting
Message-ID: <1377169244-20462-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as on ddr0 we need to cleanly shutdown ddr1 if used before rebootinh

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45_reset.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
index 721a1a3..3fd634d 100644
--- a/arch/arm/mach-at91/at91sam9g45_reset.S
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -21,6 +21,8 @@
 at91sam9g45_restart:
 			ldr	r5, =at91_ramc_base		@ preload constants
 			ldr	r0, [r5]
+			add	r5, #4				@ ddr1
+			ldr	r5, [r5]
 			ldr	r4, =at91_rstc_base
 			ldr	r1, [r4]
 
@@ -30,6 +32,8 @@ at91sam9g45_restart:
 
 			.balign	32				@ align to cache line
 
+			str	r2, [r5, #AT91_DDRSDRC_RTR]	@ disable DDR1 access
+			str	r3, [r5, #AT91_DDRSDRC_LPR]	@ power down DDR1
 			str	r2, [r0, #AT91_DDRSDRC_RTR]	@ disable DDR0 access
 			str	r3, [r0, #AT91_DDRSDRC_LPR]	@ power down DDR0
 			str	r4, [r1, #AT91_RSTC_CR]		@ reset processor
-- 
1.8.4.rc1

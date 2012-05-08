From: govindraj.raja@ti.com (Govindraj.R)
Date: Tue, 8 May 2012 14:34:17 +0530
Subject: [PATCH v4 2/2] ARM: omap3: pm: Remove uart module level wakeup
 configurations
In-Reply-To: <1336467857-12521-1-git-send-email-govindraj.raja@ti.com>
References: <1336467857-12521-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <1336467857-12521-3-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Govindraj.R" <govindraj.raja@ti.com>

The uart module level wakeups enabling and disabling
are now handled from uart driver itself remove the uart module
level configurations from pm code.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 703bd10..7a19498 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -529,8 +529,6 @@ static void __init omap3_d2d_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
-	u32 omap3630_en_uart4_mask = cpu_is_omap3630() ?
-					OMAP3630_EN_UART4_MASK : 0;
 	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
 					OMAP3630_GRPSEL_UART4_MASK : 0;
 
@@ -562,13 +560,11 @@ static void __init prcm_setup_regs(void)
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
-	omap2_prm_write_mod_reg(omap3630_en_uart4_mask |
-			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
-			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
-			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
-			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
-			  OMAP3430_EN_MCBSP4_MASK,
-			  OMAP3430_PER_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK |
+			OMAP3430_EN_GPIO3_MASK | OMAP3430_EN_GPIO4_MASK |
+			OMAP3430_EN_GPIO5_MASK | OMAP3430_EN_GPIO6_MASK |
+			OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
+			OMAP3430_EN_MCBSP4_MASK, OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
 	omap2_prm_write_mod_reg(omap3630_grpsel_uart4_mask |
 			  OMAP3430_GRPSEL_GPIO2_MASK |
-- 
1.7.9

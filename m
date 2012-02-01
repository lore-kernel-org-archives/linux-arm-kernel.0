From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  1 Feb 2012 09:49:46 +0100
Subject: [PATCH 07/20] ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST
 only on a need
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328086199-28486-8-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ERRCONFIG register's VPBOUNDINTST has an additional functional meaning
It force clears Sr_interruptz internal signal. This can result in
scenarios where VP-> SR protocol is violated where voltage processor's
As interruptz is already high, VP will never clear the signal vpirqclr.
Therefore during the next force update to reset to nominal voltage,
VP can?t pulsed vpirqclr => PRCM HW can?t generate the tranxdone IRQ
and the situation is not recoverable untill a cold reset is invoked.

To prevent this situation, check if status is set before clearing the
status as this needs to be done only on a need basis.

Reported-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ba6ad09..6dea30d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,6 +289,8 @@ error:
 static void sr_v1_disable(struct omap_sr *sr)
 {
 	int timeout = 0;
+	int errconf_val = ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
+			ERRCONFIG_MCUBOUNDINTST;
 
 	/* Enable MCUDisableAcknowledge interrupt */
 	sr_modify_reg(sr, ERRCONFIG_V1,
@@ -297,13 +299,13 @@ static void sr_v1_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
 
-	/* Disable all other SR interrupts and clear the status */
+	/* Disable all other SR interrupts and clear the status as needed */
+	if (sr_read_reg(sr, ERRCONFIG_V1) & ERRCONFIG_VPBOUNDINTST_V1)
+		errconf_val |= ERRCONFIG_VPBOUNDINTST_V1;
 	sr_modify_reg(sr, ERRCONFIG_V1,
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
 			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
-			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
-			ERRCONFIG_MCUBOUNDINTST |
-			ERRCONFIG_VPBOUNDINTST_V1));
+			errconf_val);
 
 	/*
 	 * Wait for SR to be disabled.
@@ -332,9 +334,17 @@ static void sr_v2_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
 
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+	/*
+	 * Disable all other SR interrupts and clear the status
+	 * write to status register ONLY on need basis - only if status
+	 * is set.
+	 */
+	if (sr_read_reg(sr, ERRCONFIG_V2) & ERRCONFIG_VPBOUNDINTST_V2)
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
 			ERRCONFIG_VPBOUNDINTST_V2);
+	else
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+				0x0);
 	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
 			IRQENABLE_MCUVALIDINT |
 			IRQENABLE_MCUBOUNDSINT));
-- 
1.7.5.4

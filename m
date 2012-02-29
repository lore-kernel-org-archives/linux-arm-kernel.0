From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:41 +0100
Subject: [PATCH 05/13] ARM: OMAP3+: SmartReflex: Fix status masking in
 ERRCONFIG register
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Message-ID: <1330554829-11347-6-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

ERRCONFIG register has status bits that were intended not to
be destroyed by bad modification. We cleanup and simplify the
handling the status in the modify path.

Reported-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9c39484..1c385b0 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -74,10 +74,6 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 					u32 value)
 {
 	u32 reg_val;
-	u32 errconfig_offs = 0, errconfig_mask = 0;
-
-	reg_val = __raw_readl(sr->base + offset);
-	reg_val &= ~mask;
 
 	/*
 	 * Smartreflex error config register is special as it contains
@@ -88,16 +84,15 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 	 * if they are currently set, but does allow the caller to write
 	 * those bits.
 	 */
-	if (sr->ip_type == SR_TYPE_V1) {
-		errconfig_offs = ERRCONFIG_V1;
-		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
-	} else if (sr->ip_type == SR_TYPE_V2) {
-		errconfig_offs = ERRCONFIG_V2;
-		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
-	}
+	if (sr->ip_type == SR_TYPE_V1 && offset == ERRCONFIG_V1)
+		mask |= ERRCONFIG_STATUS_V1_MASK;
+	else if (sr->ip_type == SR_TYPE_V2 && offset == ERRCONFIG_V2)
+		mask |= ERRCONFIG_VPBOUNDINTST_V2;
+
+	reg_val = __raw_readl(sr->base + offset);
+	reg_val &= ~mask;
 
-	if (offset == errconfig_offs)
-		reg_val &= ~errconfig_mask;
+	value &= mask;
 
 	reg_val |= value;
 
-- 
1.7.5.4

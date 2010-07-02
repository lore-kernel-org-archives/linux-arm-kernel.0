From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:18 -0600
Subject: [PATCH 05/20] OMAP24xx: CM: fix mask used for checking IDLEST status
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152917.6221.89090.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

On OMAP24xx, the polarity for the IDLEST bits is opposite of OMAP3.
The mask used to check this was using the bit position instead of the
bit mask.

This patch fixes the problem by using the bit mask instead of the bit
field.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 2d83565..721c3b6 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -50,15 +50,15 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 
 	cm_idlest_reg = cm_idlest_offs[idlest_id - 1];
 
+	mask = 1 << idlest_shift;
+
 	if (cpu_is_omap24xx())
-		ena = idlest_shift;
+		ena = mask;
 	else if (cpu_is_omap34xx())
 		ena = 0;
 	else
 		BUG();
 
-	mask = 1 << idlest_shift;
-
 	/* XXX should be OMAP2 CM */
 	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
 			  MAX_MODULE_READY_TIME, i);

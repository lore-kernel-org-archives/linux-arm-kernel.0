From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:11:38 +0300
Subject: [PATCH 08/11] ARM: OMAP3: Remove callback for McBSP sidetone ICLK
 workaround
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can achieve the same result with SIDLEMODE field within McBSP SYSCONFIG
register.
The ASoC driver has been modified to use this method and we can now remove
the workaround using the control module register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   26 --------------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 2 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index d57a357..996a15f 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -26,31 +26,6 @@
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
 
-/*
- * FIXME: Find a mechanism to enable/disable runtime the McBSP ICLK autoidle.
- * Sidetone needs non-gated ICLK and sidetone autoidle is broken.
- */
-#include "cm2xxx_3xxx.h"
-#include "cm-regbits-34xx.h"
-
-static int omap3_enable_st_clock(unsigned int id, bool enable)
-{
-	unsigned int w;
-
-	/*
-	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
-	 * are enabled or sidetones start sounding ugly.
-	 */
-	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
-	if (enable)
-		w &= ~(1 << (id - 2));
-	else
-		w |= 1 << (id - 2);
-	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
-
-	return 0;
-}
-
 static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
@@ -98,7 +73,6 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	if (oh->dev_attr) {
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
-		pdata->enable_st_clock = omap3_enable_st_clock;
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index c78d90b..698ccd8 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -46,7 +46,6 @@ struct omap_mcbsp_platform_data {
 	/* McBSP platform and instance specific features */
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
-	int (*enable_st_clock)(unsigned int, bool);
 };
 
 /**
-- 
1.7.8.6

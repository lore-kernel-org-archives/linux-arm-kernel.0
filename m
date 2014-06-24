From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 00:24:25 -0500
Subject: [PATCH 1/3] staging: tidspbridge: fix an erroneous removal of
 parentheses
In-Reply-To: <1403587467-59876-1-git-send-email-s-anna@ti.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Message-ID: <1403587467-59876-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4a9fdbb (staging: core: tiomap3430.c Fix line over 80 characters.)
erroneously removed the parentheses around the function pointer leading
to the following build error (when enabling the build of TI DSP/Bridge
driver):

drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_monitor':
drivers/staging/tidspbridge/core/tiomap3430.c:283:10: error: invalid type argument of unary '*' (have 'u32')
make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1

Fix this build error properly.

Fixes: 4a9fdbb (staging: core: tiomap3430.c Fix line over 80 characters.)
Cc: Aybuke Ozdemir <aybuke.147@gmail.com>
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
Cc: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 8945b4e..cb50120 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -280,8 +280,10 @@ static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt)
 					OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
 
 		/* Wait until the state has moved to ON */
-		while (*pdata->dsp_prm_read(OMAP3430_IVA2_MOD, OMAP2_PM_PWSTST)&
-					OMAP_INTRANSITION_MASK);
+		while ((*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD,
+					      OMAP2_PM_PWSTST) &
+						OMAP_INTRANSITION_MASK)
+			;
 		/* Disable Automatic transition */
 		(*pdata->dsp_cm_write)(OMAP34XX_CLKSTCTRL_DISABLE_AUTO,
 					OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
-- 
2.0.0

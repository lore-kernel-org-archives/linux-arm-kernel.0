From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 15 Dec 2011 11:34:57 +0200
Subject: [PATCH] plat-omap: mcbsp: Configure wakeup in later phase
Message-ID: <1323941697-7902-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the WAKEUPEN register at the same time we configure the rest of
the McBSP registers.
In case of OMAP3+, if the sysclock has been reconfigured we are going to
disable McBSP for the duration of the clock change, which will reset the
McBSP registers. The WAKEUPEN register need to be configured later, so
the changes will be effective during runtime.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4b15cd7..f2eb1bb 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -185,6 +185,9 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 		MCBSP_WRITE(mcbsp, XCCR, config->xccr);
 		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
+	/* Enable wakeup behavior */
+	if (mcbsp->pdata->has_wakeup)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
@@ -685,10 +688,6 @@ int omap_mcbsp_request(unsigned int id)
 
 	pm_runtime_get_sync(mcbsp->dev);
 
-	/* Enable wakeup behavior */
-	if (mcbsp->pdata->has_wakeup)
-		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
-- 
1.7.8

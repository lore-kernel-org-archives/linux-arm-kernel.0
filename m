From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Mar 2016 12:28:49 +0200
Subject: [PATCH 3/3] ASoC: omap-mcbsp: Enable/disable sidetone block auto
 clock gating for omap3
In-Reply-To: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP3's McBSP2 and McBSP3 module have integrated sidetone block with
dedicated SYSCONFIG register. The sidetone is operating from the maain
McBSP module's ICLK. For normal operation the sidetone clock auto idle
support needs to be disabled when it is activated.
Note: This is not enough to avoid choppy sidetone because this AUTOIDLE
bit is controlling only the clock auto idle from the McBSP to the sidetone
block. If the McBSP_ICLK is idling, the sidetone clock is going to do the
same.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index c7563e230c7d..4a16e778966b 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -260,6 +260,10 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata->enable_st_clock)
 		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
 
+	/* Disable Sidetone clock auto-gating for normal operation */
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
 	/* Enable McBSP Sidetone */
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
@@ -279,6 +283,10 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
 
+	/* Enable Sidetone clock auto-gating to reduce power consumption */
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
+
 	if (mcbsp->pdata->enable_st_clock)
 		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
 }
-- 
2.7.3

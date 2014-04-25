From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:39 +0100
Subject: [PATCH 155/222] imx-drm: ipuv3-crtc: change display enable/disable
 order
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYZ-0007Nc-7f@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Now that ipu_dc_disable_channel correctly waits for the channel to finish,
we can reorder the enable/disable order to first stop the DC and DI and
only then disable the IDMAC. Enabling is done the other way around: IDMAC
first, then DC, then DI.

This avoids an issue where sometimes the channel would not correctly start,
leading to non-working LVDS displays.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipuv3-crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index f2c9cd040043..ab667a191a36 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -63,9 +63,11 @@ static void ipu_fb_enable(struct ipu_crtc *ipu_crtc)
 	if (ipu_crtc->enabled)
 		return;
 
-	ipu_di_enable(ipu_crtc->di);
-	ipu_dc_enable_channel(ipu_crtc->dc);
+	/* TODO: Enable DC module here, right now it is never disabled */
 	ipu_plane_enable(ipu_crtc->plane[0]);
+	/* Start DC channel and DI after IDMAC */
+	ipu_dc_enable_channel(ipu_crtc->dc);
+	ipu_di_enable(ipu_crtc->di);
 
 	ipu_crtc->enabled = 1;
 }
@@ -75,9 +77,11 @@ static void ipu_fb_disable(struct ipu_crtc *ipu_crtc)
 	if (!ipu_crtc->enabled)
 		return;
 
-	ipu_plane_disable(ipu_crtc->plane[0]);
+	/* Stop DC channel and DI before IDMAC */
 	ipu_dc_disable_channel(ipu_crtc->dc);
 	ipu_di_disable(ipu_crtc->di);
+	ipu_plane_disable(ipu_crtc->plane[0]);
+	/* TODO: Disable DC module here */
 
 	ipu_crtc->enabled = 0;
 }
-- 
1.8.3.1

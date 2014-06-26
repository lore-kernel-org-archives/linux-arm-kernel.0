From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 11:08:51 +0100
Subject: [PATCH] drm/i2c: tda998x: add some basic mode validation
Message-ID: <E1X06br-0002iA-8H@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TDA998x can't handle modes with clocks above 150MHz, or resolutions
larger than 8192x2048.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
David, this will be part of a pull request which I intend to send during
the next few days.  Luckily, the mode_valid method in tda998x hasn't was
not deleted.

 drivers/gpu/drm/i2c/tda998x_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 3ff7d0713bfb..5a738ad0c241 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -810,6 +810,12 @@ static int
 tda998x_encoder_mode_valid(struct drm_encoder *encoder,
 			  struct drm_display_mode *mode)
 {
+	if (mode->clock > 150000)
+		return MODE_CLOCK_HIGH;
+	if (mode->htotal >= BIT(13))
+		return MODE_BAD_HVALUE;
+	if (mode->vtotal >= BIT(11))
+		return MODE_BAD_VVALUE;
 	return MODE_OK;
 }
 
-- 
1.8.3.1

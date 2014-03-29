From: kernel@esmil.dk (Emil Renner Berthing)
Date: Sat, 29 Mar 2014 13:58:11 +0100
Subject: [PATCH] staging: imx-drm: imx-hdmi: clean up hdmi_phy_wait_i2c_done
Message-ID: <1396097891-12209-1-git-send-email-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify hdmi_phy_wait_i2c_done so the call to hdmi_readb is
only done in one place. This also fixes a checkpatch warning.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/staging/imx-drm/imx-hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index da71d8d..cc8d232 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -660,13 +660,10 @@ static inline void hdmi_phy_test_dout(struct imx_hdmi *hdmi,
 
 static bool hdmi_phy_wait_i2c_done(struct imx_hdmi *hdmi, int msec)
 {
-	unsigned char val = 0;
-	val = hdmi_readb(hdmi, HDMI_IH_I2CMPHY_STAT0) & 0x3;
-	while (!val) {
+	while ((hdmi_readb(hdmi, HDMI_IH_I2CMPHY_STAT0) & 0x3) == 0) {
 		udelay(1000);
 		if (msec-- == 0)
 			return false;
-		val = hdmi_readb(hdmi, HDMI_IH_I2CMPHY_STAT0) & 0x3;
 	}
 	return true;
 }
-- 
1.9.1

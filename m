From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:36 +0000
Subject: [PATCH RFC 10/46] imx-drm: imx-hdmi: fix PLL lock wait
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypmm-0007EB-Sz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the debug for PLL lock shows that this times out almost every
time.  Having such an event at debug level is probably a bug in itself
because it hides this fact.

Waiting 5ms seems to allow it to lock.  Also, adjust the loop so that
we check for success before checking whether we've timed out: we don't
want to wait and then fail without first checking whether we locked.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 2022635fffdf..ff00759b4d6f 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1032,16 +1032,20 @@ static int hdmi_phy_configure(struct imx_hdmi *hdmi, unsigned char prep,
 	imx_hdmi_phy_gen2_pddq(hdmi, 0);
 
 	/*Wait for PHY PLL lock */
-	msec = 4;
-	val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
-	while (!val) {
-		udelay(1000);
-		if (msec-- == 0) {
-			dev_dbg(hdmi->dev, "PHY PLL not locked\n");
+	msec = 5;
+	do {
+		val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
+		if (!val)
+			break;
+
+		if (msec == 0) {
+			dev_err(hdmi->dev, "PHY PLL not locked\n");
 			return -EINVAL;
 		}
-		val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
-	}
+
+		udelay(1000);
+		msec--;
+	} while (1);
 
 	return 0;
 }
-- 
1.7.4.4

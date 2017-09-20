From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 20 Sep 2017 21:38:26 +0200
Subject: [RFC PATCH 2/7] drm: bridge: Enable workaround in dw_hdmi for v1.32a
In-Reply-To: <20170920193831.20268-1-jernej.skrabec@siol.net>
References: <20170920193831.20268-1-jernej.skrabec@siol.net>
Message-ID: <20170920193831.20268-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs have dw hdmi controller v1.32a which exhibits same
magenta line issue as i.MX6Q and i.MX6DL. Enable workaround for it.

Allwinner never released any kind of dw hdmi or errata documentation,
so it is not clear how many iterations need to be executed. One
iteration seems to be enough.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 09cb5a3e4c71..72969240a9d4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1631,9 +1631,10 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	 * then write one of the FC registers several times.
 	 *
 	 * The number of iterations matters and depends on the HDMI TX revision
-	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
-	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
-	 * 4 and 1 iterations respectively.
+	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
+	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
+	 * as needing the workaround, with 4 iterations for v1.30a and 1
+	 * iteration for others.
 	 */
 
 	switch (hdmi->version) {
@@ -1641,6 +1642,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 		count = 4;
 		break;
 	case 0x131a:
+	case 0x132a:
 		count = 1;
 		break;
 	default:
-- 
2.14.1

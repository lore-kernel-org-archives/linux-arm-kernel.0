From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Sep 2018 22:21:11 -0700
Subject: [PATCH 4/6] drm/imx: support handling bridge timings bus flags
In-Reply-To: <20180905052113.21262-1-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
Message-ID: <20180905052113.21262-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bridge might require specific settings for the pixel data on
the bus. Copy the bus flags from the bridge timings if a bridge
is in use.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/parallel-display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index aefd04e18f93..ee5840cdb9ab 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -239,6 +239,13 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret && ret != -ENODEV)
 		return ret;
 
+	if (imxpd->bridge) {
+		const struct drm_bridge_timings *btimings = imxpd->bridge->timings;
+
+		if (btimings)
+			imxpd->bus_flags = btimings->bus_flags;
+	}
+
 	imxpd->dev = dev;
 
 	ret = imx_pd_register(drm, imxpd);
-- 
2.18.0

From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:20 -0700
Subject: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bridge might require specific settings for the pixel data on
the bus. Copy the bus flags from the bridge timings if a bridge
is in use.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/parallel-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index aefd04e18f93..7798a0621df7 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret && ret != -ENODEV)
 		return ret;
 
+	if (imxpd->bridge && imxpd->bridge->timings)
+		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;
+
 	imxpd->dev = dev;
 
 	ret = imx_pd_register(drm, imxpd);
-- 
2.18.0

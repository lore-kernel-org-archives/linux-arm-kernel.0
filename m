From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 11 Jan 2016 13:47:15 -0300
Subject: [PATCH v2 7/8] [media] exynos4-is: Check v4l2_of_parse_endpoint()
 return value
In-Reply-To: <1452530844-30609-1-git-send-email-javier@osg.samsung.com>
References: <1452530844-30609-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1452530844-30609-8-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v4l2_of_parse_endpoint() function can fail so check the return value.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---

Changes in v2: None

 drivers/media/platform/exynos4-is/media-dev.c |  8 +++++++-
 drivers/media/platform/exynos4-is/mipi-csis.c | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index f3b2dd30ec77..662d4a5c584e 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -332,13 +332,19 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
 	struct fimc_source_info *pd = &fmd->sensor[index].pdata;
 	struct device_node *rem, *ep, *np;
 	struct v4l2_of_endpoint endpoint;
+	int ret;
 
 	/* Assume here a port node can have only one endpoint node. */
 	ep = of_get_next_child(port, NULL);
 	if (!ep)
 		return 0;
 
-	v4l2_of_parse_endpoint(ep, &endpoint);
+	ret = v4l2_of_parse_endpoint(ep, &endpoint);
+	if (ret) {
+		of_node_put(ep);
+		return ret;
+	}
+
 	if (WARN_ON(endpoint.base.port == 0) || index >= FIMC_MAX_SENSORS)
 		return -EINVAL;
 
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index ac5e50e595be..bd5c46c3d4b7 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -736,6 +736,7 @@ static int s5pcsis_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct v4l2_of_endpoint endpoint;
+	int ret;
 
 	if (of_property_read_u32(node, "clock-frequency",
 				 &state->clk_frequency))
@@ -751,7 +752,9 @@ static int s5pcsis_parse_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 	/* Get port node and validate MIPI-CSI channel id. */
-	v4l2_of_parse_endpoint(node, &endpoint);
+	ret = v4l2_of_parse_endpoint(node, &endpoint);
+	if (ret)
+		goto err;
 
 	state->index = endpoint.base.port - FIMC_INPUT_MIPI_CSI2_0;
 	if (state->index >= CSIS_MAX_ENTITIES)
@@ -764,9 +767,10 @@ static int s5pcsis_parse_dt(struct platform_device *pdev,
 					"samsung,csis-wclk");
 
 	state->num_lanes = endpoint.bus.mipi_csi2.num_data_lanes;
-	of_node_put(node);
 
-	return 0;
+err:
+	of_node_put(node);
+	return ret;
 }
 
 static int s5pcsis_pm_resume(struct device *dev, bool runtime);
-- 
2.4.3

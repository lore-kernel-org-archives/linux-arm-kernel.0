From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Jul 2018 11:55:10 +0100
Subject: [PATCH v2 06/10] coresight: Add helper to check if the endpoint is
 input
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531997715-6767-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to check if the given endpoint is input.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 16a77a7..b6a170f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -45,6 +45,11 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
+static inline bool of_coresight_ep_is_input(struct device_node *ep)
+{
+	return of_property_read_bool(ep, "slave-mode");
+}
+
 static void of_coresight_get_ports(const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
@@ -56,7 +61,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_property_read_bool(ep, "slave-mode"))
+		if (of_coresight_ep_is_input(ep))
 			in++;
 		else
 			out++;
@@ -212,7 +217,7 @@ of_get_coresight_platform_data(struct device *dev,
 		 * No need to deal with input ports, processing for as
 		 * processing for output ports will deal with them.
 		 */
-		if (of_find_property(ep, "slave-mode", NULL))
+		if (of_coresight_ep_is_input(ep))
 			continue;
 
 		ret = of_coresight_parse_endpoint(dev, ep, pdata, &i);
-- 
2.7.4

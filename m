From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  1 Jun 2018 14:16:06 +0100
Subject: [RFC PATCH 7/8] dts: coresight: Define new bindings for direction of
 data flow
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1527858967-16047-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far we have relied on an undocumented property "slave-mode",
to indicate if the given port is input or not. Since we are
redefining the coresight bindings, define new property for the
"direction" of data flow for a given connection endpoint in the
device.

Each endpoint must define the following property.

 - "direction" : 0 => Port is input
		 1 => Port is output

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 99d7a9c..63c1668 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -52,7 +52,19 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
-static void of_coresight_get_ports(const struct device_node *node,
+static bool of_coresight_ep_is_input(struct device *dev, struct device_node *ep_node)
+{
+	u32 dir;
+
+	if (!of_property_read_u32(ep_node, "direction", &dir))
+		return dir == 0;
+
+	dev_warn_once(dev, "Missing mandatory \"direction\" property!\n");
+	return of_property_read_bool(ep_node, "slave-mode");
+}
+
+static void of_coresight_get_ports(struct device *dev,
+				   const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
 	struct device_node *ep = NULL;
@@ -63,7 +75,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_property_read_bool(ep, "slave-mode"))
+		if (of_coresight_ep_is_input(dev, ep))
 			in++;
 		else
 			out++;
@@ -149,7 +161,7 @@ of_get_coresight_platform_data(struct device *dev,
 	pdata->name = dev_name(dev);
 
 	/* Get the number of input and output port for this component */
-	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
+	of_coresight_get_ports(dev, node, &pdata->nr_inport, &pdata->nr_outport);
 
 	if (pdata->nr_outport) {
 		ret = of_coresight_alloc_memory(dev, pdata);
@@ -168,7 +180,7 @@ of_get_coresight_platform_data(struct device *dev,
 			 * No need to deal with input ports, processing for as
 			 * processing for output ports will deal with them.
 			 */
-			if (of_find_property(ep, "slave-mode", NULL))
+			if (of_coresight_ep_is_input(dev, ep))
 				continue;
 
 			outport = of_graph_ep_coresight_get_port_id(dev, ep);
-- 
2.7.4

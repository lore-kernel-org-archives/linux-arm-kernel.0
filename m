From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Jul 2018 11:55:06 +0100
Subject: [PATCH v2 02/10] coresight: platform: Refactor graph endpoint parsing
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the of graph endpoint parsing code, to make the error
handling easier.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Splitted from the of_node refcounting fix, part1
---
 drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
 1 file changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6880bee..68faaf8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
+/*
+ * of_coresight_parse_endpoint : Parse the given output endpoint @ep
+ * and fill the connection information in @pdata[*@i].
+ *
+ * Parses the local port, remote device name and the remote port. Also
+ * updates *@i to point to the next index, when an entry is added.
+ *
+ * Returns :
+ *	 0	- If the parsing completed without any fatal errors.
+ *	-Errno	- Fatal error, abort the scanning.
+ */
+static int of_coresight_parse_endpoint(struct device *dev,
+				       struct device_node *ep,
+				       struct coresight_platform_data *pdata,
+				       int *i)
+{
+	int ret = 0;
+	struct of_endpoint endpoint, rendpoint;
+	struct device_node *rparent = NULL;
+	struct device_node *rport = NULL;
+	struct device *rdev = NULL;
+
+	do {
+		/* Parse the local port details */
+		if (of_graph_parse_endpoint(ep, &endpoint))
+			break;
+		/*
+		 * Get a handle on the remote port and parent
+		 * attached to it.
+		 */
+		rparent = of_graph_get_remote_port_parent(ep);
+		if (!rparent)
+			break;
+		rport = of_graph_get_remote_port(ep);
+		if (!rport)
+			break;
+		if (of_graph_parse_endpoint(rport, &rendpoint))
+			break;
+
+		/* If the remote device is not available, defer probing */
+		rdev = of_coresight_get_endpoint_device(rparent);
+		if (!rdev) {
+			ret = -EPROBE_DEFER;
+			break;
+		}
+
+		pdata->outports[*i] = endpoint.port;
+		pdata->child_names[*i] = dev_name(rdev);
+		pdata->child_ports[*i] = rendpoint.id;
+		/* Move the index */
+		(*i)++;
+	} while (0);
+
+	return ret;
+}
+
 struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
 	int i = 0, ret = 0;
 	struct coresight_platform_data *pdata;
-	struct of_endpoint endpoint, rendpoint;
-	struct device *rdev;
 	struct device_node *ep = NULL;
-	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
-	if (pdata->nr_outport) {
-		ret = of_coresight_alloc_memory(dev, pdata);
+	/* If there are no output connections, we are done */
+	if (!pdata->nr_outport)
+		return pdata;
+
+	ret = of_coresight_alloc_memory(dev, pdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Iterate through each port to discover topology */
+	while ((ep = of_graph_get_next_endpoint(node, ep))) {
+		/*
+		 * No need to deal with input ports, processing for as
+		 * processing for output ports will deal with them.
+		 */
+		if (of_find_property(ep, "slave-mode", NULL))
+			continue;
+
+		ret = of_coresight_parse_endpoint(dev, ep, pdata, &i);
 		if (ret)
 			return ERR_PTR(ret);
-
-		/* Iterate through each port to discover topology */
-		do {
-			/* Get a handle on a port */
-			ep = of_graph_get_next_endpoint(node, ep);
-			if (!ep)
-				break;
-
-			/*
-			 * No need to deal with input ports, processing for as
-			 * processing for output ports will deal with them.
-			 */
-			if (of_find_property(ep, "slave-mode", NULL))
-				continue;
-
-			/* Get a handle on the local endpoint */
-			ret = of_graph_parse_endpoint(ep, &endpoint);
-
-			if (ret)
-				continue;
-
-			/* The local out port number */
-			pdata->outports[i] = endpoint.port;
-
-			/*
-			 * Get a handle on the remote port and parent
-			 * attached to it.
-			 */
-			rparent = of_graph_get_remote_port_parent(ep);
-			rport = of_graph_get_remote_port(ep);
-
-			if (!rparent || !rport)
-				continue;
-
-			if (of_graph_parse_endpoint(rport, &rendpoint))
-				continue;
-
-			rdev = of_coresight_get_endpoint_device(rparent);
-			if (!rdev)
-				return ERR_PTR(-EPROBE_DEFER);
-
-			pdata->child_names[i] = dev_name(rdev);
-			pdata->child_ports[i] = rendpoint.id;
-
-			i++;
-		} while (ep);
 	}
 
-	pdata->cpu = of_coresight_get_cpu(node);
-
 	return pdata;
 }
 EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
-- 
2.7.4

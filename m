From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 27 Jul 2018 11:15:35 +0100
Subject: [PATCH v3 7/9] coresight: platform: Cleanup coresight connection
 handling
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532686537-12380-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform code parses the component connections and populates
a platform-description of the output connections in arrays of fields
(which is never freed). This is later copied in the coresight_register
to a newly allocated area, represented by coresight_connection(s).

This patch cleans up the code dealing with connections by making
use of the "coresight_connection" structure right at the platform
code and lets the generic driver simply re-use information provided
by the platform.

Thus making it reader friendly as well as avoiding the wastage of
unused memory.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c    | 21 +-----------
 drivers/hwtracing/coresight/of_coresight.c | 53 +++++++++++-------------------
 include/linux/coresight.h                  |  9 ++---
 3 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 9fd0c38..5e8880c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -995,13 +995,11 @@ postcore_initcall(coresight_init);
 
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
-	int i;
 	int ret;
 	int link_subtype;
 	int nr_refcnts = 1;
 	atomic_t *refcnts = NULL;
 	struct coresight_device *csdev;
-	struct coresight_connection *conns = NULL;
 
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
@@ -1030,22 +1028,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->nr_inport = desc->pdata->nr_inport;
 	csdev->nr_outport = desc->pdata->nr_outport;
 
-	/* Initialise connections if there is at least one outport */
-	if (csdev->nr_outport) {
-		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
-		if (!conns) {
-			ret = -ENOMEM;
-			goto err_free_refcnts;
-		}
-
-		for (i = 0; i < csdev->nr_outport; i++) {
-			conns[i].outport = desc->pdata->outports[i];
-			conns[i].child_name = desc->pdata->child_names[i];
-			conns[i].child_port = desc->pdata->child_ports[i];
-		}
-	}
-
-	csdev->conns = conns;
+	csdev->conns = desc->pdata->conns;
 
 	csdev->type = desc->type;
 	csdev->subtype = desc->subtype;
@@ -1078,8 +1061,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_free_refcnts:
-	kfree(refcnts);
 err_free_csdev:
 	kfree(csdev);
 err_out:
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 44903d3..e8fb4e1 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -75,29 +75,13 @@ static void of_coresight_get_ports(const struct device_node *node,
 static int of_coresight_alloc_memory(struct device *dev,
 			struct coresight_platform_data *pdata)
 {
-	/* List of output port on this component */
-	pdata->outports = devm_kcalloc(dev,
-				       pdata->nr_outport,
-				       sizeof(*pdata->outports),
-				       GFP_KERNEL);
-	if (!pdata->outports)
-		return -ENOMEM;
-
-	/* Children connected to this component via @outports */
-	pdata->child_names = devm_kcalloc(dev,
-					  pdata->nr_outport,
-					  sizeof(*pdata->child_names),
-					  GFP_KERNEL);
-	if (!pdata->child_names)
-		return -ENOMEM;
-
-	/* Port number on the child this component is connected to */
-	pdata->child_ports = devm_kcalloc(dev,
-					  pdata->nr_outport,
-					  sizeof(*pdata->child_ports),
-					  GFP_KERNEL);
-	if (!pdata->child_ports)
-		return -ENOMEM;
+	if (pdata->nr_outport) {
+		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
+					    sizeof(*pdata->conns),
+					    GFP_KERNEL);
+		if (!pdata->conns)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -121,7 +105,7 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
- * and fill the connection information in @pdata[@i].
+ * and fill the connection information in @conn
  *
  * Parses the local port, remote device name and the remote port.
  *
@@ -133,8 +117,7 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
  */
 static int of_coresight_parse_endpoint(struct device *dev,
 				       struct device_node *ep,
-				       struct coresight_platform_data *pdata,
-				       int i)
+				       struct coresight_connection *conn)
 {
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
@@ -166,11 +149,11 @@ static int of_coresight_parse_endpoint(struct device *dev,
 			break;
 		}
 
-		pdata->outports[i] = endpoint.port;
-		pdata->child_names[i] = devm_kstrdup(dev,
-						     dev_name(rdev),
-						     GFP_KERNEL);
-		pdata->child_ports[i] = rendpoint.port;
+		conn->outport = endpoint.port;
+		conn->child_name = devm_kstrdup(dev,
+						dev_name(rdev),
+						GFP_KERNEL);
+		conn->child_port = rendpoint.port;
 		/* Connection record updated */
 		ret = 1;
 	} while (0);
@@ -189,8 +172,9 @@ struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
-	int i = 0, ret = 0;
+	int ret = 0;
 	struct coresight_platform_data *pdata;
+	struct coresight_connection *conn;
 	struct device_node *ep = NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -212,6 +196,7 @@ of_get_coresight_platform_data(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	conn = pdata->conns;
 	/* Iterate through each port to discover topology */
 	while ((ep = of_graph_get_next_endpoint(node, ep))) {
 		/*
@@ -221,10 +206,10 @@ of_get_coresight_platform_data(struct device *dev,
 		if (of_coresight_ep_is_input(ep))
 			continue;
 
-		ret = of_coresight_parse_endpoint(dev, ep, pdata, i);
+		ret = of_coresight_parse_endpoint(dev, ep, conn);
 		switch (ret) {
 		case 1:
-			i++;		/* Fall through */
+			conn++;		/* Fall through */
 		case 0:
 			break;
 		default:
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d828a6e..41e1f43 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -94,20 +94,15 @@ union coresight_dev_subtype {
  * @cpu:	the CPU a source belongs to. Only applicable for ETM/PTMs.
  * @name:	name of the component as shown under sysfs.
  * @nr_inport:	number of input ports for this component.
- * @outports:	list of remote endpoint port number.
- * @child_names:name of all child components connected to this device.
- * @child_ports:child component port number the current component is
-		connected  to.
  * @nr_outport:	number of output ports for this component.
+ * @conns:	Array of nr_outport connections from this component
  */
 struct coresight_platform_data {
 	int cpu;
 	const char *name;
 	int nr_inport;
-	int *outports;
-	const char **child_names;
-	int *child_ports;
 	int nr_outport;
+	struct coresight_connection *conns;
 };
 
 /**
-- 
2.7.4

From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:14 +0100
Subject: [PATCH 03/20] coresight: Fix remote endpoint parsing
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When parsing the remote endpoint of an output port, we do :
     rport = of_graph_get_remote_port(ep);
     rparent = of_graph_get_remote_port_parent(ep);

and then parse the "remote_port" as if it was the remote endpoint,
which is wrong. The code worked fine because we used endpoint number
as the port number. Let us fix it and optimise a bit as:

     remote_ep = of_graph_get_remote_endpoint(ep);
     if (remote_ep)
        remote_parent = of_graph_get_port_parent(remote_ep);

and then, parse the remote_ep for the port/endpoint details.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 8a23c63..ada4f07 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -129,7 +129,7 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
+	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 
 	do {
@@ -144,16 +144,16 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 		if (of_graph_parse_endpoint(ep, &endpoint))
 			break;
 		/*
-		 * Get a handle on the remote port and parent
-		 * attached to it.
+		 * Get a handle on the remote endpoint and the device it is
+		 * attached to.
 		 */
-		rparent = of_graph_get_remote_port_parent(ep);
+		rep = of_graph_get_remote_endpoint(ep);
+		if (!rep)
+			break;
+		rparent = of_graph_get_port_parent(rep);
 		if (!rparent)
 			break;
-		rport = of_graph_get_remote_port(ep);
-		if (!rport)
-			break;
-		if (of_graph_parse_endpoint(rport, &rendpoint))
+		if (of_graph_parse_endpoint(rep, &rendpoint))
 			break;
 
 		/* If the remote device is not available, defer probing */
@@ -165,15 +165,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 
 		pdata->outports[*i] = endpoint.port;
 		pdata->child_names[*i] = dev_name(rdev);
-		pdata->child_ports[*i] = rendpoint.id;
+		pdata->child_ports[*i] = rendpoint.port;
 		/* Move the index */
 		(*i)++;
 	} while (0);
 
 	if (rparent)
 		of_node_put(rparent);
-	if (rport)
-		of_node_put(rport);
+	if (rep)
+		of_node_put(rep);
 
 	return ret;
 }
-- 
2.7.4

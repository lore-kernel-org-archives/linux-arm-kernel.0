From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 31 May 2016 12:57:36 +0100
Subject: [PATCH 3/5] coresight: Fix csdev connections initialisation
In-Reply-To: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1464695858-29284-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a cleanup patch.

coresight_device->conns holds an array to point to the devices
connected to the OUT ports of a component. Sinks, e.g ETR, do not
have an OUT port (nr_outport = 0), as it streams the trace to
memory via AXI.

At coresight_register() we do :

	conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
	if (!conns) {
		ret = -ENOMEM;
		goto err_kzalloc_conns;
	}

For ETR, since the total size requested for kcalloc is zero, the return value is,
ZERO_SIZE_PTR ( != NULL). Hence, csdev->conns = ZERO_SIZE_PTR which cannot be
verified later to contain a valid pointer. The code which accesses the csdev->conns
is bounded by the csdev->nr_outport check, hence we don't try to dereference the
ZERO_SIZE_PTR. This patch cleans up the csdev->conns and csdev->refcnt, initialisation
to make sure we initialise it properly(i.e, either NULL or valid conns array).

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 42 +++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 0fdaaf4..8410420 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -890,7 +890,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	int nr_refcnts = 1;
 	atomic_t *refcnts = NULL;
 	struct coresight_device *csdev;
-	struct coresight_connection *conns;
+	struct coresight_connection *conns = NULL;
 
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
@@ -908,29 +908,35 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 			nr_refcnts = desc->pdata->nr_outport;
 	}
 
-	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
-	if (!refcnts) {
-		ret = -ENOMEM;
-		goto err_kzalloc_refcnts;
-	}
+	if (nr_refcnts) {
+		refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
+		if (!refcnts) {
+			ret = -ENOMEM;
+			goto err_kzalloc_refcnts;
+		}
 
-	csdev->refcnt = refcnts;
+		csdev->refcnt = refcnts;
+	}
 
 	csdev->nr_inport = desc->pdata->nr_inport;
 	csdev->nr_outport = desc->pdata->nr_outport;
-	conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
-	if (!conns) {
-		ret = -ENOMEM;
-		goto err_kzalloc_conns;
-	}
 
-	for (i = 0; i < csdev->nr_outport; i++) {
-		conns[i].outport = desc->pdata->outports[i];
-		conns[i].child_name = desc->pdata->child_names[i];
-		conns[i].child_port = desc->pdata->child_ports[i];
-	}
+	/* Initialise connections if there is at least one outport for this component */
+	if (csdev->nr_outport) {
+		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
+		if (!conns) {
+			ret = -ENOMEM;
+			goto err_kzalloc_conns;
+		}
 
-	csdev->conns = conns;
+		for (i = 0; i < csdev->nr_outport; i++) {
+			conns[i].outport = desc->pdata->outports[i];
+			conns[i].child_name = desc->pdata->child_names[i];
+			conns[i].child_port = desc->pdata->child_ports[i];
+		}
+
+		csdev->conns = conns;
+	}
 
 	csdev->type = desc->type;
 	csdev->subtype = desc->subtype;
-- 
1.9.1

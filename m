From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  2 Feb 2016 14:13:59 -0700
Subject: [PATCH 5/7] coresight: remove csdev's link from topology
In-Reply-To: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454447641-29153-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In function 'coresight_unregister()', all references to the csdev that
is being taken away need to be removed from the topology.  Otherwise
building the next coresight path from source to sink may use memory
that has been released.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index a35ca54a76c9..7e6e9ff27dd1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -579,6 +579,50 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 	}
 }
 
+static int coresight_remove_match(struct device *dev, void *data)
+{
+	int i;
+	struct coresight_device *csdev, *iterator;
+	struct coresight_connection *conn;
+
+	csdev = data;
+	iterator = to_coresight_device(dev);
+
+	/* No need to check oneself */
+	if (csdev == iterator)
+		return 0;
+
+	/*
+	 * Circle throuch all the connection of that component.  If we find
+	 * a connection whose name matches @csdev, remove it.
+	 */
+	for (i = 0; i < iterator->nr_outport; i++) {
+		conn = &iterator->conns[i];
+
+		if (conn->child_dev == NULL)
+			continue;
+
+		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
+			iterator->orphan = true;
+			conn->child_dev = NULL;
+			/* No need to continue */
+			break;
+		}
+	}
+
+	/*
+	 * Returning '0' ensures that all known component on the
+	 * bus will be checked.
+	 */
+	return 0;
+}
+
+static void coresight_remove_conns(struct coresight_device *csdev)
+{
+	bus_for_each_dev(&coresight_bustype, NULL,
+			 csdev, coresight_remove_match);
+}
+
 /**
  * coresight_timeout - loop until a bit has changed to a specific state.
  * @addr: base address of the area of interest.
@@ -717,6 +761,8 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+	/* Remove references of that device in the topology */
+	coresight_remove_conns(csdev);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.1.4

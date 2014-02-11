From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 12:45:41 +0100
Subject: [RFC PATCH v2 1/4] staging: imx-drm: Add temporary copies of v4l2-of
 parsing functions
In-Reply-To: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
References: <1392119144-27868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392119144-27868-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <philipp.zabel@gmail.com>

The video interface bindings described in
Documentation/device-tree/bindings/media/video-interfaces.txt
are useful for DRM drivers, too. To decouple development,
duplicate the v4l2-of parser functions temporarily. Also modify
imx_drm_of_get_next_endpoint to decrement the refcount of prev.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/staging/imx-drm/Makefile     |   2 +-
 drivers/staging/imx-drm/imx-drm-of.c | 106 +++++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-drm.h    |   4 ++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/imx-drm/imx-drm-of.c

diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 129e3a3..743b875 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -1,5 +1,5 @@
 
-imxdrm-objs := imx-drm-core.o
+imxdrm-objs := imx-drm-core.o imx-drm-of.o
 
 obj-$(CONFIG_DRM_IMX) += imxdrm.o
 
diff --git a/drivers/staging/imx-drm/imx-drm-of.c b/drivers/staging/imx-drm/imx-drm-of.c
new file mode 100644
index 0000000..12f37eb
--- /dev/null
+++ b/drivers/staging/imx-drm/imx-drm-of.c
@@ -0,0 +1,106 @@
+/*
+ * Video Interface OF binding parsing library
+ *
+ * Copyright (C) 2012 - 2013 Samsung Electronics Co., Ltd.
+ * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * Copyright (C) 2012 Renesas Electronics Corp.
+ * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+/**
+ * imx_drm_get_next_endpoint() - get next endpoint node
+ * @parent: pointer to the parent device node
+ * @prev: previous endpoint node, or NULL to get first
+ *
+ * Return: An 'endpoint' node pointer with refcount incremented. Refcount
+ * of the passed @prev node is decremented.
+ */
+struct device_node *imx_drm_of_get_next_endpoint(
+		const struct device_node *parent, struct device_node *prev)
+{
+	struct device_node *endpoint;
+	struct device_node *port = NULL;
+
+	if (!parent)
+		return NULL;
+
+	if (!prev) {
+		struct device_node *node;
+		/*
+		 * It's the first call, we have to find a port subnode
+		 * within this node or within an optional 'ports' node.
+		 */
+		node = of_get_child_by_name(parent, "ports");
+		if (node)
+			parent = node;
+
+		port = of_get_child_by_name(parent, "port");
+
+		if (port) {
+			/* Found a port, get an endpoint. */
+			endpoint = of_get_next_child(port, NULL);
+			of_node_put(port);
+		} else {
+			endpoint = NULL;
+		}
+
+		if (!endpoint)
+			pr_err("%s(): no endpoint nodes specified for %s\n",
+			       __func__, parent->full_name);
+		of_node_put(node);
+	} else {
+		port = of_get_parent(prev);
+		if (!port) {
+			/* Hm, has someone given us the root node ?... */
+			of_node_put(prev);
+			return NULL;
+		}
+
+		endpoint = of_get_next_child(port, prev);
+		if (endpoint) {
+			of_node_put(port);
+			return endpoint;
+		}
+
+		/* No more endpoints under this port, try the next one. */
+		do {
+			port = of_get_next_child(parent, port);
+			if (!port)
+				return NULL;
+		} while (of_node_cmp(port->name, "port"));
+
+		/* Pick up the first endpoint in this port. */
+		endpoint = of_get_next_child(port, NULL);
+		of_node_put(port);
+	}
+
+	return endpoint;
+}
+EXPORT_SYMBOL_GPL(imx_drm_of_get_next_endpoint);
+
+/**
+ * imx_drm_of_get_remote_port() - get remote port node
+ * @node: pointer to a local endpoint device_node
+ *
+ * Return: Remote port node associated with remote endpoint node linked
+ *	   to @node. Use of_node_put() on it when done.
+ */
+struct device_node *imx_drm_of_get_remote_port(const struct device_node *node)
+{
+	struct device_node *np;
+
+	/* Get remote endpoint node. */
+	np = of_parse_phandle(node, "remote-endpoint", 0);
+	if (!np)
+		return NULL;
+	return of_get_next_parent(np);
+}
+EXPORT_SYMBOL_GPL(imx_drm_of_get_remote_port);
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index aa21028..9af4a82 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -58,4 +58,8 @@ int imx_drm_connector_mode_valid(struct drm_connector *connector,
 void imx_drm_connector_destroy(struct drm_connector *connector);
 void imx_drm_encoder_destroy(struct drm_encoder *encoder);
 
+struct device_node *imx_drm_of_get_next_endpoint(
+		const struct device_node *parent, struct device_node *prev);
+struct device_node *imx_drm_of_get_remote_port(const struct device_node *node);
+
 #endif /* _IMX_DRM_H_ */
-- 
1.8.5.3

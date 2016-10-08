From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri,  7 Oct 2016 21:23:15 -0700
Subject: [PATCH 5/5] rpmsg: smd: Register rpmsg user space interface for edges
In-Reply-To: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
References: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1475900595-8375-5-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create and register a rpmsg device for use with the rpmsg user space
interface, allowing user space to access SMD channels.

Also provide the "rpmsg_name" device attribute to expose the edge name
in sysfs, allowing the user to write udev rules for specific rpmsg
devices and their children.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 92efa74a0024..86856b2b558a 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -983,6 +983,20 @@ static int qcom_smd_create_device(struct qcom_smd_channel *channel)
 	return rpmsg_register_device(rpdev);
 }
 
+static int qcom_smd_create_chrdev(struct qcom_smd_edge *edge)
+{
+	struct qcom_smd_device *qsdev;
+
+	qsdev = kzalloc(sizeof(*qsdev), GFP_KERNEL);
+	if (!qsdev)
+		return -ENOMEM;
+
+	qsdev->edge = edge;
+	qsdev->rpdev.ops = &qcom_smd_device_ops;
+	qsdev->rpdev.dev.parent = &edge->dev;
+	return rpmsg_chrdev_register_device(&qsdev->rpdev);
+}
+
 /*
  * Allocate the qcom_smd_channel object for a newly found smd channel,
  * retrieving and validating the smem items involved.
@@ -1284,6 +1298,21 @@ static void qcom_smd_edge_release(struct device *dev)
 	kfree(edge);
 }
 
+static ssize_t rpmsg_name_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct qcom_smd_edge *edge = to_smd_edge(dev);
+
+	return sprintf(buf, "%s\n", edge->of_node->name);
+}
+static DEVICE_ATTR_RO(rpmsg_name);
+
+static struct attribute *qcom_smd_edge_attrs[] = {
+	&dev_attr_rpmsg_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(qcom_smd_edge);
+
 /**
  * qcom_smd_register_edge() - register an edge based on an device_node
  * @parent:    parent device for the edge
@@ -1305,6 +1334,7 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 
 	edge->dev.parent = parent;
 	edge->dev.release = qcom_smd_edge_release;
+	edge->dev.groups = qcom_smd_edge_groups;
 	dev_set_name(&edge->dev, "%s:%s", dev_name(parent), node->name);
 	ret = device_register(&edge->dev);
 	if (ret) {
@@ -1318,6 +1348,12 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 		goto unregister_dev;
 	}
 
+	ret = qcom_smd_create_chrdev(edge);
+	if (ret) {
+		dev_err(&edge->dev, "failed to register chrdev for edge\n");
+		goto unregister_dev;
+	}
+
 	schedule_work(&edge->scan_work);
 
 	return edge;
-- 
2.5.0

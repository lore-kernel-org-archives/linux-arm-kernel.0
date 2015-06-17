From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:19 +0200
Subject: [PATCH 09/13] gpu: host1x: implement class.get_dependencies()
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-10-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So others can find out dependencies of host1x clients, as specified in
bindings/gpu/nvidia,tegra20-host1x.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/host1x/dev.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 53d3d1d..c86ef88 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -212,10 +212,57 @@ static struct platform_driver tegra_host1x_driver = {
 	.remove = host1x_remove,
 };
 
+static void add_dependency(struct fwnode_handle *fwnode,
+			   const char *property,
+			   struct list_head *list)
+{
+	struct fwnode_dependency *dep;
+	struct device_node *np;
+
+	np = of_parse_phandle(of_node(fwnode), property, 0);
+	if (!np)
+		return;
+
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep)
+		return;
+
+	INIT_LIST_HEAD(&dep->dependency);
+	dep->fwnode = &np->fwnode;
+
+	list_add_tail(&dep->dependency, list);
+}
+
+struct list_head *host1x_get_dependencies(struct fwnode_handle *fwnode)
+{
+	struct list_head *list = NULL;
+
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return NULL;
+
+	INIT_LIST_HEAD(list);
+
+	add_dependency(fwnode, "nvidia,dpaux", list);
+	add_dependency(fwnode, "nvidia,panel", list);
+
+	return list;
+}
+
+static struct class host1x_class = {
+	.name = "tegra-host1x",
+
+	.get_dependencies = host1x_get_dependencies,
+};
+
 static int __init tegra_host1x_init(void)
 {
 	int err;
 
+	err = class_register(&host1x_class);
+	if (err < 0)
+		return err;
+
 	err = bus_register(&host1x_bus_type);
 	if (err < 0)
 		return err;
-- 
2.4.1

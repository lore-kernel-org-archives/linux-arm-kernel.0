From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 26 Nov 2014 15:22:18 -0600
Subject: [RFC PATCH] misc: SRAM: Add option to map SRAM to allow code execution
Message-ID: <5cca5199a7e675d2ac35b4e7f2901b10bbd5f4be.1417029919.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russ Dill <Russ.Dill@ti.com>

Allow option for mapping SRAM as executable. This is useful for
platforms using the sram driver that need to run PM code from sram
like several ARM platforms.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
This patch depends on the series here [1] and can be seen in context
as a dependency for am335x suspend in this branch based on v3.18-rc6
here [2].

[1] http://lkml.iu.edu/hypermail/linux/kernel/1411.3/02782.html
[2] https://github.com/dgerlach/linux-pm/tree/rfc-pm-am335x-v3.18-rc6

 Documentation/devicetree/bindings/misc/sram.txt |  1 +
 drivers/misc/sram.c                             | 13 ++++++++++++-
 include/linux/platform_data/sram.h              |  8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/sram.h

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 36cbe5a..c5ecde4 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -33,6 +33,7 @@ Optional properties in the area nodes:
 
 - compatible : standard definition, should contain a vendor specific string
                in the form <vendor>,[<device>-]<usage>
+- map-exec :   Map range to allow code execution
 
 Example:
 
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 21181fa..f5822de 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/genalloc.h>
+#include <linux/platform_data/sram.h>
 
 #define SRAM_GRANULARITY	32
 
@@ -56,6 +57,7 @@ static int sram_reserve_cmp(void *priv, struct list_head *a,
 
 static int sram_probe(struct platform_device *pdev)
 {
+	struct sram_platform_data *pdata = pdev->dev.platform_data;
 	void __iomem *virt_base;
 	struct sram_dev *sram;
 	struct resource *res;
@@ -64,12 +66,21 @@ static int sram_probe(struct platform_device *pdev)
 	struct sram_reserve *rblocks, *block;
 	struct list_head reserve_list;
 	unsigned int nblocks;
+	bool map_exec = false;
 	int ret;
 
 	INIT_LIST_HEAD(&reserve_list);
 
+	if (of_get_property(pdev->dev.of_node, "map-exec", NULL))
+		map_exec = true;
+	if (pdata && pdata->map_exec)
+		map_exec |= true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (map_exec)
+		virt_base = devm_ioremap_exec_resource(&pdev->dev, res);
+	else
+		virt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(virt_base))
 		return PTR_ERR(virt_base);
 
diff --git a/include/linux/platform_data/sram.h b/include/linux/platform_data/sram.h
new file mode 100644
index 0000000..8f5c4ba
--- /dev/null
+++ b/include/linux/platform_data/sram.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_SRAM_H
+#define _LINUX_SRAM_H
+
+struct sram_platform_data {
+	bool map_exec;
+};
+
+#endif
-- 
2.1.0

From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Aug 2012 11:46:40 +0100
Subject: [PATCH 4/6] mfd: Use interrupt-parent as IRQ controller if specified
 in DT
In-Reply-To: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344250002-6011-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch the default behaviour is to climb the Device
Tree and use the first encountered interrupt controller. This
does not take into account if a device node has specified to use
a particular IRQ controller using the interrupt-parent property.
This patch ensures that property is adhered to.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 0c3a01c..f10f27b 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 
 int mfd_cell_enable(struct platform_device *pdev)
 {
@@ -78,7 +79,7 @@ static int mfd_add_device(struct device *parent, int id,
 {
 	struct resource *res;
 	struct platform_device *pdev;
-	struct device_node *np = NULL;
+	struct device_node *np, *parent_node = NULL;
 	struct irq_domain *domain = NULL;
 	int ret = -ENOMEM;
 	int r;
@@ -97,7 +98,12 @@ static int mfd_add_device(struct device *parent, int id,
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				pdev->dev.of_node = np;
-				domain = irq_find_host(parent->of_node);
+#ifdef CONFIG_OF
+				parent_node = of_irq_find_parent(np);
+#endif
+				if (!parent_node)
+					parent_node = parent->of_node;
+				domain = irq_find_host(parent_node);
 				break;
 			}
 		}
-- 
1.7.9.5

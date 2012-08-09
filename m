From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:53:53 +0100
Subject: [PATCH 6/8] mfd: Use interrupt-parent as IRQ controller if specified
 in DT
In-Reply-To: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527635-6163-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch the default behaviour is to climb the Device
Tree and use the first encountered interrupt controller. This
does not take into account if a device node has specified to use
a particular IRQ controller using the interrupt-parent property.
This patch ensures that property is adhered to.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 0c3a01c..bb5e753 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -97,7 +97,7 @@ static int mfd_add_device(struct device *parent, int id,
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				pdev->dev.of_node = np;
-				domain = irq_find_host(parent->of_node);
+				domain = irq_find_host(np);
 				break;
 			}
 		}
-- 
1.7.9.5

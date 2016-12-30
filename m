From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 30 Dec 2016 16:43:33 +0100
Subject: [PATCH v2] mfd: mc13xxx: Set the irq type.
Message-ID: <1483112613-18092-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for
interrupts") removed the passing of the IRQF_TRIGGER_HIGH flag when
registering the interrupt.
This commit fixes that problem by setting the IRQF_TRIGGER_HIGH flag in
case no irq type is set via irqd framework (e.g. device tree). In the
latter case the irq flag from irqd is used.

Tested on i.MX31 PDK hardware.

Fixes: 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for interrupts")
Cc: <stable@vger.kernel.org> # 3.18.x
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
---
Changes from v1 (which was part of a patch series):
  - Now uses irqd_-functions to check if irq type is defined
  - Added Fixes: and Cc: to stable kernel.

 drivers/mfd/mc13xxx-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d7f54e4..e1757ea 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
+#include <linux/irq.h>
 
 #include "mc13xxx.h"
 
@@ -410,6 +411,7 @@ int mc13xxx_common_init(struct device *dev)
 	struct mc13xxx *mc13xxx = dev_get_drvdata(dev);
 	u32 revision;
 	int i, ret;
+	unsigned int flags;
 
 	mc13xxx->dev = dev;
 
@@ -440,7 +442,11 @@ int mc13xxx_common_init(struct device *dev)
 	mc13xxx->irq_chip.irqs = mc13xxx->irqs;
 	mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
 
-	ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
+	flags = irqd_get_trigger_type(irq_get_irq_data(mc13xxx->irq));
+	flags = (flags == IRQ_TYPE_NONE) ? IRQF_TRIGGER_HIGH : flags;
+
+	ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq,
+				  IRQF_ONESHOT | flags,
 				  0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
 	if (ret)
 		return ret;
-- 
2.7.4

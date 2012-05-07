From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 09:16:10 +0800
Subject: [PATCH RESEND 5/9] mtd: nand: gpmi: adopt pinctrl support
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336353374-28939-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-mtd at lists.infradead.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 9ec51ce..8478fd9 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/mtd/gpmi-nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pinctrl/consumer.h>
 #include "gpmi-nand.h"
 
 /* add our owner bbt descriptor */
@@ -476,6 +477,7 @@ acquire_err:
 static int __devinit acquire_resources(struct gpmi_nand_data *this)
 {
 	struct resources *res = &this->resources;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	ret = acquire_register_block(this, GPMI_NAND_GPMI_REGS_ADDR_RES_NAME);
@@ -494,6 +496,12 @@ static int __devinit acquire_resources(struct gpmi_nand_data *this)
 	if (ret)
 		goto exit_dma_channels;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto exit_pin;
+	}
+
 	res->clock = clk_get(&this->pdev->dev, NULL);
 	if (IS_ERR(res->clock)) {
 		pr_err("can not get the clock\n");
@@ -503,6 +511,7 @@ static int __devinit acquire_resources(struct gpmi_nand_data *this)
 	return 0;
 
 exit_clock:
+exit_pin:
 	release_dma_channels(this);
 exit_dma_channels:
 	release_bch_irq(this);
-- 
1.7.5.4

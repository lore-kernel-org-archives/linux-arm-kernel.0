From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:37 +0100
Subject: [PATCH 08/15] drivers/mmc: MMCI: Use correct GPIO binding for IRQ
 requests
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now there are irqdomains in place for Snowball, we can request
GPIO IRQs directly by their binding. This replaces the previous method
of hard-coding the hwirq using u32 values in the DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mmci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5a7da17..2303a16 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -1203,11 +1204,11 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 {
 	int bus_width = 0;
 
-	of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
+	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
 	if (!pdata->gpio_wp)
 		pdata->gpio_wp = -1;
 
-	of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
+	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
 	if (!pdata->gpio_cd)
 		pdata->gpio_cd = -1;
 
-- 
1.7.9.1

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Apr 2017 22:40:55 +0200
Subject: [PATCH 2/5 v3] usb: host: fotg2: add device tree probing
In-Reply-To: <20170421204058.6206-1-linus.walleij@linaro.org>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
Message-ID: <20170421204058.6206-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans Ulli Kroll <ulli.kroll@googlemail.com>

Add device tree probing to the fotg2 driver.

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Change compatible to "faraday,fotg210" simply.
---
 drivers/usb/host/fotg210-hcd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 1c5b34b74860..c226041101d1 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -23,6 +23,7 @@
  * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/device.h>
 #include <linux/dmapool.h>
 #include <linux/kernel.h>
@@ -5600,6 +5601,15 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
+	/* Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+
+	retval = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval)
+		goto fail_create_hcd;
+
 	pdev->dev.power.power_state = PMSG_ON;
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -5676,9 +5686,18 @@ static int fotg210_hcd_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id fotg210_of_match[] = {
+	{ .compatible = "faraday,fotg210" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fotg210_of_match);
+#endif
+
 static struct platform_driver fotg210_hcd_driver = {
 	.driver = {
 		.name   = "fotg210-hcd",
+		.of_match_table = of_match_ptr(fotg210_of_match),
 	},
 	.probe  = fotg210_hcd_probe,
 	.remove = fotg210_hcd_remove,
-- 
2.9.3

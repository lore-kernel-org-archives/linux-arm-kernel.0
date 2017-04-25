From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 25 Apr 2017 18:01:51 +0800
Subject: [RFC] usb: chipidea: set dma_ops for the created ci_hdrc
 platform_device
Message-ID: <20170425180151.0f03ca0e@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After commit 1dccb598df549 ("arm64: simplify dma_get_ops"), the chipidea
driver can't work any more on Marvell Berlin arm64 platforms, the reason
is the created ci_hdrc platform_device's dma_ops is dummy_dma_ops, so all
dma related operations will fail. The fix I can think of would be something
as below:

And I noticed that dwc3 has the same issue[1], and as pointed out in its
discussion, the patch can't fix None-DT platforms, so could you please
guide me what's the proper fix which can be mainlined?

Any suggestion is appreciated!

Thanks,
Jisheng

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425079.html

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 047afdbb7049..acb80457603c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -62,6 +62,7 @@
 #include <linux/usb/chipidea.h>
 #include <linux/usb/of.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/ehci_def.h>
 
@@ -786,6 +787,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	pdev->dev.dma_mask = dev->dma_mask;
 	pdev->dev.dma_parms = dev->dma_parms;
 	dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
+	of_dma_configure(&pdev->dev, dev->of_node);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

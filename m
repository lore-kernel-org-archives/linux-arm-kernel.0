From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  9 Feb 2013 21:44:26 +0100
Subject: [PATCH RFC 2/7] net: smsc911x: add pinctrl support
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no pinctrl is available just report a warning since
it may not needed in some cases (e.g: non-DT kernels).

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/net/ethernet/smsc/smsc911x.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index e112877..40766c7 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -59,6 +59,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_net.h>
+#include <linux/pinctrl/consumer.h>
 #include "smsc911x.h"
 
 #define SMSC_CHIPNAME		"smsc911x"
@@ -2352,6 +2353,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	struct smsc911x_data *pdata;
 	struct smsc911x_platform_config *config = pdev->dev.platform_data;
 	struct resource *res, *irq_res;
+	struct pinctrl *pinctrl;
 	unsigned int intcfg = 0;
 	int res_size, irq_flags;
 	int retval;
@@ -2381,6 +2383,15 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_0;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		retval = PTR_ERR(pinctrl);
+		if (retval == -EPROBE_DEFER)
+			goto out_0;
+
+		dev_warn(&pdev->dev, "No pinctrl provided\n");
+	}
+
 	dev = alloc_etherdev(sizeof(struct smsc911x_data));
 	if (!dev) {
 		retval = -ENOMEM;
-- 
1.7.7.6

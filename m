From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jan 2013 16:46:16 +0100
Subject: [PATCH V3 4/5] W1: Add pinctrl support to MXC onewire master.
In-Reply-To: <20130129154608.5184.46101.stgit@localhost>
References: <20130129154608.5184.46101.stgit@localhost>
Message-ID: <20130129154616.5184.41342.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/masters/mxc_w1.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 317b2bc..48afc2c 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "../w1.h"
 #include "../w1_int.h"
@@ -107,6 +108,7 @@ static int mxc_w1_probe(struct platform_device *pdev)
 {
 	struct mxc_w1_device *mdev;
 	struct resource *res;
+	struct pinctrl *pinctrl;
 	int err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -117,6 +119,13 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (!mdev)
 		return -ENOMEM;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		err = PTR_ERR(pinctrl);
+		dev_err(&pdev->dev, "failed to get default pinctrl: %d\n", err);
+		goto failed_pin;
+	}
+
 	mdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mdev->clk)) {
 		err = PTR_ERR(mdev->clk);
@@ -152,6 +161,7 @@ failed_add:
 
 failed_req:
 failed_clk:
+failed_pin:
 	kfree(mdev);
 	return err;
 }

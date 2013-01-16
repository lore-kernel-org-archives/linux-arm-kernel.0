From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 10:48:29 +0100
Subject: [PATCH 4/5] W1: Add pinctrl support to MXC onewire master.
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116094829.9660.49196.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/w1/masters/mxc_w1.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 949e566..7454938 100644
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
 	mdev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mdev->clk)) {
 		err = PTR_ERR(mdev->clk);
@@ -159,6 +168,7 @@ failed_ioremap:
 	release_mem_region(res->start, resource_size(res));
 failed_req:
 	clk_put(mdev->clk);
+failed_pin:
 failed_clk:
 	kfree(mdev);
 	return err;

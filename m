From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Apr 2017 22:40:56 +0200
Subject: [PATCH 3/5 v3] usb: host: fotg2: add silicon clock handling
In-Reply-To: <20170421204058.6206-1-linus.walleij@linaro.org>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
Message-ID: <20170421204058.6206-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When used in a system with software-controller silicon clocks,
the FOTG210 needs to grab, prepare and enable the clock.
This is needed on for example the Cortina Gemini, where the
platform will by default gate off the clock unless the
peripheral (in this case the USB driver) grabs and enables
the clock.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/host/fotg210-hcd.c | 26 ++++++++++++++++++++++----
 drivers/usb/host/fotg210.h     |  3 +++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index c226041101d1..906e42458791 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -45,6 +45,7 @@
 #include <linux/uaccess.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -5635,7 +5636,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
-		goto failed;
+		goto failed_put_hcd;
 	}
 
 	hcd->rsrc_start = res->start;
@@ -5645,22 +5646,35 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 
 	fotg210->caps = hcd->regs;
 
+	/* It's OK not to supply this clock */
+	fotg210->pclk = clk_get(dev, "PCLK");
+	if (!IS_ERR(fotg210->pclk)) {
+		retval = clk_prepare_enable(fotg210->pclk);
+		if (retval) {
+			dev_err(dev, "failed to enable PCLK\n");
+			goto failed_dis_clk;
+		}
+	}
+
 	retval = fotg210_setup(hcd);
 	if (retval)
-		goto failed;
+		goto failed_dis_clk;
 
 	fotg210_init(fotg210);
 
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval) {
 		dev_err(dev, "failed to add hcd with err %d\n", retval);
-		goto failed;
+		goto failed_dis_clk;
 	}
 	device_wakeup_enable(hcd->self.controller);
 
 	return retval;
 
-failed:
+failed_dis_clk:
+	if (!IS_ERR(fotg210->pclk))
+		clk_disable_unprepare(fotg210->pclk);
+failed_put_hcd:
 	usb_put_hcd(hcd);
 fail_create_hcd:
 	dev_err(dev, "init %s fail, %d\n", dev_name(dev), retval);
@@ -5676,6 +5690,10 @@ static int fotg210_hcd_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct fotg210_hcd *fotg210 = hcd_to_fotg210(hcd);
+
+	if (!IS_ERR(fotg210->pclk))
+		clk_disable_unprepare(fotg210->pclk);
 
 	if (!hcd)
 		return 0;
diff --git a/drivers/usb/host/fotg210.h b/drivers/usb/host/fotg210.h
index b5cfa7aeb277..c429efeb2b7e 100644
--- a/drivers/usb/host/fotg210.h
+++ b/drivers/usb/host/fotg210.h
@@ -181,6 +181,9 @@ struct fotg210_hcd {			/* one per controller */
 #	define COUNT(x)
 #endif
 
+	/* silicon clock */
+	struct clk		*pclk;
+
 	/* debug files */
 	struct dentry		*debug_dir;
 };
-- 
2.9.3

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 May 2010 11:41:17 +0900
Subject: [PATCH 4/4] usb: s3c-hsotg: Enable HCLK for the OTG module.
In-Reply-To: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
References: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1275014477-23133-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch modifies the following in S3C hsotg driver.

1. Gets a reference to the USB OTG hclk clock and enables it. This is
   required for plaforms on which the USB OTG hclk is disabled during
   the boot time clock intialization.

2. Add necessary clock clean up in case of error during initialization
   failure or during module unload.

3. Add a new field 'clk_otg' in 'struct s3c_hsotg' to maintain a
   reference to the USB OTG hclk clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/usb/gadget/s3c-hsotg.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 81c47d2..526d081 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -130,6 +130,7 @@ struct s3c_hsotg_ep {
  * @dev: The parent device supplied to the probe function
  * @driver: USB gadget driver
  * @plat: The platform specific configuration data.
+ * @clk_otg: The hclk for otg module.
  * @regs: The memory area mapped for accessing registers.
  * @regs_res: The resource that was allocated when claiming register space.
  * @irq: The IRQ number we are using
@@ -147,6 +148,7 @@ struct s3c_hsotg {
 	struct device		 *dev;
 	struct usb_gadget_driver *driver;
 	struct s3c_hsotg_plat	 *plat;
+	struct clk		 *clk_otg;
 
 	void __iomem		*regs;
 	struct resource		*regs_res;
@@ -3269,6 +3271,14 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 		goto err_regs_res;
 	}
 
+	hsotg->clk_otg = clk_get(&pdev->dev, "otg");
+	if (IS_ERR(hsotg->clk_otg)) {
+		dev_err(dev, "failed to find usb otg clock source\n");
+		ret = -ENODEV;
+		goto err_noclk;
+	}
+	clk_enable(hsotg->clk_otg);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
 		dev_err(dev, "cannot find IRQ\n");
@@ -3330,6 +3340,10 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	return 0;
 
 err_regs:
+	clk_disable(hsotg->clk_otg);
+	clk_put(hsotg->clk_otg);
+
+err_noclk:
 	iounmap(hsotg->regs);
 
 err_regs_res:
@@ -3352,6 +3366,9 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 	free_irq(hsotg->irq, hsotg);
 	iounmap(hsotg->regs);
 
+	clk_disable(hsotg->clk_otg);
+	clk_put(hsotg->clk_otg);
+
 	release_resource(hsotg->regs_res);
 	kfree(hsotg->regs_res);
 
-- 
1.6.3.3

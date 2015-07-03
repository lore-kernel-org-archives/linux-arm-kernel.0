From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat,  4 Jul 2015 01:15:17 +0200
Subject: [PATCH v4 4/7] rtc: mxc: add support of device tree
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1435965320-1478-5-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for the mxc rtc driver.

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/rtc/rtc-mxc.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 4ce7e21..4191a87 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -16,6 +16,8 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #define RTC_INPUT_CLK_32768HZ	(0x00 << 5)
 #define RTC_INPUT_CLK_32000HZ	(0x01 << 5)
@@ -98,6 +100,15 @@ static const struct platform_device_id imx_rtc_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
 
+#ifdef CONFIG_OF
+static const struct of_device_id imx_rtc_dt_ids[] = {
+	{ .compatible = "fsl,imx1-rtc", .data = (const void *)IMX1_RTC },
+	{ .compatible = "fsl,imx21-rtc", .data = (const void *)IMX21_RTC },
+	{}
+};
+MODULE_DEVICE_TABLE(of, imx_rtc_dt_ids);
+#endif
+
 static inline int is_imx1_rtc(struct rtc_plat_data *data)
 {
 	return data->devtype == IMX1_RTC;
@@ -362,12 +373,17 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	u32 reg;
 	unsigned long rate;
 	int ret;
+	const struct of_device_id *of_id;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->devtype = pdev->id_entry->driver_data;
+	of_id = of_match_device(imx_rtc_dt_ids, &pdev->dev);
+	if (of_id)
+		pdata->devtype = (enum imx_rtc_type)of_id->data;
+	else
+		pdata->devtype = pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
@@ -488,6 +504,7 @@ static SIMPLE_DEV_PM_OPS(mxc_rtc_pm_ops, mxc_rtc_suspend, mxc_rtc_resume);
 static struct platform_driver mxc_rtc_driver = {
 	.driver = {
 		   .name	= "mxc_rtc",
+		   .of_match_table = of_match_ptr(imx_rtc_dt_ids),
 		   .pm		= &mxc_rtc_pm_ops,
 	},
 	.id_table = imx_rtc_devtype,
-- 
1.7.4.4

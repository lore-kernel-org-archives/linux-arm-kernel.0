From: aford173@gmail.com (Adam Ford)
Date: Sun, 24 Jun 2018 19:12:29 -0500
Subject: [RFC 1/5] usb: musb: am35x: Add device tree support
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Message-ID: <20180625001233.9785-2-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AM35x glue doesn't yet support device tree, so this patch
adds the basics hooks so it doesn't haven't use pdata-quirks.c

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 660641ab1545..a55db15a8457 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -591,6 +591,16 @@ static int am35x_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id am35xx_id_table[] = {
+	{
+		.compatible = "ti,am35xx-musb"
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, am35xx_id_table);
+#endif
+
 static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
 
 static struct platform_driver am35x_driver = {
@@ -599,6 +609,7 @@ static struct platform_driver am35x_driver = {
 	.driver		= {
 		.name	= "musb-am35x",
 		.pm	= &am35x_pm_ops,
+		.of_match_table = of_match_ptr(am35xx_id_table),
 	},
 };
 
-- 
2.17.1

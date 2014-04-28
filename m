From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 28 Apr 2014 16:58:45 +0200
Subject: [PATCH 2/7] reset: sunxi: allow MFD subdevices probe
In-Reply-To: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398697130-8338-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation uses sunxi_reset_init function for both early
init and platform device probe.

The sunxi_reset_init function uses DT to retrieve device resources, which
will be an issue if reset controllers are registered from an MFD device
that define resources from mfd_cell definition.

Moreover, we can make use of devm functions when we're in probe context.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/reset/reset-sunxi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 695bd34..115fbb1 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -145,7 +145,24 @@ MODULE_DEVICE_TABLE(of, sunxi_reset_dt_ids);
 
 static int sunxi_reset_probe(struct platform_device *pdev)
 {
-	return sunxi_reset_init(pdev->dev.of_node);
+	struct sunxi_reset_data *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->membase = devm_request_and_ioremap(&pdev->dev, res);
+	if (!data->membase)
+		return -ENOMEM;
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = resource_size(res) * 32;
+	data->rcdev.ops = &sunxi_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return reset_controller_register(&data->rcdev);
 }
 
 static int sunxi_reset_remove(struct platform_device *pdev)
-- 
1.8.3.2

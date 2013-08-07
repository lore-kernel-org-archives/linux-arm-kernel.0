From: b35083@freescale.com (Jingchang Lu)
Date: Wed, 7 Aug 2013 17:05:38 +0800
Subject: [PATCH 3/8] i2c: imx: don't change platform device id_entry directly
In-Reply-To: <1375866343-2074-1-git-send-email-b35083@freescale.com>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Message-ID: <1375866343-2074-3-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The id_entry field should be changed by platform driver core,
driver should prevent changing it derectly. Use local variable
to save and extract platform_device_id info of the dts devices
instead.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 7adb351..cbea84b 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -499,6 +499,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx;
 	struct resource *res;
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
+	const struct platform_device_id *imx_id;
 	void __iomem *base;
 	int irq, ret;
 	u32 bitrate;
@@ -524,8 +525,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	if (of_id)
-		pdev->id_entry = of_id->data;
-	i2c_imx->devtype = pdev->id_entry->driver_data;
+		imx_id = of_id->data;
+	else
+		imx_id = platform_get_device_id(pdev);
+
+	i2c_imx->devtype = imx_id->driver_data;
 
 	/* Setup i2c_imx driver structure */
 	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.name));
-- 
1.8.0

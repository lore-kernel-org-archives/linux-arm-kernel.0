From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 21 Jan 2015 16:53:08 +0100
Subject: [PATCH 1/3] spi/xilinx: Use automatic bus number on device tree
In-Reply-To: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1421855590-9210-2-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is more than one spi device on a device tree, the second one
will fail to probe due to a duplicated bus_num.

This patch uses automatic bus number if the device is deined on a device
tree.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 79bd84f..2ea4ca5 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -332,14 +332,17 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	u32 tmp;
 	u8 i;
+	s16 bus_num;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
+		bus_num = pdev->id;
 	} else {
 		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
 					  &num_cs);
+		bus_num = -1;
 	}
 
 	if (!num_cs) {
@@ -369,7 +372,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
-	master->bus_num = pdev->id;
+	master->bus_num = bus_num;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
 
-- 
2.1.4

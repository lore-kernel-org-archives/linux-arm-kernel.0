From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 20:53:39 +0100
Subject: [PATCH] spi/xilinx: Check number of slaves range
Message-ID: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

The core only supports up to 32 slaves, and the chipselect function
expects the same.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---

v2: Change suggested by Mark Brown
-Namespace the constant

 drivers/spi/spi-xilinx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 416b227..354dbb4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -22,6 +22,8 @@
 #include <linux/spi/xilinx_spi.h>
 #include <linux/io.h>
 
+#define XILINX_SPI_MAX_CS	32
+
 #define XILINX_SPI_NAME "xilinx_spi"
 
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
@@ -354,6 +356,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (num_cs > XILINX_SPI_MAX_CS) {
+		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		return -EINVAL;
+	}
+
 	master = spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
 	if (!master)
 		return -ENODEV;
-- 
2.1.4

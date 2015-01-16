From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 16 Jan 2015 13:55:14 +0100
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
Message-ID: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use standard num-cs binding property and setup
"xlnx,num-ss-bits" as deprecated.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 79bd84f43430..30e5180195bb 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -338,8 +338,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
+		if (of_property_read_u32(pdev->dev.of_node, "num-cs",
+					 &num_cs)) {
+			if (!of_property_read_u32(pdev->dev.of_node,
+						  "xlnx,num-ss-bits",
+						  &num_cs)) {
+				dev_err(&pdev->dev,
+					"property name 'xlnx,num-ss-bits' is deprecated.\n");
+			}
+		}
 	}

 	if (!num_cs) {
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/9091f481/attachment.sig>

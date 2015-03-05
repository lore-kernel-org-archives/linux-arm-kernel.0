From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  5 Mar 2015 14:10:30 +0100
Subject: [RESENT PATCH] spi: xilinx: Use standard num-cs binding
Message-ID: <1777fd49a103237c7ac0ebca434b33509e1b843f.1425561027.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use standard num-cs binding property and setup
"xlnx,num-ss-bits" as deprecated.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 133f53a9c1d4..69313407b690 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -374,8 +374,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
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

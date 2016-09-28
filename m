From: atull@opensource.altera.com (Alan Tull)
Date: Wed, 28 Sep 2016 13:21:54 -0500
Subject: [PATCH v19 06/12] fpga: add fpga image information struct for socfpga
 support
In-Reply-To: <20160928182200.15800-1-atull@opensource.altera.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
Message-ID: <20160928182200.15800-7-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor changes to the Altera SoCFPGA FPGA Manager support driver
due to FPGA Manager framework API changes for the new fpga
image information struct.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
v19: Added in v19 of this patchset
---
 drivers/fpga/socfpga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 27d2ff2..b6672e6 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -407,13 +407,14 @@ static int socfpga_fpga_reset(struct fpga_manager *mgr)
 /*
  * Prepare the FPGA to receive the configuration data.
  */
-static int socfpga_fpga_ops_configure_init(struct fpga_manager *mgr, u32 flags,
+static int socfpga_fpga_ops_configure_init(struct fpga_manager *mgr,
+					   struct fpga_image_info *info,
 					   const char *buf, size_t count)
 {
 	struct socfpga_fpga_priv *priv = mgr->priv;
 	int ret;
 
-	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
 		return -EINVAL;
 	}
@@ -478,7 +479,7 @@ static int socfpga_fpga_ops_configure_write(struct fpga_manager *mgr,
 }
 
 static int socfpga_fpga_ops_configure_complete(struct fpga_manager *mgr,
-					       u32 flags)
+					       struct fpga_image_info *info)
 {
 	struct socfpga_fpga_priv *priv = mgr->priv;
 	u32 status;
-- 
2.9.3

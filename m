From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 13 Nov 2018 10:06:14 -0600
Subject: [RESEND 4/4] net: stmmac: socfpga: Convert to shared System Manager
 driver
In-Reply-To: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1542125174-8204-5-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The ARM64 System Manager requires a different method of reading
the System Manager than ARM32. A new System Manager driver was
created to steer ARM32 System Manager calls to syscon and ARM64
System Manager calls to the new access method.

Convert from syscon to the shared System Manager driver so that
both ARM64 and ARM32 are supported.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a0a3bf..743c7f471edb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -15,6 +15,7 @@
  * Adopted from dwmac-sti.c
  */
 
+#include <linux/mfd/altera-sysmgr.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -114,7 +115,8 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 	dwmac->interface = of_get_phy_mode(np);
 
-	sys_mgr_base_addr = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	sys_mgr_base_addr =
+		altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
 	if (IS_ERR(sys_mgr_base_addr)) {
 		dev_info(dev, "No sysmgr-syscon node found\n");
 		return PTR_ERR(sys_mgr_base_addr);
-- 
2.7.4

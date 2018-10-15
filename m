From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 15 Oct 2018 10:59:43 +0530
Subject: [PATCH v9 1/6] edac: synopsys: Add error handling for NULL in probe()
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1539581388-23963-2-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function of_device_get_match_data() can return NULL in case of
error. Add error handling for the same in probe().

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1c3795d..0005ef3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -477,6 +477,9 @@ static int mc_probe(struct platform_device *pdev)
 		return PTR_ERR(baseaddr);
 
 	p_data = of_device_get_match_data(&pdev->dev);
+	if (!p_data)
+		return -ENODEV;
+
 	if (!p_data->get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
-- 
2.1.1

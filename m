From: jcd@tribudubois.net (Jean-Christophe Dubois)
Date: Sat, 30 Jun 2018 22:54:04 +0200
Subject: [PATCH] i.MX6: Allow thermal probe to fail gracefully in case of bad
 calibration.
Message-ID: <20180630205404.25568-1-jcd@tribudubois.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this fix, the thermal probe on i.MX6 might trigger a division
by zero exception later in the probe if the calibration does fail.

Note: This linux behavior (Division by zero in kernel) has been triggered
on a Qemu i.MX6 emulation where parameters in nvmem were not set. With this
fix the division by zero is not triggeed anymore as the thermal probe does
fail early.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 drivers/thermal/imx_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 334d98be03b9..b1f82d64253e 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -604,7 +604,10 @@ static int imx_init_from_nvmem_cells(struct platform_device *pdev)
 	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
 	if (ret)
 		return ret;
-	imx_init_calib(pdev, val);
+
+	ret = imx_init_calib(pdev, val);
+	if (ret)
+		return ret;
 
 	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
 	if (ret)
-- 
2.17.1

From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 23 May 2014 16:41:28 +0800
Subject: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
Message-ID: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
and clk_get_rate(), which might sleep, so we need to set can_sleep flag
on pwm_chip.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes since v1:
 - Set can_sleep flag for both imx_pwm_v1 and imx_pwm_v2

 drivers/pwm/pwm-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d797c7b84c3f..5449d9150d40 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -262,6 +262,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
+	imx->chip.can_sleep = true;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
-- 
1.8.3.2

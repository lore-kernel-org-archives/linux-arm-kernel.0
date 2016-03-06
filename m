From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun,  6 Mar 2016 03:21:46 +0200
Subject: [PATCH] pwm: bcm7038: fix check of error code returned by
 devm_ioremap_resource()
Message-ID: <1457227306-3142-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change fixes potential oops while accessing iomem on invalid
address, if devm_ioremap_resource() fails due to some reason.

The devm_ioremap_resource() function returns ERR_PTR() and never
returns NULL, which makes useless a following check for NULL.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
---
 drivers/pwm/pwm-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 423ce08..5d5adee 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -274,8 +274,8 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!p->base) {
-		ret = -ENOMEM;
+	if (IS_ERR(p->base)) {
+		ret = PTR_ERR(p->base);
 		goto out_clk;
 	}
 
-- 
2.1.4

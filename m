From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 18:08:52 +0100
Subject: [PATCH 8/10] phy: phy-stih407-usb: Inform the reset framework that
 our reset line may be shared
In-Reply-To: <20160606155655.10860-8-lee.jones@linaro.org>
References: <20160606155655.10860-8-lee.jones@linaro.org>
Message-ID: <20160606170854.12407-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the STiH410 B2120 development board the ports on the Generic PHY
share their reset lines with each other.  New functionality in the
reset subsystems forces consumers to be explicit when requesting
shared/exclusive reset lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/phy/phy-stih407-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-stih407-usb.c b/drivers/phy/phy-stih407-usb.c
index 1d5ae5f..b1f44ab 100644
--- a/drivers/phy/phy-stih407-usb.c
+++ b/drivers/phy/phy-stih407-usb.c
@@ -105,13 +105,13 @@ static int stih407_usb2_picophy_probe(struct platform_device *pdev)
 	phy_dev->dev = dev;
 	dev_set_drvdata(dev, phy_dev);
 
-	phy_dev->rstc = devm_reset_control_get(dev, "global");
+	phy_dev->rstc = devm_reset_control_get_shared(dev, "global");
 	if (IS_ERR(phy_dev->rstc)) {
 		dev_err(dev, "failed to ctrl picoPHY reset\n");
 		return PTR_ERR(phy_dev->rstc);
 	}
 
-	phy_dev->rstport = devm_reset_control_get(dev, "port");
+	phy_dev->rstport = devm_reset_control_get_exclusive(dev, "port");
 	if (IS_ERR(phy_dev->rstport)) {
 		dev_err(dev, "failed to ctrl picoPHY reset\n");
 		return PTR_ERR(phy_dev->rstport);
-- 
2.8.3

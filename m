From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 21:45:22 +0800
Subject: [PATCH v2 3/5] net: fec: use managed function devm_gpio_request_one
In-Reply-To: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
References: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340804724-29410-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using gpio_request_one will require the probe fail-out call gpio_free,
which is missing currently.  Change to use devm_gpio_request_one to
fix the problem.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/net/ethernet/freescale/fec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index 4dce9e3..f174070 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -1513,7 +1513,8 @@ static void __devinit fec_reset_phy(struct platform_device *pdev)
 		return;
 
 	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
-	err = gpio_request_one(phy_reset, GPIOF_OUT_INIT_LOW, "phy-reset");
+	err = devm_gpio_request_one(&pdev->dev, phy_reset,
+				    GPIOF_OUT_INIT_LOW, "phy-reset");
 	if (err) {
 		pr_debug("FEC: failed to get gpio phy-reset: %d\n", err);
 		return;
-- 
1.7.5.4

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:48 +0200
Subject: [PATCH V3 05/19] mmc: mmci: Add DT bindings for feedback clock pin
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ST Micro variant supports the option of using a feedback clock signal in
favor of the clockout pin when latching incoming signals on the data bus.

Since this is matter of how pins are being routed we need to provide a new DT
binding to be able to configure this through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |    2 ++
 drivers/mmc/host/mmci.c                        |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 9bd2ffa..2c8756f 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -24,6 +24,7 @@ Optional properties:
 - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
 - st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to DAT[7].
 - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
+- st,sig-pin-fbclk       : feedback clock signal pin used.
 
 Example:
 
@@ -47,6 +48,7 @@ sdi0_per1 at 80126000 {
 	st,sig-dir-dat0;
 	st,sig-dir-dat2;
 	st,sig-dir-cmd;
+	st,sig-pin-fbclk;
 
 	vmmc-supply = <&ab8500_ldo_aux3_reg>;
 	vqmmc-supply = <&vmmci>;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2766e5c..173e7de 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1402,6 +1402,8 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 		pdata->sigdir |= MCI_ST_DATA74DIREN;
 	if (of_get_property(np, "st,sig-dir-cmd", NULL))
 		pdata->sigdir |= MCI_ST_CMDDIREN;
+	if (of_get_property(np, "st,sig-pin-fbclk", NULL))
+		pdata->sigdir |= MCI_ST_FBCLKEN;
 
 	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
 	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
-- 
1.7.9.5

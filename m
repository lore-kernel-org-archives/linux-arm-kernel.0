From: b29396@freescale.com (Dong Aisheng)
Date: Sat, 14 Apr 2012 00:18:35 +0800
Subject: [PATCH 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <1334333915-1174-1-git-send-email-b29396@freescale.com>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
Message-ID: <1334333915-1174-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

---
This patch is used for test the new pinctrl driver.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx6q-arm2.dts   |    4 +++
 arch/arm/boot/dts/imx6q.dtsi       |   40 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 ++++++++++
 3 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..ee2ee98 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -44,10 +44,14 @@
 				fsl,card-wired;
 				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc4_1>;
 			};
 
 			uart4: uart at 021f0000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart4_1>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 4905f51..5f3505c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -386,7 +386,47 @@
 			};
 
 			iomuxc at 020e0000 {
+				compatible = "fsl,imx6q-iomuxc";
 				reg = <0x020e0000 0x4000>;
+
+				/* shared pinctrl settings */
+				uart4 {
+					pinctrl_uart4_1: uart4grp-1 {
+						fsl,pins =	"MX6Q_PAD_KEY_COL0",
+								"MX6Q_PAD_KEY_ROW0";
+						fsl,mux = <4 4>;
+						fsl,pull = <2>;
+						fsl,pue = <1>;
+						fsl,pke = <1>;
+						fsl,speed = <2>;
+						fsl,drive-strength = <6>;
+						fsl,slew-rate = <1>;
+						fsl,hysteresis = <1>;
+					};
+				};
+
+				usdhc4 {
+					pinctrl_usdhc4_1: usdhc4grp-1 {
+						fsl,pins =	"MX6Q_PAD_SD4_CMD",
+								"MX6Q_PAD_SD4_CLK",
+								"MX6Q_PAD_SD4_DAT0",
+								"MX6Q_PAD_SD4_DAT1",
+								"MX6Q_PAD_SD4_DAT2",
+								"MX6Q_PAD_SD4_DAT3",
+								"MX6Q_PAD_SD4_DAT4",
+								"MX6Q_PAD_SD4_DAT5",
+								"MX6Q_PAD_SD4_DAT6",
+								"MX6Q_PAD_SD4_DAT7";
+						fsl,mux = <0 0 1 1 1 1 1 1 1 1>;
+						fsl,pull = <1>;
+						fsl,pue = <1>;
+						fsl,pke = <1>;
+						fsl,speed = <1>;
+						fsl,drive-strength = <3>;
+						fsl,slew-rate = <1>;
+						fsl,hysteresis = <1>;
+					};
+				};
 			};
 
 			dcic at 020e4000 { /* DCIC1 */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6193a0d..84ef749 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <mach/esdhc.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -68,6 +69,7 @@ struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
 	enum imx_esdhc_type devtype;
+	struct pinctrl *p;
 	struct esdhc_platform_data boarddata;
 };
 
@@ -467,6 +469,12 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
+	imx_data->p = pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(imx_data->p)) {
+		err = PTR_ERR(imx_data->p);
+		goto pin_err;
+	}
+
 	if (!is_imx25_esdhc(imx_data))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
@@ -559,6 +567,8 @@ no_card_detect_irq:
 		gpio_free(boarddata->wp_gpio);
 no_card_detect_pin:
 no_board_data:
+	pinctrl_put(imx_data->p);
+pin_err:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
@@ -586,6 +596,8 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 		gpio_free(boarddata->cd_gpio);
 	}
 
+	pinctrl_put(imx_data->p);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 	kfree(imx_data);
-- 
1.7.0.4

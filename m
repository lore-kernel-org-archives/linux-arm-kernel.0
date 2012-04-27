From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:03:02 +0800
Subject: [PATCH 08/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-9-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
 arch/arm/boot/dts/imx6q.dtsi          |   10 ++++++++++
 sound/soc/fsl/imx-audmux.c            |    8 ++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 02f93bc..cdae2dd 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -54,7 +54,10 @@
 
 			audmux at 021d8000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_audmux_1>;
 			};
+
 			uart2: uart at 021e8000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 7bf402e..3c3004d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -402,6 +402,16 @@
 				reg = <0x020e0000 0x4000>;
 
 				/* shared pinctrl settings */
+				audmux {
+					pinctrl_audmux_1: audmux-1 {
+						fsl,pins =	"MX6Q_PAD_SD2_DAT0",
+								"MX6Q_PAD_SD2_DAT3",
+								"MX6Q_PAD_SD2_DAT2",
+								"MX6Q_PAD_SD2_DAT1";
+						fsl,mux = <3 3 3 3>;
+					};
+				};
+
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
 						fsl,pins =	"MX6Q_PAD_EIM_D21",
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index f237003..6c7dfc0 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -26,6 +26,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "imx-audmux.h"
 
@@ -249,6 +250,7 @@ EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 static int __devinit imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct pinctrl *pct;
 	const struct of_device_id *of_id =
 			of_match_device(imx_audmux_dt_ids, &pdev->dev);
 
@@ -257,6 +259,12 @@ static int __devinit imx_audmux_probe(struct platform_device *pdev)
 	if (!audmux_base)
 		return -EADDRNOTAVAIL;
 
+	pct = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pct)) {
+		dev_err(&pdev->dev, "setup pinctrl failed!");
+		return PTR_ERR(pct);
+	}
+
 	audmux_clk = clk_get(&pdev->dev, "audmux");
 	if (IS_ERR(audmux_clk)) {
 		dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
-- 
1.7.5.4

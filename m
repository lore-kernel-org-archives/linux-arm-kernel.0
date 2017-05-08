From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:16 +0200
Subject: [PATCH 7/8] arm64: dts: hi6220: Move board data from the dwmmc nodes
 to hikey dts
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the board specific descriptions for the dwmmc nodes in the hi6220 SoC
dtsi, into the hikey dts as it's there these belongs.

While changing this, let's take the opportunity to drop the use of the
"ti,non-removable" binding for one of the dwmmc device nodes, as it's not a
valid binding and not used. Drop also the unnecessary use of "num-slots =
<0x1>" for all of the dwmmc nodes, as there is no need to set this since
when default number of slots is one.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 23 ++++++++++++++++++++++-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 19 -------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 6dab03a..d4b3879 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -281,8 +281,29 @@
 
 		/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
 
+		dwmmc_0: dwmmc0 at f723d000 {
+			cap-mmc-highspeed;
+			non-removable;
+			bus-width = <0x8>;
+			vmmc-supply = <&ldo19>;
+		};
+
+		dwmmc_1: dwmmc1 at f723e000 {
+			card-detect-delay = <200>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			vqmmc-supply = <&ldo7>;
+			vmmc-supply = <&ldo10>;
+			bus-width = <0x4>;
+			disable-wp;
+			cd-gpios = <&gpio1 0 1>;
+		};
+
 		dwmmc_2: dwmmc2 at f723f000 {
-			ti,non-removable;
+			broken-cd;
+			bus-width = <0x4>;
 			non-removable;
 			/* WL_EN */
 			vmmc-supply = <&wlan_en_reg>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 951152d..5013e4b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -756,17 +756,12 @@
 
 		dwmmc_0: dwmmc0 at f723d000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
-			num-slots = <0x1>;
-			cap-mmc-highspeed;
-			non-removable;
 			reg = <0x0 0xf723d000 0x0 0x1000>;
 			interrupts = <0x0 0x48 0x4>;
 			clocks = <&sys_ctrl 2>, <&sys_ctrl 1>;
 			clock-names = "ciu", "biu";
 			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC0>;
 			reset-names = "reset";
-			bus-width = <0x8>;
-			vmmc-supply = <&ldo19>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&emmc_pmx_func &emmc_clk_cfg_func
 				     &emmc_cfg_func &emmc_rst_cfg_func>;
@@ -774,13 +769,7 @@
 
 		dwmmc_1: dwmmc1 at f723e000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
-			num-slots = <0x1>;
-			card-detect-delay = <200>;
 			hisilicon,peripheral-syscon = <&ao_ctrl>;
-			cap-sd-highspeed;
-			sd-uhs-sdr12;
-			sd-uhs-sdr25;
-			sd-uhs-sdr50;
 			reg = <0x0 0xf723e000 0x0 0x1000>;
 			interrupts = <0x0 0x49 0x4>;
 			#address-cells = <0x1>;
@@ -789,11 +778,6 @@
 			clock-names = "ciu", "biu";
 			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC1>;
 			reset-names = "reset";
-			vqmmc-supply = <&ldo7>;
-			vmmc-supply = <&ldo10>;
-			bus-width = <0x4>;
-			disable-wp;
-			cd-gpios = <&gpio1 0 1>;
 			pinctrl-names = "default", "idle";
 			pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
 			pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
@@ -801,15 +785,12 @@
 
 		dwmmc_2: dwmmc2 at f723f000 {
 			compatible = "hisilicon,hi6220-dw-mshc";
-			num-slots = <0x1>;
 			reg = <0x0 0xf723f000 0x0 0x1000>;
 			interrupts = <0x0 0x4a 0x4>;
 			clocks = <&sys_ctrl HI6220_MMC2_CIUCLK>, <&sys_ctrl HI6220_MMC2_CLK>;
 			clock-names = "ciu", "biu";
 			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC2>;
 			reset-names = "reset";
-			bus-width = <0x4>;
-			broken-cd;
 			pinctrl-names = "default", "idle";
 			pinctrl-0 = <&sdio_pmx_func &sdio_clk_cfg_func &sdio_cfg_func>;
 			pinctrl-1 = <&sdio_pmx_idle &sdio_clk_cfg_idle &sdio_cfg_idle>;
-- 
2.7.4

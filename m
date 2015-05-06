From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  6 May 2015 11:39:39 -0300
Subject: [PATCH] ARM: dts: cubox-i: add support for Broadcom Wifi/Bluetooth
 devices
Message-ID: <1430923179-25448-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add DT support for the Broadcom Wifi/Bluetooth devices found on the
microsom board.

[Modified original Russell King's patch to use mmc-pwrseq]

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-microsom.dtsi | 106 ++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
index 349f82b..f37d2e5 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -39,15 +39,101 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		reg_brcm_osc: brcm-osc-reg {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio5 5 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_microsom_brcm_osc_reg>;
+			regulator-name = "brcm_osc_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		reg_brcm: brcm-reg {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio3 19 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_microsom_brcm_reg>;
+			regulator-name = "brcm_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			startup-delay-us = <200000>;
+		};
+	};
+
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>,
+			      <&gpio6 0 GPIO_ACTIVE_LOW>;
+	};
+};
 
 &iomuxc {
 	microsom {
+		pinctrl_microsom_brcm_bt: microsom-brcm-bt {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x40013070
+				MX6QDL_PAD_CSI0_DAT15__GPIO6_IO01	0x40013070
+				MX6QDL_PAD_CSI0_DAT18__GPIO6_IO04	0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_osc_reg: microsom-brcm-osc-reg {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05	0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_reg: microsom-brcm-reg {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x40013070
+			>;
+		};
+
+		pinctrl_microsom_brcm_wifi: microsom-brcm-wifi {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__XTALOSC_REF_CLK_32K	0x1b0b0
+				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x40013070
+				MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26	0x40013070
+				MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27	0x40013070
+			>;
+		};
+
 		pinctrl_microsom_uart1: microsom-uart1 {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
 				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
 			>;
 		};
+
+		pinctrl_microsom_uart4: microsom-uart4 {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
+			>;
+		};
+
+		pinctrl_microsom_usdhc1: microsom-usdhc1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+			>;
+		};
 	};
 };
 
@@ -56,3 +142,23 @@
 	pinctrl-0 = <&pinctrl_microsom_uart1>;
 	status = "okay";
 };
+
+/* UART4 - Connected to optional BRCM Wifi/BT/FM */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_brcm_bt &pinctrl_microsom_uart4>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+/* USDHC1 - Connected to optional BRCM Wifi/BT/FM */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_microsom_brcm_wifi &pinctrl_microsom_usdhc1>;
+	bus-width = <4>;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	keep-power-in-suspend;
+	non-removable;
+	vmmc-supply = <&reg_brcm>;
+	status = "okay";
+};
-- 
1.9.1

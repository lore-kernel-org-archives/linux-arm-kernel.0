From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 13:36:24 +0800
Subject: [PATCH v2 4/7] ARM: mxs: convert apx4devkit board to device tree
In-Reply-To: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341898587-8462-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/apx4devkit.dts |  143 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi     |   33 +++++++++
 arch/arm/mach-mxs/mach-mxs.c     |   20 +++++
 3 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/apx4devkit.dts

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
new file mode 100644
index 0000000..a670a90
--- /dev/null
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -0,0 +1,143 @@
+/dts-v1/;
+/include/ "imx28.dtsi"
+
+/ {
+	model = "Bluegiga APX4 Development Kit";
+	compatible = "bluegiga,apx4devkit", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x04000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					     &mmc0_cd_cfg
+					     &mmc0_sck_cfg>;
+				bus-width = <8>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			saif0: saif at 80042000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif0_pins_a>;
+				status = "okay";
+			};
+
+			saif1: saif at 80046000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif1_pins_a>;
+				fsl,saif-master = <&saif0>;
+				status = "okay";
+			};
+
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				sgtl5000: codec at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_3p3v>;
+					VDDIO-supply = <&reg_3p3v>;
+
+				};
+
+				pcf8563: rtc at 51 {
+					compatible = "phg,pcf8563";
+					reg = <0x51>;
+				};
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+				status = "okay";
+			};
+
+			auart1: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart1_2pins_a>;
+				status = "okay";
+			};
+
+			auart2: serial at 8006e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart2_2pins_a>;
+				status = "okay";
+			};
+
+			auart3: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart3_2pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx28-evk-sgtl5000",
+			     "fsl,mxs-audio-sgtl5000";
+		model = "imx28-evk-sgtl5000";
+		saif-controllers = <&saif0 &saif1>;
+		audio-codec = <&sgtl5000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio3 28 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 895a072..8595977 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -243,6 +243,28 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart1_2pins_a: auart1-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3040 /* MX28_PAD_AUART1_RX__AUART1_RX */
+						0x3050 /* MX28_PAD_AUART1_TX__AUART1_TX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				auart2_2pins_a: auart2-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2101 /* MX28_PAD_SSP2_SCK__AUART2_RX */
+						0x2111 /* MX28_PAD_SSP2_MOSI__AUART2_TX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -256,6 +278,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart3_2pins_a: auart3-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2121 /* MX28_PAD_SSP2_MISO__AUART3_RX */
+						0x2131 /* MX28_PAD_SSP2_SS0__AUART3_TX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index d3fc8ba..d0bf414 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -16,9 +16,11 @@
 #include <linux/init.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
+#include <linux/micrel_phy.h>
 #include <linux/mxsfb.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -233,6 +235,21 @@ static void __init m28evk_init(void)
 	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
 }
 
+static int apx4devkit_phy_fixup(struct phy_device *phy)
+{
+	phy->dev_flags |= MICREL_PHY_50MHZ_CLK;
+	return 0;
+}
+
+static void __init apx4devkit_init(void)
+{
+	enable_clk_enet_out();
+
+	if (IS_BUILTIN(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
+					   apx4devkit_phy_fixup);
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
@@ -241,6 +258,8 @@ static void __init mxs_machine_init(void)
 		imx23_evk_init();
 	else if (of_machine_is_compatible("denx,m28evk"))
 		m28evk_init();
+	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
+		apx4devkit_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
@@ -254,6 +273,7 @@ static const char *imx23_dt_compat[] __initdata = {
 };
 
 static const char *imx28_dt_compat[] __initdata = {
+	"bluegiga,apx4devkit",
 	"crystalfontz,cfa10036",
 	"denx,m28evk",
 	"fsl,imx28-evk",
-- 
1.7.5.4

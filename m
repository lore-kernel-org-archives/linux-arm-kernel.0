From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:24 +1030
Subject: [PATCH v3 16/20] ARM: dts: aspeed: Add Ingrasys Zaius BMC machine
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-17-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xo Wang <xow@google.com>

Zaius is a POWER9 platform announced at OpenPOWER Summit 2016. This adds
basic DTS support for its AST2500 BMC.

This adds the device tree description for most upstream components. It
is a squashed commit of all of the patches from the OpenBMC kernel tree.

Signed-off-by: Xo Wang <xow@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Peter Hanson <peterh@google.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Rick Altherr <raltherr@google.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 v3:
  - Add GPIO include
  - Add unit name for memory node to fix warning
---
 arch/arm/boot/dts/Makefile                 |   4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 426 +++++++++++++++++++++++++++++
 2 files changed, 428 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 15a9207319c1..48c55f307aa9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1105,6 +1105,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
 	aspeed-bmc-opp-romulus.dtb \
-	aspeed-bmc-opp-witherspoon.dtb
-
+	aspeed-bmc-opp-witherspoon.dtb \
+	aspeed-bmc-opp-zaius.dtb
 endif
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
new file mode 100644
index 000000000000..c881484a85cf
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Zaius BMC";
+	compatible = "ingrasys,zaius-bmc", "aspeed,ast2500";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory at 80000000 {
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flash_memory: region at 98000000 {
+			no-map;
+			reg = <0x98000000 0x04000000>; /* 64M */
+		};
+	};
+
+	onewire0 {
+		compatible = "w1-gpio";
+		gpios = <&gpio ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
+	};
+
+	onewire1 {
+		compatible = "w1-gpio";
+		gpios = <&gpio ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+	};
+
+	onewire2 {
+		compatible = "w1-gpio";
+		gpios = <&gpio ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+	};
+
+	onewire3 {
+		compatible = "w1-gpio";
+		gpios = <&gpio ASPEED_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		checkstop {
+			label = "checkstop";
+			gpios = <&gpio ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 7)>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		sys_boot_status {
+			label = "System boot status";
+			gpios = <&gpio ASPEED_GPIO(D, 5) GPIO_ACTIVE_LOW>;
+		};
+
+		attention {
+			label = "Attention";
+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
+		};
+
+		plt_fault {
+			label = "Platform fault";
+			gpios = <&gpio ASPEED_GPIO(D, 7) GPIO_ACTIVE_LOW>;
+		};
+
+		hdd_fault {
+			label = "Onboard drive fault";
+			gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	fsi: gpio-fsi {
+		compatible = "fsi-master-gpio", "fsi-master";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		trans-gpios = <&gpio ASPEED_GPIO(O, 6) GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
+		clock-gpios = <&gpio ASPEED_GPIO(G, 0) GPIO_ACTIVE_HIGH>;
+		data-gpios = <&gpio ASPEED_GPIO(G, 1) GPIO_ACTIVE_HIGH>;
+		mux-gpios = <&gpio ASPEED_GPIO(P, 6) GPIO_ACTIVE_HIGH>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+			<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+			<&adc 13>, <&adc 14>, <&adc 15>;
+	};
+
+	iio-hwmon-battery {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 12>;
+	};
+
+};
+
+&fmc {
+	status = "okay";
+
+	flash at 0 {
+		status = "okay";
+		label = "bmc";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash at 0 {
+		status = "okay";
+		label = "pnor";
+		m25p,fast-read;
+	};
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2ck_default
+		     &pinctrl_spi2cs0_default
+		     &pinctrl_spi2cs1_default
+		     &pinctrl_spi2miso_default
+		     &pinctrl_spi2mosi_default>;
+
+	flash at 0 {
+		status = "okay";
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi1>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+
+&uart5 {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&mac1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+
+	ucd90160 at 64 {
+		compatible = "ti,ucd90160";
+		reg = <0x64>;
+	};
+
+	/* Power sequencer UCD90160 PMBUS @64h
+	 * FRU AT24C64D @50h
+	 * RTC PCF8523 @68h
+	 * Clock buffer 9DBL04 @6dh
+	 */
+};
+
+&i2c1 {
+	status = "okay";
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	/* MUX1 PCA9546A @71h
+	 *   PCIe 0
+	 *   PCIe 1
+	 *   PCIe 2
+	 *   TPM header
+	 */
+};
+
+&i2c2 {
+	status = "disabled";
+
+	/* OCP Mezz Connector A (OOB SMBUS) */
+};
+
+&i2c3 {
+	status = "disabled";
+
+	/* OCP Mezz Connector A (PCIe slot SMBUS) */
+};
+
+&i2c4 {
+	status = "okay";
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	/* MUX1 PCA9546A @71h
+	 *   PCIe 3
+	 *   PCIe 4
+	 */
+};
+
+
+&i2c5 {
+	status = "disabled";
+
+	/* CPU0 PRM 0.7V */
+	/* CPU0 PRM 1.2V CH03 */
+	/* CPU0 PRM 0.8V */
+	/* CPU0 PRM 1.2V CH47 */
+};
+
+&i2c6 {
+	status = "disabled";
+
+	/* CPU1 PRM 0.7V */
+	/* CPU1 PRM 1.2V CH03 */
+	/* CPU1 PRM 0.8V */
+	/* CPU1 PRM 1.2V CH47 */
+};
+
+&i2c7 {
+	status = "okay";
+
+	pca9541a at 70 {
+		compatible = "nxp,pca9541";
+		reg = <0x70>;
+
+		i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hotswap at 54 {
+				compatible = "ti,lm5066i";
+				reg = <0x54>;
+			};
+		};
+	};
+
+	/* Master selector PCA9541A @70h (other master: CPU0)
+	 *   LM5066I PMBUS @10h
+	 */
+
+	/* 12V Quarter Brick DC/DC Converter Q54SJ12050 @61h */
+	power-brick at 61 {
+		compatible = "delta,dps800";
+		reg = <0x61>;
+	};
+
+	/* CPU0 VR ISL68137 0.7V, 0.96V PMBUS @64h */
+	/* CPU0 VR ISL68137 1.2V CH03 PMBUS @40h */
+	/* CPU0 VR ISL68137 0.8V PMBUS @60h */
+	/* CPU0 VR 1.0V IR38064 I2C @11h, PMBUS @41h */
+	/* CPU0 VR ISL68137 1.2V CH47 PMBUS @41h */
+};
+
+&i2c8 {
+	status = "okay";
+
+	/* CPU1 VR ISL68137 0.7V, 0.96V PMBUS @65h */
+	/* CPU1 VR ISL68137 1.2V CH03 PMBUS @44h */
+	/* CPU1 VR ISL68137 0.8V PMBUS @61h */
+	/* CPU1 VR 1.0V IR38064 I2C @12h, PMBUS @42h */
+	/* CPU0 VR ISL68137 1.2V CH47 PMBUS @45h */
+};
+
+
+&i2c9 {
+	status = "disabled";
+
+	/* Fan board */
+};
+
+&i2c10 {
+	status = "disabled";
+};
+
+&i2c11 {
+	status = "disabled";
+
+	/* GPU sideband */
+};
+
+&i2c12 {
+	status = "disabled";
+};
+
+&i2c13 {
+	status = "disabled";
+
+	/* MUX PI3USB102
+	 *   CPU0 debug
+	 *   CPU1 debug
+	 */
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+
+	pinctrl_gpioh_unbiased: gpioi_unbiased {
+		pins = "A8", "C7", "B7", "A7", "D7", "B6", "A6", "E7";
+		bias-disable;
+	};
+};
+
+&gpio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpioh_unbiased>;
+
+	line_iso_u146_en {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "iso_u164_en";
+	};
+
+	ncsi_mux_en_n {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "ncsi_mux_en_n";
+	};
+
+	line_bmc_i2c2_sw_rst_n {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "bmc_i2c2_sw_rst_n";
+	};
+
+	line_bmc_i2c5_sw_rst_n {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "bmc_i2c5_sw_rst_n";
+	};
+};
+
+&vuart {
+	status = "okay";
+};
+
+&gfx {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default
+		&pinctrl_pwm2_default &pinctrl_pwm3_default>;
+
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan at 1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan at 2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan at 3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+};
-- 
2.15.1

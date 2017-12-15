From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:41 +1030
Subject: [PATCH v2 17/19] ARM: dts: aspeed: Add Qanta Q71L BMC machine
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-18-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rick Altherr <raltherr@google.com>

The Qanta Q71L BMC is an ASPEED ast2400 based BMC that is part of a
Qanta x86 server.

This adds the device tree description for most upstream components. It
is a squashed commit from the OpenBMC kernel tree.

Signed-off-by: Peter Hanson <peterh@google.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Patrick Venture <venture@google.com>
Signed-off-by: Rick Altherr <raltherr@google.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/Makefile                   |   3 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 458 +++++++++++++++++++++++++++
 2 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 48c55f307aa9..5ab5d9169511 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1106,5 +1106,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-palmetto.dtb \
 	aspeed-bmc-opp-romulus.dtb \
 	aspeed-bmc-opp-witherspoon.dtb \
-	aspeed-bmc-opp-zaius.dtb
+	aspeed-bmc-opp-zaius.dtb \
+	aspeed-bmc-quanta-q71l.dtb
 endif
diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
new file mode 100644
index 000000000000..2f40bab63149
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+
+/ {
+	model = "Quanta Q71L BMC";
+	compatible = "quanta,q71l-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x40000000 0x8000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer at 47800000 {
+			no-map;
+			reg = <0x47800000 0x00800000>; /* 8MB */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+			gpios = <&gpio ASPEED_GPIO(B, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+			<&adc 8>, <&adc 9>, <&adc 10>;
+	};
+
+	iio-hwmon-battery {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 11>;
+	};
+
+	i2c1mux: i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* mux-gpios = <&sgpio 10 GPIO_ACTIVE_HIGH> */
+		i2c-parent = <&i2c1>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		label = "bmc";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_vgahs_default &pinctrl_vgavs_default
+			&pinctrl_ddcclk_default &pinctrl_ddcdat_default>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	/* temp2 inlet */
+	tmp75 at 4c {
+		compatible = "ti,tmp75";
+		reg = <0x4c>;
+	};
+
+	/* temp3 */
+	tmp75 at 4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	/* temp1 */
+	tmp75 at 4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	/* Baseboard FRU */
+	eeprom at 54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	/* FP FRU */
+	eeprom at 57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	/* 0: PCIe Slot 2,
+	 *    Slot 3,
+	 *    Slot 6,
+	 *    Slot 7
+	 */
+	i2c-switch at 74 {
+		compatible = "nxp,pca9546";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;  /* may use mux at 77 next. */
+
+		i2c_pcie2: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c_pcie3: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_pcie6: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c_pcie7: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	/* 0: PCIe Slot 1,
+	 *    Slot 4,
+	 *    Slot 5,
+	 *    Slot 8,
+	 *    Slot 9,
+	 *    Slot 10,
+	 *    SSD 1,
+	 *    SSD 2
+	 */
+	i2c-switch at 77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;  /* may use mux at 74 next. */
+
+		i2c_pcie1: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c_pcie4: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_pcie5: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c_pcie8: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c_pcie9: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c_pcie10: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c_ssd1: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c_ssd2: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	/* BIOS FRU */
+	eeprom at 56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+
+	/* 0: PSU4
+	 *    PSU1
+	 *    PSU3
+	 *    PSU2
+	 */
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c_psu4: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c_psu1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_psu3: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c_psu2: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	/* PDB FRU */
+	eeprom at 52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	/* BMC FRU */
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&vuart {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		&pinctrl_pwm1_default
+		&pinctrl_pwm2_default
+		&pinctrl_pwm3_default>;
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
+
+	fan at 4 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan at 5 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan at 6 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan at 7 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+};
+
+&i2c1mux {
+	i2c at 0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Memory Riser 1 FRU */
+		eeprom at 50 {
+			compatible = "atmel,24c02";
+			reg = <0x50>;
+		};
+
+		/* Memory Riser 2 FRU */
+		eeprom at 51 {
+			compatible = "atmel,24c02";
+			reg = <0x51>;
+		};
+
+		/* Memory Riser 3 FRU */
+		eeprom at 52 {
+			compatible = "atmel,24c02";
+			reg = <0x52>;
+		};
+
+		/* Memory Riser 4 FRU */
+		eeprom at 53 {
+			compatible = "atmel,24c02";
+			reg = <0x53>;
+		};
+	};
+
+	i2c at 1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Memory Riser 5 FRU */
+		eeprom at 50 {
+			compatible = "atmel,24c02";
+			reg = <0x50>;
+		};
+
+		/* Memory Riser 6 FRU */
+		eeprom at 51 {
+			compatible = "atmel,24c02";
+			reg = <0x51>;
+		};
+
+		/* Memory Riser 7 FRU */
+		eeprom at 52 {
+			compatible = "atmel,24c02";
+			reg = <0x52>;
+		};
+
+		/* Memory Riser 8 FRU */
+		eeprom at 53 {
+			compatible = "atmel,24c02";
+			reg = <0x53>;
+		};
+	};
+};
-- 
2.14.1

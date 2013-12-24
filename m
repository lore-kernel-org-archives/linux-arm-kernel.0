From: maxime.hadjinlian@gmail.com (Maxime Hadjinlian)
Date: Tue, 24 Dec 2013 13:53:18 +0100
Subject: [PATCH v3 1/2] ARM: Kirkwood: Add 6192 DTSI file
Message-ID: <1387889599-12898-1-git-send-email-maxime.hadjinlian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file is mainly a copy of kirkwood-6281.dtsi.
The pinctrl seems to be the same.
These platforms differs only with their CPU, memory capabilities and the
number of GPIO available (36 on 6192, 50 on 6281).

Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
---
 arch/arm/boot/dts/kirkwood-6192.dtsi | 107 +++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-6192.dtsi

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
new file mode 100644
index 0000000..3916937
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -0,0 +1,107 @@
+/ {
+	mbus {
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6192-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pmx_nand: pmx-nand {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+					       "mpp4", "mpp5", "mpp18",
+					       "mpp19";
+				marvell,function = "nand";
+			};
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp5", "mpp21", "mpp23";
+				marvell,function = "sata0";
+			};
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp4", "mpp20", "mpp22";
+				marvell,function = "sata1";
+			};
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
+			pmx_sdio: pmx-sdio {
+				marvell,pins = "mpp12", "mpp13", "mpp14",
+					       "mpp15", "mpp16", "mpp17";
+				marvell,function = "sdio";
+			};
+		};
+
+		rtc at 10300 {
+			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
+			reg = <0x10300 0x20>;
+			interrupts = <53>;
+			clocks = <&gate_clk 7>;
+		};
+
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <21>;
+			clocks = <&gate_clk 14>, <&gate_clk 15>;
+			clock-names = "0", "1";
+			status = "disabled";
+		};
+
+		mvsdio at 90000 {
+			compatible = "marvell,orion-sdio";
+			reg = <0x90000 0x200>;
+			interrupts = <28>;
+			clocks = <&gate_clk 4>;
+			bus-width = <4>;
+			cap-sdio-irq;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			status = "disabled";
+		};
+	};
+};
-- 
1.8.5.1

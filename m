From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 15:46:38 -0500
Subject: [PATCH 3/3] ARM: dts: keystone-k2g-evm: add bindings for SPI NOR flash
In-Reply-To: <20170908204638.13149-1-fcooper@ti.com>
References: <20170908204638.13149-1-fcooper@ti.com>
Message-ID: <20170908204638.13149-4-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

K2G EVM has n25q128a13 SPI NOR flash on SPI1. Enable SPI1 in the DT
node as well as add a subnode for the SPI NOR.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index f462f10..d5c43c7 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -81,6 +81,16 @@
 			K2G_CORE_IOPAD(0x1110) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
 		>;
 	};
+
+	spi1_pins: pinmux_spi1_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x11a4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* spi1_scs0.spi1_scs0 */
+			K2G_CORE_IOPAD(0x11ac) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* spi1_clk.spi1_clk */
+			K2G_CORE_IOPAD(0x11b0) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* spi1_miso.spi1_miso */
+			K2G_CORE_IOPAD(0x11b4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* spi1_mosi.spi1_mosi */
+		>;
+	};
+
 };
 
 &uart0 {
@@ -112,3 +122,30 @@
 	memory-region = <&dsp_common_memory>;
 	status = "okay";
 };
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+
+	spi_nor: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <5000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition at 0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x100000>;
+			read-only;
+		};
+
+		partition at 1 {
+			label = "misc";
+			reg = <0x100000 0xf00000>;
+		};
+	};
+};
+
-- 
2.9.4.dirty

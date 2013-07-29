From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:29:06 +0200
Subject: [PATCH 4/4] ARM: dove: add initial DT file for Globalscale D2Plug
In-Reply-To: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1375100946-28521-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an initial DT file for the Globalscale D2Plug with Dove SoC.
Currently, one LED is missing and I have not been able to get SD8787 driver
working. Those will be taken care of later.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/Makefile        |    1 +
 arch/arm/boot/dts/dove-d2plug.dts |   69 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/dove-d2plug.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..6f10a07 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 	dove-cubox.dtb \
+	dove-d2plug.dtb \
 	dove-dove-db.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/dove-d2plug.dts
new file mode 100644
index 0000000..e2222ce
--- /dev/null
+++ b/arch/arm/boot/dts/dove-d2plug.dts
@@ -0,0 +1,69 @@
+/dts-v1/;
+
+/include/ "dove.dtsi"
+
+/ {
+	model = "Globalscale D2Plug";
+	compatible = "globalscale,d2plug", "marvell,dove";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_gpio_0 &pmx_gpio_1 &pmx_gpio_2>;
+		pinctrl-names = "default";
+
+		wlan-ap {
+			label = "wlan-ap";
+			gpios = <&gpio0 0 1>;
+		};
+
+		wlan-act {
+			label = "wlan-act";
+			gpios = <&gpio0 1 1>;
+		};
+
+		bluetooth-act {
+			label = "bt-act";
+			gpios = <&gpio0 2 1>;
+		};
+	};
+};
+
+&uart0 { status = "okay"; };
+&sata0 { status = "okay"; };
+&i2c0 { status = "okay"; };
+&mdio { status = "okay"; };
+&eth { status = "okay"; };
+
+/* Samsung M8G2F eMMC */
+&sdio0 {
+	status = "okay";
+	non-removable;
+	bus-width = <4>;
+};
+
+/* Marvell SD8787 WLAN/BT */
+&sdio1 {
+	status = "okay";
+	non-removable;
+	bus-width = <4>;
+};
+
+&spi0 {
+	status = "okay";
+
+	/* spi0.0: 4M Flash Macronix MX25L3205D */
+	spi-flash at 0 {
+		compatible = "st,m25l3205d";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
-- 
1.7.10.4

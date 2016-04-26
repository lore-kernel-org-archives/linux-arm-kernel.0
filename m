From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 00:10:32 +0300
Subject: [PATCH v2 5/7] ARM: dts: lpc32xx: phy3250: avoid extension of device
 nodes by absolute path
In-Reply-To: <1461705034-355-1-git-send-email-vz@mleia.com>
References: <1461705034-355-1-git-send-email-vz@mleia.com>
Message-ID: <1461705034-355-6-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change simplifies layout of PHY3250 board description by
referencing device nodes of LPC32xx controllers by label.

No functional change intended.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* added Sylvain's acked-by.

 arch/arm/boot/dts/phy3250.dts | 282 +++++++++++++++++++++---------------------
 1 file changed, 138 insertions(+), 144 deletions(-)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 26e070f..c1a6e62 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -56,147 +56,6 @@
 		};
 	};
 
-	ahb {
-		mac: ethernet at 31060000 {
-			phy-mode = "rmii";
-			use-iram;
-		};
-
-		clcd at 31040000 {
-			status = "okay";
-		};
-
-		/* 64MB Flash via SLC NAND controller */
-		slc: flash at 20020000 {
-			status = "okay";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			nxp,wdr-clks = <14>;
-			nxp,wwidth = <40000000>;
-			nxp,whold = <100000000>;
-			nxp,wsetup = <100000000>;
-			nxp,rdr-clks = <14>;
-			nxp,rwidth = <40000000>;
-			nxp,rhold = <66666666>;
-			nxp,rsetup = <100000000>;
-			nand-on-flash-bbt;
-			gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
-
-			mtd0 at 00000000 {
-				label = "phy3250-boot";
-				reg = <0x00000000 0x00064000>;
-				read-only;
-			};
-
-			mtd1 at 00064000 {
-				label = "phy3250-uboot";
-				reg = <0x00064000 0x00190000>;
-				read-only;
-			};
-
-			mtd2 at 001f4000 {
-				label = "phy3250-ubt-prms";
-				reg = <0x001f4000 0x00010000>;
-			};
-
-			mtd3 at 00204000 {
-				label = "phy3250-kernel";
-				reg = <0x00204000 0x00400000>;
-			};
-
-			mtd4 at 00604000 {
-				label = "phy3250-rootfs";
-				reg = <0x00604000 0x039fc000>;
-			};
-		};
-
-		apb {
-			uart5: serial at 40090000 {
-				status = "okay";
-			};
-
-			uart3: serial at 40080000 {
-				status = "okay";
-			};
-
-			i2c1: i2c at 400A0000 {
-				clock-frequency = <100000>;
-
-				pcf8563: rtc at 51 {
-					compatible = "nxp,pcf8563";
-					reg = <0x51>;
-				};
-
-				uda1380: uda1380 at 18 {
-					compatible = "nxp,uda1380";
-					reg = <0x18>;
-					power-gpio = <&gpio 0x59 0>;
-					reset-gpio = <&gpio 0x51 0>;
-					dac-clk = "wspll";
-				};
-			};
-
-			i2c2: i2c at 400A8000 {
-				clock-frequency = <100000>;
-			};
-
-			ssp0: ssp at 20084000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				num-cs = <1>;
-				cs-gpios = <&gpio 3 5 0>;
-				status = "okay";
-
-				eeprom: at25 at 0 {
-					pl022,interface = <0>;
-					pl022,com-mode = <0>;
-					pl022,rx-level-trig = <1>;
-					pl022,tx-level-trig = <1>;
-					pl022,ctrl-len = <11>;
-					pl022,wait-state = <0>;
-					pl022,duplex = <0>;
-
-					at25,byte-len = <0x8000>;
-					at25,addr-mode = <2>;
-					at25,page-size = <64>;
-
-					compatible = "atmel,at25";
-					reg = <0>;
-					spi-max-frequency = <5000000>;
-				};
-			};
-
-			sd at 20098000 {
-				wp-gpios = <&gpio 3 0 0>;
-				cd-gpios = <&gpio 3 1 0>;
-				cd-inverted;
-				bus-width = <4>;
-				vmmc-supply = <&sd_reg>;
-				status = "okay";
-			};
-		};
-
-		fab {
-			uart2: serial at 40018000 {
-				status = "okay";
-			};
-
-			tsc at 40048000 {
-				status = "okay";
-			};
-
-			key at 40050000 {
-				status = "okay";
-				keypad,num-rows = <1>;
-				keypad,num-columns = <1>;
-				nxp,debounce-delay-ms = <3>;
-				nxp,scan-delay-ms = <34>;
-				linux,keymap = <0x00000002>;
-			};
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -212,12 +71,31 @@
 	};
 };
 
-/* Here, choose exactly one from: ohci, usbd */
-&ohci /* &usbd */ {
-	transceiver = <&isp1301>;
+&clcd {
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+
+	uda1380: uda1380 at 18 {
+		compatible = "nxp,uda1380";
+		reg = <0x18>;
+		power-gpio = <&gpio 0x59 0>;
+		reset-gpio = <&gpio 0x51 0>;
+		dac-clk = "wspll";
+	};
+
+	pcf8563: rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+};
+
 &i2cusb {
 	clock-frequency = <100000>;
 
@@ -226,3 +104,119 @@
 		reg = <0x2c>;
 	};
 };
+
+&key {
+	keypad,num-rows = <1>;
+	keypad,num-columns = <1>;
+	nxp,debounce-delay-ms = <3>;
+	nxp,scan-delay-ms = <34>;
+	linux,keymap = <0x00000002>;
+	status = "okay";
+};
+
+&mac {
+	phy-mode = "rmii";
+	use-iram;
+};
+
+/* Here, choose exactly one from: ohci, usbd */
+&ohci /* &usbd */ {
+	transceiver = <&isp1301>;
+	status = "okay";
+};
+
+&sd {
+	wp-gpios = <&gpio 3 0 0>;
+	cd-gpios = <&gpio 3 1 0>;
+	cd-inverted;
+	bus-width = <4>;
+	vmmc-supply = <&sd_reg>;
+	status = "okay";
+};
+
+/* 64MB Flash via SLC NAND controller */
+&slc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "okay";
+
+	nxp,wdr-clks = <14>;
+	nxp,wwidth = <40000000>;
+	nxp,whold = <100000000>;
+	nxp,wsetup = <100000000>;
+	nxp,rdr-clks = <14>;
+	nxp,rwidth = <40000000>;
+	nxp,rhold = <66666666>;
+	nxp,rsetup = <100000000>;
+	nand-on-flash-bbt;
+	gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
+
+	mtd0 at 00000000 {
+		label = "phy3250-boot";
+		reg = <0x00000000 0x00064000>;
+		read-only;
+	};
+
+	mtd1 at 00064000 {
+		label = "phy3250-uboot";
+		reg = <0x00064000 0x00190000>;
+		read-only;
+	};
+
+	mtd2 at 001f4000 {
+		label = "phy3250-ubt-prms";
+		reg = <0x001f4000 0x00010000>;
+	};
+
+	mtd3 at 00204000 {
+		label = "phy3250-kernel";
+		reg = <0x00204000 0x00400000>;
+	};
+
+	mtd4 at 00604000 {
+		label = "phy3250-rootfs";
+		reg = <0x00604000 0x039fc000>;
+	};
+};
+
+&ssp0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	num-cs = <1>;
+	cs-gpios = <&gpio 3 5 0>;
+	status = "okay";
+
+	eeprom: at25 at 0 {
+		compatible = "atmel,at25";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+
+		pl022,interface = <0>;
+		pl022,com-mode = <0>;
+		pl022,rx-level-trig = <1>;
+		pl022,tx-level-trig = <1>;
+		pl022,ctrl-len = <11>;
+		pl022,wait-state = <0>;
+		pl022,duplex = <0>;
+
+		at25,byte-len = <0x8000>;
+		at25,addr-mode = <2>;
+		at25,page-size = <64>;
+	};
+};
+
+&tsc {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.1.4

From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:10 +0200
Subject: [PATCH 7/9] ARM: SPMP8000: Add dts file of SPMP8000 SoC and Letcool
	board
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-8-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/dts/spmp8000-letcool.dts |  163 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spmp8000.dtsi        |  169 ++++++++++++++++++++++++++++++++
 2 files changed, 332 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/spmp8000-letcool.dts
 create mode 100644 arch/arm/boot/dts/spmp8000.dtsi

diff --git a/arch/arm/boot/dts/spmp8000-letcool.dts b/arch/arm/boot/dts/spmp8000-letcool.dts
new file mode 100644
index 0000000..270f00e
--- /dev/null
+++ b/arch/arm/boot/dts/spmp8000-letcool.dts
@@ -0,0 +1,163 @@
+/dts-v1/;
+/include/ "spmp8000.dtsi"
+/ {
+	model = "Letcool N350JP handheld game console";
+	compatible = "gameware,letcool", "sunplus,spmp8000";
+
+	memory {
+		reg = <0x00000000 0x02000000>;
+	};
+
+	chosen {
+		bootargs = "console=tty0 mem=32M root=/dev/mmcblk0p1 console=ttyS0,115200 rootdelay=5 loglevel=8 earlyprintk";
+		linux,stdout-path = &uart0;
+	};
+
+	pwm-backlight {
+		compatible = "pwm-backlight";
+		reg = <0 0>;	/* Hack to pass platform data as AUXDATA */
+	};
+
+	plat {
+		plat-apb {
+			mmc at 92B0B000 {
+				cd-gpios = <&gpio0 9 0>;
+			};
+		};
+	};
+
+	armapb {
+		gpio at 9000A000 {
+				polarity = <0>;
+				sticky = <0>;
+				direction = <0xFFFFFFFF>;
+				debounce-val = <100>;
+				debounce = <0xFFFFFFFF>;
+		};
+	
+		gpio at 9000A004 {
+				polarity = <0>;
+				sticky = <0>;
+				direction = <0xFFFFFFFF>;
+				debounce-val = <100>;
+				debounce = <0xFFFFFFFF>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		up {
+			label = "D-Pad Up";
+			gpios = <&gpio0 0 0>;
+			linux,code = <103>; /* KEY_UP */
+			gpio-key,wakeup;
+		};
+
+		right {
+			label = "D-Pad Right";
+			gpios = <&gpio0 1 0>;
+			linux,code = <106>; /* KEY_RIGHT */
+			gpio-key,wakeup;
+		};
+
+		down {
+			label = "D-Pad Down";
+			gpios = <&gpio0 2 0>;
+			linux,code = <108>; /* KEY_DOWN */
+			gpio-key,wakeup;
+		};
+
+		left {
+			label = "D-Pad Left";
+			gpios = <&gpio0 3 0>;
+			linux,code = <105>; /* KEY_LEFT */
+			gpio-key,wakeup;
+		};
+
+		button-x {
+			label = "Button X";
+			gpios = <&gpio0 4 0>;
+			linux,code = <45>; /* KEY_X */
+			gpio-key,wakeup;
+		};
+
+		button-a {
+			label = "Button A";
+			gpios = <&gpio0 5 0>;
+			linux,code = <30>; /* KEY_A */
+			gpio-key,wakeup;
+		};
+
+		button-y {
+			label = "Button Y";
+			gpios = <&gpio0 6 0>;
+			linux,code = <21>; /* KEY_Y */
+			gpio-key,wakeup;
+		};
+
+		button-b {
+			label = "Button B";
+			gpios = <&gpio0 7 0>;
+			linux,code = <48>; /* KEY_B */
+			gpio-key,wakeup;
+		};
+	};
+
+	analog-keys {
+		compatible = "spmp8000-ak";
+
+		channel-1 {
+			adc-channel = <1>;
+			idle-value = <0>;
+			tolerance = <10>;
+
+			button-left {
+				adc-value = <0x00B0>;
+				linux,code = <0x110>; /* BTN_LEFT */
+			};
+
+			button-right {
+				adc-value = <0xFEAB>;
+				linux,code = <0x111>; /* BTN_RIGHT */
+			};
+
+			button-volup {
+				adc-value = <0x015E>;
+				linux,code = <115>; /* KEY_VOLUMEUP */
+			};
+
+			button-voldown {
+				adc-value = <0xFF56>;
+				linux,code = <114>; /* KEY_VOLUMEDOWN */
+			};
+		};
+
+		channel-3 {
+			adc-channel = <3>;
+			idle-value = <5>;
+			tolerance = <10>;
+
+			button-select {
+				adc-value = <0x0113>;
+				linux,code = <0x13a>; /* BTN_SELECT */
+			};
+
+			button-start {
+				adc-value = <0xFEF7>;
+				linux,code = <0x13b>; /* BTN_START */
+			};
+		};
+
+	};
+
+	snd-card {
+		compatible = "spmp8000-sndcard";
+		hp-detect-gpios = <&gpio0 8 0>;
+		spk-enable-gpios = <&gpio3 12 0>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/spmp8000.dtsi b/arch/arm/boot/dts/spmp8000.dtsi
new file mode 100644
index 0000000..74764b2c6
--- /dev/null
+++ b/arch/arm/boot/dts/spmp8000.dtsi
@@ -0,0 +1,169 @@
+/ {
+	compatible = "sunplus,spmp8000";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	armapb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x90000000 0x90000000 0x10000>;
+
+		timer at 90000000 {
+			compatible = "sunplus,spmp8000-timer";
+			reg = <0x90000000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <7 8 9>;
+		};
+
+		pwm at 90000000 {
+			compatible = "sunplus,spmp8000-pwm";
+			reg = <0x90000000 0x1000>;
+			id = <0>;
+		};
+
+		gpio3: gpio at 90005070 {
+			compatible = "basic-mmio-gpio";	/* No DT binding yet */
+			reg = <0x90005070 0xC>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio0: gpio at 9000A000 {
+			compatible = "sunplus,spmp8000-gpio";
+			reg = <0x9000A000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			bits = <16>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio1: gpio at 9000A004 {
+			compatible = "sunplus,spmp8000-gpio";
+			reg = <0x9000A004 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			bits = <32>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
+
+	armahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x90010000 0x90010000 0x20000>;
+
+		vic0: interrupt-controller at 90010000 {
+			compatible = "arm,pl192";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x90010000 0x1000>;
+		};
+
+		vic1: interrupt-controller at 900020000 {
+			compatible = "arm,pl192";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x90020000 0x1000>;
+		};
+	};
+
+	plat {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x92000000 0x92000000 0x1000000>;
+
+		plat-apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x92B00000 0x92B00000 0x10000>;
+
+			dma at 92B00000 {
+				compatible = "sunplus,spmp8000-apbdma-c";
+				reg = <0x92B00000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <28 29 30 31>;
+			};
+
+			uart0: uart-c0 at 92B04000 {
+				compatible = "ns16550a";
+				reg = <0x92B04000 0x1000>;
+				clock-frequency = <2076923>;
+				interrupt-parent = <&vic1>;
+				interrupts = <24>;
+				current-speed = <115200>;
+				reg-shift = <2>;
+			};
+
+			mmc at 92B0B000 {
+				compatible = "sunplus,mmc";
+				reg = <0x92B0B000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <8>;
+			};
+		};
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x93000000 0x93000000 0x800000>;
+
+		fb at 93000000 {
+			compatible = "sunplus,spmp8000-lcd";
+			reg = <0x93000000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <23>;
+		};
+
+		axi-apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x93010000 0x93010000 0x10000>;
+
+			dma at 93010000 {
+				compatible = "sunplus,spmp8000-apbdma-a";
+				reg = <0x93010000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <24 25 26 27>;
+			};
+
+			i2s at 93012000 {
+				compatible = "sunplus,spmp8000-i2s-tx";
+				reg = <0x93012000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <13>;
+			};
+
+			i2s at 9301D000 {
+				compatible = "sunplus,spmp8000-i2s-rx";
+				reg = <0x9301D000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <14>;
+			};
+
+			adc at 9301F000 {
+				compatible = "sunplus,spmp8000-adc";
+				reg = <0x9301F000 0x20>;
+				interrupt-parent = <&vic1>;
+				interrupts = <27>;
+			};
+
+			codec at 9301F020 {
+				compatible = "sunplus,spmp8000-codec";
+				reg = <0x9301F020 0x20>;
+			};
+		};
+	};
+};
-- 
1.7.4.1

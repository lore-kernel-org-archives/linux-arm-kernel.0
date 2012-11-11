From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:30 +0530
Subject: [PATCH 08/14] ARM: SPEAr: DT: Update device nodes
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <b3925b105ee2c6fe828ef3b54928aeee02a801ae.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch adds multiple device nodes for SPEAr machines and boards.

Signed-off-by: Bhavna Yadav <bhavna.yadav@st.com>
Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Vijay Kumar Mishra <vijay.kumar@st.com>
Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts |  89 +++++++++++++++++++
 arch/arm/boot/dts/spear1310.dtsi    |   2 +
 arch/arm/boot/dts/spear1340-evb.dts | 172 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340.dtsi    |  46 ++++++++++
 arch/arm/boot/dts/spear13xx.dtsi    |  39 ++++++++
 arch/arm/boot/dts/spear320.dtsi     |  11 +++
 arch/arm/boot/dts/spear3xx.dtsi     |   2 +
 arch/arm/boot/dts/spear600-evb.dts  |  24 +++++
 arch/arm/boot/dts/spear600.dtsi     |  15 ++++
 9 files changed, 400 insertions(+)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index c60c3f8..56ea6d5 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -147,6 +147,20 @@
 			};
 		};
 
+		gpio_keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			button at 1 {
+				label = "wakeup";
+				linux,code = <0x100>;
+				gpios = <&gpio0 7 0x4>;
+				debounce-interval = <20>;
+				gpio-key,wakeup = <1>;
+			};
+		};
+
 		gmac0: eth at e2000000 {
 			phy-mode = "gmii";
 			status = "okay";
@@ -326,6 +340,81 @@
 
 			spi0: spi at e0100000 {
 				status = "okay";
+				num-cs = <3>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+
+				stmpe610 at 0 {
+					status = "okay";
+					compatible = "st,stmpe610";
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					spi-max-frequency = <1000000>;
+					spi-cpha;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x7>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+					id = <0>;
+					blocks = <4>;
+					irq_over_gpio;
+					irq-gpios = <&gpio1 6 0x4>;
+					irq-trigger = <0x2>;
+
+					stmpe610-ts {
+						compatible = "stmpe,ts";
+						reg = <0>;
+						ts,sample-time = <4>;
+						ts,mod-12b = <1>;
+						ts,ref-sel = <0>;
+						ts,adc-freq = <1>;
+						ts,ave-ctrl = <1>;
+						ts,touch-det-delay = <2>;
+						ts,settling = <2>;
+						ts,fraction-z = <7>;
+						ts,i-drive = <1>;
+					};
+				};
+
+				m25p80 at 1 {
+					status = "okay";
+					compatible = "st,m25p80";
+					reg = <1>;
+					spi-max-frequency = <12000000>;
+					spi-cpol;
+					spi-cpha;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0x2>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x11>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+				};
+
+				spidev at 2 {
+					status = "okay";
+					compatible = "spidev";
+					reg = <2>;
+					spi-max-frequency = <25000000>;
+					spi-cpha;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0x2>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x11>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+				};
 			};
 
 			wdt at ec800620 {
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index bd6b64b..8fb22b9 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -154,6 +154,8 @@
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x5d400000 0x1000>;
 				interrupts = <0 99 0x4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index c6051dd..c0a3677 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -118,6 +118,10 @@
 			};
 		};
 
+		ahci at b1000000 {
+			status = "okay";
+		};
+
 		dma at ea800000 {
 			status = "okay";
 		};
@@ -205,10 +209,37 @@
 			status = "okay";
 		};
 
+		gpio_keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			button at 1 {
+				label = "wakeup";
+				linux,code = <0x100>;
+				gpios = <&gpio1 1 0x4>;
+				debounce-interval = <20>;
+				gpio-key,wakeup = <1>;
+			};
+		};
+
 		ehci at e5800000 {
 			status = "okay";
 		};
 
+		i2s0: i2s-play at b2400000 {
+			status = "okay";
+		};
+
+		i2s1: i2s-rec at b2000000 {
+			status = "okay";
+		};
+
+		incodec: dir-hifi {
+			compatible = "dummy,dir-hifi";
+			status = "okay";
+		};
+
 		ohci at e4000000 {
 			status = "okay";
 		};
@@ -217,11 +248,43 @@
 			status = "okay";
 		};
 
+		outcodec: dit-hifi {
+			compatible = "dummy,dit-hifi";
+			status = "okay";
+		};
+
+		sound {
+			compatible = "spear,spear-evb";
+			audio-controllers = <&spdif0 &spdif1 &i2s0 &i2s1>;
+			audio-codecs = <&incodec &outcodec &sta529 &sta529>;
+			codec_dai_name = "dir-hifi", "dit-hifi", "sta529-audio", "sta529-audio";
+			stream_name = "spdif-cap", "spdif-play", "i2s-play", "i2s-cap";
+			dai_name = "spdifin-pcm", "spdifout-pcm", "i2s0-pcm", "i2s1-pcm";
+			nr_controllers = <4>;
+		        status = "okay";
+		};
+
+		spdif0: spdif-in at d0100000 {
+			status = "okay";
+		};
+
+		spdif1: spdif-out at d0000000 {
+			status = "okay";
+		};
+
 		apb {
 			adc at e0080000 {
 				status = "okay";
 			};
 
+			i2s-play at b2400000 {
+				status = "okay";
+			};
+
+			i2s-rec at b2000000 {
+				status = "okay";
+			};
+
 			gpio0: gpio at e0600000 {
 			       status = "okay";
 			};
@@ -232,10 +295,39 @@
 
 			i2c0: i2c at e0280000 {
 			       status = "okay";
+
+				sta529: sta529 at 1a {
+					compatible = "st,sta529";
+					reg = <0x1a>;
+				};
 			};
 
 			i2c1: i2c at b4000000 {
 			       status = "okay";
+
+				eeprom0 at 56 {
+					compatible = "st,eeprom";
+					reg = <0x56>;
+				};
+
+				stmpe801 at 41 {
+					compatible = "st,stmpe801";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x41>;
+					irq-over-gpio;
+					irq-gpios = <&gpio0 4 0x4>;
+					id = <0>;
+					blocks = <1>;
+					irq-trigger = <0x2>;
+
+					stmpegpio: stmpe-gpio {
+						compatible = "stmpe,gpio";
+						reg = <0>;
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+				};
 			};
 
 			kbd at e0300000 {
@@ -344,6 +436,86 @@
 
 			spi0: spi at e0100000 {
 				status = "okay";
+				num-cs = <3>;
+				cs-gpios = <&gpiopinctrl 80 0>, <&gpiopinctrl 24 0>,
+					   <&gpiopinctrl 85 0>;
+
+				m25p80 at 0 {
+					status = "okay";
+					compatible = "m25p80";
+					reg = <0>;
+					spi-max-frequency = <12000000>;
+					spi-cpol;
+					spi-cpha;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0x2>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x11>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+				};
+
+				stmpe610 at 1 {
+					status = "okay";
+					compatible = "st,stmpe610";
+					spi-max-frequency = <1000000>;
+					spi-cpha;
+					reg = <1>;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x7>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+					irq-over-gpio;
+					irq-gpios = <&gpiopinctrl 100 0>;
+					id = <0>;
+					blocks = <4>;
+					irq-trigger = <0x2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					stmpe610-ts {
+						compatible = "stmpe,ts";
+						reg = <0>;
+						ts,sample-time = <4>;
+						ts,mod-12b = <1>;
+						ts,ref-sel = <0>;
+						ts,adc-freq = <1>;
+						ts,ave-ctrl = <1>;
+						ts,touch-det-delay = <2>;
+						ts,settling = <2>;
+						ts,fraction-z = <7>;
+						ts,i-drive = <1>;
+					};
+				};
+
+				spidev at 2 {
+					status = "okay";
+					compatible = "spidev";
+					reg = <2>;
+					spi-max-frequency = <25000000>;
+					spi-cpha;
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable;
+					pl022,com-mode = <0x2>;
+					pl022,rx-level-trig = <0>;
+					pl022,tx-level-trig = <0>;
+					pl022,ctrl-len = <0x11>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+				};
+			};
+
+			timer at ec800600 {
+				status = "okay";
 			};
 
 			wdt at ec800620 {
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 1446f1b..0d3eb4f 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -38,9 +38,55 @@
 			status = "disabled";
 		};
 
+		i2s-play at b2400000 {
+			compatible = "snps,designware-i2s";
+			reg = <0xb2400000 0x10000>;
+			interrupt-names = "play_irq";
+			interrupts = <0 98 0x4
+				      0 99 0x4>;
+			play;
+			channel = <8>;
+			status = "disabled";
+		};
+
+		i2s-rec at b2000000 {
+			compatible = "snps,designware-i2s";
+			reg = <0xb2000000 0x10000>;
+			interrupt-names = "record_irq";
+			interrupts = <0 100  0x4
+				      0 101 0x4>;
+			record;
+			channel = <8>;
+			status = "disabled";
+		};
+
+		pwm: pwm at e0180000 {
+			compatible ="st,spear13xx-pwm";
+			reg = <0xe0180000 0x1000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		spdif-in at d0100000 {
+			compatible = "st,spdif-in";
+			reg = < 0xd0100000 0x20000
+				0xd0110000 0x10000 >;
+			interrupts = <0 84 0x4>;
+			status = "disabled";
+		};
+
+		spdif-out at d0000000 {
+			compatible = "st,spdif-out";
+			reg = <0xd0000000 0x20000>;
+			interrupts = <0 85 0x4>;
+			status = "disabled";
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 99 0x4>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 4d35144..2e650f9 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -64,6 +64,18 @@
 		bootargs = "console=ttyAMA0,115200";
 	};
 
+	cpufreq {
+		compatible = "st,cpufreq";
+		cpufreq_tbl = < 166000
+			200000
+			250000
+			300000
+			400000
+			500000
+			600000 >;
+		status = "disable";
+	};
+
 	ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -128,6 +140,13 @@
 			status = "disabled";
 		};
 
+		pcm {
+			compatible = "st,pcm-audio";
+			#address-cells = <0>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
 		smi: flash at ea000000 {
 			compatible = "st,spear600-smi";
 			#address-cells = <1>;
@@ -217,9 +236,29 @@
 				status = "disabled";
 			};
 
+			i2s at e0180000 {
+				compatible = "st,designware-i2s";
+				reg = <0xe0180000 0x1000>;
+				interrupt-names = "play_irq", "record_irq";
+				interrupts = <0 10 0x4
+					      0 11 0x4 >;
+				status = "disabled";
+			};
+
+			i2s at e0200000 {
+				compatible = "st,designware-i2s";
+				reg = <0xe0200000 0x1000>;
+				interrupt-names = "play_irq", "record_irq";
+				interrupts = <0 26 0x4
+					      0 53 0x4>;
+				status = "disabled";
+			};
+
 			spi0: spi at e0100000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0xe0100000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 02113f3..582ded7 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -55,15 +55,26 @@
 		spi1: spi at a5000000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xa5000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
 		spi2: spi at a6000000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xa6000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
+		pwm: pwm at a8000000 {
+			compatible ="st,spear-pwm";
+			reg = <0xa8000000 0x1000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+                };
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index 4946360..c2a852d 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -70,6 +70,8 @@
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xd0100000 0x1000>;
 			interrupts = <20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index 5e6ef03..d865a89 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -24,15 +24,35 @@
 	};
 
 	ahb {
+		clcd at fc200000 {
+			status = "okay";
+		};
+
 		dma at fc400000 {
 			status = "okay";
 		};
 
+		ehci at e1800000 {
+			status = "okay";
+		};
+
+		ehci at e2000000 {
+			status = "okay";
+		};
+
 		gmac: ethernet at e0800000 {
 			phy-mode = "gmii";
 			status = "okay";
 		};
 
+		ohci at e1900000 {
+			status = "okay";
+		};
+
+		ohci at e2100000 {
+			status = "okay";
+		};
+
 		smi: flash at fc000000 {
 			status = "okay";
 			clock-rate=<50000000>;
@@ -83,6 +103,10 @@
 				pinctrl-0 = <>;
 			};
 
+			rtc at fc900000 {
+			       status = "okay";
+			};
+
 			i2c at d0200000 {
 				clock-frequency = <400000>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index f74feea..e051dde 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -45,6 +45,14 @@
 			#interrupt-cells = <1>;
 		};
 
+		clcd at fc200000 {
+			compatible = "arm,pl110", "arm,primecell";
+			reg = <0xfc200000 0x1000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <12>;
+			status = "disabled";
+		};
+
 		dma at fc400000 {
 			compatible = "arm,pl080", "arm,primecell";
 			reg = <0xfc400000 0x1000>;
@@ -179,6 +187,13 @@
 				status = "disabled";
 			};
 
+			rtc at fc900000 {
+				compatible = "st,spear600-rtc";
+				reg = <0xfc900000 0x1000>;
+				interrupts = <10>;
+				status = "disabled";
+			};
+
 			timer at f0000000 {
 				compatible = "st,spear-timer";
 				reg = <0xf0000000 0x400>;
-- 
1.7.12.rc2.18.g61b472e

From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:13:58 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an initial device tree to run Linux on the Cortex-M4 on
Vybrid.

HACK: Because we include armv7-m.dtsi, the soc node happens to
be before the clock node. This is a problem for vf610-clk.c, which
tries to optain the fixed clocks defined in the clock nodes. But
because clock drivers are initialized sequencially, and we do not
have support for deferred probing, the clock initialization fails
horrible.
Move the armv7-m.dtsi include to the bottom to temporarily work
work around this...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
hack as well. Is it common acceptable that the kernel depends
on DTS order?

 arch/arm/boot/dts/Makefile     |   1 +
 arch/arm/boot/dts/armv7-m.dtsi |   1 -
 arch/arm/boot/dts/vf610m4.dts  | 144 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/vf610m4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..b1c6c1d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
+dtb-$(CONFIG_SOC_VF610M4) += vf610m4.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index 5a660d0..0516484 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -1,4 +1,3 @@
-#include "skeleton.dtsi"
 
 / {
 	nvic: nv-interrupt-controller  {
diff --git a/arch/arm/boot/dts/vf610m4.dts b/arch/arm/boot/dts/vf610m4.dts
new file mode 100644
index 0000000..61488fe
--- /dev/null
+++ b/arch/arm/boot/dts/vf610m4.dts
@@ -0,0 +1,144 @@
+/*
+ * Device tree for VF610 Cortex-M4 support
+ */
+
+/dts-v1/;
+#include "skeleton.dtsi"
+#include "vf610-pinfunc.h"
+#include <dt-bindings/clock/vf610-clock.h>
+
+/ {
+	model = "VF610 Cortex-M4";
+	compatible = "fsl,vf610m4";
+
+	chosen {
+		bootargs = "console=ttyLP0,115200 ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc root=/dev/mmcblk0p2 rootwait";
+	};
+
+	memory {
+		reg = <0x88000000 0x2000000>;
+	};
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sxosc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		fxosc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+	};
+
+	soc {
+		aips0: aips-bus at 40000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x40000000 0x70000>;
+			ranges;
+
+/*
+			uart0: serial at 40027000 {
+				compatible = "fsl,vf610-lpuart";
+				reg = <0x40027000 0x1000>;
+				interrupts = <61>;
+				clocks = <&clks VF610_CLK_UART0>;
+				clock-names = "ipg";
+				status = "okay";
+			};
+
+			uart1: serial at 40028000 {
+				compatible = "fsl,vf610-lpuart";
+				reg = <0x40028000 0x1000>;
+				interrupts = <62>;
+				clocks = <&clks VF610_CLK_UART1>;
+				clock-names = "ipg";
+				status = "okay";
+			};
+*/
+			uart2: serial at 40029000 {
+				compatible = "fsl,vf610-lpuart";
+				reg = <0x40029000 0x1000>;
+				interrupts = <63>;
+				clocks = <&clks VF610_CLK_UART2>;
+				clock-names = "ipg";
+				status = "okay";
+			};
+
+			pit: pit at 40037000 {
+				compatible = "fsl,vf610-pit";
+				reg = <0x40037000 0x1000>;
+				interrupts = <39>;
+				clocks = <&clks VF610_CLK_PIT>;
+				clock-names = "pit";
+			};
+
+			iomuxc: iomuxc at 40048000 {
+				compatible = "fsl,vf610-iomuxc";
+				reg = <0x40048000 0x1000>;
+				#gpio-range-cells = <3>;
+
+				vf610-colibri {
+					pinctrl_esdhc1: esdhc1grp {
+						fsl,pins = <
+							VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
+							VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
+							VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
+							VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
+							VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
+							VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
+							VF610_PAD_PTB20__GPIO_42	0x219d
+						>;
+					};
+				};
+			};
+
+			anatop at 40050000 {
+				compatible = "fsl,vf610-anatop";
+				reg = <0x40050000 0x1000>;
+			};
+
+			clks: ccm at 4006b000 {
+				compatible = "fsl,vf610-ccm";
+				reg = <0x4006b000 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		aips1: aips-bus at 40080000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x40080000 0x80000>;
+			ranges;
+
+
+			esdhc1: esdhc at 400b2000 {
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x400b2000 0x1000>;
+				interrupts = <28>;
+				clocks = <&clks VF610_CLK_IPG_BUS>,
+					<&clks VF610_CLK_PLATFORM_BUS>,
+					<&clks VF610_CLK_ESDHC1>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_esdhc1>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+#include "armv7-m.dtsi"
-- 
2.1.2

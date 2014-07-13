From: mollie.wu@linaro.org (Mollie Wu)
Date: Sun, 13 Jul 2014 14:28:31 +0800
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <message-id-of-cover-letter>
References: <message-id-of-cover-letter>
Message-ID: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MB86S7X is a bigLITTLE configuration of 2xCA7 & 2xCA15 under Linux.
And the remote master firmware (called SCB) running on CM3. Linux asks
for things to be done over Mailbox API, to SCB which controls most of
the important things. variations S70 & S73 are supported.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
---
 .../bindings/arm/fujistu/power_domain.txt          |  22 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mb86s70.dtsi                     | 635 ++++++++++++++
 arch/arm/boot/dts/mb86s70eb.dts                    |  38 +
 arch/arm/boot/dts/mb86s73.dtsi                     | 910 +++++++++++++++++++++
 arch/arm/boot/dts/mb86s73eb.dts                    |  73 ++
 arch/arm/configs/fujitsu_defconfig                 | 156 ++++
 arch/arm/mach-mb86s7x/Kconfig                      |  18 +
 arch/arm/mach-mb86s7x/Makefile                     |   2 +
 arch/arm/mach-mb86s7x/board.c                      |  65 ++
 arch/arm/mach-mb86s7x/iomap.h                      |  34 +
 arch/arm/mach-mb86s7x/mcpm.c                       | 293 +++++++
 arch/arm/mach-mb86s7x/pm_domains.c                 | 237 ++++++
 arch/arm/mach-mb86s7x/scb_mhu.c                    | 447 ++++++++++
 include/linux/platform_data/mb86s7x_mbox.h         | 249 ++++++
 17 files changed, 3183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/configs/fujitsu_defconfig
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile
 create mode 100644 arch/arm/mach-mb86s7x/board.c
 create mode 100644 arch/arm/mach-mb86s7x/iomap.h
 create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
 create mode 100644 arch/arm/mach-mb86s7x/pm_domains.c
 create mode 100644 arch/arm/mach-mb86s7x/scb_mhu.c
 create mode 100644 include/linux/platform_data/mb86s7x_mbox.h

diff --git a/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
new file mode 100644
index 0000000..44abfe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
@@ -0,0 +1,22 @@
+* Fujitsu MB86S7x Power Domains
+
+Remote f/w on MB86S7x can enable/disable power to various IPs.
+
+Required Properties:
+- compatible: Should be "fujitsu,mb86s7x-pd"
+- index: Index of the power gate control for the block
+
+Example:
+
+	pd_cpu: genpd at 3 {
+		compatible = "fujitsu,mb86s7x-pd";
+		index = <3>;
+	};
+
+Example of the node using power domain:
+
+	node {
+		/* ... */
+		fujitsu,power-domain = <&pd_cpu>;
+		/* ... */
+	};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..44fd319 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -955,6 +955,8 @@ source "arch/arm/mach-kirkwood/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-mb86s7x/Kconfig"
+
 source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab..d6ec5cd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -166,6 +166,7 @@ machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_KIRKWOOD)		+= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
+machine-$(CONFIG_ARCH_MB86S7X)		+= mb86s7x
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MSM)		+= msm
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9..0c8addb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_ARCH_MB86S7X) += mb86s70eb.dtb mb86s73eb.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
diff --git a/arch/arm/boot/dts/mb86s70.dtsi b/arch/arm/boot/dts/mb86s70.dtsi
new file mode 100644
index 0000000..b6d8970
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70.dtsi
@@ -0,0 +1,635 @@
+
+/dts-v1/;
+
+/ {
+	model = "Fujitsu mb86s70";
+	compatible = "fujitsu,mb86s70";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			operating-points = <
+				/* kHz    uV */
+				800000  900000
+			>;
+			clock-latency = <100000>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			operating-points = <
+				/* kHz    uV */
+				800000  900000
+			>;
+			clock-latency = <100000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			cci-control-port = <&cci_control4>;
+			clock-frequency = <1000000000>;
+			operating-points = <
+				/* kHz    uV */
+				1200000 900000
+				1600000 1000000
+				2000000 1100000
+				2400000 1200000
+			>;
+			clock-latency = <100000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			cci-control-port = <&cci_control4>;
+			clock-frequency = <1000000000>;
+			operating-points = <
+				/* kHz    uV */
+				1200000 900000
+				1600000 1000000
+				2000000 1100000
+				2400000 1200000
+			>;
+			clock-latency = <100000>;
+		};
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x2c090000 0x1000>;
+		ranges = <0x0 0x0 0x2c090000 0x10000>;
+
+		cci_control3: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control4: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+
+		pmu at 9000 {
+			compatible = "arm,cci-400-pmu";
+			reg = <0x9000 0x5000>;
+			interrupts = <0 77 4>,
+					<0 77 4>,
+					<0 77 4>,
+					<0 77 4>,
+					<0 77 4>;
+		};
+	};
+
+	/**
+	 * cntrlr : 0->ALW, 1->DDR3, 2->MAIN, 3->CA15, 4->HDMI, 5->DPHY
+	 * port : [0,7] -> Gateable Clock Ports.  [8]->UngatedCLK
+	 */
+	clocks {
+		clk_alw_0_0: clk_alw_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_alw_0_1: clk_alw_0_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <1>;
+		};
+
+		clk_alw_0_2: clk_alw_0_2 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <2>;
+		};
+
+		clk_alw_0_4: clk_alw_0_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <4>;
+		};
+
+		clk_alw_0_5: clk_alw_0_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <5>;
+		};
+
+		clk_alw_0_8: clk_alw_0_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <8>;
+		};
+
+		clk_alw_1_0: clk_alw_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_alw_1_1: clk_alw_1_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <1>;
+		};
+
+		clk_alw_1_8: clk_alw_1_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <8>;
+		};
+
+		clk_alw_2_0: clk_alw_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_alw_2_1: clk_alw_2_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <1>;
+		};
+
+		clk_alw_2_2: clk_alw_2_2 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <2>;
+		};
+
+		clk_alw_2_4: clk_alw_2_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <4>;
+		};
+
+		clk_alw_2_5: clk_alw_2_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <5>;
+		};
+
+		clk_alw_2_8: clk_alw_2_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <8>;
+		};
+
+		clk_alw_6_8: clk_alw_6_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <6>;
+			port = <8>;
+		};
+
+		clk_alw_7_0: clk_alw_7_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_alw_8_0: clk_alw_8_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <8>;
+			port = <0>;
+		};
+
+		clk_alw_a_0: clk_alw_a_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0a>;
+			port = <0>;
+		};
+
+		clk_alw_a_1: clk_alw_a_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0a>;
+			port = <1>;
+		};
+
+		clk_ddr3_0_0: clk_ddr3_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <1>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_0: clk_main_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_8: clk_main_0_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0>;
+			port = <8>;
+		};
+
+		clk_main_1_3: clk_main_1_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <1>;
+			port = <3>;
+		};
+
+		clk_main_1_4: clk_main_1_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <1>;
+			port = <4>;
+		};
+
+		clk_main_2_0: clk_main_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_main_2_3: clk_main_2_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <3>;
+		};
+
+		clk_main_2_7: clk_main_2_7 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <7>;
+		};
+
+		clk_main_3_0: clk_main_3_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_main_3_3: clk_main_3_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <3>;
+		};
+
+		clk_main_3_4: clk_main_3_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <4>;
+		};
+
+		clk_main_3_5: clk_main_3_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <5>;
+		};
+
+		clk_main_3_6: clk_main_3_6 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <6>;
+		};
+
+		clk_main_4_0: clk_main_4_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <4>;
+			port = <0>;
+		};
+
+		clk_main_4_1: clk_main_4_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <4>;
+			port = <1>;
+		};
+
+		clk_main_5_0: clk_main_5_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <0>;
+		};
+
+		clk_main_5_3: clk_main_5_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <3>;
+		};
+
+		clk_main_5_4: clk_main_5_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <4>;
+		};
+
+		clk_main_5_5: clk_main_5_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <5>;
+		};
+
+		clk_main_7_0: clk_main_7_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_main_8_1: clk_main_8_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <8>;
+			port = <1>;
+		};
+
+		clk_main_9_0: clk_main_9_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <9>;
+			port = <0>;
+		};
+
+		clk_hdmi_0_0: clk_hdmi_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_hdmi_1_0: clk_hdmi_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_hdmi_2_0: clk_hdmi_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_hdmi_3_0: clk_hdmi_3_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_dphy_0_0: clk_dphy_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <5>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_dphy_1_0: clk_dphy_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <5>;
+			domain = <1>;
+			port = <0>;
+		};
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0 0x2c001000 0x1000>,
+		      <0 0x2c002000 0x1000>,
+		      <0 0x2c004000 0x2000>,
+		      <0 0x2c006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+
+	timer0: timer0 at 31080000 {
+		compatible = "arm,sp804";
+		reg = <0 0x31080000 0x10000>;
+		interrupts = <0 324 4>,
+			     <0 325 4>;
+		clocks = <&clk_alw_6_8>;
+	};
+
+	mhu: mhu0 at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "fujitsu,mhu";
+		reg = <0 0x2B1F0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+	};
+
+	mhu_client: scb at 0 {
+		compatible = "fujitsu,scb";
+		mbox = <&mhu 1>;
+		mbox-names = "HP_NonSec";
+	};
+
+	pinctrl: pinctrl at 2a4d0000 {
+		compatible = "fujitsu,mb86s70-pinctrl";
+		reg = <0 0x2a4d0000 0x1000>;
+		#gpio-range-cells = <3>;
+	};
+
+	gpio0: mb86s70_gpio0 {
+		compatible = "fujitsu,mb86s7x-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	gpio1: mb86s70_gpio1 {
+		compatible = "fujitsu,mb86s7x-gpio";
+		reg = <0 0x31010000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	uart0: serial at 0x31040000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31040000 0x100>;
+		interrupts = <0 320 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	uart1: serial at 0x31050000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31050000 0x100>;
+		interrupts = <0 321 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	uart2: serial at 0x31060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31060000 0x100>;
+		interrupts = <0 322 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	sdhci0: emmc at 300c0000 {
+		compatible = "fujitsu,f-sdh30";
+		reg = <0 0x300c0000 0x1000>;
+		interrupts = <0 164 0x4>,
+			     <0 165 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		bus-width = <8>;
+		clocks = <&clk_alw_1_8>, <&clk_alw_6_8>;
+		clock-names = "sd_sd4clk", "sd_bclk";
+	};
+
+	sdhci1: sdio at 36600000 {
+		compatible = "fujitsu,f-sdh30";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		pwr-mux-gpios = <&gpio0 7 0>;
+		clocks = <&clk_hdmi_2_0>, <&clk_hdmi_3_0>;
+		clock-names = "sd_sd4clk", "sd_bclk";
+	};
+
+	eth0: f_taiki {
+                compatible = "fujitsu,ogma";
+		reg = <0 0x31600000 0x10000>,
+			<0 0x31618000 0x4000>,
+			<0 0x3161c000 0x4000>;
+		interrupts = <0 163 0x4>;
+		clocks = <&clk_alw_0_8>;
+		phy-mode = "rgmii";
+		max-speed = <1000>;
+		max-frame-size = <9000>;
+		local-mac-address = [ a4 17 31 00 00 ed ];
+		phy-handle = <&ethphy0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 1 {
+			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s70eb.dts b/arch/arm/boot/dts/mb86s70eb.dts
new file mode 100644
index 0000000..ee25dd9
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70eb.dts
@@ -0,0 +1,38 @@
+
+/include/ "mb86s70.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Fujitsu MB86S70 EVB";
+	compatible = "fujitsu,mb86s70-evb";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>, <0x08 0x80000000 0x80000000>;
+
+	};
+
+	chosen {
+		bootargs = "loglevel=4 console=ttyS0,115200 root=/dev/mmcblk1p2 rootfstype=ext4 rootwait rw";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		d3 {
+			label = "led3";
+			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		d4 {
+			label = "led4";
+			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+		};
+		d5 {
+			label = "led5";
+			gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s73.dtsi b/arch/arm/boot/dts/mb86s73.dtsi
new file mode 100644
index 0000000..ef4f5a0
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73.dtsi
@@ -0,0 +1,910 @@
+
+/ {
+	model = "Fujitsu mb86s73";
+	compatible = "fujitsu,mb86s73";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			operating-points = <
+				/* kHz    uV */
+				800000   900000
+				1200000  1000000
+			>;
+			clock-latency = <100000>;
+			fujitsu,power-domain = <&pd_cpu>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			operating-points = <
+				/* kHz    uV */
+				800000   900000
+				1200000  1000000
+			>;
+			clock-latency = <100000>;
+			fujitsu,power-domain = <&pd_cpu>;
+		};
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x2c090000 0x1000>;
+		ranges = <0x0 0x0 0x2c090000 0x10000>;
+		fujitsu,power-domain = <&pd_offchip>;
+
+		cci_control3: slave-if at 4000 {
+		compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+	};
+
+	/**
+	 * cntrlr : 0->ALW, 1->DDR3, 2->MAIN, 3->CA7, 4->USB, 5->FPDLINK
+	 * port : [0,7] -> Gateable Clock Ports.  [8]->UngatedCLK
+	 */
+	clocks {
+		clk_alw_0_0: clk_alw_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_alw_0_1: clk_alw_0_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <1>;
+		};
+
+		clk_alw_0_2: clk_alw_0_2 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <2>;
+		};
+
+		clk_alw_0_4: clk_alw_0_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <4>;
+		};
+
+		clk_alw_0_5: clk_alw_0_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <5>;
+		};
+
+		clk_alw_0_8: clk_alw_0_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0>;
+			port = <8>;
+		};
+
+		clk_alw_1_0: clk_alw_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_alw_1_1: clk_alw_1_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <1>;
+		};
+
+		clk_alw_1_2: clk_alw_1_2 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <2>;
+		};
+
+		clk_alw_1_8: clk_alw_1_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <1>;
+			port = <8>;
+		};
+
+		clk_alw_2_0: clk_alw_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_alw_2_1: clk_alw_2_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <1>;
+		};
+
+		clk_alw_2_2: clk_alw_2_2 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <2>;
+		};
+
+		clk_alw_2_4: clk_alw_2_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <4>;
+		};
+
+		clk_alw_2_5: clk_alw_2_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <5>;
+		};
+
+		clk_alw_2_8: clk_alw_2_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <2>;
+			port = <8>;
+		};
+
+		clk_alw_6_8: clk_alw_6_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <6>;
+			port = <8>;
+		};
+
+		clk_alw_7_0: clk_alw_7_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_alw_8_0: clk_alw_8_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <8>;
+			port = <0>;
+		};
+
+		clk_alw_a_0: clk_alw_a_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0a>;
+			port = <0>;
+		};
+
+		clk_alw_a_1: clk_alw_a_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0a>;
+			port = <1>;
+		};
+
+		clk_alw_b_0: clk_alw_b_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0b>;
+			port = <0>;
+		};
+
+		clk_alw_c_0: clk_alw_c_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <0>;
+			domain = <0x0c>;
+			port = <0>;
+		};
+
+		clk_ddr3_0_0: clk_ddr3_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <1>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_0: clk_main_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_8: clk_main_0_8 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0>;
+			port = <8>;
+		};
+
+		clk_main_1_3: clk_main_1_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <1>;
+			port = <3>;
+		};
+
+		clk_main_1_4: clk_main_1_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <1>;
+			port = <4>;
+		};
+
+		clk_main_2_0: clk_main_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_main_2_3: clk_main_2_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <3>;
+		};
+
+		clk_main_2_4: clk_main_2_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <4>;
+		};
+
+		clk_main_2_7: clk_main_2_7 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <2>;
+			port = <7>;
+		};
+
+		clk_main_3_0: clk_main_3_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_main_3_3: clk_main_3_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <3>;
+		};
+
+		clk_main_3_4: clk_main_3_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <4>;
+		};
+
+		clk_main_3_5: clk_main_3_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <5>;
+		};
+
+		clk_main_3_6: clk_main_3_6 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <3>;
+			port = <6>;
+		};
+
+		clk_main_4_0: clk_main_4_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <4>;
+			port = <0>;
+		};
+
+		clk_main_4_4: clk_main_4_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <4>;
+			port = <4>;
+		};
+
+		clk_main_4_5: clk_main_4_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <4>;
+			port = <5>;
+		};
+
+		clk_main_5_0: clk_main_5_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <0>;
+		};
+
+		clk_main_5_3: clk_main_5_3 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <3>;
+		};
+
+		clk_main_5_4: clk_main_5_4 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <4>;
+		};
+
+		clk_main_5_5: clk_main_5_5 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <5>;
+			port = <5>;
+		};
+
+		clk_main_7_0: clk_main_7_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_main_8_1: clk_main_8_1 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <8>;
+			port = <1>;
+		};
+
+		clk_main_9_0: clk_main_9_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <9>;
+			port = <0>;
+		};
+
+		clk_main_a_0: clk_main_a_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0xa>;
+			port = <0>;
+		};
+
+		clk_main_b_0: clk_main_b_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0xb>;
+			port = <0>;
+		};
+
+		clk_main_c_0: clk_main_c_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0xc>;
+			port = <0>;
+		};
+
+		clk_main_d_0: clk_main_d_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <2>;
+			domain = <0xd>;
+			port = <0>;
+		};
+
+		clk_usb_0_0: clk_usb_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_usb_1_0: clk_usb_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_usb_2_0: clk_usb_2_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_usb_3_0: clk_usb_3_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <4>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_fpdlink_0_0: clk_fpdlink_0_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <5>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_fpdlink_1_0: clk_fpdlink_1_0 {
+			compatible = "fujitsu,mb86s7x_clk";
+			#clock-cells = <0>;
+			cntrlr = <5>;
+			domain = <1>;
+			port = <0>;
+		};
+	};
+
+	timer0: timer0 at 31080000 {
+		compatible = "arm,sp804";
+		reg = <0 0x31080000 0x10000>;
+		interrupts = <0 324 4>,
+			     <0 325 4>;
+		clocks = <&clk_alw_6_8>;
+	};
+
+	timer1: archtimer {
+		compatible = "arm,armv7-timer";
+		clock-frequency = <125000000>;
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+	};
+
+	pinctrl: pinctrl at 2a4d0000 {
+		compatible = "fujitsu,mb86s73-pinctrl";
+		reg = <0 0x2a4d0000 0x1000>, <0 0x312e0000 0x1000>;
+		#gpio-range-cells = <3>;
+
+		pcie0_pins_active: pcie0_active {
+			mb86s7x,function = "pcie0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		pcie0_pins_sleep: pcie0_sleep {
+			mb86s7x,function = "pcie0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		usb3h0_pins_active: usb3h0_active {
+			mb86s7x,function = "usb3h0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		usb3h0_pins_sleep: usb3h0_sleep {
+			mb86s7x,function = "usb3h0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		usb2h0_pins_active: usb2h0_active {
+			mb86s7x,function = "usb2h0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		usb2h0_pins_sleep: usb2h0_sleep {
+			mb86s7x,function = "usb2h0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		usb2d0_pins_active: usb2d0_active {
+			mb86s7x,function = "usb2d0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		usb2d0_pins_sleep: usb2d0_sleep {
+			mb86s7x,function = "usb2d0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		sdh30_pins_active: sdh30_active {
+			mb86s7x,function = "sdh30";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		sdh30_pins_sleep: sdh30_sleep {
+			mb86s7x,function = "sdh30";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		emmc0_pins_active: emmc0_active {
+			mb86s7x,function = "emmc0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		emmc0_pins_sleep: emmc0_sleep {
+			mb86s7x,function = "emmc0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		hsspi0_pins_active: hsspi0_active {
+			mb86s7x,function = "hsspi0";
+			mb86s7x,drvst = <8>; /* in mA */
+		};
+		hsspi0_pins_sleep: hsspi0_sleep {
+			mb86s7x,function = "hsspi0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		gmacd0_pins_active: gmacd0_active {
+			mb86s7x,function = "gmacd0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		gmacd0_pins_sleep: gmacd0_sleep {
+			mb86s7x,function = "gmacd0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		gmacm0_pins_active: gmacm0_active {
+			mb86s7x,function = "gmacm0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		gmacm0_pins_sleep: gmacm0_sleep {
+			mb86s7x,function = "gmacm0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		i2s0_pins_active: i2s0_active {
+			mb86s7x,function = "i2s0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		i2s0_pins_sleep: i2s0_sleep {
+			mb86s7x,function = "i2s0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		other0_pins_active: other0_active {
+			mb86s7x,function = "other0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		other0_pins_sleep: other0_sleep {
+			mb86s7x,function = "other0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		jtag0_pins_active: jtag0_active {
+			mb86s7x,function = "jtag0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		jtag0_pins_sleep: jtag0_sleep {
+			mb86s7x,function = "jtag0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		pcie1_pins_active: pcie1_active {
+			mb86s7x,function = "pcie1";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		pcie1_pins_sleep: pcie1_sleep {
+			mb86s7x,function = "pcie1";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		usb3h1_pins_active: usb3h1_active {
+			mb86s7x,function = "usb3h1";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		usb3h1_pins_sleep: usb3h1_sleep {
+			mb86s7x,function = "usb3h1";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		cfg_pins_active: cfg_active {
+			mb86s7x,function = "cfg";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		cfg_pins_sleep: cfg_sleep {
+			mb86s7x,function = "cfg";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		uart0_pins_active: uart0_active {
+			mb86s7x,function = "uart0";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		uart0_pins_sleep: uart0_sleep {
+			mb86s7x,function = "uart0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		uart1_pins_active: uart1_active {
+			mb86s7x,function = "uart1";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		uart1_pins_sleep: uart1_sleep {
+			mb86s7x,function = "uart1";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		uart2_pins_active: uart2_active {
+			mb86s7x,function = "uart2";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		uart2_pins_sleep: uart2_sleep {
+			mb86s7x,function = "uart2";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		trace_pins_active: trace_active {
+			mb86s7x,function = "trace";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		trace_pins_sleep: trace_sleep {
+			mb86s7x,function = "trace";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		pl244_pins_active: pl244_active {
+			mb86s7x,function = "pl244";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		pl244_pins_sleep: pl244_sleep {
+			mb86s7x,function = "pl244";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		smt_pins_active: smt_active {
+			mb86s7x,function = "smt";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		smt_pins_sleep: smt_sleep {
+			mb86s7x,function = "smt";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+
+		memcs_pins_active: memcs_active {
+			mb86s7x,function = "memcs";
+			mb86s7x,drvst = <4>; /* in mA */
+		};
+		memcs_pins_sleep: memcs_sleep {
+			mb86s7x,function = "memcs";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+	};
+
+	gpio0: mb86s70_gpio0 {
+		compatible = "fujitsu,mb86s7x-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	gpio1: mb86s70_gpio1 {
+		compatible = "fujitsu,mb86s7x-gpio";
+		reg = <0 0x31010000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	pd_alwayson: genpd at 0 {
+		compatible = "fujitsu,mb86s7x-pd";
+		index = <0>;
+	};
+
+	pd_default: genpd at 1 {
+		compatible = "fujitsu,mb86s7x-pd";
+		index = <1>;
+	};
+
+	pd_offchip: genpd at 2 {
+		compatible = "fujitsu,mb86s7x-pd";
+		index = <2>;
+	};
+
+	pd_cpu: genpd at 3 {
+		compatible = "fujitsu,mb86s7x-pd";
+		index = <3>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0 0x2c001000 0x1000>,
+		      <0 0x2c002000 0x1000>,
+		      <0 0x2c004000 0x2000>,
+		      <0 0x2c006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+
+	pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 18 4>,
+			     <0 22 4>;
+		fujitsu,power-domain = <&pd_cpu>;
+	};
+
+	mhu: mhu0 at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "fujitsu,mhu";
+		reg = <0 0x2B1F0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+		fujitsu,power-domain = <&pd_default>;
+	};
+
+	mhu_client: scb at 0 {
+		compatible = "fujitsu,scb";
+		mbox = <&mhu 1>;
+		mbox-names = "HP_NonSec";
+	};
+
+	uart0: serial at 0x31040000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31040000 0x100>;
+		interrupts = <0 320 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+		fujitsu,power-domain = <&pd_default>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&uart0_pins_active>;
+		pinctrl-1 = <&uart0_pins_sleep>;
+	};
+
+	uart1: serial at 0x31050000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31050000 0x100>;
+		interrupts = <0 321 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+		fujitsu,power-domain = <&pd_default>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&uart1_pins_active>;
+		pinctrl-1 = <&uart1_pins_sleep>;
+	};
+
+	uart2: serial at 0x31060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31060000 0x100>;
+		interrupts = <0 322 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+		fujitsu,power-domain = <&pd_default>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&uart2_pins_active>;
+		pinctrl-1 = <&uart2_pins_sleep>;
+	};
+
+	sdhci0: emmc at 300c0000 {
+		compatible = "fujitsu,f-sdh30";
+		reg = <0 0x300c0000 0x1000>;
+		interrupts = <0 164 0x4>,
+			     <0 165 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		bus-width = <8>;
+		clocks = <&clk_alw_c_0>, <&clk_alw_b_0>;
+		clock-names = "sd_sd4clk", "sd_bclk";
+		fujitsu,power-domain = <&pd_default>;
+	};
+
+	sdhci1: sdio at 36600000 {
+		compatible = "fujitsu,f-sdh30";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		clocks = <&clk_main_c_0>, <&clk_main_d_0>;
+		clock-names = "sd_sd4clk", "sd_bclk";
+		resume-detect-retry;
+		fujitsu,power-domain = <&pd_offchip>;
+	};
+
+	eth0: f_taiki {
+                compatible = "fujitsu,ogma";
+		reg = <0 0x31600000 0x10000>, <0 0x31618000 0x4000>, <0 0x3161c000 0x4000>;
+		interrupts = <0 163 0x4>;
+		clocks = <&clk_alw_0_8>;
+		phy-mode = "rgmii";
+		max-speed = <1000>;
+		max-frame-size = <9000>;
+		local-mac-address = [ a4 17 31 00 00 ed ];
+		phy-handle = <&ethphy0>;
+		fujitsu,power-domain = <&pd_default>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 1 {
+			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s73eb.dts b/arch/arm/boot/dts/mb86s73eb.dts
new file mode 100644
index 0000000..81862d9
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73eb.dts
@@ -0,0 +1,73 @@
+
+/include/ "mb86s73.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Fujitsu MB86S73 EVB";
+	compatible = "fujitsu,mb86s73-evb";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "loglevel=4 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait rw";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		d34_a {
+			label = "led34a";
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+		d34_b {
+			label = "led34b";
+			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+		};
+		d37 {
+			label = "led37";
+			gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		d38 {
+			label = "led38";
+			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys-polled";
+		poll-interval = <20>;
+		home {
+			label = "Home";
+			gpios = <&gpio1 4 0>;
+			linux,code = <KEY_HOME>;
+			gpio-key;
+		};
+		power {
+			label = "Power";
+			gpios = <&gpio1 5 0>;
+			linux,code = <KEY_POWER>;
+			gpio-key;
+		};
+
+		up {
+			label = "Up";
+			gpios = <&gpio1 6 0>;
+			linux,code = <KEY_UP>;
+			gpio-key;
+		};
+		down {
+			label = "Down";
+			gpios = <&gpio1 7 0>;
+			linux,code = <KEY_DOWN>;
+			gpio-key;
+		};
+	};
+};
diff --git a/arch/arm/configs/fujitsu_defconfig b/arch/arm/configs/fujitsu_defconfig
new file mode 100644
index 0000000..bfc78c9
--- /dev/null
+++ b/arch/arm/configs/fujitsu_defconfig
@@ -0,0 +1,156 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="MB86S7x"
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_RD_XZ=y
+CONFIG_RD_LZO=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_ARCH_MB86S7X=y
+CONFIG_ARM_LPAE=y
+# CONFIG_SWP_EMULATE is not set
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_ARM_ERRATA_775420=y
+CONFIG_ARM_ERRATA_798181=y
+CONFIG_PCI=y
+CONFIG_PCIEASPM_POWERSAVE=y
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
+CONFIG_SCHED_SMT=y
+CONFIG_BL_SWITCHER=y
+CONFIG_BL_SWITCHER_DUMMY_IF=m
+CONFIG_VMSPLIT_2G=y
+CONFIG_PREEMPT=y
+CONFIG_THUMB2_KERNEL=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
+# CONFIG_ATAGS is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="mem=2048M earlycon=ttyS0,115200 earlyprintk console=ttyS0,115200 console=tty0 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"
+CONFIG_KEXEC=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_PM_WAKELOCKS=y
+CONFIG_PM_RUNTIME=y
+CONFIG_PM_DEBUG=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_XFRM_MODE_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_BEET=m
+CONFIG_IPV6_SIT=m
+# CONFIG_ANDROID_PARANOID_NETWORK is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FW_LOADER_USER_HELPER is not set
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=192
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=1024
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
+CONFIG_INPUT_EVDEV=m
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO_POLLED=y
+# CONFIG_MOUSE_PS2 is not set
+CONFIG_MOUSE_GPIO=m
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_EGALAX=m
+CONFIG_TOUCHSCREEN_ILI210X=m
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=16
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_CLKGATE=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_F_SDH30=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=m
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=m
+CONFIG_MAILBOX=y
+CONFIG_MBOX_F_MHU=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_VFAT_FS=m
+CONFIG_TMPFS=y
+CONFIG_CONFIGFS_FS=m
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_RCU_CPU_STALL_VERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_USER=y
+# CONFIG_DEBUG_LL is not set
+CONFIG_DEBUG_LL_UART_8250=y
+CONFIG_DEBUG_UART_PHYS=0x31040000
+CONFIG_DEBUG_UART_VIRT=0xfe000000
+CONFIG_DEBUG_UART_8250_WORD=y
+# CONFIG_EARLY_PRINTK is not set
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
new file mode 100644
index 0000000..44f5b0c
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Kconfig
@@ -0,0 +1,18 @@
+config ARCH_MB86S7X
+	bool "Fujitsu MB86S7x platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_TIMER_SP804
+	select HAVE_ARM_ARCH_TIMER
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
+	select PM_OPP
+	select PINCTRL
+	select PINCTRL_MB86S7X
+	select ARM_CCI
+	select BIG_LITTLE
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Support for Fujitsu MB86S7x based platforms
diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
new file mode 100644
index 0000000..5524a6c
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/Makefile
@@ -0,0 +1,2 @@
+obj-y		+= board.o scb_mhu.o mcpm.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
diff --git a/arch/arm/mach-mb86s7x/board.c b/arch/arm/mach-mb86s7x/board.c
new file mode 100644
index 0000000..d6e76ec
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/board.c
@@ -0,0 +1,65 @@
+/*
+ * Support for the Fujitsu's MB86S7x based devices.
+ *
+ * Copyright (C) 2014 Linaro, LTD
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/of.h>
+
+#include <asm/mcpm.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+
+#include "iomap.h"
+
+bool __init mb86s7x_smp_init_ops(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
+	if (node && of_device_is_available(node)) {
+		mcpm_smp_set_ops();
+		return true;
+	}
+
+	return false;
+}
+
+#define IOMAP_DEV(name) { \
+		.virtual = (unsigned long) MB86S7X_##name##_VIRT, \
+		.pfn = __phys_to_pfn(MB86S7X_##name##_PHYS), \
+		.length = MB86S7X_##name##_SIZE, \
+		.type = MT_DEVICE, \
+	}
+
+static struct map_desc mb86s7x_io_desc[] = {
+	IOMAP_DEV(MHU),
+	IOMAP_DEV(ISRAM),
+};
+
+void __init mb86s7x_dt_map_io(void)
+{
+	iotable_init(mb86s7x_io_desc, ARRAY_SIZE(mb86s7x_io_desc));
+}
+
+static const char *mb86s7x_dt_match[] __initconst = {
+	"fujitsu,mb86s70-evb",
+	"fujitsu,mb86s73-evb",
+	NULL,
+};
+
+DT_MACHINE_START(MB86S7X_DT, "Fujitsu MB86S7X-based board")
+	.dt_compat	= mb86s7x_dt_match,
+	.smp_init	= smp_init_ops(mb86s7x_smp_init_ops),
+	.map_io		= mb86s7x_dt_map_io,
+MACHINE_END
diff --git a/arch/arm/mach-mb86s7x/iomap.h b/arch/arm/mach-mb86s7x/iomap.h
new file mode 100644
index 0000000..2b8db1d
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/iomap.h
@@ -0,0 +1,34 @@
+/*
+ * arch/arm/mach-mb86s7x/iomap.h
+ *
+ * Created by: Jassi Brar <jassisinghbrar@gmail.com>
+ * Copyright:	(C) 2013-2014 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MB86S7X_IOMAP_H
+#define __MB86S7X_IOMAP_H
+
+#include <linux/sizes.h>
+
+#define SEC_RSTADDR_OFF		0x3fc
+
+#define MB86S7X_MHU_PHYS	0x2b1f0000
+#define MB86S7X_MHU_SIZE	SZ_4K
+
+/* Internal SRAM */
+#define MB86S7X_ISRAM_PHYS	0x2e000000
+#define MB86S7X_ISRAM_SIZE	SZ_16K
+#define MB86S7X_TRAMPOLINE_PHYS	(MB86S7X_ISRAM_PHYS + 0x3c00)
+
+#define MB86S7X_ISRAM_VIRT	IOMEM(0xfe000000)
+#define MB86S7X_MHU_VIRT	(MB86S7X_ISRAM_VIRT + MB86S7X_ISRAM_SIZE)
+
+/* Non-Secure High-Priority Channel is used */
+#define MB86S7X_SHM_FROM_SCB_VIRT	(MB86S7X_ISRAM_VIRT + 0x3800)
+#define MB86S7X_TRAMPOLINE_VIRT		(MB86S7X_ISRAM_VIRT + 0x3c00)
+
+#endif /* __MB86S7X_IOMAP_H */
diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
new file mode 100644
index 0000000..86d223f
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/mcpm.c
@@ -0,0 +1,293 @@
+/*
+ * arch/arm/mach-mb86s7x/mcpm.c
+ *
+ * "Inspired" by tc_pm.c
+ * Copyright:	(C) 2013-2014  Fujitsu Semiconductor Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <linux/arm-cci.h>
+#include <linux/spinlock.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/platform_data/mb86s7x_mbox.h>
+
+#include <asm/mcpm.h>
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/system_misc.h>
+
+#include "iomap.h"
+
+static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int mb86s7x_pm_use_count[2][2];
+
+#define MB86S7X_WFICOLOR_VIRT (MB86S7X_ISRAM_VIRT + WFI_COLOR_REG_OFFSET)
+
+static void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
+{
+	u8 val;
+
+	if (clr & ~AT_WFI_COLOR_MASK)
+		return;
+
+	val = readb_relaxed(MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
+	val &= ~AT_WFI_COLOR_MASK;
+	val |= clr;
+	writeb_relaxed(val, MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
+}
+
+static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
+{
+	struct completion got_rsp;
+	int ret = 0;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	arch_spin_lock(&mb86s7x_pm_lock);
+
+	mb86s7x_pm_use_count[cpu][cluster]++;
+
+	if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
+		struct mb86s7x_cpu_gate cmd;
+
+		arch_spin_unlock(&mb86s7x_pm_lock);
+		cmd.payload_size = sizeof(cmd);
+		cmd.cluster_class = 0;
+		cmd.cluster_id = cluster;
+		cmd.cpu_id = cpu;
+		cmd.cpu_state = SCB_CPU_STATE_ON;
+
+		pr_debug("%s:%d CMD Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
+			 __func__, __LINE__, cmd.cluster_class,
+			 cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
+
+		init_completion(&got_rsp);
+		mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
+		ret = mhu_send_packet(CMD_CPU_CLOCK_GATE_SET_REQ,
+				      &cmd, sizeof(cmd), &got_rsp);
+		if (ret < 0) {
+			pr_err("%s:%d failed!\n", __func__, __LINE__);
+			return ret;
+		}
+		if (ret)
+			wait_for_completion(&got_rsp);
+
+		pr_debug("%s:%d REP Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u}\n",
+			 __func__, __LINE__, cmd.cluster_class,
+			 cmd.cluster_id, cmd.cpu_id, cmd.cpu_state);
+
+		if (cmd.cpu_state != SCB_CPU_STATE_ON)
+			return -ENODEV;
+
+	} else if (mb86s7x_pm_use_count[cpu][cluster] != 2) {
+		/*
+		 * The only possible values are:
+		 * 0 = CPU down
+		 * 1 = CPU (still) up
+		 * 2 = CPU requested to be up before it had a chance
+		 *     to actually make itself down.
+		 * Any other value is a bug.
+		 */
+		BUG();
+	}
+
+	arch_spin_unlock(&mb86s7x_pm_lock);
+
+	return 0;
+}
+
+static void mb86s7x_pm_suspend(u64 ignored)
+{
+	unsigned int mpidr, cpu, cluster;
+	bool last_man = false, skip_wfi = false;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	arch_spin_lock(&mb86s7x_pm_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+
+	mb86s7x_pm_use_count[cpu][cluster]--;
+
+	if (mb86s7x_pm_use_count[cpu][cluster] == 0) {
+		if (!mb86s7x_pm_use_count[0][cluster] &&
+		    !mb86s7x_pm_use_count[1][cluster])
+			last_man = true;
+		mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_POWEROFF);
+	} else if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
+		skip_wfi = true; /* Overtaken by a power up */
+	} else {
+		BUG();
+	}
+
+	if (!skip_wfi)
+		gic_cpu_if_down();
+
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
+		arch_spin_unlock(&mb86s7x_pm_lock);
+
+		if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+			/*
+			 * On the Cortex-A15 we need to disable
+			 * L2 prefetching before flushing the cache.
+			 */
+			asm volatile(
+			"mcr p15, 1, %0, c15, c0, 3\n\t"
+			"isb\n\t"
+			"dsb"
+			: : "r" (0x400));
+		}
+
+		v7_exit_coherency_flush(all);
+
+		cci_disable_port_by_cpu(mpidr);
+
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		arch_spin_unlock(&mb86s7x_pm_lock);
+		v7_exit_coherency_flush(louis);
+	}
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	/* Now we are prepared for power-down, do it: */
+	if (!skip_wfi)
+		wfi();
+
+	/* Not dead at this point?  Let our caller cope. */
+}
+
+static void mb86s7x_pm_power_down(void)
+{
+	mb86s7x_pm_suspend(0);
+}
+
+static int mb86s7x_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+{
+	struct mb86s7x_cpu_gate cmd;
+	struct completion got_rsp;
+	int i, ret;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.cluster_class = 0;
+	cmd.cluster_id = cluster;
+	cmd.cpu_id = cpu;
+	cmd.cpu_state = SCB_CPU_STATE_ON;
+
+	for (i = 0; i < 50; i++) {
+		init_completion(&got_rsp);
+		ret = mhu_send_packet(CMD_CPU_CLOCK_GATE_GET_REQ,
+				      &cmd, sizeof(cmd), &got_rsp);
+		if (ret < 0) {
+			pr_err("%s:%d failed to get CPU status\n",
+			       __func__, __LINE__);
+			return -ETIMEDOUT;
+		}
+		if (ret)
+			wait_for_completion(&got_rsp);
+
+		pr_debug("%s:%d Cl_Class-%u CL_ID-%u CPU_ID-%u STATE-%u\n",
+			 __func__, __LINE__,
+			 cmd.cluster_class, cmd.cluster_id,
+			 cmd.cpu_id, cmd.cpu_state);
+
+		if (cmd.cpu_state == SCB_CPU_STATE_OFF)
+			return 0;
+
+		msleep(20);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct mcpm_platform_ops mb86s7x_pm_power_ops = {
+	.power_up		= mb86s7x_pm_power_up,
+	.power_down		= mb86s7x_pm_power_down,
+	.wait_for_powerdown	= mb86s7x_wait_for_powerdown,
+	.suspend		= mb86s7x_pm_suspend,
+};
+
+static void mb86s7x_restart(enum reboot_mode reboot_mode, const char *unused)
+{
+	/* Reboot immediately */
+	mb86s7x_reboot(50);
+}
+
+static void mb86s7x_poweroff(void)
+{
+	/* Reboot never, remain dead */
+	mb86s7x_reboot(~0);
+}
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ */
+static void __naked mb86s7x_pm_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile ("\n"
+"	cmp	r0, #1\n"
+"	bxne	lr\n"
+"	b	cci_enable_port_for_self");
+}
+
+static int __init mb86s7x_mcpm_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	struct mb86s7x_scb_version cmd;
+	struct completion got_rsp;
+	int ret;
+
+	arm_pm_restart = mb86s7x_restart;
+	pm_power_off = mb86s7x_poweroff;
+
+	if (!cci_probed())
+		return -ENODEV;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_info("Booting on cpu_%u cluster_%u\n", cpu, cluster);
+	mb86s7x_pm_use_count[cpu][cluster] = 1;
+
+	/* reset the wfi 'color' for primary cpu */
+	mb86s7x_set_wficolor(cluster, cpu, AT_WFI_DO_NOTHING);
+
+	/* Set entry point for any CPU nowonwards */
+	writel_relaxed(virt_to_phys(mcpm_entry_point),
+		     MB86S7X_TRAMPOLINE_VIRT + SEC_RSTADDR_OFF);
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.version = 0;
+	cmd.config_version = 0;
+	init_completion(&got_rsp);
+	ret = mhu_send_packet(CMD_SCB_CAPABILITY_GET_REQ,
+			      &cmd, sizeof(cmd), &got_rsp);
+	if (ret < 0)
+		pr_err("%s:%d failed to get SCB version\n",
+		       __func__, __LINE__);
+	if (ret)
+		wait_for_completion(&got_rsp);
+
+	pr_info("MB86S7x MCPM initialized: SCB version 0x%x:0x%x\n",
+		cmd.version, cmd.config_version);
+
+	ret = mcpm_platform_register(&mb86s7x_pm_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(mb86s7x_pm_power_up_setup);
+
+	return ret;
+}
+early_initcall(mb86s7x_mcpm_init);
diff --git a/arch/arm/mach-mb86s7x/pm_domains.c b/arch/arm/mach-mb86s7x/pm_domains.c
new file mode 100644
index 0000000..1fec5ed
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/pm_domains.c
@@ -0,0 +1,237 @@
+/*
+ * mb86s7x generic powerdomain support
+ * Copyright (C) 2014 Linaro, Ltd  Andy Green <andy.green@linaro.org>
+ *
+ * based on -->
+ *
+ * Exynos Generic power domain support.
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Implementation of Exynos specific power domain control which is used in
+ * conjunction with runtime-pm. Support for both device-tree and non-device-tree
+ * based power domain support is included.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_domain.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/sched.h>
+#include <linux/platform_data/mb86s7x_mbox.h>
+
+/*
+ * mb86s7x specific wrapper around the generic power domain
+ */
+struct mb86s7x_pm_domain {
+	struct generic_pm_domain pd;
+	char const *name;
+	int powerdomain_index;
+	bool is_off;
+};
+
+static int mb86s7x_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	struct mb86s7x_pm_domain *pd;
+	struct mb86s7x_pmd_cmd cmd;
+	struct completion got_rsp;
+	int ret;
+
+	pd = container_of(domain, struct mb86s7x_pm_domain, pd);
+
+	pr_debug("%s: domain %s <- %d\n", __func__, pd->name, power_on);
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.powerdomain_index = pd->powerdomain_index;
+	cmd.state = power_on;
+	if (pd->powerdomain_index >= 0) {
+		pr_info("First powerdomain index1 set :%d .\n",
+			pd->powerdomain_index);
+		init_completion(&got_rsp);
+
+		ret = mhu_send_packet(CMD_POWERDOMAIN_SET_REQ,
+				      &cmd, sizeof(cmd), &got_rsp);
+		if (ret < 0) {
+			pr_err("%s:%d failed to set powerdomain\n",
+			       __func__, __LINE__);
+			return ret;
+		}
+		if (ret)
+			wait_for_completion(&got_rsp);
+	}
+	pd->is_off = !power_on;
+	return 0;
+}
+
+static int mb86s7x_pd_power_on(struct generic_pm_domain *domain)
+{
+	return mb86s7x_pd_power(domain, true);
+}
+
+static int mb86s7x_pd_power_off(struct generic_pm_domain *domain)
+{
+	return mb86s7x_pd_power(domain, false);
+}
+
+static void mb86s7x_add_device_to_domain(struct mb86s7x_pm_domain *pd,
+					 struct device *dev)
+{
+	int ret;
+
+	dev_info(dev, "adding to power domain %s\n", pd->pd.name);
+
+	while (1) {
+		ret = pm_genpd_add_device(&pd->pd, dev);
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	}
+
+	pm_genpd_dev_need_restore(dev, true);
+}
+
+static void mb86s7x_remove_device_from_domain(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	int ret;
+
+	if (genpd == ERR_PTR(-EINVAL)) {
+		dev_dbg(dev, "device has no power domain\n");
+		return;
+	}
+
+	dev_info(dev, "removing from power domain %s\n", genpd->name);
+
+	while (1) {
+		ret = pm_genpd_remove_device(genpd, dev);
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static void mb86s7x_read_domain_from_dt(struct device *dev)
+{
+	struct platform_device *pd_pdev;
+	struct mb86s7x_pm_domain *pd;
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "fujitsu,power-domain", 0);
+	if (!node)
+		return;
+	pd_pdev = of_find_device_by_node(node);
+	if (!pd_pdev)
+		return;
+	pd = platform_get_drvdata(pd_pdev);
+	mb86s7x_add_device_to_domain(pd, dev);
+}
+
+static int mb86s7x_pm_notifier_call(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	switch (event) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		if (dev->of_node)
+			mb86s7x_read_domain_from_dt(dev);
+
+		break;
+
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		mb86s7x_remove_device_from_domain(dev);
+
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block platform_nb = {
+	.notifier_call = mb86s7x_pm_notifier_call,
+};
+
+static __init int mb86s7x_pm_init_power_domain(void)
+{
+	struct platform_device *pdev, *master_pd_pdev;
+	struct device_node *np, *master_node;
+	struct mb86s7x_pmd_cmd cmd;
+	struct completion got_rsp;
+	int ret;
+
+	for_each_compatible_node(np, NULL, "fujitsu,mb86s7x-pd") {
+		struct mb86s7x_pm_domain *pd, *master_pd;
+
+		pdev = of_find_device_by_node(np);
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			pr_err("%s: failed to allocate memory for domain\n",
+			       __func__);
+			return -ENOMEM;
+		}
+
+		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
+		pd->name = pd->pd.name;
+		pd->pd.power_off = mb86s7x_pd_power_off;
+		pd->pd.power_on = mb86s7x_pd_power_on;
+		pd->pd.of_node = np;
+
+		if (of_property_read_u32(np, "index", &pd->powerdomain_index))
+			pd->powerdomain_index = -1;
+
+		platform_set_drvdata(pdev, pd);
+
+		/* first power domain */
+		cmd.payload_size = sizeof(cmd);
+		cmd.powerdomain_index = pd->powerdomain_index;
+		cmd.state = 0;
+
+		if (pd->powerdomain_index >= 0) {
+			init_completion(&got_rsp);
+
+			ret = mhu_send_packet(CMD_POWERDOMAIN_GET_REQ,
+					      &cmd, sizeof(cmd), &got_rsp);
+			if (ret < 0)
+				pr_err("%s:%d failed to get SCB version\n",
+				       __func__, __LINE__);
+			if (ret)
+				wait_for_completion(&got_rsp);
+		}
+
+		pm_genpd_init(&pd->pd, NULL, !cmd.state);
+
+		dev_info(&pdev->dev, "power domain %s starting\n", pd->pd.name);
+
+		/* find any master domain and register self to it*/
+		master_node = of_parse_phandle(np, "fujitsu,power-domain", 0);
+		if (!master_node)
+			continue;
+		master_pd_pdev = of_find_device_by_node(master_node);
+		if (!master_pd_pdev) {
+			pr_err("sneeker : this should never happened.\n");
+			continue;
+		}
+		master_pd = platform_get_drvdata(master_pd_pdev);
+		while (1) {
+			ret = pm_genpd_add_subdomain(&master_pd->pd, &pd->pd);
+			if (ret != -EAGAIN)
+				break;
+			cond_resched();
+		}
+	}
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	pr_info("mb86s7x Power Domain support initialized\n");
+
+	return 0;
+}
+arch_initcall(mb86s7x_pm_init_power_domain);
diff --git a/arch/arm/mach-mb86s7x/scb_mhu.c b/arch/arm/mach-mb86s7x/scb_mhu.c
new file mode 100644
index 0000000..fd5f034
--- /dev/null
+++ b/arch/arm/mach-mb86s7x/scb_mhu.c
@@ -0,0 +1,447 @@
+/*
+ * arch/arm/mach-mb86s7x/scb_mhu.c Shim 'server' for Mailbox clients
+ *
+ * Created by: Jassi Brar <jassisinghbrar@gmail.com>
+ * Copyright:	(C) 2013-2014 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/mb86s7x_mbox.h>
+
+#include "iomap.h"
+
+#define INTR_STAT_OFS	0x0
+#define INTR_SET_OFS	0x8
+#define INTR_CLR_OFS	0x10
+
+static int do_xfer(void);
+static void try_xfer(struct work_struct *ignored);
+
+static void __iomem *cmd_from_scb = MB86S7X_SHM_FROM_SCB_VIRT;
+static void __iomem *rsp_from_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x100;
+static void __iomem *cmd_to_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x200;
+static void __iomem *rsp_to_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x300;
+
+static LIST_HEAD(free_xfers);
+static LIST_HEAD(pending_xfers);
+static DEFINE_SPINLOCK(fsm_lock);
+static struct mbox_client mhu_cl;
+static struct mbox_chan *mhu_chan;
+static DECLARE_WORK(scb_work, try_xfer);
+static mhu_handler_t handler[MHU_NUM_CMDS];
+
+static enum {
+	MHU_PARK = 0,
+	MHU_WRR, /* Waiting to get Remote's Reply */
+	MHU_WRL, /* Waiting to send Reply */
+	MHU_WRRL, /* WAIT_Ra && WAIT_Rb */
+	MHU_INVLD,
+} fsm_state;
+
+enum fsm_event {
+	EV_LC = 0, /* Local sent a command */
+	EV_RC, /* Remote sent a command */
+	EV_RR, /* Remote sent a reply */
+	EV_LR, /* Local sent a reply */
+};
+
+static int mhu_fsm[4][4] = {
+	[MHU_PARK] = {
+		[EV_LC] = MHU_WRR,
+		[EV_RC] = MHU_WRL,
+		[EV_RR] = MHU_INVLD,
+		[EV_LR] = MHU_INVLD,
+	},
+	[MHU_WRR] = {
+		[EV_LC] = MHU_INVLD,
+		[EV_RC] = MHU_WRRL,
+		[EV_RR] = MHU_PARK,
+		[EV_LR] = MHU_INVLD,
+	},
+	[MHU_WRL] = {
+		[EV_LC] = MHU_WRRL,
+		[EV_RC] = MHU_INVLD,
+		[EV_RR] = MHU_INVLD,
+		[EV_LR] = MHU_PARK,
+	},
+	[MHU_WRRL] = {
+		[EV_LC] = MHU_INVLD,
+		[EV_RC] = MHU_INVLD,
+		[EV_RR] = MHU_WRL,
+		[EV_LR] = MHU_WRR,
+	},
+};
+
+struct mhu_xfer {
+	int code;
+	int len;
+	void *buf;
+	struct completion *c;
+	struct list_head node;
+};
+
+static struct mhu_xfer *ax; /* stages of xfer */
+
+static int mhu_alloc_xfers(int n, struct list_head *list)
+{
+	struct mhu_xfer *x = kcalloc(n, sizeof(struct mhu_xfer), GFP_ATOMIC);
+	int i;
+
+	if (!x)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++)
+		list_add(&x[i].node, &free_xfers);
+
+	return 0;
+}
+
+static void try_xfer(struct work_struct *ignored)
+{
+	/* If polling overtook the scheduled work */
+	if (mhu_chan == NULL)
+		return;
+
+	/* Now that we got a reply to last TX, that
+	 * must mean the last TX was successful */
+	mbox_client_txdone(mhu_chan, 0);
+
+	do_xfer();
+}
+
+static void got_data(u32 code)
+{
+	struct completion *c = NULL;
+	mhu_handler_t hndlr = NULL;
+	unsigned long flags;
+	int ev;
+
+	if (code & RESP_BIT)
+		ev = EV_RR;
+	else
+		ev = EV_RC;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		pr_err("State-%d EV-%d FSM Broken!\n", fsm_state, ev);
+		return;
+	}
+	fsm_state = mhu_fsm[fsm_state][ev];
+
+	if (code & RESP_BIT) {
+		c = ax->c;
+		memcpy_fromio(ax->buf, rsp_from_scb, ax->len);
+		list_move(&ax->node, &free_xfers);
+		ax = NULL;
+	} else {
+		/* Find and dispatch relevant registered handler */
+		if (code < MHU_NUM_CMDS)
+			hndlr = handler[code];
+		if (!hndlr)
+			pr_err("No handler for CMD_%u\n", code);
+	}
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	if (hndlr)
+		hndlr(code, cmd_from_scb);
+	if (c)
+		complete(c);
+}
+
+static void mhu_recv(struct mbox_client *cl, void *data)
+{
+	got_data((u32)data);
+	schedule_work(&scb_work);
+}
+
+static int do_xfer(void)
+{
+	unsigned long flags;
+	struct mhu_xfer *x;
+	int ev;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (list_empty(&pending_xfers)) {
+		struct mbox_chan *_ch = NULL;
+		int cmd;
+
+		for (cmd = 0; cmd < MHU_NUM_CMDS && !handler[cmd]; cmd++)
+			;
+		/* Don't free channel if any user is listening */
+		if (cmd != MHU_NUM_CMDS) {
+			spin_unlock_irqrestore(&fsm_lock, flags);
+			return 1;
+		}
+
+		if (fsm_state == MHU_PARK) {
+			_ch = mhu_chan;
+			mhu_chan = NULL;
+		}
+
+		spin_unlock_irqrestore(&fsm_lock, flags);
+
+		if (_ch)
+			mbox_free_channel(_ch);
+
+		return 1;
+	}
+
+	x = list_first_entry(&pending_xfers, struct mhu_xfer, node);
+	ev = x->code & RESP_BIT ? EV_LR : EV_LC;
+
+	if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		pr_err("%s:%d\n", __func__, __LINE__);
+		return 1;
+	}
+	list_del_init(&x->node);
+
+	/* Layout the SHM */
+	if (x->code & RESP_BIT)
+		memcpy_toio(rsp_to_scb, x->buf, x->len);
+	else
+		memcpy_toio(cmd_to_scb, x->buf, x->len);
+
+	ev = x->code & RESP_BIT ? EV_LR : EV_LC;
+	if (ev == EV_LC)
+		ax = x;
+	else
+		list_move(&x->node, &free_xfers);
+	fsm_state = mhu_fsm[fsm_state][ev];
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	/* Prefer mailbox API */
+	if (!mhu_chan) {
+		struct mbox_chan *_ch;
+
+		_ch = mbox_request_channel(&mhu_cl);
+		if (!IS_ERR(_ch))
+			mhu_chan = _ch;
+	}
+
+	if (mhu_chan) {
+		/* Send via generic api */
+		mbox_send_message(mhu_chan, (void *)x->code);
+	} else {
+		void __iomem *tx_reg = MB86S7X_MHU_VIRT + 0x120; /* HP-NonSec */
+		void __iomem *rx_reg = MB86S7X_MHU_VIRT + 0x20; /* HP-NonSec */
+		u32 val, count;
+
+		/* Send via early-boot api */
+		val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+		if (val) {
+			pr_err("Last CMD not yet read by SCB\n");
+			writel_relaxed(val, tx_reg + INTR_CLR_OFS);
+		}
+
+		writel_relaxed(x->code, tx_reg + INTR_SET_OFS);
+
+		/* Wait until this message is read */
+		count = 0x1000000;
+		do {
+			cpu_relax();
+			val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+		} while (--count && val);
+		if (val)
+			pr_err("%s:%d SCB not listening!\n",
+			       __func__, __LINE__);
+
+		if (!ax) {
+			/* A quick poll for pending remote cmd */
+			val = readl_relaxed(rx_reg + INTR_STAT_OFS);
+			if (val) {
+				got_data(val);
+				writel_relaxed(val, rx_reg + INTR_CLR_OFS);
+			}
+		} else {
+			do {
+retry:
+				/* Wait until we get reply */
+				count = 0x1000000;
+				do {
+					cpu_relax();
+					val = readl_relaxed(
+						rx_reg + INTR_STAT_OFS);
+				} while (--count && !val);
+
+				if (!val) {
+					pr_err("%s:%d SCB didn't reply\n",
+					       __func__, __LINE__);
+					goto retry;
+				} else {
+					got_data(val);
+					writel_relaxed(val,
+						     rx_reg + INTR_CLR_OFS);
+				}
+			} while (!(val & RESP_BIT));
+		}
+		return 0;
+	}
+
+	return do_xfer();
+}
+
+int mhu_hndlr_set(u32 cmd, mhu_handler_t hndlr)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+	if (cmd < MHU_NUM_CMDS && !handler[cmd]) {
+		ret = 0;
+		handler[cmd] = hndlr;
+	}
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	if (!mhu_chan) {
+		struct mbox_chan *_ch;
+
+		_ch = mbox_request_channel(&mhu_cl);
+		if (!IS_ERR(_ch))
+			mhu_chan = _ch;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhu_hndlr_set);
+
+void mhu_hndlr_clr(u32 cmd, mhu_handler_t hndlr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (cmd < MHU_NUM_CMDS && handler[cmd] == hndlr)
+		handler[cmd] = NULL;
+
+	if (list_empty(&pending_xfers)) {
+		struct mbox_chan *_ch = NULL;
+
+		for (cmd = 0; cmd < MHU_NUM_CMDS && !handler[cmd]; cmd++)
+			;
+		/* Don't free channel if any user is listening */
+		if (cmd != MHU_NUM_CMDS) {
+			spin_unlock_irqrestore(&fsm_lock, flags);
+			return;
+		}
+
+		if (fsm_state == MHU_PARK) {
+			_ch = mhu_chan;
+			mhu_chan = NULL;
+		}
+
+		spin_unlock_irqrestore(&fsm_lock, flags);
+
+		if (_ch)
+			mbox_free_channel(_ch);
+
+		return;
+	}
+	spin_unlock_irqrestore(&fsm_lock, flags);
+}
+EXPORT_SYMBOL_GPL(mhu_hndlr_clr);
+
+int mhu_send_packet(int code, void *buf, int len, struct completion *c)
+{
+	struct mhu_xfer *x;
+	unsigned long flags;
+
+	if (code & ~0xff) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if ((code & RESP_BIT) &&
+			fsm_state != MHU_WRRL && fsm_state != MHU_WRL) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&fsm_lock, flags);
+
+	if (list_empty(&free_xfers) && mhu_alloc_xfers(5, &free_xfers)) {
+		spin_unlock_irqrestore(&fsm_lock, flags);
+		pr_err("%s:%d OOM\n", __func__, __LINE__);
+		return -EAGAIN;
+	}
+
+	x = list_first_entry(&free_xfers, struct mhu_xfer, node);
+	x->code = code;
+	x->buf = buf;
+	x->len = len;
+	x->c = c;
+
+	if (code & RESP_BIT)
+		list_move(&x->node, &pending_xfers);
+	else
+		list_move_tail(&x->node, &pending_xfers);
+
+	spin_unlock_irqrestore(&fsm_lock, flags);
+
+	return do_xfer();
+}
+EXPORT_SYMBOL_GPL(mhu_send_packet);
+
+void mb86s7x_reboot(u32 delay)
+{
+	void __iomem *tx_reg = MB86S7X_MHU_VIRT + 0x120; /* HP-NonSec */
+	struct mb86s7x_hard_reset cmd;
+	u32 val;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.delay = delay;
+
+	val = readl_relaxed(tx_reg + INTR_STAT_OFS);
+	if (val) /* Flush anything pending */
+		writel_relaxed(val, tx_reg + INTR_CLR_OFS);
+
+	memcpy_toio(cmd_to_scb, &cmd, sizeof(cmd));
+	writel_relaxed(CMD_HARD_RESET_REQ, tx_reg + INTR_SET_OFS);
+}
+EXPORT_SYMBOL_GPL(mb86s7x_reboot);
+
+static int f_scb_probe(struct platform_device *pdev)
+{
+	mhu_cl.tx_block = true;
+	mhu_cl.knows_txdone = true;
+	mhu_cl.rx_callback = mhu_recv;
+	mhu_cl.dev = &pdev->dev;
+	mhu_cl.chan_name = "HP_NonSec";
+	return 0;
+}
+
+static const struct of_device_id scb_dt_ids[] = {
+	{ .compatible = "fujitsu,scb" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, scb_dt_ids);
+
+static struct platform_driver f_scb_driver = {
+	.driver		= {
+		.name	= "f_scb",
+		.owner = THIS_MODULE,
+		.of_match_table = scb_dt_ids,
+	},
+	.probe = f_scb_probe,
+};
+
+static int __init f_scb_init(void)
+{
+	return platform_driver_register(&f_scb_driver);
+}
+module_init(f_scb_init);
diff --git a/include/linux/platform_data/mb86s7x_mbox.h b/include/linux/platform_data/mb86s7x_mbox.h
new file mode 100644
index 0000000..4f4287e
--- /dev/null
+++ b/include/linux/platform_data/mb86s7x_mbox.h
@@ -0,0 +1,249 @@
+/*
+ * include/linux/platform_data/mb86s7x_mbox.h
+ *
+ * Created by: Jassi Brar <jassisinghbrar@gmail.com>
+ * Copyright:	(C) 2013-2014 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MB86S7X_MBOX_API_H
+#define __MB86S7X_MBOX_API_H
+
+#define CMD_MASK    0x7f    /* 128 possible commands */
+#define RESP_BIT    (1 << 7) /* If it's a response */
+
+#define ENC_CMD(c)  ((c) & CMD_MASK)
+#define DEC_CMD(v)  (((v) & ~CMD_MASK) ? CMD_INVALID : ((v) & CMD_MASK))
+
+#define ENC_REP(r)  (((r) & CMD_MASK) | RESP_BIT)
+
+/* If v is the reply to command c */
+#define IS_A_REP(v, c)  (((v) & RESP_BIT) && (((v) & CMD_MASK) == (c)))
+
+enum {
+	CMD_INVALID = 0,
+	CMD_I2C_XFER_REQ = 1,
+	CMD_PERI_POWER_SET_REQ = 2,
+	CMD_PERI_CLOCK_GATE_SET_REQ = 3,
+	CMD_PERI_CLOCK_GATE_GET_REQ = 4,
+	CMD_PERI_CLOCK_RATE_SET_REQ = 5,
+	CMD_PERI_CLOCK_RATE_GET_REQ = 6,
+	CMD_CPU_CLOCK_GATE_SET_REQ = 7,
+	CMD_CPU_CLOCK_GATE_GET_REQ = 8,
+	CMD_CPU_CLOCK_RATE_SET_REQ = 9,
+	CMD_CPU_CLOCK_RATE_GET_REQ = 0xa,
+	CMD_CLUSTER_OPP_GET_REQ = 0xb,
+	CMD_CLOCK_DSI_PIXEL_REQ = 0xc,
+	CMD_SCB_CAPABILITY_GET_REQ = 0xd,
+	CMD_SYS_RESET_CAUSE_GET_REQ = 0xe,
+	CMD_SYS_SPECIFIC_INFO_GET_REQ = 0xf,
+	CMD_REBOOT_AP_AFTER_REQ = 0x10,
+	CMD_TAIKI_REQ = 0x11,
+	CMD_TAIKI_ASYNC_MSG_REQ = 0x12,
+	CMD_GET_WORD_REQ = 0x13,
+	CMD_HARD_RESET_REQ = 0x14,
+	CMD_MAINTENANCE_MODE_REQ = 0x15,
+	CMD_STG_GET_SIZE_REQ = 0x16,
+	CMD_STG_BLOCK_READ_REQ = 0x17,
+	CMD_STG_BLOCK_WRITE_REQ = 0x18,
+	CMD_MEMORY_LAYOUT_GET_REQ = 0x19,
+	CMD_POWERDOMAIN_GET_REQ = 0x1a,
+	CMD_POWERDOMAIN_SET_REQ = 0x1b,
+	CMD_STG_BLOCK_ERASE_REQ = 0x1c,
+
+	/* Do NOT add new commands below this line */
+	MHU_NUM_CMDS,
+};
+
+#define CMD_I2C_XFER_REP	ENC_REP(CMD_I2C_XFER_REQ)
+#define CMD_PERI_POWER_SET_REP	ENC_REP(CMD_PERI_POWER_SET_REQ)
+#define CMD_PERI_CLOCK_GATE_SET_REP	ENC_REP(CMD_PERI_CLOCK_GATE_SET_REQ)
+#define CMD_PERI_CLOCK_GATE_GET_REP	ENC_REP(CMD_PERI_CLOCK_GATE_GET_REQ)
+#define CMD_PERI_CLOCK_RATE_SET_REP	ENC_REP(CMD_PERI_CLOCK_RATE_SET_REQ)
+#define CMD_PERI_CLOCK_RATE_GET_REP	ENC_REP(CMD_PERI_CLOCK_RATE_GET_REQ)
+#define CMD_CPU_CLOCK_GATE_SET_REP	ENC_REP(CMD_CPU_CLOCK_GATE_SET_REQ)
+#define CMD_CPU_CLOCK_GATE_GET_REP	ENC_REP(CMD_CPU_CLOCK_GATE_GET_REQ)
+#define CMD_CPU_CLOCK_RATE_SET_REP	ENC_REP(CMD_CPU_CLOCK_RATE_SET_REQ)
+#define CMD_CPU_CLOCK_RATE_GET_REP	ENC_REP(CMD_CPU_CLOCK_RATE_GET_REQ)
+#define CMD_CLUSTER_OPP_GET_REP	ENC_REP(CMD_CLUSTER_OPP_GET_REQ)
+#define CMD_CLOCK_DSI_PIXEL_REP	ENC_REP(CMD_CLOCK_DSI_PIXEL_REQ)
+#define CMD_SCB_CAPABILITY_GET_REP	ENC_REP(CMD_SCB_CAPABILITY_GET_REQ)
+#define CMD_SYS_RESET_CAUSE_GET_REP	ENC_REP(CMD_SYS_RESET_CAUSE_GET_REQ)
+#define CMD_SYS_SPECIFIC_INFO_GET_REP	ENC_REP(CMD_SYS_SPECIFIC_INFO_GET_REQ)
+#define CMD_GET_WORD_REP	ENC_REP(CMD_GET_WORD_REQ)
+#define CMD_REBOOT_AP_AFTER_REP	ENC_REP(CMD_REBOOT_AP_AFTER_REQ)
+#define CMD_TAIKI_REP			ENC_REP(CMD_TAIKI_REQ)
+#define CMD_TAIKI_ASYNC_MSG_REP		ENC_REP(CMD_TAIKI_ASYNC_MSG_REQ)
+#define CMD_HARD_RESET_REP		ENC_REP(CMD_HARD_RESET_REQ)
+#define CMD_MAINTENANCE_MODE_REP	ENC_RSP(CMD_MAINTENANCE_MODE_REQ)
+#define CMD_STG_GET_SIZE_REP		ENC_REP(CMD_STG_GET_SIZE_REQ)
+#define CMD_STG_BLOCK_READ_REP		ENC_REP(CMD_STG_BLOCK_READ_REQ)
+#define CMD_STG_BLOCK_WRITE_REP		ENC_REP(CMD_STG_BLOCK_WRITE_REQ)
+#define CMD_MEMORY_LAYOUT_GET_REP	ENC_REP(CMD_MEMORY_LAYOUT_GET_REQ)
+#define CMD_POWERDOMAIN_GET_REP		ENC_REP(CMD_POWERDOMAIN_GET_REQ)
+#define CMD_POWERDOMAIN_SET_REP		ENC_REP(CMD_POWERDOMAIN_SET_REQ)
+#define CMD_STG_BLOCK_ERASE_REP		ENC_REP(CMD_STG_BLOCK_ERASE_REQ)
+
+struct mb86s7x_peri_clk {
+	u32 payload_size;
+	u32 cntrlr;
+	u32 domain;
+	u32 port;
+	u32 en;
+	u64 freqency;
+} __packed;
+
+struct mb86s7x_peri_power {
+	u32 payload_size;
+	u32 peri_id;
+	u32 en;
+} __packed;
+
+#define AT_WFI_DO_NOTHING	0x0
+#define AT_WFI_DO_SUSPEND	0x1
+#define AT_WFI_DO_POWEROFF	0x2
+#define AT_WFI_COLOR_MASK	0x3
+
+#define WFI_COLOR_REG_OFFSET	0x3f00
+
+struct mb86s7x_cpu_gate {
+	u32 payload_size;
+	u32 cluster_class;
+	u32 cluster_id;
+	u32 cpu_id;
+#define SCB_CPU_STATE_OFF	0x0
+#define SCB_CPU_STATE_ON	0x1
+#define SCB_CPU_STATE_SUSP	0x2
+	u32 cpu_state;
+} __packed;
+
+struct mb86s7x_cpu_freq {
+	u32 payload_size;
+	u32 cluster_class;
+	u32 cluster_id;
+	u32 cpu_id;
+	u64 freqency;
+} __packed;
+
+struct mb86s7x_cluster_opp {
+	u32 voltage;
+	u64 freqency;
+} __packed;
+
+struct mb86s7x_cluster_opp_get {
+	u32 payload_size;
+	u32 cluster_class;
+	u32 cluster_id;
+	u32 opp_num;
+	struct mb86s7x_cluster_opp opp[0];
+} __packed;
+
+struct mb86s7x_clk_dsipxl {
+	u32 payload_size;
+	u32 mode;
+} __packed;
+
+struct mb86s7x_scb_version {
+	u32 payload_size;
+	u32 version;
+	u32 config_version;
+} __packed;
+
+struct mb86s7x_reset_cause {
+	u32 payload_size;
+#define RESET_BY_COLDBOOT	0x0
+#define RESET_BY_SW		0x1
+#define RESET_BY_WDOG		0x2
+#define RESET_BY_xxyz		0x3
+	u32 cause;
+} __packed;
+
+struct mb86s7x_sys_info {
+	u32 payload_size;
+	u64 specific_info;
+} __packed;
+
+struct mb86s7x_softreboot {
+	u32 payload_size;
+	u32 delay;
+} __packed;
+
+struct mb86s7x_debug_readl {
+	u32 payload_size;
+#define REG_TOP_STATUS_CFG_CTL		0x44010000
+#define REG_TOP_STATUS_CRG11_ALW	0xF1000000
+#define REG_TOP_STATUS_CRG11_DDR3	0xF1010000
+#define REG_TOP_STATUS_CRG11_MAIN	0xF1020000
+#define REG_TOP_STATUS_CRG11_HDMI	0xF1040000
+#define REG_TOP_STATUS_CRG11_DPHY	0xF1050000
+#define REG_TOP_STATUS_CRGSYSOC		0xF1080000
+#define REG_TOP_STATUS_PRMUX		0xCA4D0000
+	u32 address;
+	u32 data;
+} __packed;
+
+struct mb86s7x_taiki {
+	u32	payload_data[64];
+} __packed;
+
+struct mb86s7x_taiki_async_msg {
+	u32	payload_data[64];
+} __packed;
+
+struct mb86s7x_hard_reset {
+	u32 payload_size;
+	u32 delay;
+} __packed;
+
+struct mb86s7x_stg_get_size {
+	u32 payload_size;
+#define SCB_SECTOR_SIZE 128
+	u32 count_sectors;
+	u32 erase_block_size_bytes;
+} __packed;
+
+struct mb86s7x_stg_block_rw {
+	u32 payload_size;
+	u32 sector;
+	u32 result;
+	u8 data[SCB_SECTOR_SIZE];
+} __packed;
+
+struct mb86s7x_stg_block_erase {
+	u32 payload_size;
+	u32 sector;
+	u32 result;
+} __packed;
+
+struct mb86s7x_memory_region {
+	u64 start;
+	u64 length;
+} __packed;
+
+struct mb86s7x_memory_layout {
+	u32 payload_size;
+	u32 count_regions;
+	struct mb86s7x_memory_region regions[0];
+} __packed;
+
+struct mb86s7x_pmd_cmd {
+	u32 payload_size;
+	u32 powerdomain_index;
+	u32 state;
+} __packed;
+
+#define MB86S7X_VERSION_SUPPORT_BLOCKDEV 0x509
+
+int mhu_send_packet(int cmd, void *buf, int len, struct completion *c);
+void mb86s7x_reboot(u32 delay);
+
+/* This function must not sleep */
+typedef void (*mhu_handler_t)(u32 cmd, u8 rcbuf[]);
+
+int mhu_hndlr_set(u32 cmd, mhu_handler_t);
+void mhu_hndlr_clr(u32 cmd, mhu_handler_t);
+
+#endif /* __MB86S7X_MBOX_API_H */
-- 
1.8.1.2

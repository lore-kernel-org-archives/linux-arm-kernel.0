From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  9 Dec 2011 19:03:51 +0000
Subject: [PATCH v5 8/9] ARM: vexpress: Add Device Tree for V2P-CA9 core tile
In-Reply-To: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1323457432-4800-9-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Device Tree file for the CoreTile Express A9x4 (V2P-CA9).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts |  190 ++++++++++++++++++++++++++++++++
 arch/arm/mach-vexpress/Makefile.boot   |    3 +-
 2 files changed, 192 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
new file mode 100644
index 0000000..84542e7
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -0,0 +1,190 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * CoreTile Express A9x4
+ * Cortex-A9 MPCore (V2P-CA9)
+ *
+ * HBI-0191B
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA9";
+	arm,hbi = <0x191>;
+	compatible = "arm,vexpress,v2p-ca9", "arm,vexpress";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &v2m_serial0;
+		serial1 = &v2m_serial1;
+		serial2 = &v2m_serial2;
+		serial3 = &v2m_serial3;
+		i2c0 = &v2m_i2c_dvi;
+		i2c1 = &v2m_i2c_pcie;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory at 60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	clcd at 10020000 {
+		compatible = "arm,pl111", "arm,primecell";
+		reg = <0x10020000 0x1000>;
+		interrupts = <0 44 4>;
+	};
+
+	memory-controller at 100e0000 {
+		compatible = "arm,pl341", "arm,primecell";
+		reg = <0x100e0000 0x1000>;
+	};
+
+	memory-controller at 100e1000 {
+		compatible = "arm,pl354", "arm,primecell";
+		reg = <0x100e1000 0x1000>;
+		interrupts = <0 45 4>,
+			     <0 46 4>;
+	};
+
+	timer at 100e4000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x100e4000 0x1000>;
+		interrupts = <0 48 4>,
+			     <0 49 4>;
+	};
+
+	watchdog at 100e5000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x100e5000 0x1000>;
+		interrupts = <0 51 4>;
+	};
+
+	scu at 1e000000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x1e000000 0x58>;
+	};
+
+	timer at 1e000600 {
+		compatible = "arm,smp-twd";
+		reg = <0x1e000600 0x20>;
+		interrupts = <1 2 0xf04>,
+			     <1 3 0xf04>;
+	};
+
+	gic: interrupt-controller at 1e001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x1e001000 0x1000>,
+		      <0x1e000100 0x100>;
+	};
+
+	L2: cache-controller at 1e00a000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x1e00a000 0x1000>;
+		interrupts = <0 43 4>;
+		cache-level = <2>;
+		arm,data-latency = <1 1 1>;
+		arm,tag-latency = <1 1 1>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 60 4>,
+			     <0 61 4>,
+			     <0 62 4>,
+			     <0 63 4>;
+	};
+
+	motherboard {
+		ranges = <0 0 0x40000000 0x04000000>,
+			 <1 0 0x44000000 0x04000000>,
+			 <2 0 0x48000000 0x04000000>,
+			 <3 0 0x4c000000 0x04000000>,
+			 <7 0 0x10000000 0x00020000>;
+
+		interrupt-map-mask = <0 0 63>;
+		interrupt-map = <0 0  0 &gic 0  0 4>,
+				<0 0  1 &gic 0  1 4>,
+				<0 0  2 &gic 0  2 4>,
+				<0 0  3 &gic 0  3 4>,
+				<0 0  4 &gic 0  4 4>,
+				<0 0  5 &gic 0  5 4>,
+				<0 0  6 &gic 0  6 4>,
+				<0 0  7 &gic 0  7 4>,
+				<0 0  8 &gic 0  8 4>,
+				<0 0  9 &gic 0  9 4>,
+				<0 0 10 &gic 0 10 4>,
+				<0 0 11 &gic 0 11 4>,
+				<0 0 12 &gic 0 12 4>,
+				<0 0 13 &gic 0 13 4>,
+				<0 0 14 &gic 0 14 4>,
+				<0 0 15 &gic 0 15 4>,
+				<0 0 16 &gic 0 16 4>,
+				<0 0 17 &gic 0 17 4>,
+				<0 0 18 &gic 0 18 4>,
+				<0 0 19 &gic 0 19 4>,
+				<0 0 20 &gic 0 20 4>,
+				<0 0 21 &gic 0 21 4>,
+				<0 0 22 &gic 0 22 4>,
+				<0 0 23 &gic 0 23 4>,
+				<0 0 24 &gic 0 24 4>,
+				<0 0 25 &gic 0 25 4>,
+				<0 0 26 &gic 0 26 4>,
+				<0 0 27 &gic 0 27 4>,
+				<0 0 28 &gic 0 28 4>,
+				<0 0 29 &gic 0 29 4>,
+				<0 0 30 &gic 0 30 4>,
+				<0 0 31 &gic 0 31 4>,
+				<0 0 32 &gic 0 32 4>,
+				<0 0 33 &gic 0 33 4>,
+				<0 0 34 &gic 0 34 4>,
+				<0 0 35 &gic 0 35 4>,
+				<0 0 36 &gic 0 36 4>,
+				<0 0 37 &gic 0 37 4>,
+				<0 0 38 &gic 0 38 4>,
+				<0 0 39 &gic 0 39 4>,
+				<0 0 40 &gic 0 40 4>,
+				<0 0 41 &gic 0 41 4>,
+				<0 0 42 &gic 0 42 4>;
+	};
+};
+
+/include/ "vexpress-v2m.dtsi"
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 5e2177e..2f0ad9f 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -4,4 +4,5 @@
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
 
-dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb \
+				   vexpress-v2p-ca9.dtb
-- 
1.7.5.4

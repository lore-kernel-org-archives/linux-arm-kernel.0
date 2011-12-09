From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  9 Dec 2011 19:03:52 +0000
Subject: [PATCH v5 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core tile
 (TC1 variant)
In-Reply-To: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1323457432-4800-10-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Device Tree file for the CoreTile Express A15x2
(V2P-CA15) with Test Chip 1.

As the chip's GIC has 160 interrupt inputs, NR_IRQS is increased.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  155 +++++++++++++++++++++++++++
 arch/arm/mach-vexpress/Makefile.boot        |    3 +-
 arch/arm/mach-vexpress/include/mach/irqs.h  |    2 +-
 3 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
new file mode 100644
index 0000000..02cada5
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -0,0 +1,155 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * CoreTile Express A15x2 (version with Test Chip 1)
+ * Cortex-A15 MPCore (V2P-CA15)
+ *
+ * HBI-0237A
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA15";
+	arm,hbi = <0x237>;
+	compatible = "arm,vexpress,v2p-ca15,tc1", "arm,vexpress,v2p-ca15", "arm,vexpress";
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
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	hdlcd at 2b000000 {
+		compatible = "arm,hdlcd";
+		reg = <0x2b000000 0x1000>;
+		interrupts = <0 85 4>;
+	};
+
+	memory-controller at 2b0a0000 {
+		compatible = "arm,pl341", "arm,primecell";
+		reg = <0x2b0a0000 0x1000>;
+	};
+
+	wdt at 2b060000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x2b060000 0x1000>;
+		interrupts = <98>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x2c001000 0x1000>,
+		      <0x2c002000 0x100>;
+	};
+
+	memory-controller at 7ffd0000 {
+		compatible = "arm,pl354", "arm,primecell";
+		reg = <0x7ffd0000 0x1000>;
+		interrupts = <0 86 4>,
+			     <0 87 4>;
+	};
+
+	dma at 7ffb0000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x7ffb0000 0x1000>;
+		interrupts = <0 92 4>,
+			     <0 88 4>,
+			     <0 89 4>,
+			     <0 90 4>,
+			     <0 91 4>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 68 4>,
+			     <0 69 4>;
+	};
+
+	motherboard {
+		ranges = <0 0 0x08000000 0x04000000>,
+			 <1 0 0x14000000 0x04000000>,
+			 <2 0 0x18000000 0x04000000>,
+			 <3 0 0x1c000000 0x04000000>,
+			 <4 0 0x0c000000 0x04000000>,
+			 <5 0 0x10000000 0x04000000>;
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
+/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 2f0ad9f..909f85e 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -5,4 +5,5 @@ params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
 
 dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb \
-				   vexpress-v2p-ca9.dtb
+				   vexpress-v2p-ca9.dtb \
+				   vexpress-v2p-ca15-tc1.dtb
diff --git a/arch/arm/mach-vexpress/include/mach/irqs.h b/arch/arm/mach-vexpress/include/mach/irqs.h
index 7054cbf..4b10ee7 100644
--- a/arch/arm/mach-vexpress/include/mach/irqs.h
+++ b/arch/arm/mach-vexpress/include/mach/irqs.h
@@ -1,4 +1,4 @@
 #define IRQ_LOCALTIMER		29
 #define IRQ_LOCALWDOG		30
 
-#define NR_IRQS	128
+#define NR_IRQS	256
-- 
1.7.5.4

From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 15:41:46 +0100
Subject: [PATCHv2 3/3] picoxcell: add the DTS for the PC7302 board
In-Reply-To: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1314196906-20709-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PC7302 board can be populated with either a PC3X2 or PC3X3 device.
Add DTS files for both variants of the PC7302.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts |   87 ++++++++++++++++++++++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts |   93 ++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
 create mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts

diff --git a/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts b/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
new file mode 100644
index 0000000..4c9a7ba
--- /dev/null
+++ b/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
@@ -0,0 +1,87 @@
+/*
+ *  Copyright (C) 2011 Picochip, Jamie Iles
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "picoxcell-pc3x2.dtsi"
+/ {
+	model = "Picochip PC7302 (PC3X2)";
+	compatible = "picochip,pc7302-pc3x2", "picochip,pc3x2";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk loglevel=9 root=ubi0:rootfs rw rootfstype=ubifs ubi.mtd=5,2048";
+		linux,stdout-path = &uart0;
+	};
+
+	clocks {
+		ref_clk: clock at 1 {
+			compatible = "fixed-clock";
+			clock-outputs = "ref";
+			clock-frequency = <20000000>;
+		};
+	};
+
+	rwid-axi {
+		ebi at 50000000 {
+			nand: gpio-nand at 2,0 {
+				compatible = "gpio-control-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <2 0x0000 0x1000>;
+				bus-clock = <&pclk>, "bus";
+				gpio-control-nand,io-sync-reg =
+					<0x00000000 0x80220000>;
+
+				gpios = <&banka 1 0	/* rdy */
+					 &banka 2 0 	/* nce */
+					 &banka 3 0 	/* ale */
+					 &banka 4 0 	/* cle */
+					 0		/* nwp */>;
+
+				boot at 100000 {
+					label = "Boot";
+					reg = <0x100000 0x80000>;
+				};
+
+				redundant-boot at 200000 {
+					label = "Redundant Boot";
+					reg = <0x200000 0x80000>;
+				};
+
+				boot-env at 300000 {
+					label = "Boot Evironment";
+					reg = <0x300000 0x20000>;
+				};
+
+				redundant-boot-env at 320000 {
+					label = "Redundant Boot Environment";
+					reg = <0x300000 0x20000>;
+				};
+
+				kernel at 380000 {
+					label = "Kernel";
+					reg = <0x380000 0x800000>;
+				};
+
+				fs at b80000 {
+					label = "File System";
+					reg = <0xb80000 0xf480000>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts b/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
new file mode 100644
index 0000000..381eb6a
--- /dev/null
+++ b/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
@@ -0,0 +1,93 @@
+/*
+ *  Copyright (C) 2011 Picochip, Jamie Iles
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "picoxcell-pc3x3.dtsi"
+/ {
+	model = "Picochip PC7302 (PC3X3)";
+	compatible = "picochip,pc7302-pc3x3", "picochip,pc3x3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk loglevel=9 root=ubi0:rootfs rw rootfstype=ubifs ubi.mtd=5,2048";
+		linux,stdout-path = &uart0;
+	};
+
+	clocks {
+		ref_clk: clock at 10 {
+			compatible = "fixed-clock";
+			clock-outputs = "ref";
+			clock-frequency = <20000000>;
+		};
+
+		clkgate: clkgate at 800a0048 {
+			clock at 4 {
+				picochip,clk-no-disable;
+			};
+		};
+	};
+
+	rwid-axi {
+		ebi at 50000000 {
+			nand: gpio-nand at 2,0 {
+				compatible = "gpio-control-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <2 0x0000 0x1000>;
+				bus-clock = <&ebi_clk>, "bus";
+				gpio-control-nand,io-sync-reg =
+					<0x00000000 0x80220000>;
+
+				gpios = <&banka 1 0	/* rdy */
+					 &banka 2 0 	/* nce */
+					 &banka 3 0 	/* ale */
+					 &banka 4 0 	/* cle */
+					 0		/* nwp */>;
+
+				boot at 100000 {
+					label = "Boot";
+					reg = <0x100000 0x80000>;
+				};
+
+				redundant-boot at 200000 {
+					label = "Redundant Boot";
+					reg = <0x200000 0x80000>;
+				};
+
+				boot-env at 300000 {
+					label = "Boot Evironment";
+					reg = <0x300000 0x20000>;
+				};
+
+				redundant-boot-env at 320000 {
+					label = "Redundant Boot Environment";
+					reg = <0x300000 0x20000>;
+				};
+
+				kernel at 380000 {
+					label = "Kernel";
+					reg = <0x380000 0x800000>;
+				};
+
+				fs at b80000 {
+					label = "File System";
+					reg = <0xb80000 0xf480000>;
+				};
+			};
+		};
+	};
+};
-- 
1.7.4.1

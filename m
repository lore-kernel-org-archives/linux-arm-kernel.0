From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 23 Apr 2015 15:37:30 -0400
Subject: [PATCH 2/4] ARM: dts: k2hk-evm: Add device bindings for netcp driver
In-Reply-To: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
References: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1429817852-27938-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables networking on k2hk evm by adding device
bindings for netcp, knav and qmss.  See device binding
documentation below for details.

Documentation/devicetree/bindings/net/keystone-netcp.txt

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts    |    1 +
 arch/arm/boot/dts/k2hk-netcp.dtsi |  208 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk.dtsi       |    1 +
 3 files changed, 210 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2hk-netcp.dtsi

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 3223cc1..660ebf5 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -169,6 +169,7 @@
 };
 
 &mdio {
+	status = "ok";
 	ethphy0: ethernet-phy at 0 {
 		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
diff --git a/arch/arm/boot/dts/k2hk-netcp.dtsi b/arch/arm/boot/dts/k2hk-netcp.dtsi
new file mode 100644
index 0000000..308abe5
--- /dev/null
+++ b/arch/arm/boot/dts/k2hk-netcp.dtsi
@@ -0,0 +1,208 @@
+/*
+ * Device Tree Source for Keystone 2 Hawking Netcp driver
+ *
+ * Copyright 2015 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+qmss: qmss at 2a40000 {
+	compatible = "ti,keystone-navigator-qmss";
+	dma-coherent;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	clocks = <&chipclk13>;
+	ranges;
+	queue-range	= <0 0x4000>;
+	linkram0	= <0x100000 0x8000>;
+	linkram1	= <0x0 0x10000>;
+
+	qmgrs {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		qmgr0 {
+			managed-queues = <0 0x2000>;
+			reg = <0x2a40000 0x20000>,
+			      <0x2a06000 0x400>,
+			      <0x2a02000 0x1000>,
+			      <0x2a03000 0x1000>,
+			      <0x23a80000 0x20000>,
+			      <0x2a80000 0x20000>;
+			reg-names = "peek", "status", "config",
+				    "region", "push", "pop";
+		};
+
+		qmgr1 {
+			managed-queues = <0x2000 0x2000>;
+			reg = <0x2a60000 0x20000>,
+			      <0x2a06400 0x400>,
+			      <0x2a04000 0x1000>,
+			      <0x2a05000 0x1000>,
+			      <0x23aa0000 0x20000>,
+			      <0x2aa0000 0x20000>;
+			reg-names = "peek", "status", "config",
+				    "region", "push", "pop";
+		};
+	};
+	queue-pools {
+		qpend {
+			qpend-0 {
+				qrange = <658 8>;
+				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
+					     0 43 0xf04 0 44 0xf04 0 45 0xf04
+					     0 46 0xf04 0 47 0xf04>;
+			};
+			qpend-1 {
+				qrange = <8704 16>;
+				interrupts = <0 48 0xf04 0 49 0xf04 0 50 0xf04
+					      0 51 0xf04 0 52 0xf04 0 53 0xf04
+					      0 54 0xf04 0 55 0xf04 0 56 0xf04
+					      0 57 0xf04 0 58 0xf04 0 59 0xf04
+					      0 60 0xf04 0 61 0xf04 0 62 0xf04
+					      0 63 0xf04>;
+				qalloc-by-id;
+			};
+			qpend-2 {
+				qrange = <8720 16>;
+				interrupts = <0 64 0xf04 0 65 0xf04 0 66 0xf04
+					      0 59 0xf04 0 68 0xf04 0 69 0xf04
+					      0 70 0xf04 0 71 0xf04 0 72 0xf04
+					      0 73 0xf04 0 74 0xf04 0 75 0xf04
+					      0 76 0xf04 0 77 0xf04 0 78 0xf04
+					      0 79 0xf04>;
+			};
+		};
+		general-purpose {
+			gp-0 {
+				qrange = <4000 64>;
+			};
+			netcp-tx {
+				qrange = <640 9>;
+				qalloc-by-id;
+			};
+			netcpx-tx {
+				qrange = <8752 8>;
+				qalloc-by-id;
+			};
+		};
+	};
+	descriptor-regions {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		region-12 {
+			id = <12>;
+			region-spec = <8192 128>;	/* num_desc desc_size */
+			link-index = <0x4000>;
+		};
+	};
+}; /* qmss */
+
+knav_dmas: knav_dmas at 0 {
+	compatible = "ti,keystone-navigator-dma";
+	clocks = <&papllclk>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+	ti,navigator-cloud-address = <0x23a80000 0x23a90000
+				   0x23aa0000 0x23ab0000>;
+
+	dma_gbe: dma_gbe at 0 {
+		reg = <0x2004000 0x100>,
+			  <0x2004400 0x120>,
+			  <0x2004800 0x300>,
+			  <0x2004c00 0x120>,
+			  <0x2005000 0x400>;
+		reg-names = "global", "txchan", "rxchan",
+				"txsched", "rxflow";
+	};
+};
+
+netcp: netcp at 2000000 {
+	reg = <0x2620110 0x8>;
+	reg-names = "efuse";
+	compatible = "ti,netcp-1.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/* NetCP address range */
+	ranges  = <0 0x2000000 0xfffff>;
+
+	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
+	dma-coherent;
+
+	ti,navigator-dmas = <&dma_gbe 22>,
+			<&dma_gbe 23>,
+			<&dma_gbe 8>;
+	ti,navigator-dma-names = "netrx0", "netrx1", "nettx";
+
+	netcp-devices {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		gbe at 90000 { /* ETHSS */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			label = "netcp-gbe";
+			compatible = "ti,netcp-gbe";
+			reg = <0x90000 0x300>, <0x90400 0x400>, <0x90800 0x700>;
+			/* enable-ale; */
+			tx-queue = <648>;
+			tx-channel = "nettx";
+
+			interfaces {
+				gbe0: interface-0 {
+					slave-port = <0>;
+					link-interface = <1>;
+					phy-handle = <&ethphy0>;
+				};
+				gbe1: interface-1 {
+					slave-port = <1>;
+					link-interface = <1>;
+					phy-handle = <&ethphy1>;
+				};
+			};
+
+			secondary-slave-ports {
+				port-2 {
+					slave-port = <2>;
+					link-interface	= <2>;
+				};
+				port-3 {
+					slave-port = <3>;
+					link-interface	= <2>;
+				};
+			};
+		};
+	};
+
+	netcp-interfaces {
+		interface-0 {
+			rx-channel = "netrx0";
+			rx-pool = <1024 12>;
+			tx-pool = <1024 12>;
+			rx-queue-depth = <128 128 0 0>;
+			rx-buffer-size = <1518 4096 0 0>;
+			rx-queue = <8704>;
+			tx-completion-queue = <8706>;
+			efuse-mac = <1>;
+			netcp-gbe = <&gbe0>;
+
+		};
+		interface-1 {
+			rx-channel = "netrx1";
+			rx-pool = <1024 12>;
+			tx-pool = <1024 12>;
+			rx-queue-depth = <128 128 0 0>;
+			rx-buffer-size = <1518 4096 0 0>;
+			rx-queue = <8705>;
+			tx-completion-queue = <8707>;
+			efuse-mac = <0>;
+			local-mac-address = [02 18 31 7e 3e 6f];
+			netcp-gbe = <&gbe1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
index d721f4b..ae64724 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -98,5 +98,6 @@
 			#gpio-cells = <2>;
 			gpio,syscon-dev = <&devctrl 0x25c>;
 		};
+		/include/ "k2hk-netcp.dtsi"
 	};
 };
-- 
1.7.9.5

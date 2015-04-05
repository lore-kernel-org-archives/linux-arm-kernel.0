From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 05 Apr 2015 15:43:53 +0300
Subject: [PATCH v2 2/3] ARM: dts: alpine: add internal pci
Message-ID: <55212e09.RH2EglWE3maYKEXN%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device-tree entry for the internal pci bus on Alpine.
Alpine's on-chip devices appear as pci devices on this bus.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/boot/dts/alpine.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 519f58c..9af2d60 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -137,5 +137,24 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 		};
+
+		/* Internal PCIe Controller */
+		pcie-internal at 0xfbc00000 {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#size-cells = <2>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			reg = <0x0 0xfbc00000 0x0 0x100000>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			/* Add legacy interrupts for SATA devices only */
+			interrupt-map =	<0x4000 0 0 1 &gic 0 43 4>,
+					<0x4800 0 0 1 &gic 0 44 4>;
+
+			/* 32 bit non prefetchable memory space */
+			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
+
+			bus-range = <0x00 0x00>;
+		};
 	};
 };
-- 
1.9.1

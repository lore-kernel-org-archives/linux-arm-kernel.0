From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 10:50:35 +0200
Subject: [PATCH 2/2] ARM: dts: alpine: add internal pci
Message-ID: <5511255b.GYpoKoNk+LNZOZVX%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device-tree entry for the internal pci bus on Alpine.
On-chip devices appear as pci devices on this bus.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/boot/dts/alpine.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 519f58c..48589ca 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -137,5 +137,25 @@
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
+			interrupt-map = <0x3000 0 0 1 &gic 0 32 4>,
+					<0x3800 0 0 1 &gic 0 36 4>,
+					<0x4000 0 0 1 &gic 0 43 4>,
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

From: s-anna@ti.com (Suman Anna)
Date: Thu, 10 Aug 2017 18:52:45 -0500
Subject: [PATCH 3/3] ARM: dts: keystone-k2g-ice: Add and enable DSP CMA memory
 pool
In-Reply-To: <20170810235245.30316-1-s-anna@ti.com>
References: <20170810235245.30316-1-s-anna@ti.com>
Message-ID: <20170810235245.30316-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A CMA memory pool reserved memory node is added, and is attached
to the DSP node through the 'memory-region' property on the K2G
ICE board. This area will be used for allocating virtio rings and
buffers. This node allows the DSP Memory Protection and Address
Extension (MPAX) module to be configured properly for the DSP
processor, and matches the values used on the other Keystone 2
boards for software compatibility.

The reserved memory node and the user DSP node are also marked
okay to enable the DSP on the K2G ICE board.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-ice.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index d820d37b5148..78692745e0af 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -17,6 +17,19 @@
 		device_type = "memory";
 		reg = <0x00000008 0x00000000 0x00000000 0x20000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dsp_common_memory: dsp-common-memory at 81f800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00000008 0x1f800000 0x00000000 0x800000>;
+			reusable;
+			status = "okay";
+		};
+	};
 };
 
 &k2g_pinctrl {
@@ -33,3 +46,8 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&dsp0 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
-- 
2.13.1

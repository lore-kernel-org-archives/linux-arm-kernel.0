From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 18:19:18 -0500
Subject: [PATCH 6/6] ARM: dts: keystone-k2e-evm: Add and enable DSP CMA memory
 pool
In-Reply-To: <20170728231918.16778-1-s-anna@ti.com>
References: <20170728231918.16778-1-s-anna@ti.com>
Message-ID: <20170728231918.16778-7-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sam Nelson <sam.nelson@ti.com>

A CMA memory pool reserved memory node is added, and is attached to
the DSP node through the 'memory-region' property on the K2E EVM board.
This area will be used for allocating virtio rings and buffers. This
node allows the DSP Memory Protection and Address Extension (MPAX)
module to be configured properly for the DSP processor, and matches
the values used on the other Keystone 2 boards for software
compatibility.

The reserved memory node and the user DSP node are also marked okay
to enable the DSP on the 66AK2E EVM board.

Signed-off-by: Sam Nelson <sam.nelson@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index ae1ebe7ee021..f1f32c54e72f 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -16,6 +16,19 @@
 	compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Edison EVM";
 
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
+
 	soc {
 
 		clocks {
@@ -160,3 +173,8 @@
 		reg = <1>;
 	};
 };
+
+&dsp0 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
-- 
2.13.1

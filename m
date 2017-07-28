From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 18:19:16 -0500
Subject: [PATCH 4/6] ARM: dts: keystone-k2hk-evm: Add and enable common DSP
 CMA memory pool
In-Reply-To: <20170728231918.16778-1-s-anna@ti.com>
References: <20170728231918.16778-1-s-anna@ti.com>
Message-ID: <20170728231918.16778-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sam Nelson <sam.nelson@ti.com>

A common CMA memory pool reserved memory node is added, and is attached
to all the DSP nodes through the 'memory-region' property on the 66AK2H
EVM board. This area will be used for allocating virtio rings and buffers.
The common node allows the DSP Memory Protection and Address Extension
(MPAX) module to be configured uniformly across all the DSP processors.

The reserved memory node and all the user DSP nodes are also marked okay
to enable the DSPs on the 66AK2K EVM board.

Signed-off-by: Sam Nelson <sam.nelson@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index 2156ff92d08f..6dd13b98aaba 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -16,6 +16,19 @@
 	compatible =  "ti,k2hk-evm", "ti,k2hk", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Kepler/Hawking EVM";
 
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
 			refclksys: refclksys {
@@ -184,3 +197,43 @@
 		reg = <1>;
 	};
 };
+
+&dsp0 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp1 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp2 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp3 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp4 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp5 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp6 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
+
+&dsp7 {
+	memory-region = <&dsp_common_memory>;
+	status = "okay";
+};
-- 
2.13.1

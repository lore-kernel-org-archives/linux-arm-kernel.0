From: s-anna@ti.com (Suman Anna)
Date: Mon, 18 Sep 2017 19:28:32 -0500
Subject: [PATCH 2/3] ARM: dts: da850-lcdk: Add and enable CMA reserved pool
 for DSP
In-Reply-To: <20170919002833.5677-1-s-anna@ti.com>
References: <20170919002833.5677-1-s-anna@ti.com>
Message-ID: <20170919002833.5677-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A CMA reserved memory node of 16 MB has been added and assigned to
the DSP remoteproc device on the OMAP-L138 LCDK board. The CMA starting
address matches the values used within the TI IPC 3.x software. Both
the CMA node and the corresponding rproc node are also marked okay
to enable the DSP on the OMAP-L138 LCDK board.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a0f0916156e6..eed89e659143 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -26,6 +26,19 @@
 		reg = <0xc0000000 0x08000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dsp_memory_region: dsp-memory at c3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0xc3000000 0x1000000>;
+			reusable;
+			status = "okay";
+		};
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
@@ -319,3 +332,8 @@
 	pinctrl-0 = <&vpif_capture_pins>;
 	status = "okay";
 };
+
+&dsp {
+	memory-region = <&dsp_memory_region>;
+	status = "okay";
+};
-- 
2.13.1

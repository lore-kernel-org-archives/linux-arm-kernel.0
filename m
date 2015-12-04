From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Dec 2015 19:48:50 +0000
Subject: [PATCH v2 13/12] ARM: dts: dove: add DT GPU support
In-Reply-To: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
References: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <E1a4wLa-0004Vi-2t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for the Vivante GC600 GPU on Marvell Dove platforms.
These nodes default to being disabled unless a platform decides they
should be enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This replaces the previous patch I sent out in error; this version
adds all the DT nodes required.  Also included along with this is a
patch which enables the GPU for Cubox platforms.

This additional patch is in conjunction with my PMU (already merged)
and clock driver patch sets.

 arch/arm/boot/dts/dove.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index ea36a262d056..f36e3b9c6730 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -33,6 +33,12 @@
 		marvell,tauros2-cache-features = <0>;
 	};
 
+	gpu-subsystem {
+		compatible = "marvell,dove-gpu-subsystem";
+		cores = <&gpu>;
+		status = "disabled";
+	};
+
 	i2c-mux {
 		compatible = "i2c-mux-pinctrl";
 		#address-cells = <1>;
@@ -773,6 +779,16 @@
 				interrupts = <47>;
 				status = "disabled";
 			};
+
+			gpu: gpu at 840000 {
+				clocks = <&divider_clk 1>;
+				clock-names = "core";
+				compatible = "vivante,gc";
+				interrupts = <48>;
+				power-domains = <&gpu_domain>;
+				reg = <0x840000 0x4000>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.1.0

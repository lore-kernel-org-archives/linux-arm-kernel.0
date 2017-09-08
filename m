From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:16 +0800
Subject: [PATCH 8/8] ARM: dts: sun6i: Add cross pipeline connections between
 DRCs and TCONs
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TCONs on A31/A31s can select either backend as its input. As there
is no configurable mux in the backend or DRC to redirect their output,
or for the DRC to select an input, the connections are presumably from
the each DRC to each TCON, with the TCON having two input ports, like
the following diagram:

	Backend 0  -------  DRC 0  ------- [0]  TCON 0
				   --   -- [1]
                                     \ /
				      X
				     / \
				   --   -- [0]
	Backend 1  -------  DRC 1  ------- [1]  TCON 1

Add these connection endpoints to the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 00a4c7614e0a..93209cda28db 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -278,6 +278,11 @@
 						reg = <0>;
 						remote-endpoint = <&drc0_out_tcon0>;
 					};
+
+					tcon0_in_drc1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&drc1_out_tcon0>;
+					};
 				};
 
 				tcon0_out: port at 1 {
@@ -311,6 +316,11 @@
 					#size-cells = <0>;
 					reg = <0>;
 
+					tcon1_in_drc0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_out_tcon1>;
+					};
+
 					tcon1_in_drc1: endpoint at 1 {
 						reg = <1>;
 						remote-endpoint = <&drc1_out_tcon1>;
@@ -1079,6 +1089,11 @@
 					#size-cells = <0>;
 					reg = <1>;
 
+					drc1_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_drc1>;
+					};
+
 					drc1_out_tcon1: endpoint at 1 {
 						reg = <1>;
 						remote-endpoint = <&tcon1_in_drc1>;
@@ -1170,6 +1185,11 @@
 						reg = <0>;
 						remote-endpoint = <&tcon0_in_drc0>;
 					};
+
+					drc0_out_tcon1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tcon1_in_drc0>;
+					};
 				};
 			};
 		};
-- 
2.14.1

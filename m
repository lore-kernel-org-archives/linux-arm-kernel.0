From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu,  3 Mar 2016 16:09:17 +0800
Subject: [PATCH v5 5/6] dt/bindings: rockchip: modify document of Rockchip
 power domains
In-Reply-To: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
References: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1456992557-25331-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the power domains
found on Rockchip RK3399 SoCs.
RK3399 pd on/off not need to enable clk which in this pd.
So remove the clocks in the rk3399 pd example.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/soc/rockchip/power_domain.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 13dc6a3..98085c8 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -7,6 +7,7 @@ Required properties for power domain controller:
 - compatible: Should be one of the following.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
+	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
 - #power-domain-cells: Number of cells in a power-domain specifier.
 	Should be 1 for multiple PM domains.
 - #address-cells: Should be 1.
@@ -16,6 +17,7 @@ Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
+	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
 - clocks (optional): phandles to clocks which need to be enabled while power domain
 	switches state.
 
@@ -45,12 +47,41 @@ Example:
                 };
         };
 
+Example 2:
+		power: power-controller {
+			compatible = "rockchip,rk3399-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_vio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <RK3399_PD_VIO>;
+
+				pd_vo {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <RK3399_PD_VO>;
+
+					pd_vopb {
+						reg = <RK3399_PD_VOPB>;
+					};
+
+					pd_vopl {
+						reg = <RK3399_PD_VOPL>;
+					};
+				};
+			};
+		};
+
 Node of a device using power domains must have a power-domains property,
 containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
+	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
 
 Example of the node using power domain:
 
@@ -65,3 +96,9 @@ Example of the node using power domain:
                 power-domains = <&power RK3368_PD_GPU_1>;
                 /* ... */
         };
+
+	node {
+		/* ... */
+		power-domains = <&power RK3399_PD_VOPB>;
+		/* ... */
+	};
-- 
1.9.1

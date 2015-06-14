From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 14 Jun 2015 13:13:36 +0800
Subject: [PATCH v15 1/4] dt-bindings: add document of Rockchip power domain
In-Reply-To: <1434258820-26779-1-git-send-email-wxt@rock-chips.com>
References: <1434258820-26779-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1434258820-26779-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the necessary binding documentation for the power domain
found on Rockchip Socs.

Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v15: None
Changes in v9:
- add document decription.
Series-changes:8
- document go back to v2.
Series-changes:3
- DT structure has changed.
Series-changes:2
- move clocks to "optional".

 .../bindings/soc/rockchip/power_domain.txt         | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
new file mode 100644
index 0000000..3e74e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -0,0 +1,48 @@
+* Rockchip Power Domains
+
+Rockchip processors include support for multiple power domains which can be
+powered up/down by software based on different application scenes to save power.
+
+Required properties for power domain controller:
+- compatible: should be one of the following.
+    * rockchip,rk3288-power-controller - for rk3288 type power domain.
+- #power-domain-cells: Number of cells in a power-domain specifier.
+		       should be 1.
+- rockchip,pmu: phandle referencing a syscon providing the pmu registers
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Required properties for power domain sub nodes:
+- reg: index of the power domain, should use macros in:
+    *  include/dt-bindings/power-domain/rk3288.h - for rk3288 type power domain.
+- clocks (optional): phandles to clocks which need to be enabled while power domain
+          switches state.
+
+Example:
+
+	power: power-controller {
+	       compatible = "rockchip,rk3288-power-controller";
+	       #power-domain-cells = <1>;
+	       rockchip,pmu = <&pmu>;
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+	       pd_gpu {
+	               reg = <RK3288_PD_GPU>;
+	               clocks = <&cru ACLK_GPU>;
+	       };
+	};
+
+Node of a device using power domains must have a power-domains property,
+containing a phandle to the power device node and an index specifying which
+power domain to use.
+The index should use macros in:
+   * include/dt-bindings/power-domain/rk3288.h - for rk3288 type power domain.
+
+Example of the node using power domain:
+
+	node {
+		/* ... */
+		power-domains = <&power RK3288_PD_GPU>;
+		/* ... */
+	};
-- 
1.9.1

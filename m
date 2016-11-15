From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Nov 2016 17:04:52 +0100
Subject: [PATCH v4 5/5] dt-bindings: firmware: Allow child nodes inside the
 Tegra BPMP
In-Reply-To: <20161115160452.27183-1-thierry.reding@gmail.com>
References: <20161115160452.27183-1-thierry.reding@gmail.com>
Message-ID: <20161115160452.27183-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The BPMP implements some services which must be represented by separate
nodes. For example, it can provide access to certain I2C controllers,
and the I2C bindings represent each I2C controller as a device tree
node. Update the binding to describe how the BPMP supports this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
[treding at nvidia.com: renamed bpmp-i2c to i2c as per Rob]
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
index 0d3fef423c48..e821e16ad65b 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
@@ -38,6 +38,24 @@ implemented by this node:
 - .../reset/reset.txt
 - <dt-bindings/reset/tegra186-reset.h>
 
+The BPMP implements some services which must be represented by separate nodes.
+For example, it can provide access to certain I2C controllers, and the I2C
+bindings represent each I2C controller as a device tree node. Such nodes should
+be nested directly inside the main BPMP node.
+
+Software can determine whether a child node of the BPMP node represents a device
+by checking for a compatible property. Any node with a compatible property
+represents a device that can be instantiated. Nodes without a compatible
+property may be used to provide configuration information regarding the BPMP
+itself, although no such configuration nodes are currently defined by this
+binding.
+
+The BPMP firmware defines no single global name-/numbering-space for such
+services. Put another way, the numbering scheme for I2C buses is distinct from
+the numbering scheme for any other service the BPMP may provide (e.g. a future
+hypothetical SPI bus service). As such, child device nodes will have no reg
+property, and the BPMP node will have no #address-cells or #size-cells property.
+
 The shared memory bindings for BPMP
 -----------------------------------
 
@@ -82,4 +100,9 @@ bpmp {
 	#clock-cells = <1>;
 	#power-domain-cells = <1>;
 	#reset-cells = <1>;
+
+	i2c {
+		compatible = "...";
+		...
+	};
 };
-- 
2.10.2

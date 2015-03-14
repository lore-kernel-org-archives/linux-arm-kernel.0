From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:42 +0800
Subject: [PATCH 07/10] dt/binding: Document ZTE zx296702 devicetree
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-8-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new compatible for zx296702 platform and
clock control.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/arm/zte.txt      |  9 ++++++
 .../devicetree/bindings/clock/zx296702-clk.txt     | 35 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 3 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
new file mode 100644
index 0000000..edd6791
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -0,0 +1,9 @@
+ZTE platforms device tree bindings
+---------------------------------------
+
+-  ZX296702 board:
+    Required root node properties:
+      - compatible = "zte,zx296702-ad1", "zte,zx296702"
+
+Low power management required properties:
+      - compatible = "zte,aon-sysctrl"
diff --git a/Documentation/devicetree/bindings/clock/zx296702-clk.txt b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
new file mode 100644
index 0000000..9b527b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
@@ -0,0 +1,35 @@
+Device Tree Clock bindings for ZTE zx296702
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"zte,zx296702-topcrm":
+		zx296702 top clock selection, divider and gating
+
+	"zte,zx296702-lsp0crpm" or
+	"zte,zx296702-lsp1crpm":
+		zx296702 device level clock selection and gating
+
+- reg: Address and length of the register set
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx5-clock.h
+for the full list of i.MX5 clock IDs.
+
+
+clks: topcrm at 0x09800000 {
+        compatible = "zte,zx296702-topcrm";
+        reg = <0x09800000 0x1000>;
+        #clock-cells = <1>;
+};
+
+uart0: serial at 0x09405000 {
+        compatible = "zte,zx296702-uart";
+        reg = <0x09405000 0x1000>;
+        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks ZX296702_UART0_PCLK>;
+        status = "disabled";
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389ca13..e4f96ad 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -197,3 +197,4 @@ xillybus	Xillybus Ltd.
 xlnx	Xilinx
 zyxel	ZyXEL Communications Corp.
 zarlink	Zarlink Semiconductor
+zte	ZTE Corp.
-- 
1.9.1

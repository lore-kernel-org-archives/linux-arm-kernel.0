From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 26 Mar 2015 19:13:37 +0800
Subject: [PATCH 2/4] dt-bindings: clk: hisilicon: Document stub clock driver
In-Reply-To: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
References: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1427368419-22222-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new compatible for stub clock driver which is used for CPU
and DDR's dynamic frequency scaling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/clock/hisi,stub-clock.txt  | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisi,stub-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/hisi,stub-clock.txt b/Documentation/devicetree/bindings/clock/hisi,stub-clock.txt
new file mode 100644
index 0000000..07ef5a11
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisi,stub-clock.txt
@@ -0,0 +1,38 @@
+* Clock bindings for Hisilicon Stub Clock Driver
+
+The Hisilicon stub clock will directly send dynamic frequency scaling request
+to power controller, then the power controller will handle the request for
+cpu and ddr's frequency change.
+
+Required properties:
+- compatible: must be "hisilicon,hisi-clock-stub"
+- hisilicon,clk-stub-sram: phandle to the syscon managing the SoC internal sram;
+  the driver need use the sram to pass parameters for frequency change.
+- hisilicon,clk-stub-mc: phandle to the syscon managing the multi-cores'
+  communication; need set related register to trigger the dynamic frequency
+  scaling.
+- #clock-cells: should be <1>
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hisi,stub-clock.h>.
+
+Example:
+
+	sram: sram {
+		compatible = "hisilicon,sram", "syscon";
+		reg = <0x0 0xFFF80000 0x0 0x12000>;
+	};
+
+	ipc_s: ipc_s {
+		compatible = "hisilicon,ipc-s", "syscon";
+		reg = <0x0 0xF7510000 0x0 0x1000>;
+	};
+
+	clock_stub: clock_stub {
+		compatible = "hisilicon,hisi-clock-stub";
+		hisilicon,clk-stub-sram = <&sram>;
+		hisilicon,clk-stub-mc = <&ipc_s>;
+		#clock-cells = <1>;
+	};
-- 
1.9.1

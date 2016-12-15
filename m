From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 15 Dec 2016 13:58:12 +0800
Subject: [PATCH 1/2] dt-bindings: Document the hi3660 clock bindings
In-Reply-To: <1481781493-6188-1-git-send-email-zhangfei.gao@linaro.org>
References: <1481781493-6188-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1481781493-6188-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for hi3660 SoC clock.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/clock/hi3660-clock.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3660-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/hi3660-clock.txt b/Documentation/devicetree/bindings/clock/hi3660-clock.txt
new file mode 100644
index 0000000..7296fd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hi3660-clock.txt
@@ -0,0 +1,42 @@
+* Hisilicon Hi3660 Clock Controller
+
+The Hi3660 clock controller generates and supplies clock to various
+controllers within the Hi3660 SoC.
+
+Required Properties:
+
+- compatible: the compatible should be one of the following strings to
+	indicate the clock controller functionality.
+
+	- "hisilicon,hi3660-crgctrl"
+	- "hisilicon,hi3660-pctrl"
+	- "hisilicon,hi3660-pmuctrl"
+	- "hisilicon,hi3660-sctrl"
+	- "hisilicon,hi3660-iomcu"
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- #clock-cells: should be 1.
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hi3660-clock.h>.
+
+Examples:
+	crg_ctrl: crg_ctrl at fff35000 {
+		compatible = "hisilicon,hi3660-crgctrl", "syscon";
+		reg = <0x0 0xfff35000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	uart0: uart at fdf02000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0xfdf02000 0x0 0x1000>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&crg_ctrl HI3660_CLK_MUX_UART0>,
+			 <&crg_ctrl HI3660_PCLK>;
+		clock-names = "uartclk", "apb_pclk";
+		status = "disabled";
+	};
-- 
2.7.4

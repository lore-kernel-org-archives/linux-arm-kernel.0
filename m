From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:42:21 +0800
Subject: [PATCH v2 09/10] Documentation: devicetree: Add dts description for
 nuc900
In-Reply-To: <1468136542-2656-1-git-send-email-vw@iommu.org>
References: <1468136542-2656-1-git-send-email-vw@iommu.org>
Message-ID: <1468136542-2656-2-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add dts description for nuc900 platform.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 .../devicetree/bindings/arm/nuvoton/nuc970.txt     | 12 ++++++++++++
 .../bindings/clock/nuvoton,nuc970-clk.txt          | 13 +++++++++++++
 .../interrupt-controller/nuvoton,nuc900-aic.txt    | 15 +++++++++++++++
 .../bindings/reset/nuvoton,nuc900-reset.txt        | 12 ++++++++++++
 .../devicetree/bindings/serial/nuc970-uart.txt     | 22 ++++++++++++++++++++++
 .../bindings/soc/nuvoton/nuvoton,nuc900-soc.txt    | 12 ++++++++++++
 .../bindings/timer/nuvoton,nuc970-tmr.txt          | 20 ++++++++++++++++++++
 7 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,nuc970-clk.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nuvoton,nuc900-aic.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,nuc900-reset.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nuc970-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,nuc970-tmr.txt

diff --git a/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt b/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
new file mode 100644
index 0000000..0872f6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
@@ -0,0 +1,12 @@
+Nuvoton NUC970 SoC platform Device Tree Bindings
+------------------------------------------
+
+Boards with the NUC970 SoC shall have the following properties:
+
+Root node required properties:
+- compatible: Should be "syscon" or "nuvoton,nuc970-gcr"
+
+GCR register required properties:
+- compatible: Should be "nuvoton,nuc970-gcr"
+- reg: Should contain registers location and length
+
diff --git a/Documentation/devicetree/bindings/clock/nuvoton,nuc970-clk.txt b/Documentation/devicetree/bindings/clock/nuvoton,nuc970-clk.txt
new file mode 100644
index 0000000..82fcf32
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,nuc970-clk.txt
@@ -0,0 +1,13 @@
+NUC970 Clock Controller
+
+Clock required properties:
+- compatible: Should be "nuvoton,nuc970-clk"
+- reg: Should contain registers location and length
+
+Examples:
+
+clks: clk at b0000200 {
+	compatible = "nuvoton,nuc970-clk";
+	reg = <0xb0000200 0x200>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/nuvoton,nuc900-aic.txt b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,nuc900-aic.txt
new file mode 100644
index 0000000..f265095
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,nuc900-aic.txt
@@ -0,0 +1,15 @@
+NUC900 interrupt Controller
+
+Interrupt-controller required properties
+- compatible: Should be "nuvoton,nuc900-aic"
+- reg: Should contain registers location and length
+- interrupt-cells: set to 1
+
+Examples:
+
+aic: interrupt-controller at b8002000 {
+	compatible = "nuvoton,nuc900-aic";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	reg = <0xb8002000 0x1000>;
+};
diff --git a/Documentation/devicetree/bindings/reset/nuvoton,nuc900-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,nuc900-reset.txt
new file mode 100644
index 0000000..ab6056a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,nuc900-reset.txt
@@ -0,0 +1,12 @@
+. Nuvoton NUC900 series, reset controller binding.
+
+Required properties:
+- compatible : Should be "nuvoton,nuc900-reset"
+- syscon : Reference to gcr controller.
+
+Example:
+
+reset {
+	compatible = "nuvoton,nuc900-reset";
+	syscon = <&gcr>;
+};
diff --git a/Documentation/devicetree/bindings/serial/nuc970-uart.txt b/Documentation/devicetree/bindings/serial/nuc970-uart.txt
new file mode 100644
index 0000000..a143a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nuc970-uart.txt
@@ -0,0 +1,22 @@
+NUC970 UART Controller
+
+Uart required properties:
+- compatible: Should be "nuvoton,nuc970-uart"
+- reg: Should contain registers location and length
+
+Examples:
+
+aliases {
+	serial0 = &uart0;
+};
+
+uart0: serial at b8000000 {
+	compatible = "nuvoton,nuc970-uart";
+	reg = <0xb8000000 0x1000>;
+	interrupts = <36>;
+	clocks = <&clks UART0_GATE>,
+		 <&clks UART0_ECLK_GATE>;
+	clock-names = "uart0", "uart0_eclk";
+	clock-frequency = <12000000>;
+	status = "disabled";
+};
diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
new file mode 100644
index 0000000..0284edf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
@@ -0,0 +1,12 @@
+. Nuvoton NUC900 series, Soc specific driver binding.
+
+Required properties:
+- compatible : Should be "nuvoton,nuc900-soc"
+- syscon : Reference to gcr controller.
+
+Example:
+
+reset {
+	compatible = "nuvoton,nuc900-soc";
+	syscon = <&gcr>;
+};
diff --git a/Documentation/devicetree/bindings/timer/nuvoton,nuc970-tmr.txt b/Documentation/devicetree/bindings/timer/nuvoton,nuc970-tmr.txt
new file mode 100644
index 0000000..4d74615
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nuvoton,nuc970-tmr.txt
@@ -0,0 +1,20 @@
+. Nuvoton NUC900 series, NUC970 SoC timer
+
+The NUC900 family has several general-purpose 32 bits timers.
+
+Required properties:
+- compatible : Should be "nuvoton,nuc970-tmr"
+- reg : Address and length of the register set
+- clocks : Reference on the timer input clock
+- interrupts : Reference to the timer interrupt
+
+Example:
+
+tmr at 0xb8001000 {
+	compatible = "nuvoton,nuc970-tmr";
+	reg = <0xb8001000 0x1000>;
+	interrupts = <16>;
+	clocks = <&clks TIMER0_GATE>,
+	<&clks TIMER1_GATE>;
+	clock-names = "timer0", "timer1";
+};
-- 
2.7.4

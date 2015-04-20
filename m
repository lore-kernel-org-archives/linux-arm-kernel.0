From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 21 Apr 2015 05:05:26 +0800
Subject: [PATCH v4 04/11] Document: dt: binding: imx: update document for
 imx7d support
In-Reply-To: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429563933-3129-5-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

This part just add necessary change to boot imx7d.
Update clock, pinctrl and gpt for imx7d

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 .../devicetree/bindings/clock/imx7d-clock.txt      | 13 +++++++++++
 .../bindings/pinctrl/fsl,imx-pinctrl.txt           |  3 +++
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 27 ++++++++++++++++++++++
 .../devicetree/bindings/timer/fsl,imxgpt.txt       |  3 +++
 4 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/imx7d-clock.txt b/Documentation/devicetree/bindings/clock/imx7d-clock.txt
new file mode 100644
index 0000000..3db0076
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7d-clock.txt
@@ -0,0 +1,13 @@
+* Clock bindings for Freescale i.MX7 Dual
+
+Required properties:
+- compatible: Should be "fsl,imx7d-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of clock specifiers, must contain an entry for each required
+  entry in clock-names
+- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx7d-clock.h
+for the full list of i.MX7 Dual clock IDs.
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
index 9fde25f..c343a90 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
@@ -21,6 +21,9 @@ Required properties for iomux controller:
 - compatible: "fsl,<soc>-iomuxc"
   Please refer to each fsl,<soc>-pinctrl.txt binding doc for supported SoCs.
 
+  "fsl,<chip>-iomux-lpsr". Some <chip> (imx7d) support one kinds of iomux which
+can keep statue when LPSR mode.
+
 Required properties for pin configuration node:
 - fsl,pins: each entry consists of 6 integers and represents the mux and config
   setting for one pin. The first 5 integers <mux_reg conf_reg input_reg mux_val
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
new file mode 100644
index 0000000..b537da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
@@ -0,0 +1,27 @@
+* Freescale i.MX7 Dual IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,imx67d-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx6sx-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX7 Dual
+  Reference Manual for detailed CONFIG settings.
+
+CONFIG bits definition:
+PAD_CTL_PUS_100K_DOWN           (0 << 5)
+PAD_CTL_PUS_5K_UP               (1 << 5)
+PAD_CTL_PUS_47K_UP              (2 << 5)
+PAD_CTL_PUS_100K_UP             (3 << 5)
+PAD_CTL_PUE                     (1 << 4)
+PAD_CTL_HYS                     (1 << 3)
+PAD_CTL_SRE_SLOW                (1 << 2)
+PAD_CTL_SRE_FAST                (0 << 2)
+PAD_CTL_DSE_X1                  (0 << 0)
+PAD_CTL_DSE_X2                  (1 << 0)
+PAD_CTL_DSE_X3                  (2 << 0)
+PAD_CTL_DSE_X4                  (3 << 0)
diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11..c14843b 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -7,6 +7,9 @@ Required properties:
 - interrupts : A list of 4 interrupts; one per timer channel.
 - clocks : The clocks provided by the SoC to drive the timer.
 
+Supported <soc>:
+	imx1,imx27,imx51,imx53,imx6q,imx6dl,imx6sl,imx6sx,imx7d.
+
 Example:
 
 gpt1: timer at 10003000 {
-- 
1.9.1

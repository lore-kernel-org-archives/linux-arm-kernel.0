From: mirza.krak@gmail.com (Mirza Krak)
Date: Sat,  6 Aug 2016 21:40:49 +0200
Subject: [PATCH 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1470512452-8322-4-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Document the devicetree bindings for the Generic Memory Interface (GMI)
bus driver found on Tegra SOCs.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt

diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
new file mode 100644
index 0000000..046846e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
@@ -0,0 +1,99 @@
+Device tree bindings for NVIDIA Tegra Generic Memory Interface bus
+
+The Generic Memory Interface bus enables memory transfers between internal and
+external memory. Can be used to attach various high speed devices such as
+synchronous/asynchronous NOR, FPGA, UARTS and more.
+
+The actual devices are instantiated from the child nodes of a GMI node.
+
+Required properties:
+  - compatible : Should contain one of the following:
+        For Tegra20 must contain "nvidia,tegra20-gmi".
+        For Tegra30 must contain "nvidia,tegra30-gmi".
+ - reg: Should contain GMI controller registers location and length.
+ - clocks: Must contain an entry for each entry in clock-names.
+ - clock-names: Must include the following entries: "gmi"
+ - resets : Must contain an entry for each entry in reset-names.
+ - reset-names : Must include the following entries: "gmi"
+ - #address-cells: The number of cells used to represent physical base
+   addresses in the GMI address space.
+ - #size-cells: The number of cells used to represent the size of an address
+   range in the GMI address space.
+ - ranges: Mapping of the GMI address space to the CPU address space.
+
+Note that the GMI controller does not have any internal chip-select address
+decoding and if you want to access multiple devices external chip-select
+decoding must be provided. Furthermore, if you do have external logic to
+support multiple devices this would assume that the devices use the same
+timing and so are probably the same type. It also assumes that they can fit in
+the 256MB address range.
+
+Optional properties:
+
+ - nvidia,snor-data-width-32bit: Use 32bit data-bus, default is 16bit.
+ - nvidia,snor-mux-mode: Enable address/data MUX mode.
+ - nvidia,snor-rdy-active-before-data: Assert RDY signal one cycle before data.
+   If omitted it will be asserted with data.
+ - nvidia,snor-rdy-inv: RDY signal is active high
+ - nvidia,snor-adv-inv: ADV signal is active high
+ - nvidia,snor-oe-inv: WE/OE signal is active high
+ - nvidia,snor-cs-inv: CS signal is active high
+ - nvidia,snor-cs-select: CS output pin configuration. Default is CS0
+ 	<0> : CS0
+	<1> : CS1
+	<2> : CS2
+	<3> : CS3
+	<4> : CS4
+	<5> : CS5
+	<6> : CS6
+	<7> : CS7
+
+  Note that there is some special handling for the timing values.
+  From Tegra TRM:
+  Programming 0 means 1 clock cycle: actual cycle = programmed cycle + 1
+
+ - nvidia,snor-muxed-width: Number of cycles MUX address/data asserted on the
+   bus. Valid values are 0-15, default is 1
+ - nvidia,snor-hold-width: Number of cycles CE stays asserted after the
+   de-assertion of WR_N (in case of SLAVE/MASTER Request) or OE_N
+   (in case of MASTER Request). Valid values are 0-15, default is 1
+ - nvidia,snor-adv-width: Number of cycles during which ADV stays asserted.
+   Valid values are 0-15, default is 1.
+ - nvidia,snor-ce-width: Number of cycles before CE is asserted.
+   Valid values are 0-255, default is 4
+ - nvidia,snor-we-width: Number of cycles during which WE stays asserted.
+   Valid values are 0-15, default is 1
+ - nvidia,snor-oe-width: Number of cycles during which OE stays asserted.
+   Valid values are 0-255, default is 1
+ - nvidia,snor-wait-width: Number of cycles before READY is asserted.
+   Valid values are 0-255, default is 3
+
+Example with two SJA1000 CAN controllers connected to the GMI bus:
+
+  gmi at 70090000 {
+    #address-cells = <1>;
+    #size-cells = <1>;
+    ranges;
+    nvidia,snor-mux-mode;
+    nvidia,snor-adv-inv;
+    nvidia,snor-cs-select = <4>;
+
+    bus at 0,0 {
+      compatible = "simple-bus";
+      reg = <0 0>;
+      ranges;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      can at 48000000 {
+        reg = <0x48000000 0x100>;
+        ...
+      };
+
+      can at 48040000 {
+        reg = <0x48040000 0x100>;
+        ...
+      };
+    };
+  };
-- 
2.1.4

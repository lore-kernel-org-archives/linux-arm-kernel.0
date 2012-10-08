From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 10:39:16 +0200
Subject: [PATCH 16/16] Documentation: Update samsung-pinctrl device tree
 bindings documentation
In-Reply-To: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349685556-23718-17-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           | 212 ++++++++++++++++++---
 1 file changed, 187 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 03dee50..6ebc946 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -13,8 +13,35 @@ Required Properties:
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
 
-- interrupts: interrupt specifier for the controller. The format and value of
-  the interrupt specifier depends on the interrupt parent for the controller.
+- Pin bank types: Pin bank nodes reference pin bank types by their phandles to
+  determine low level bank parameters such as bit field availability and widths.
+  There is no restriction for placement of such nodes. A bank type node must
+  contain following properties:
+
+  - samsung,reg-names: names of registers specified in samsung,reg-params
+    property. Allowed register names are:
+    - "func" - function configuration register (GPxCON)
+    - "dat" - input/output value register (GPxDAT)
+    - "pud" - pull-up/-down control register (GPxPUD)
+    - "drv" - driver strength control register (GPxDRV)
+    - "conpdn" - power-down state control register (GPxCONPDN)
+    - "pudpdn" - power-down pull-up/-down control register (GPxPUDPDN)
+  - samsung,reg-params: register specifiers for registers named by
+    samsung,reg-names property. Each specifier contains two cells:
+      - first cell: offset in bytes from first register of the bank
+      - second cell: bits in register used for single pin.
+
+- Pin banks as child nodes: Pin banks of the controller are represented by child
+  nodes of the controller node. Bank name is taken from name of the node. Each
+  bank node must contain following properties:
+
+  - gpio-controller: identifies the node as a gpio controller and pin bank.
+  - samsung,pctrl-offset: offset to pin control registers of the bank.
+  - samsung,pin-count: number of pins in the bank.
+  - samsung,bank-type: phandle to a node defining bank type.
+  - #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
+    binding is used, the amount of cells must be specified as 2. See generic
+    GPIO binding documentation for description of particular cells.
 
 - Pin mux/config groups as child nodes: The pin mux (selecting pin function
   mode) and pin config (pull up/down, driver strength) settings are represented
@@ -72,16 +99,30 @@ used as system wakeup events.
 A. External GPIO Interrupts: For supporting external gpio interrupts, the
    following properties should be specified in the pin-controller device node.
 
-- interrupt-controller: identifies the controller node as interrupt-parent.
-- #interrupt-cells: the value of this property should be 2.
-  - First Cell: represents the external gpio interrupt number local to the
-    external gpio interrupt space of the controller.
-  - Second Cell: flags to identify the type of the interrupt
-    - 1 = rising edge triggered
-    - 2 = falling edge triggered
-    - 3 = rising and falling edge triggered
-    - 4 = high level triggered
-    - 8 = low level triggered
+   - samsung,geint-con: offset of first EXT_INTxx_CON register.
+   - samsung,geint-mask: offset of first EXT_INTxx_MASK register.
+   - samsung,geint-pend: offset of first EXT_INTxx_PEND register.
+   - samsung,svc: offset of EXT_INT_SERVICE register.
+   - interrupt-parent: phandle of the interrupt parent to which the external
+     GPIO interrupts are forwarded to.
+   - interrupts: interrupt specifier for the controller. The format and value of
+     the interrupt specifier depends on the interrupt parent for the controller.
+
+   In addition, following properties must be present in node of every bank
+   of pins supporting GPIO interrupts:
+
+   - interrupt-controller: identifies the controller node as interrupt-parent.
+   - samsung,eint-offset: offset of register related to this bank from first
+     CON/MASK/PEND register.
+   - #interrupt-cells: the value of this property should be 2.
+     - First Cell: represents the external gpio interrupt number local to the
+       external gpio interrupt space of the controller.
+     - Second Cell: flags to identify the type of the interrupt
+       - 1 = rising edge triggered
+       - 2 = falling edge triggered
+       - 3 = rising and falling edge triggered
+       - 4 = high level triggered
+       - 8 = low level triggered
 
 B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
    child node representing the external wakeup interrupt controller should be
@@ -94,7 +135,18 @@ B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
        found on Samsung Exynos4210 SoC.
    - interrupt-parent: phandle of the interrupt parent to which the external
      wakeup interrupts are forwarded to.
+   - interrupts: interrupt used by multiplexed wakeup interrupts.
+   - samsung,weint-con: offset of first wake-up EXT_INTxx_CON register.
+   - samsung,weint-mask: offset of first wake-up EXT_INTxx_MASK register.
+   - samsung,weint-pend: offset of first wake-up EXT_INTxx_PEND register.
+
+   In addition, following properties must be present in node of every bank
+   of pins supporting wake-up interrupts:
+
    - interrupt-controller: identifies the node as interrupt-parent.
+   - samsung,wkup-eint: marks the bank as supporting wake-up interrupts.
+   - samsung,eint-offset: offset of register related to this bank from first
+     wake-up CON/MASK/PEND register.
    - #interrupt-cells: the value of this property should be 2
      - First Cell: represents the external wakeup interrupt number local to
        the external wakeup interrupt space of the controller.
@@ -105,17 +157,125 @@ B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
        - 4 = high level triggered
        - 8 = low level triggered
 
+   Node of every bank of pins supporting direct wake-up interrupts (without
+   multiplexing) must contain following properties:
+
+   - interrupt-parent: phandle of the interrupt parent to which the external
+     wakeup interrupts are forwarded to.
+   - interrupts: interrupts of the interrupt parent which are used for external
+     wakeup interrupts from pins of the bank, must contain interrupts for all
+     pins of the bank.
+
 Aliases:
 
 All the pin controller nodes should be represented in the aliases node using
 the following format 'pinctrl{n}' where n is a unique number for the alias.
 
+Example: Nodes for pin bank types:
+
+	pinctrl-bank-types {
+		bank_off: bank-off {
+			samsung,reg-names = "func", "dat", "pud",
+						"drv", "conpdn", "pudpdn";
+			samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
+						<0x0C 2>, <0x10 2>, <0x14 2>;
+		};
+
+		bank_alive: bank-alive {
+			samsung,reg-names = "func", "dat", "pud",
+						"drv";
+			samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
+						<0x0C 2>;
+		};
+	};
+
+Example: A pin-controller node with pin banks:
+
+	pinctrl_0: pinctrl at 11400000 {
+		compatible = "samsung,pinctrl-exynos4210";
+		reg = <0x11400000 0x1000>;
+		interrupts = <0 47 0>;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
+
+		/* ... */
+
+		/* Pin bank without external interrupts */
+		gpy0: gpy0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x120>;
+			samsung,pin-count = <6>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		/* ... */
+
+		/* Pin bank with external GPIO interrupts */
+		gpj0: gpj0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
+		};
+
+		/* ... */
+
+		/* Pin bank with external direct wake-up interrupts */
+		gpx0: gpx0 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC00>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			interrupt-parent = <&gic>;
+			interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
+				     <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>;
+			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
+		};
+
+		/* ... */
+
+		/* Pin bank with external multiplexed wake-up interrupts */
+		gpx2: gpx2 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC40>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
+		};
+
+		/* ... */
+	};
+
 Example 1: A pin-controller node with pin groups.
 
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11400000 0x1000>;
 		interrupts = <0 47 0>;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
+
+		/* ... */
 
 		uart0_data: uart0-data {
 			samsung,pins = "gpa0-0", "gpa0-1";
@@ -158,20 +318,21 @@ Example 2: A pin-controller node with external wakeup interrupt controller node.
 	pinctrl_1: pinctrl at 11000000 {
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11000000 0x1000>;
-		interrupts = <0 46 0>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+		interrupts = <0 46 0>
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
 
-		wakup_eint: wakeup-interrupt-controller {
+		/* ... */
+
+		wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
 			interrupt-parent = <&gic>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
-					<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
-					<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
-					<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
-					<0 32 0>;
+			interrupts = <0 32 0>;
+			samsung,weint-con = <0xE00>;
+			samsung,weint-mask = <0xF00>;
+			samsung,weint-pend = <0xF40>;
 		};
 	};
 
@@ -190,7 +351,8 @@ Example 4: Set up the default pin state for uart controller.
 
 	static int s3c24xx_serial_probe(struct platform_device *pdev) {
 		struct pinctrl *pinctrl;
-		...
-		...
+
+		/* ... */
+
 		pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	}
-- 
1.7.12

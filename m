From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2016 10:52:35 +0200
Subject: [PATCH 1/4 v2] soc: qcom: add EBI2 device tree bindings
In-Reply-To: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472028758-29272-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the External Bus Interface 2, EBI2
to the Qualcomm SoC drivers.

Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Introduce per-SoC compatible strings for apq8060 and msm8660
- Move the binding to bus/qcom,ebi2.txt
- Add a vendor prefix for each chipselect XMEM configuration option
  "qcom,xmem-foo"
- Move all CS XMEM settings to the EBI2 node, encode the six
  different chipselects into an array of settings.
- Use ranges to specify the address windows for the six different
  chipselects.
- Alter #address-cells to <2> using the first as chipselect and the
  second as offset into the range.
- Augment the example accordingly.
---
 .../devicetree/bindings/bus/qcom,ebi2.txt          | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.txt

diff --git a/Documentation/devicetree/bindings/bus/qcom,ebi2.txt b/Documentation/devicetree/bindings/bus/qcom,ebi2.txt
new file mode 100644
index 000000000000..4adadb65bea6
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/qcom,ebi2.txt
@@ -0,0 +1,136 @@
+Qualcomm External Bus Interface 2 (EBI2)
+
+The EBI2 contains two peripheral blocks: XMEM and LCDC. The XMEM handles any
+external memory (such as NAND or other memory-mapped peripherals) whereas
+LCDC handles LCD displays.
+
+As it says it connects devices to an external bus interface, meaning address
+lines (up to 9 address lines so can only address 1KiB external memory space),
+data lines (16 bits), OE (output enable), ADV (address valid, used on some
+NOR flash memories), WE (write enable). This on top of 6 different chip selects
+(CS0 thru CS5) so that in theory 6 different devices can be connected.
+
+Apparently this bus is clocked at 64MHz. It has dedicated pins on the package
+and the bus can only come out on these pins, however if some of the pins are
+unused they can be left unconnected or remuxed to be used as GPIO or in some
+cases other orthogonal functions as well.
+
+Also CS1 and CS2 has -A and -B signals. Why they have that is unclear to me.
+
+The chip selects have the following memory range assignments. This region of
+memory is referred to as "Chip Peripheral SS FPB0" and is 168MB big.
+
+Chip Select                     Physical address base
+CS0 GPIO134                     0x1a800000-0x1b000000 (8MB)
+CS1 GPIO39 (A) / GPIO123 (B)    0x1b000000-0x1b800000 (8MB)
+CS2 GPIO40 (A) / GPIO124 (B)    0x1b800000-0x1c000000 (8MB)
+CS3 GPIO133                     0x1d000000-0x25000000 (128 MB)
+CS4 GPIO132                     0x1c800000-0x1d000000 (8MB)
+CS5 GPIO131                     0x1c000000-0x1c800000 (8MB)
+
+The APQ8060 Qualcomm Application Processor User Guide, 80-N7150-14 Rev. A,
+August 6, 2012 contains some incomplete documentation of the EBI2.
+
+FIXME: the manual mentions "write precharge cycles" and "precharge cycles".
+We have not been able to figure out which bit fields these correspond to
+in the hardware, or what valid values exist. The current hypothesis is that
+this is something just used on the FAST chip selects and that the SLOW
+chip selects are understood fully. There is also a "byte device enable"
+flag somewhere for 8bit memories.
+
+FIXME: The chipselects have SLOW and FAST configuration registers. It's a bit
+unclear what this means, if they are mutually exclusive or can be used
+together, or if some chip selects are hardwired to be FAST and others are SLOW
+by design.
+
+The XMEM registers are totally undocumented but could be partially decoded
+because the Cypress AN49576 Antioch Westbridge apparently has suspiciously
+similar register layout, see: http://www.cypress.com/file/105771/download
+
+Required properties:
+- compatible: should be one of:
+  "qcom,msm8660-ebi2"
+  "qcom,apq8060-ebi2"
+- #address-cells: shoule be <2>: the first cell is the chipselect,
+  the second cell is the offset inside the memory range
+- #size-cells: should be <1>
+- ranges: should be set to:
+  ranges = <0 0x0 0x1a800000 0x00800000>,
+           <1 0x0 0x1b000000 0x00800000>,
+           <2 0x0 0x1b800000 0x00800000>,
+           <3 0x0 0x1d000000 0x00800000>,
+           <4 0x0 0x1c800000 0x00800000>,
+           <5 0x0 0x1c000000 0x00800000>;
+- reg: two ranges of registers: EBI2 config and XMEM config areas
+- reg-names: should be "ebi2", "xmem"
+- clocks: two clocks, EBI_2X and EBI
+- clock-names: shoule be "ebi2x", "ebi2"
+
+The following optional properties are all arrays indexed to the target
+chipselect, usually an array of six elements representing the six chipselects:
+
+Optional properties arrays for SLOW chip selects:
+- qcom,xmem-recovery-cycles: recovery cycles is the time the memory continues to
+  drive the data bus after OE is de-asserted, in order to avoid contention on
+  the data bus. They are inserted when reading one CS and switching to another
+  CS or read followed by write on the same CS. Valid values 0 thru 15. Minimum
+  value is actually 1, so a value of 0 will still yield 1 recovery cycle.
+- qcom,xmem-write-hold-cycles: write hold cycles, these are extra cycles
+  inserted after every write minimum 1. The data out is driven from the time
+  WE is asserted until CS is asserted. With a hold of 1 (value = 0), the CS
+  stays active for 1 extra cycle etc. Valid values 0 thru 15.
+- qcom,xmem-write-delta-cycles: initial latency for write cycles inserted for
+  the first write to a page or burst memory. Valid values 0 thru 255.
+- qcom,xmem-read-delta-cycles: initial latency for read cycles inserted for the
+  first read to a page or burst memory. Valid values 0 thru 255.
+- qcom,xmem-write-wait-cycles: number of wait cycles for every write access, 0=1
+  cycle. Valid values 0 thru 15.
+- qcom,xmem-read-wait-cycles: number of wait cycles for every read access, 0=1
+  cycle. Valid values 0 thru 15.
+
+Optional properties arrays for FAST chip selects:
+- qcom,xmem-address-hold-enable: this is a boolean property stating that we
+  shall hold the address for an extra cycle to meet hold time requirements
+  with ADV assertion.
+- qcom,xmem-adv-to-oe-recovery-cycles: the number of cycles elapsed before an OE
+  assertion, with respect to the cycle where ADV (address valid) is asserted.
+  2 means 2 cycles between ADV and OE. Valid values 0, 1, 2 or 3.
+- qcom,xmem-read-hold-cycles: the length in cycles of the first segment of a
+  read transfer. For a single read trandfer this will be the time from CS
+  assertion to OE assertion. Valid values 0 thru 15.
+
+Optional subnodes:
+- Nodes inside the EBI2 will be considered device nodes.
+
+Example:
+
+ebi2 at 1a100000 {
+	compatible = "qcom,apq8060-ebi2";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0x0 0x1a800000 0x00800000>,
+		 <1 0x0 0x1b000000 0x00800000>,
+		 <2 0x0 0x1b800000 0x00800000>,
+		 <3 0x0 0x1d000000 0x00800000>,
+		 <4 0x0 0x1c800000 0x00800000>,
+		 <5 0x0 0x1c000000 0x00800000>;
+	reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
+	reg-names = "ebi2", "xmem";
+	clocks = <&gcc EBI2_2X_CLK>, <&gcc EBI2_CLK>;
+	clock-names = "ebi2x", "ebi2";
+	/* Make sure to set up the pin control for the EBI2 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&foo_ebi2_pins>;
+	qcom,xmem-recovery-cycles = <0>, <0>, <0>, <0>, <0>, <0>;
+	qcom,xmem-write-hold-cycles = <0>, <0>, <3>, <0>, <0>, <0>;
+	qcom,xmem-write-delta-cycles = <0>, <0>, <31>, <0>, <0>, <0>;
+	qcom,xmem-read-delta-cycles = <0>, <0>, <28>, <0>, <0>, <0>;
+	qcom,xmem-write-wait-cycles = <0>, <0>, <9>, <0>, <0>, <0>;
+	qcom,xmem-read-wait-cycles = <0>, <0>, <9>, <0>, <0>, <0>;
+
+ 	foo-ebi2 at 1b800000 {
+		compatible = "foo";
+		reg = <2 0x1b800000 0x100>;
+		(...)
+	};
+};
-- 
2.7.4

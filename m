From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Jul 2015 23:20:12 +0200
Subject: [PATCH v2 2/2] doc: dt: add documentation for pl172 memory bindings
In-Reply-To: <1436822412-20171-1-git-send-email-manabian@gmail.com>
References: <1436822412-20171-1-git-send-email-manabian@gmail.com>
Message-ID: <1436822412-20171-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for configuration and timing setup of
static memory devices on the ARM PL172 controller.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/memory-controllers/arm,pl172.txt      | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt b/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
new file mode 100644
index 000000000000..e6df32f9986d
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
@@ -0,0 +1,125 @@
+* Device tree bindings for ARM PL172 MultiPort Memory Controller
+
+Required properties:
+
+- compatible:		"arm,pl172", "arm,primecell"
+
+- reg:			Must contains offset/length value for controller.
+
+- #address-cells:	Must be 2. The partition number has to be encoded in the
+			first address cell and it may accept values 0..N-1
+			(N - total number of partitions). The second cell is the
+			offset into the partition.
+
+- #size-cells:		Must be set to 1.
+
+- ranges:		Must contain one or more chip select memory regions.
+
+- clocks:		Must contain references to controller clocks.
+
+- clock-names:		Must contain "mpmcclk" and "apb_pclk".
+
+- clock-ranges:		Empty property indicating that child nodes can inherit
+			named clocks. Required only if clock tree data present
+			in device tree.
+			See clock-bindings.txt
+
+Child chip-select (cs) nodes contain the memory devices nodes connected to
+such as NOR (e.g. cfi-flash) and NAND.
+
+Required child cs node properties:
+
+- #address-cells:	Must be 2.
+
+- #size-cells:		Must be 1.
+
+- ranges:		Empty property indicating that child nodes can inherit
+			memory layout.
+
+- clock-ranges:		Empty property indicating that child nodes can inherit
+			named clocks. Required only if clock tree data present
+			in device tree.
+
+- mpmc,cs:		Chip select number. Indicates to the pl0172 driver
+			which chipselect is used for accessing the memory.
+
+- mpmc,memory-width:	Width of the chip select memory. Must be equal to
+			either 8, 16 or 32.
+
+Optional child cs node config properties:
+
+- mpmc,async-page-mode:	Enable asynchronous page mode.
+
+- mpmc,cs-active-high:	Set chip select polarity to active high.
+
+- mpmc,byte-lane-low:	Set byte lane state to low.
+
+- mpmc,extended-wait:	Enable extended wait.
+
+- mpmc,buffer-enable:	Enable write buffer.
+
+- mpmc,write-protect:	Enable write protect.
+
+Optional child cs node timing properties:
+
+- mpmc,write-enable-delay:	Delay from chip select assertion to write
+				enable (WE signal) in nano seconds.
+
+- mpmc,output-enable-delay:	Delay from chip select assertion to output
+				enable (OE signal) in nano seconds.
+
+- mpmc,write-access-delay:	Delay from chip select assertion to write
+				access in nano seconds.
+
+- mpmc,read-access-delay:	Delay from chip select assertion to read
+				access in nano seconds.
+
+- mpmc,page-mode-read-delay:	Delay for asynchronous page mode sequential
+				accesses in nano seconds.
+
+- mpmc,turn-round-delay:	Delay between access to memory banks in nano
+				seconds.
+
+If any of the above timing parameters are absent, current parameter value will
+be taken from the corresponding HW reg.
+
+Example for pl172 with nor flash on chip select 0 shown below.
+
+emc: memory-controller at 40005000 {
+	compatible = "arm,pl172", "arm,primecell";
+	reg = <0x40005000 0x1000>;
+	clocks = <&ccu1 CLK_CPU_EMCDIV>, <&ccu1 CLK_CPU_EMC>;
+	clock-names = "mpmcclk", "apb_pclk";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x1c000000 0x1000000
+		  1 0 0x1d000000 0x1000000
+		  2 0 0x1e000000 0x1000000
+		  3 0 0x1f000000 0x1000000>;
+
+	cs0 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		mpmc,cs = <0>;
+		mpmc,memory-width = <16>;
+		mpmc,byte-lane-low;
+		mpmc,write-enable-delay = <0>;
+		mpmc,output-enable-delay = <0>;
+		mpmc,read-enable-delay = <70>;
+		mpmc,page-mode-read-delay = <70>;
+
+		flash at 0,0 {
+			compatible = "sst,sst39vf320", "cfi-flash";
+			reg = <0 0 0x400000>;
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition at 0 {
+				label = "data";
+				reg = <0 0x400000>;
+			};
+		};
+	};
+};
-- 
1.8.0

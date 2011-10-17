From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Oct 2011 10:52:56 -0700
Subject: [RFC] [PATCH] ARM: tegra: emc: device tree bindings
Message-ID: <1318873976-25335-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First cut at device tree bindings for the EMC tables on tegra.

Note that I have a prerequisite patch that changes the tegra2_emc code
to be a platform driver; but I wanted to do a sanity-check of my device
tree usage here before posting the whole series.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 .../devicetree/bindings/arm/tegra/emc.txt          |   77 ++++++++++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts               |   36 +++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |    7 ++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/emc.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/emc.txt b/Documentation/devicetree/bindings/arm/tegra/emc.txt
new file mode 100644
index 0000000..dd7f845
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/emc.txt
@@ -0,0 +1,77 @@
+Embedded Memory Controller
+
+Properties:
+- name : Should be emc
+- #address-cells : Should be 1
+- #size-cells : Should be 0
+- compatible : should contain "nvidia,tegra20-emc".
+- reg : Offset and length of the register set for the device
+- nvidia,use-ram-code : If present, the sub-nodes will be addressed
+  and chosen using the ramcode board selector. If omitted, only one
+  set of tables can be present and said tables will be used
+  irrespective of ram-code configuration.
+
+Child device nodes describe the memory settings for different configurations and clock rates.
+
+Example:
+
+	emc at 7000f400 {
+		#address-cells = < 1 >;
+		#size-cells = < 0 >;
+		compatible = "nvidia,tegra20-emc";
+		reg = <0x7000f4000 0x200>;
+	}
+
+
+Embedded Memory Controller configuration table
+
+This is a table containing the EMC register settings for the various
+operating speeds of the memory controller. They are always located as
+subnodes of the emc controller node.
+
+There are two ways of specifying which tables to use:
+
+* The simplest is if there is just one set of tables in the device tree,
+  and they will always be used (based on which frequency is used).
+  This is the preferred method, especially when firmware can fill in
+  this information based on the specific system information and just
+  pass it on to the kernel.
+
+* The slightly more complex one is when more than one memory configuration
+  might exist on the system.  The Tegra20 platform handles this during
+  early boot by selecting one out of possible 4 memory settings based
+  on a 2-pin "ram code" bootstrap setting on the board. The values of
+  these strappings can be read through a register in the SoC, and thus
+  used to select which tables to use.
+
+Properties:
+- name : Should start with emc-table
+- compatible : should contain "nvidia,tegra20-emc-table".
+- reg : only needed if nvidia,use-ram-code is present in the
+  parent. If so, the numerical representation of the selected ram code
+  as reported by the strap option APB misc register.
+- clock-frequency : the clock frequency for the EMC at which this
+  table should be used (in kHz).
+- nvidia,emc-registers : a 46 word array of EMC registers to be programmed
+  for operation at the 'clock-frequency' setting.
+  The order and contents of the registers are defined in the Tegra TRM.
+
+		emc-table-333mhz at 0 {
+			reg = <0>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = < 333000 >;
+			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 >;
+		};
+
+		emc-table-666mhz at 0 {
+			reg = <0>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = < 666000 >;
+			nvidia,emc-registers = < 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+						 0 0 0 0 >;
+		};
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index a72299b..2d60b5ff 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -20,6 +20,42 @@
 		clock-frequency = < 216000000 >;
 	};
 
+	emc {
+		emc-table-166 {
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = < 166500 >;
+			nvidia,emc-registers = < 0x0000000a 0x00000021
+				0x00000008 0x00000003 0x00000004 0x00000004
+				0x00000002 0x0000000c 0x00000003 0x00000003
+				0x00000002 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x000004df
+				0x00000000 0x00000003 0x00000003 0x00000003
+				0x00000003 0x00000001 0x0000000a 0x000000c8
+				0x00000003 0x00000006 0x00000004 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xa04004ae
+				0x007fd010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000 >;
+		};
+
+		emc-table-333 {
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = < 333000 >;
+			nvidia,emc-registers = < 0x00000014 0x00000041
+				0x0000000f 0x00000005 0x00000004 0x00000005
+				0x00000003 0x0000000c 0x00000005 0x00000005
+				0x00000003 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x000009ff
+				0x00000000 0x00000003 0x00000003 0x00000005
+				0x00000005 0x00000001 0x0000000f 0x000000c8
+				0x00000003 0x0000000c 0x00000006 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xe034048b
+				0x007e8010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000 >;
+		};
+	};
+
 	sdhci at c8000400 {
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 65d7e6a..f4dc8d3 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -120,6 +120,13 @@
 		interrupts = < 123 >;
 	};
 
+	emc at 7000f400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,tegra20-emc";
+		reg = <0x7000f400 0x200>;
+	};
+
 	sdhci at c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
-- 
1.7.4.1

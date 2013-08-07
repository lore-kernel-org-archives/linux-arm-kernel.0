From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  7 Aug 2013 16:09:46 +0100
Subject: [PATCH v2 3/5] ARM: vexpress: Add SCC to V2P-CA15_A7's device tree
In-Reply-To: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
References: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1375888188-30213-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCC (Serial Configuration Controller) is used to set initial
conditions for the test chip (TC2). Its registers are also mapped
in normal address space and used to obtain runtime information
and for power management.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 .../devicetree/bindings/arm/vexpress-scc.txt       | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  6 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-scc.txt

diff --git a/Documentation/devicetree/bindings/arm/vexpress-scc.txt b/Documentation/devicetree/bindings/arm/vexpress-scc.txt
new file mode 100644
index 0000000..ae5043e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vexpress-scc.txt
@@ -0,0 +1,33 @@
+ARM Versatile Express Serial Configuration Controller
+-----------------------------------------------------
+
+Test chips for ARM Versatile Express platform implement SCC (Serial
+Configuration Controller) interface, used to set initial conditions
+for the test chip.
+
+In some cases its registers are also mapped in normal address space
+and can be used to obtain runtime information about the chip internals
+(like silicon temperature sensors) and as interface to other subsystems
+like platform configuration control and power management.
+
+Required properties:
+
+- compatible value: "arm,vexpress-scc,<model>", "arm,vexpress-scc";
+		    where <model> is the full tile model name (as used
+		    in the tile's Technical Reference Manual),
+		    eg. for Coretile Express A15x2 A7x3 (V2P-CA15_A7):
+	compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
+
+Optional properties:
+
+- reg: when the SCC is memory mapped, physical address and size of the
+       registers window
+- interrupts: when the SCC can generate a system-level interrupt
+
+Example:
+
+	scc at 7fff0000 {
+		compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
+		reg = <0 0x7fff0000 0 0x1000>;
+		interrupts = <0 95 4>;
+	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index d2803be..759b0cd 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -125,6 +125,12 @@
 		clock-names = "apb_pclk";
 	};
 
+        scc at 7fff0000 {
+		compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
+		reg = <0 0x7fff0000 0 0x1000>;
+		interrupts = <0 95 4>;
+        };
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
-- 
1.8.1.2

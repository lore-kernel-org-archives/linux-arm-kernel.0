From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 15:31:15 -0600
Subject: [PATCH 1/5] ARM: tegra: define DT bindings for and instantiate timer
Message-ID: <1348090279-22631-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra timer provides a number of 29-bit timer channels, a single
32-bit free running counter, and in the Tegra30 variant, 5 watchdog modules.
The first two channels may also trigger a legacy watchdog reset.

Define a DT binding for this HW module, and add the module into the Tegra
device tree files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../bindings/timer/nvidia,tegra20-timer.txt        |   21 ++++++++++++++++++
 .../bindings/timer/nvidia,tegra30-timer.txt        |   23 ++++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |    9 +++++++
 arch/arm/boot/dts/tegra30.dtsi                     |   11 +++++++++
 4 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
new file mode 100644
index 0000000..e019fdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
@@ -0,0 +1,21 @@
+NVIDIA Tegra20 timer
+
+The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
+running counter. The first two channels may also trigger a watchdog reset.
+
+Required properties:
+
+- compatible : should be "nvidia,tegra20-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 4 interrupts; one per timer channel.
+
+Example:
+
+timer {
+	compatible = "nvidia,tegra20-timer";
+	reg = <0x60005000 0x60>;
+	interrupts = <0 0 0x04
+			0 1 0x04
+			0 41 0x04
+			0 42 0x04>;
+};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
new file mode 100644
index 0000000..906109d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
@@ -0,0 +1,23 @@
+NVIDIA Tegra30 timer
+
+The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
+running counter, and 5 watchdog modules. The first two channels may also
+trigger a legacy watchdog reset.
+
+Required properties:
+
+- compatible : should be "nvidia,tegra30-timer", "nvidia,tegra20-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 6 interrupts; one per each of timer channels 1
+    through 5, and one for the shared interrupt for the remaining channels.
+
+timer {
+	compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
+	reg = <0x60005000 0x400>;
+	interrupts = <0 0 0x04
+		      0 1 0x04
+		      0 41 0x04
+		      0 42 0x04
+		      0 121 0x04
+		      0 122 0x04>;
+};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 405d167..0fadf4d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -12,6 +12,15 @@
 		#interrupt-cells = <3>;
 	};
 
+	timer at 60005000 {
+		compatible = "nvidia,tegra20-timer";
+		reg = <0x60005000 0x60>;
+		interrupts = <0 0 0x04
+			      0 1 0x04
+			      0 41 0x04
+			      0 42 0x04>;
+	};
+
 	apbdma: dma {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 3e4334d..d6f8e4c 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -12,6 +12,17 @@
 		#interrupt-cells = <3>;
 	};
 
+	timer at 60005000 {
+		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
+		reg = <0x60005000 0x400>;
+		interrupts = <0 0 0x04
+			      0 1 0x04
+			      0 41 0x04
+			      0 42 0x04
+			      0 121 0x04
+			      0 122 0x04>;
+	};
+
 	apbdma: dma {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
-- 
1.7.0.4

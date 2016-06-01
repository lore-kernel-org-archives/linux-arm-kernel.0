From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:14 +0200
Subject: [PATCH 05/32] ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-6-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

While this devicetree also works for booting in 32-bit mode, it's
placed in arm64 since it's a 64-bit CPU (as suggested by Arnd).

v2: Move to arm64/ instead of arm/

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org> (v1)

[ kraxel: drop bcm2837-rpi-3-b.dtb from arm(32) Makefile ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/boot/dts/broadcom/Makefile            |  1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 29 ++++++++++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi        | 74 ++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index bec1f8b..05faf2a 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb
 dtb-$(CONFIG_ARCH_VULCAN) += vulcan-eval.dtb
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
new file mode 100644
index 0000000..223793d
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -0,0 +1,29 @@
+/dts-v1/;
+#include "bcm2837.dtsi"
+#include "../../../../arm/boot/dts/bcm2835-rpi.dtsi"
+
+/ {
+	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
+	model = "Raspberry Pi 3 Model B";
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	leds {
+		act {
+			gpios = <&gpio 47 0>;
+		};
+
+		pwr {
+			label = "PWR";
+			gpios = <&gpio 35 0>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
new file mode 100644
index 0000000..2320f8d
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -0,0 +1,74 @@
+#include "../../../../arm/boot/dts/bcm283x.dtsi"
+
+/ {
+	compatible = "brcm,bcm2836";
+
+	soc {
+		ranges = <0x7e000000 0x3f000000 0x1000000>,
+			 <0x40000000 0x40000000 0x00001000>;
+		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
+
+		local_intc: local_intc {
+			compatible = "brcm,bcm2836-l1-intc";
+			reg = <0x40000000 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&local_intc>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&local_intc>;
+		interrupts = <0>, // PHYS_SECURE_PPI
+			     <1>, // PHYS_NONSECURE_PPI
+			     <3>, // VIRT_PPI
+			     <2>; // HYP_PPI
+		always-on;
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x000000e0>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x000000e8>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x000000f0>;
+		};
+	};
+};
+
+/* Make the BCM2835-style global interrupt controller be a child of the
+ * CPU-local interrupt controller.
+ */
+&intc {
+	compatible = "brcm,bcm2836-armctrl-ic";
+	reg = <0x7e00b200 0x200>;
+	interrupt-parent = <&local_intc>;
+	interrupts = <8>;
+};
-- 
1.8.3.1

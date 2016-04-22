From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 22 Apr 2016 11:07:23 +0200
Subject: [PATCH v6 01/12] arm64: dts: r8a7795: Add SYSC PM Domains
In-Reply-To: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461316054-27999-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the System Controller.
Hook up the Cortex-A57 CPU cores and the Cortex-A57 and Cortex A53 L2
caches/SCUs to their respective PM Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - Add Acked-by,

v5:
  - Remove "power-domains" property again from the sysc node, as the
    System Controller itself is not part of the Clock Domain,

v4:
  - Add "power-domains" property to the sysc node, to refer to the SoC's
    Clock Domain,
  - Extract using "<&sysc R8A7795_PD_ALWAYS_ON>" for devices in the
    always-on power area into a separate patch,

v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",
  - Use "<&sysc R8A7795_PD_ALWAYS_ON>" for devices in the always-on
    power area,
  - Drop fallback compatibility strings,

v2:
  - New.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 11f9971a85433b7f..9c7424fc171fb876 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a7795-sysc.h>
 
 / {
 	compatible = "renesas,r8a7795";
@@ -39,6 +40,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -47,6 +49,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -54,6 +57,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x2>;
 			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA57_CPU2>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -61,6 +65,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x3>;
 			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA57_CPU3>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -68,12 +73,14 @@
 
 	L2_CA57: cache-controller at 0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7795_PD_CA57_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	L2_CA53: cache-controller at 1 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7795_PD_CA53_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -305,6 +312,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7795-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
 		audma0: dma-controller at ec700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xec700000 0 0x10000>;
-- 
1.9.1

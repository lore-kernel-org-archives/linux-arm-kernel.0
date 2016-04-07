From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  7 Apr 2016 14:20:24 +0200
Subject: [PATCH v4 01/12] ARM: dts: r8a7779: Add SYSC PM Domains
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1460031635-13452-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the System Controller, and hook it up to the
CPG/MSTP Clock Domain.
Hook up ARM CPU cores 1-3 to their respective PM Domains.
Note that ARM CPU core 0 cannot be shut off.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Add power-domains property to the sysc node, to refer to the SoC's
    Clock Domain,

v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",

v2:
  - Correct sysc "reg" property (#address/size-cells = 1, not 2),
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7779.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c1d48d712a18652..2679ab4629d5c2b2 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7779-sysc.h>
 
 / {
 	compatible = "renesas,r8a7779";
@@ -34,18 +35,21 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM1>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM2>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM3>;
 		};
 	};
 
@@ -586,4 +590,11 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller at ffd85000 {
+		compatible = "renesas,r8a7779-sysc";
+		reg = <0xffd85000 0x0200>;
+		power-domains = <&cpg_clocks>;
+		#power-domain-cells = <1>;
+	};
 };
-- 
1.9.1

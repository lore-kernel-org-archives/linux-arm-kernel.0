From: kapilh@broadcom.com (Kapil Hali)
Date: Tue, 1 Dec 2015 11:24:07 -0500
Subject: [PATCH v4 3/5] ARM: dts: Add SMP support for Broadcom NSP
In-Reply-To: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
Message-ID: <1448987049-17041-4-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree changes required for providing SMP support
for Broadcom Northstar Plus SoC.

Signed-off-by: Kapil Hali <kapilh@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 58aca27..4c52417 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -40,24 +40,33 @@
 	model = "Broadcom Northstar Plus SoC";
 	interrupt-parent = <&gic>;
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "brcm,bcm-nsp-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			secondary-boot-reg = <0xffff042c>;
+			reg = <0x1>;
+		};
+	};
+
 	mpcore {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19020000 0x00003000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		cpus {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cpu at 0 {
-				device_type = "cpu";
-				compatible = "arm,cortex-a9";
-				next-level-cache = <&L2>;
-				reg = <0x0>;
-			};
-		};
-
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0x2000 0x1000>;
-- 
2.1.0

From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:11:31 -0400
Subject: [PATCH v3 3/3] ARM: dts: NSP: Add Thermal Support
In-Reply-To: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493410291-16679-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal support via the ns-thermal driver and create a single
thermal zone for the entire SoC.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 832795b..be6fcfb 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -383,6 +383,12 @@
 			      <0x3f408 0x04>;
 		};
 
+		thermal: thermal at 3f2c0 {
+			compatible = "brcm,ns-thermal";
+			reg = <0x3f2c0 0x10>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		sata_phy: sata_phy at 40100 {
 			compatible = "brcm,iproc-nsp-sata-phy";
 			reg = <0x40100 0x340>;
@@ -533,4 +539,24 @@
 			brcm,pcie-msi-inten;
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			coefficients = <(-556) 418000>;
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature     = <125000>;
+					hysteresis      = <0>;
+					type            = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
 };
-- 
2.7.4

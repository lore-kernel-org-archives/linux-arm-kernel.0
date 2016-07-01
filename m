From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Fri,  1 Jul 2016 16:37:11 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: add ETM, ETB and ETMCK node
In-Reply-To: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
References: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
Message-ID: <1467383831-6985-2-git-send-email-olivier.schonken@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node to support SAMA5D2 Embedded Trace Macrocell and Embedded
Trace Buffer. Add a dummy clock node needed by drivers/amba/bus.c
for succesfull probe. The coresight clock is always present, and
can thus not be enabled/disabled by a register write.

This patch depends on coresight-etm3x: Add ARM ETM-A5 peripheral ID
for proper functionality.

Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 5d63206..4a3a3fb 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -77,6 +77,37 @@
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
+	etb: etb at 00740000 {
+		compatible = "arm,coresight-etb10", "arm,primecell";
+		reg = <0x740000 0x1000>;
+		status = "okay";
+
+		clocks = <&etmck>;
+		clock-names = "apb_pclk";
+
+		port {
+			etb_in: endpoint {
+				slave-mode;
+				remote-endpoint = <&etm_out>;
+			};
+		};
+	};
+
+	etm: etm at 0073C000 {
+		compatible = "arm,coresight-etm3x", "arm,primecell";
+		reg = <0x73C000 0x1000>;
+		status = "okay";
+
+		clocks = <&etmck>;
+		clock-names = "apb_pclk";
+
+		port {
+			etm_out: endpoint {
+				remote-endpoint = <&etb_in>;
+			};
+		};
+	};
+
 	memory {
 		reg = <0x20000000 0x20000000>;
 	};
@@ -474,6 +505,19 @@
 					};
 				};
 
+				/*
+				 * This is a dummy clock needed by
+				 * drivers/amba/bus.c when probing
+				 * for ETM/ETB. On SAMA5D2 the coresight
+				 * clock is always supplied.
+				*/
+
+				etmck: etmck {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <0>;
+				};
+
 				systemck {
 					compatible = "atmel,at91rm9200-clk-system";
 					#address-cells = <1>;
-- 
1.9.1

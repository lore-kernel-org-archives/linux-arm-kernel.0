From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Tue,  5 Jul 2016 10:05:50 +0200
Subject: [PATCH v2 2/2] ARM: dts: at91: sama5d2: add ETM and ETB nodes
In-Reply-To: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
References: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
Message-ID: <1467705950-29482-2-git-send-email-olivier.schonken@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node to support SAMA5D2 Embedded Trace Macrocell and Embedded
Trace Buffer.

This patch depends on coresight-etm3x: Add ARM ETM-A5 peripheral ID
for proper coresight functionality.
It also depends on clocksource: timer-atmel-pit: enable mck to not
stall SAMA5D2 on bootup.

Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 5d63206..bde24ab 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -77,6 +77,35 @@
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
+	etb {
+		compatible = "arm,coresight-etb10", "arm,primecell";
+		reg = <0x740000 0x1000>;
+
+		clocks = <&mck>;
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
+	etm {
+		compatible = "arm,coresight-etm3x", "arm,primecell";
+		reg = <0x73C000 0x1000>;
+
+		clocks = <&mck>;
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
-- 
1.9.1

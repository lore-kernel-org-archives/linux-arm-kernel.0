From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Jun 2018 12:22:11 +0100
Subject: [PATCH v2 4/6] dts: bindings: Document device tree binding for CATU
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Message-ID: <20180625112213.23492-5-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document CATU device-tree bindings. CATU augments the TMC-ETR
by providing an improved Scatter Gather mechanism for streaming
trace data to non-contiguous system RAM pages.

Cc: devicetree at vger.kernel.org
Cc: frowand.list at gmail.com
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 9aa30a1..5d1ad09 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -39,6 +39,8 @@ its hardware characteristcs.
 
 		- System Trace Macrocell:
 			"arm,coresight-stm", "arm,primecell"; [1]
+		- Coresight Address Translation Unit (CATU)
+			"arm,coresight-catu", "arm,primecell";
 
 	* reg: physical base address and length of the register
 	  set(s) of the component.
@@ -90,6 +92,10 @@ its hardware characteristcs.
 	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
 	  use the SG mode on this system.
 
+* Optional property for CATU :
+	* interrupts : Exactly one SPI may be listed for reporting the address
+	  error
+
 Example:
 
 1. Sinks
@@ -121,6 +127,35 @@ Example:
 		};
 	};
 
+	etr at 20070000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20070000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port at 0 {
+				reg =  <0>;
+				etr_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator2_out_port0>;
+				};
+			};
+
+			/* CATU link represented by output port */
+			port at 1 {
+				reg = <1>;
+				etr_out_port: endpoint {
+					remote-endpoint = <&catu_in_port>;
+				};
+			};
+		};
+	};
+
 2. Links
 	replicator {
 		/* non-configurable replicators don't show up on the
@@ -250,5 +285,23 @@ Example:
 		};
 	};
 
+5. CATU
+
+	catu at 207e0000 {
+		compatible = "arm,coresight-catu", "arm,primecell";
+		reg = <0 0x207e0000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		port {
+			catu_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&etr_out_port>;
+			};
+		};
+	};
+
 [1]. There is currently two version of STM: STM32 and STM500.  Both
 have the same HW interface and as such don't need an explicit binding name.
-- 
2.9.5

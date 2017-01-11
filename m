From: mike.leach@linaro.org (Mike Leach)
Date: Wed, 11 Jan 2017 20:44:08 +0000
Subject: [PATCH v2 1/2] arm64: dts: juno: Fix CoreSight support for Juno r1/r2
 variants
In-Reply-To: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
References: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
Message-ID: <1484167449-14432-2-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CoreSight support added for Juno is valid for only Juno r0.
The Juno r1 and r2 variants have additional components and alternative
connection routes between trace source and sinks.

The CoreSight infrastructure external to the Cortex-Axx clusters, has
been split into separate .dtsi include files for r0 and r1/r2 to correctly
represent these variations.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 135 ----------------
 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi   | 150 ++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 250 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts       |   1 +
 arch/arm64/boot/dts/arm/juno-r2.dts       |   1 +
 arch/arm64/boot/dts/arm/juno.dts          |   1 +
 6 files changed, 403 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 7d83224..7c89000 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -83,104 +83,6 @@
 	 * The actual size is just 4K though 64K is reserved. Access to the
 	 * unmapped reserved region results in a DECERR response.
 	 */
-	etf at 20010000 {
-		compatible = "arm,coresight-tmc", "arm,primecell";
-		reg = <0 0x20010000 0 0x1000>;
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* input port */
-			port at 0 {
-				reg = <0>;
-				etf_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&main_funnel_out_port>;
-				};
-			};
-
-			/* output port */
-			port at 1 {
-				reg = <0>;
-				etf_out_port: endpoint {
-					remote-endpoint = <&replicator_in_port0>;
-				};
-			};
-		};
-	};
-
-	tpiu at 20030000 {
-		compatible = "arm,coresight-tpiu", "arm,primecell";
-		reg = <0 0x20030000 0 0x1000>;
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		power-domains = <&scpi_devpd 0>;
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
-			};
-		};
-	};
-
-	main-funnel at 20040000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
-		reg = <0 0x20040000 0 0x1000>;
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				main_funnel_out_port: endpoint {
-					remote-endpoint = <&etf_in_port>;
-				};
-			};
-
-			port at 1 {
-				reg = <0>;
-				main_funnel_in_port0: endpoint {
-					slave-mode;
-					remote-endpoint = <&cluster0_funnel_out_port>;
-				};
-			};
-
-			port at 2 {
-				reg = <1>;
-				main_funnel_in_port1: endpoint {
-					slave-mode;
-					remote-endpoint = <&cluster1_funnel_out_port>;
-				};
-			};
-
-		};
-	};
-
-	etr at 20070000 {
-		compatible = "arm,coresight-tmc", "arm,primecell";
-		reg = <0 0x20070000 0 0x1000>;
-		iommus = <&smmu_etr 0>;
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		power-domains = <&scpi_devpd 0>;
-		port {
-			etr_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
-			};
-		};
-	};
-
 	etm0: etm at 22040000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x22040000 0 0x1000>;
@@ -351,43 +253,6 @@
 		};
 	};
 
-	coresight-replicator {
-		/*
-		 * Non-configurable replicators don't show up on the
-		 * AMBA bus.  As such no need to add "arm,primecell".
-		 */
-		compatible = "arm,coresight-replicator";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* replicator output ports */
-			port at 0 {
-				reg = <0>;
-				replicator_out_port0: endpoint {
-					remote-endpoint = <&tpiu_in_port>;
-				};
-			};
-
-			port at 1 {
-				reg = <1>;
-				replicator_out_port1: endpoint {
-					remote-endpoint = <&etr_in_port>;
-				};
-			};
-
-			/* replicator input port */
-			port at 2 {
-				reg = <0>;
-				replicator_in_port0: endpoint {
-					slave-mode;
-					remote-endpoint = <&etf_out_port>;
-				};
-			};
-		};
-	};
-
 	sram: sram at 2e000000 {
 		compatible = "arm,juno-sram-ns", "mmio-sram";
 		reg = <0x0 0x2e000000 0x0 0x8000>;
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
new file mode 100644
index 0000000..24419ed
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
@@ -0,0 +1,150 @@
+	/*
+	 * Juno trace infrastructure.
+	 * Trace links and sinks and interconnections
+	 * from clusters.
+	 * Connections for Juno r0.
+	 */
+	etf at 20010000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port at 0 {
+				reg = <0>;
+				etf_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&main_funnel_out_port>;
+				};
+			};
+
+			/* output port */
+			port at 1 {
+				reg = <0>;
+				etf_out_port: endpoint {
+					remote-endpoint = <&replicator_in_port0>;
+				};
+			};
+		};
+	};
+
+	tpiu at 20030000 {
+		compatible = "arm,coresight-tpiu", "arm,primecell";
+		reg = <0 0x20030000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			tpiu_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port0>;
+			};
+		};
+	};
+
+	main-funnel at 20040000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20040000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				main_funnel_out_port: endpoint {
+					remote-endpoint = <&etf_in_port>;
+				};
+			};
+
+			/* input ports */
+			port at 1 {
+				reg = <0>;
+				main_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&cluster0_funnel_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				main_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&cluster1_funnel_out_port>;
+				};
+			};
+
+			port at 3 {
+				reg = <2>;
+				main_funnel_in_port2: endpoint {
+					slave-mode;
+					remote-endpoint = <&stm_out_port>;
+				};
+			};
+
+
+		};
+	};
+
+	etr at 20070000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20070000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			etr_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port1>;
+			};
+		};
+	};
+
+	coresight-replicator {
+		/*
+		 * Non-configurable replicators don't show up on the
+		 * AMBA bus.  As such no need to add "arm,primecell".
+		 */
+		compatible = "arm,coresight-replicator";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* replicator output ports */
+			port at 0 {
+				reg = <0>;
+				replicator_out_port0: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				replicator_out_port1: endpoint {
+					remote-endpoint = <&etr_in_port>;
+				};
+			};
+
+			/* replicator input port */
+			port at 2 {
+				reg = <0>;
+				replicator_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&etf_out_port>;
+				};
+			};
+		};
+	};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
new file mode 100644
index 0000000..caaf58e
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -0,0 +1,250 @@
+	/*
+	 * Juno trace infrastructure.
+	 * Trace links and sinks and interconnections
+	 * from clusters.
+	 * Connections for Juno r1 and r2.
+	 */
+	etf0 at 20010000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port at 0 {
+				reg = <0>;
+				etf0_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&main_funnel_out_port>;
+				};
+			};
+
+			/* output port */
+			port at 1 {
+				reg = <0>;
+				etf0_out_port: endpoint {
+					remote-endpoint = <&csys2_funnel_in_port0>;
+				};
+			};
+		};
+	};
+
+	etf1 at 20140000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20140000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port at 0 {
+				reg = <0>;
+				etf1_in_port: endpoint {
+					slave-mode;
+					remote-endpoint =
+						<&csys1_funnel_out_port>;
+				};
+			};
+
+			/* output port */
+			port at 1 {
+				reg = <0>;
+				etf1_out_port: endpoint {
+					remote-endpoint =
+						<&csys2_funnel_in_port1>;
+				};
+			};
+		};
+	};
+
+	csys1_funnel at 20130000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20130000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port at 0 {
+				reg = <0>;
+				csys1_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&etf1_in_port>;
+				};
+			};
+
+			/* output port */
+			port at 1 {
+				reg = <0>;
+				csys1_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint =
+						<&stm_out_port>;
+				};
+			};
+
+		};
+	};
+
+	csys2_funnel at 20150000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20150000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				csys2_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&replicator_in_port0>;
+				};
+			};
+
+			/* input ports */
+			port at 1 {
+				reg = <0>;
+				csys2_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&etf0_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				csys2_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&etf1_out_port>;
+				};
+			};
+
+		};
+	};
+
+	tpiu at 20030000 {
+		compatible = "arm,coresight-tpiu", "arm,primecell";
+		reg = <0 0x20030000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			tpiu_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port0>;
+			};
+		};
+	};
+
+	/*
+	 * This is labelled cssys0 funnel in the Juno r1/r2 TRM
+	 * Retain the name from r0 to maintain compatibility with common
+	 * juno-base.dtsi
+	 */
+	main-funnel at 20040000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20040000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				main_funnel_out_port: endpoint {
+					remote-endpoint = <&etf0_in_port>;
+				};
+			};
+
+			/* input ports */
+			port at 1 {
+				reg = <0>;
+				main_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&cluster0_funnel_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				main_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&cluster1_funnel_out_port>;
+				};
+			};
+		};
+	};
+
+	etr at 20070000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20070000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			etr_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port1>;
+			};
+		};
+	};
+
+	coresight-replicator {
+		/*
+		 * Non-configurable replicators don't show up on the
+		 * AMBA bus.  As such no need to add "arm,primecell".
+		 */
+		compatible = "arm,coresight-replicator";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* replicator output ports */
+			port at 0 {
+				reg = <0>;
+				replicator_out_port0: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				replicator_out_port1: endpoint {
+					remote-endpoint = <&etr_in_port>;
+				};
+			};
+
+			/* replicator input port */
+			port at 2 {
+				reg = <0>;
+				replicator_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&csys2_funnel_out_port>;
+				};
+			};
+		};
+	};
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index eec37fe..8813395 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -178,6 +178,7 @@
 	};
 
 	#include "juno-base.dtsi"
+	#include "juno-cs-r1r2.dtsi"
 };
 
 &memtimer {
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 28f40ec..fca3a17 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -178,6 +178,7 @@
 	};
 
 	#include "juno-base.dtsi"
+	#include "juno-cs-r1r2.dtsi"
 };
 
 &memtimer {
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index ac5ceb7..c90c37b 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -178,6 +178,7 @@
 	};
 
 	#include "juno-base.dtsi"
+	#include "juno-cs-r0.dtsi"
 };
 
 &etm0 {
-- 
2.7.4

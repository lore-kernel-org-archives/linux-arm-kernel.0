From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 15:20:08 +0000
Subject: [PATCH v3 1/3] arm64: dts: juno: refactor CoreSight support on Juno r0
In-Reply-To: <1484234410-7670-1-git-send-email-sudeep.holla@arm.com>
References: <1484234410-7670-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1484234410-7670-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the Coresight components are supported only on Juno r0
variant. In preparation to add support to Juno r1/r2 variants, this
patch refactors the existing coresight device nodes so that r1/r2
support can be added easily.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/arm/juno.dts       |  8 ++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 7d832247d0db..6d7f56573e89 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -83,7 +83,7 @@
 	 * The actual size is just 4K though 64K is reserved. Access to the
 	 * unmapped reserved region results in a DECERR response.
 	 */
-	etf at 20010000 {
+	etf0 at 20010000 {
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20010000 0 0x1000>;
 
@@ -97,7 +97,7 @@
 			/* input port */
 			port at 0 {
 				reg = <0>;
-				etf_in_port: endpoint {
+				etf0_in_port: endpoint {
 					slave-mode;
 					remote-endpoint = <&main_funnel_out_port>;
 				};
@@ -106,8 +106,7 @@
 			/* output port */
 			port at 1 {
 				reg = <0>;
-				etf_out_port: endpoint {
-					remote-endpoint = <&replicator_in_port0>;
+				etf0_out_port: endpoint {
 				};
 			};
 		};
@@ -128,7 +127,8 @@
 		};
 	};
 
-	main-funnel at 20040000 {
+	/* This is labelled cssys0 funnel in the Juno r1/r2 TRM */
+	main_funnel: main-funnel at 20040000 {
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x20040000 0 0x1000>;
 
@@ -139,13 +139,15 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			/* output port */
 			port at 0 {
 				reg = <0>;
 				main_funnel_out_port: endpoint {
-					remote-endpoint = <&etf_in_port>;
+					remote-endpoint = <&etf0_in_port>;
 				};
 			};
 
+			/* input ports */
 			port at 1 {
 				reg = <0>;
 				main_funnel_in_port0: endpoint {
@@ -161,7 +163,6 @@
 					remote-endpoint = <&cluster1_funnel_out_port>;
 				};
 			};
-
 		};
 	};
 
@@ -382,7 +383,6 @@
 				reg = <0>;
 				replicator_in_port0: endpoint {
 					slave-mode;
-					remote-endpoint = <&etf_out_port>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index ac5ceb73f45f..ba10d688beaa 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -203,3 +203,11 @@
 &etm5 {
 	cpu = <&A53_3>;
 };
+
+&etf0_out_port {
+	remote-endpoint = <&replicator_in_port0>;
+};
+
+&replicator_in_port0 {
+	remote-endpoint = <&etf0_out_port>;
+};
-- 
2.7.4

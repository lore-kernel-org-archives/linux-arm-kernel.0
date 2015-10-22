From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 22 Oct 2015 11:13:48 -0700
Subject: [PATCH 1/4] ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes
In-Reply-To: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445537631-29055-2-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a4c1762b53ea..1b64723bd8a0 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -11,6 +11,17 @@
 	compatible = "qcom,apq8064";
 	interrupt-parent = <&intc>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		smem_region: smem at 80000000 {
+			reg = <0x80000000 0x200000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -80,6 +91,19 @@
 		interrupts = <1 10 0x304>;
 	};
 
+	sfpb_mutex: hwmutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_region>;
+
+		hwlocks = <&sfpb_mutex 3>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -156,6 +180,11 @@
 			};
 		};
 
+		sfpb_wrapper_mutex: syscon at 1200000 {
+			compatible = "syscon";
+			reg = <0x01200000 0x8000>;
+		};
+
 		intc: interrupt-controller at 2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.4.2

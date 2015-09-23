From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:53:26 -0500
Subject: [Patch v2 07/10] arm: dts: Add APQ8084 SMEM nodes
In-Reply-To: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443027209-19444-8-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds all the required nodes to support SMEM on APQ8084

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0554fbd..76be0ba 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -10,6 +10,17 @@
 	compatible = "qcom,apq8084";
 	interrupt-parent = <&intc>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		smem_mem: smem_region at fa00000 {
+			reg = <0xfa00000 0x200000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -224,6 +235,26 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		tcsr_mutex_regs: syscon at fd484000 {
+			compatible = "syscon";
+			reg = <0xfd484000 0x2000>;
+		};
+
+		tcsr_mutex: hwlock {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_regs 0 0x80>;
+			#hwlock-cells = <1>;
+		};
+
+		smem {
+			compatible = "qcom,smem";
+			reg = <0xfc428000 0x4000>;
+			reg-names = "aux-mem1";
+
+			memory-region = <&smem_mem>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
 		tlmm: pinctrl at fd510000 {
 			compatible = "qcom,apq8084-pinctrl";
 			reg = <0xfd510000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

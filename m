From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 00:13:05 -0600
Subject: [Patch v4 2/2] arm: dts: Add APQ8084 SMEM nodes
In-Reply-To: <1449814385-11970-1-git-send-email-andy.gross@linaro.org>
References: <1449814385-11970-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1449814385-11970-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Gross <agross@codeaurora.org>

This patch adds all the required nodes to support SMEM on APQ8084

Signed-off-by: Andy Gross <agross@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index fcffeca..3d3b394 100644
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
@@ -89,6 +100,15 @@
 		clock-frequency = <19200000>;
 	};
 
+	smem {
+		compatible = "qcom,smem";
+
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		memory-region = <&smem_mem>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -225,6 +245,22 @@
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
+		rpm_msg_ram: memory at fc428000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0xfc428000 0x4000>;
+		};
+
 		tlmm: pinctrl at fd510000 {
 			compatible = "qcom,apq8084-pinctrl";
 			reg = <0xfd510000 0x4000>;
-- 
1.9.1

From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 00:13:04 -0600
Subject: [Patch v4 1/2] arm64: dts: qcom: Add MSM8916 SMEM nodes
In-Reply-To: <1449814385-11970-1-git-send-email-andy.gross@linaro.org>
References: <1449814385-11970-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1449814385-11970-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Gross <agross@codeaurora.org>

This patch adds the nodes necessary to support the SMEM driver on MSM8916
platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8d184ff..fe4541f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -37,6 +37,22 @@
 		reg = <0 0 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		reserve_aligned at 86000000 {
+			reg = <0x0 0x86000000 0x0 0x0300000>;
+			no-map;
+		};
+
+		smem_mem: smem_region at 86300000 {
+			reg = <0x0 0x86300000 0x0 0x0100000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -74,6 +90,15 @@
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	smem {
+		compatible = "qcom,smem";
+
+		memory-region = <&smem_mem>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +128,22 @@
 			reg = <0x1800000 0x80000>;
 		};
 
+		tcsr_mutex_regs: syscon at 1905000 {
+			compatible = "syscon";
+			reg = <0x1905000 0x20000>;
+		};
+
+		tcsr_mutex: hwlock {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_regs 0 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
+		rpm_msg_ram: memory at 60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x60000 0x8000>;
+		};
+
 		blsp1_uart1: serial at 78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x78af000 0x200>;
-- 
1.9.1

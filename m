From: agross@codeaurora.org (Andy Gross)
Date: Thu, 24 Sep 2015 14:18:52 -0500
Subject: [Patch v3 03/10] arm64: dts: qcom: Add MSM8916 SMEM nodes
In-Reply-To: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
References: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443122339-13917-4-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the nodes necessary to support the SMEM driver on MSM8916
platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |   36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5911de0..d321266 100644
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
@@ -102,6 +118,26 @@
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
+		smem {
+			compatible = "qcom,smem";
+			reg = <0x60000 0x8000>;
+			reg-names = "aux-mem1";
+
+			memory-region = <&smem_mem>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
 		blsp1_uart2: serial at 78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x78b0000 0x200>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

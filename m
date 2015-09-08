From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:35:23 -0500
Subject: [PATCH 04/11] arm64: dts: qcom: Add RPM/SMD support on MSM8916
In-Reply-To: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
References: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
Message-ID: <1441748131-26490-5-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the SMD and RPM devices found on MSM8916 platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d321266..27d3e90 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -138,6 +138,11 @@
 			hwlocks = <&tcsr_mutex 3>;
 		};
 
+		apcs: syscon at b011000 {
+			compatible = "syscon";
+			reg = <0x0b011000 0x1000>;
+		};
+
 		blsp1_uart2: serial at 78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x78b0000 0x200>;
@@ -427,6 +432,21 @@
 			#interrupt-cells = <4>;
 		};
 	};
+
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8916";
+				qcom,smd-channels = "rpm_requests";
+			};
+		};
+	};
 };
 
 #include "msm8916-pins.dtsi"
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

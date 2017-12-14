From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Thu, 14 Dec 2017 17:34:02 +0000
Subject: [RESEND PATCH v2 15/15] arm64: dts: msm8996: db820c: Add sound card
 support
In-Reply-To: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171214173402.19074-16-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds hdmi sound card support to db820c via qdsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  5 +++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 33 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 9769053957af..b955769b100d 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -190,6 +190,11 @@
 		};
 	};
 
+	snd {
+		compatible = "qcom,apq8096-sndcard";
+		qcom,model = "DB820c";
+		iommus = <&lpass_q6_smmu 1>;
+	};
 
 	gpio_keys {
 		compatible = "gpio-keys";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index a144cec7bb71..25c43fb8ab49 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1262,6 +1262,7 @@
 
 				phys = <&hdmi_phy>;
 				phy-names = "hdmi_phy";
+				#sound-dai-cells = <0>;
 
 				ports {
 					#address-cells = <1>;
@@ -1297,6 +1298,33 @@
 					      "ref_clk";
 			};
 		};
+
+	        lpass_q6_smmu: arm,smmu-lpass_q6 at 1600000 {
+			compatible = "qcom,msm8996-smmu-v2";
+	                reg = <0x1600000 0x20000>;
+	                #iommu-cells = <1>;
+                        power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+		        interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
+			clock-names = "iface", "bus";
+                        status = "okay";
+		};
 	};
 
 	adsp-pil {
@@ -1325,6 +1353,11 @@
 			qcom,ipc = <&apcs 16 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+
+			apr {
+				compatible = "qcom,apr-msm8996";
+				qcom,smd-channels = "apr_audio_svc";
+			};
 		};
 	};
 
-- 
2.15.0

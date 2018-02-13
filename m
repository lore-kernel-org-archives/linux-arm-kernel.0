From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Tue, 13 Feb 2018 16:58:37 +0000
Subject: [PATCH v3 25/25] arm64: dts: msm8996: db820c: Add sound card support
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180213165837.1620-26-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds hdmi sound card support to db820c via qdsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 44 +++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 62 ++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 9769053957af..6f6f21501ee9 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,7 +18,8 @@
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
-
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 / {
 	aliases {
 		serial0 = &blsp2_uart1;
@@ -186,6 +187,7 @@
 
 				core-vdda-supply = <&pm8994_l12>;
 				core-vcc-supply = <&pm8994_s4>;
+				#sound-dai-cells = <1>;
 			};
 		};
 	};
@@ -360,4 +362,44 @@
 			};
 		};
 	};
+	adsp-pil {
+		power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+		smd-edge {
+			apr {
+				iommus = <&lpass_q6_smmu 1>;
+				audio {
+					compatible = "qcom,apq8096-sndcard";
+					qcom,model = "DB820c";
+					qcom,audio-routing =
+						"RX_BIAS", "MCLK";
+
+					fe at 1 {
+						is-fe;
+						link-name = "MultiMedia1 Playback";
+						cpu {
+							sound-dai = <&q6asm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+						};
+						platform {
+							sound-dai = <&q6asm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+						};
+					};
+
+					be at 1 {
+						link-name = "HDMI Playback";
+						cpu {
+							sound-dai = <&q6afe AFE_PORT_HDMI_RX>;
+						};
+
+						platform {
+							sound-dai = <&q6adm>;
+						};
+
+						codec {
+							sound-dai = <&hdmi 0>;
+						};
+					};
+				};
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c93bbae645bd..75cb055b0c55 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8996.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -1287,6 +1288,34 @@
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
+
 	};
 
 	adsp-pil {
@@ -1315,6 +1344,39 @@
 			qcom,ipc = <&apcs 16 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+			apr {
+				compatible = "qcom,apr-v2";
+				qcom,smd-channels = "apr_audio_svc";
+				qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
+
+				q6core {
+					qcom,apr-svc-name = "CORE";
+					qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
+					compatible = "qcom,q6core";
+				};
+
+				q6afe: q6afe {
+					compatible = "qcom,q6afe";
+					qcom,apr-svc-name = "AFE";
+					qcom,apr-svc-id = <APR_SVC_AFE>;
+					#sound-dai-cells = <1>;
+				};
+
+				q6asm: q6asm {
+					compatible = "qcom,q6asm";
+					qcom,apr-svc-name = "ASM";
+					qcom,apr-svc-id = <APR_SVC_ASM>;
+					#sound-dai-cells = <1>;
+				};
+
+				q6adm: q6adm {
+					compatible = "qcom,q6adm";
+					qcom,apr-svc-name = "ADM";
+					qcom,apr-svc-id = <APR_SVC_ADM>;
+					#sound-dai-cells = <0>;
+				};
+
+			};
 		};
 	};
 
-- 
2.15.1

From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Sat, 10 Mar 2018 02:24:55 +0000
Subject: [PATCH v4 23/24] arm64: dts: db820c: add sound card dt entry
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180310022456.26739-24-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds a sound card entry for basic hdmi playback using adsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 34 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 75 +++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 0be734be95f9..d69ffd042835 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,6 +18,8 @@
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 / {
 	aliases {
@@ -222,6 +224,7 @@
 
 				core-vdda-supply = <&pm8994_l12>;
 				core-vcc-supply = <&pm8994_s4>;
+				#sound-dai-cells = <1>;
 			};
 		};
 	};
@@ -397,3 +400,34 @@
 		};
 	};
 };
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+	qcom,audio-routing =
+		"RX_BIAS", "MCLK";
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+		platform {
+			sound-dai = <&q6asmdai>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afedai HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6e04827879c0..8fc9354e84c5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -1560,6 +1561,37 @@
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
+	};
+
+	sound: sound {
+
 	};
 
 	adsp-pil {
@@ -1583,11 +1615,52 @@
 
 		smd-edge {
 			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
-
 			label = "lpass";
 			qcom,ipc = <&apcs 16 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+
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
+					q6afedai: dais {
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6asm: q6asm {
+					compatible = "qcom,q6asm";
+					qcom,apr-svc-name = "ASM";
+					qcom,apr-svc-id = <APR_SVC_ASM>;
+					q6asmdai: dais {
+						#sound-dai-cells = <1>;
+						power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+						iommus = <&lpass_q6_smmu 1>;
+					};
+				};
+
+				q6adm: q6adm {
+					compatible = "qcom,q6adm";
+					qcom,apr-svc-name = "ADM";
+					qcom,apr-svc-id = <APR_SVC_ADM>;
+					q6routing: routing {
+						#sound-dai-cells = <0>;
+					};
+				};
+
+			};
 		};
 	};
 
-- 
2.15.1

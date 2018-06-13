From: dianders@chromium.org (Douglas Anderson)
Date: Wed, 13 Jun 2018 09:53:52 -0700
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845: Enable debug UART and I2C10
 on sdm845-mtp
In-Reply-To: <20180613165352.139060-1-dianders@chromium.org>
References: <20180613165352.139060-1-dianders@chromium.org>
Message-ID: <20180613165352.139060-2-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug UART is very useful to have.  I2C10 is enabled as an example
of a I2C port we can talk on for now.  Eventually we'll want to put
peripherals under it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v2:
- Got rid of all sleep pinctrl states for now
- Add Bjorn's tags.

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 979ab49913f1..6d651f314193 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -12,4 +12,49 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp";
+
+	aliases {
+		serial0 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_i2c10_default {
+	pinconf {
+		pins = "gpio55", "gpio56";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&qup_uart9_default {
+	pinconf-tx {
+		pins = "gpio4";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pinconf-rx {
+		pins = "gpio5";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
-- 
2.18.0.rc1.244.gcf134e6275-goog

From: dianders@chromium.org (Douglas Anderson)
Date: Thu,  7 Jun 2018 13:46:08 -0700
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: Enable debug UART and I2C10 on
 sdm845-mtp
In-Reply-To: <20180607204608.27688-1-dianders@chromium.org>
References: <20180607204608.27688-1-dianders@chromium.org>
Message-ID: <20180607204608.27688-2-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug UART is very useful to have.  I2C10 is enabled as an example
of a I2C port we can talk on for now.  Eventually we'll want to put
peripherals under it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 979ab49913f1..e1eda143a725 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -12,4 +12,56 @@
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
+};
+
+&qup_uart9_sleep {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		bias-pull-down;
+	};
 };
-- 
2.17.1.1185.g55be947832-goog

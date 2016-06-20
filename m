From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:47 +0100
Subject: [PATCH 8/8] arm64: dts: db820c: add support to external sd card.
In-Reply-To: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466452907-23290-9-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to external sd card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi | 39 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi      | 10 ++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
new file mode 100644
index 0000000..24552f1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+&msmgpio {
+	sdc2_cd_on: sdc2_cd_on {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <16>;	/* 16 MA */
+		};
+	};
+
+	sdc2_cd_off: sdc2_cd_off {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 08b063d..3fbd23e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -12,6 +12,7 @@
  */
 
 #include "msm8996.dtsi"
+#include "apq8096-db820c-pins.dtsi"
 
 / {
 	aliases {
@@ -74,5 +75,14 @@
 			label = "HS-SPI1";
 			status = "okay";
 		};
+
+		sdhci at 74A4900 {
+		/* External SD card */
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+			cd-gpios = <&msmgpio 38 0x1>;
+			status = "okay";
+		};
 	};
 };
-- 
2.7.4

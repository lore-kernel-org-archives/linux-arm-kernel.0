From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jan 2014 13:30:32 -0800
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Krait CPU/L1 error reporting device is made up a per-CPU
interrupt. While we're here, document the next-level-cache
property that's used by the Krait EDAC driver.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 91304353eea4..c332b5168456 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,16 @@ nodes to be present and contain the properties described below.
 			  property identifying a 64-bit zero-initialised
 			  memory location.
 
+	- interrupts
+		Usage: required for cpus with compatible string "qcom,krait".
+		Value type: <prop-encoded-array>
+		Definition: L1/CPU error interrupt
+
+	- next-level-cache
+		Usage: optional
+		Value type: <phandle>
+		Definition: phandle pointing to the next level cache
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
@@ -382,3 +392,45 @@ cpus {
 		cpu-release-addr = <0 0x20000000>;
 	};
 };
+
+
+Example 5 (Krait 32-bit system):
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <1 9 0xf04>;
+
+	cpu at 0 {
+		device_type = "cpu";
+		compatible = "qcom,krait";
+		reg = <0>;
+		next-level-cache = <&L2>;
+	};
+
+	cpu at 1 {
+		device_type = "cpu";
+		compatible = "qcom,krait";
+		reg = <1>;
+		next-level-cache = <&L2>;
+	};
+
+	cpu at 2 {
+		device_type = "cpu";
+		compatible = "qcom,krait";
+		reg = <2>;
+		next-level-cache = <&L2>;
+	};
+
+	cpu at 3 {
+		device_type = "cpu";
+		compatible = "qcom,krait";
+		reg = <3>;
+		next-level-cache = <&L2>;
+	};
+
+	L2: l2-cache {
+		compatible = "cache";
+		interrupts = <0 2 0x4>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

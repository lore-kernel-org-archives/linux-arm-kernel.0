From: agross@codeaurora.org (Andy Gross)
Date: Mon, 14 Apr 2014 22:10:36 -0500
Subject: [PATCH 2/3] dt: Document Qualcomm IPQ8064 pinctrl binding
In-Reply-To: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
References: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
Message-ID: <1397531437-9104-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a new binding for the Qualcomm TLMMv2 based pin controller inside the
IPQ8064.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   95 ++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
new file mode 100644
index 0000000..e0d35a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
@@ -0,0 +1,95 @@
+Qualcomm IPQ8064 TLMM block
+
+Required properties:
+- compatible: "qcom,ipq8064-pinctrl"
+- reg: Should be the base address and length of the TLMM block.
+- interrupts: Should be the parent IRQ of the TLMM block.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be two.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells : Should be two.
+                The first cell is the gpio pin number and the
+                second cell is used for optional parameters.
+
+Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
+a general description of GPIO and interrupt bindings.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+Qualcomm's pin configuration nodes act as a container for an abitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, drive strength, etc.
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Each subnode only affects those parameters that are explicitly listed. In
+other words, a subnode that lists a mux function but no pin configuration
+parameters implies no information about any pin configuration parameters.
+Similarly, a pin subnode that describes a pullup parameter implies no
+information about e.g. the mux function.
+
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pin configuration subnode:
+
+ pins, function, bias-disable, bias-pull-down, bias-pull,up, drive-strength,
+ output-low, output-high.
+
+Non-empty subnodes must specify the 'pins' property.
+
+Valid values for qcom,pins are:
+  gpio0-gpio68
+   Supports mux, bias, and drive-strength
+
+  sdc3_clk, sdc3_cmd, sdc3_data
+   Supports bias and drive-strength
+
+
+Valid values for function are:
+  mdio, mi2s, pdm, ssbi, spmi, audio_pcm, gsbi1, gsbi2, gsbi4, gsbi5,
+  gsbi5_spi_cs1, gsbi5_spi_cs2, gsbi5_spi_cs3, gsbi6, gsbi7, nss_spi, sdc1,
+  spdif, nand, tsif1, tsif2, usb_fs_n, usb_fs, usb2_hsic, rgmii2, sata,
+  pcie1_rst, pcie1_prsnt, pcie1_pwren_n, pcie1_pwren, pcie1_pwrflt,
+  pcie1_clk_req, pcie2_rst, pcie2_prsnt, pcie2_pwren_n, pcie2_pwren,
+  pcie2_pwrflt, pcie2_clk_req, pcie3_rst, pcie3_prsnt, pcie3_pwren_n,
+  pcie3_pwren, pcie3_pwrflt, pcie3_clk_req, ps_hold
+
+Example:
+
+	pinmux: pinctrl at 800000 {
+		compatible = "qcom,ipq8064-pinctrl";
+		reg = <0x800000 0x4000>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <0 32 0x4>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gsbi5_uart_default>;
+
+		gsbi5_uart_default: gsbi5_uart_default {
+			mux {
+				pins = "gpio18", "gpio19";
+				function = "gsbi5";
+			};
+
+			tx {
+				pins = "gpio18";
+				drive-strength = <4>;
+				bias-disable;
+			};
+
+			rx {
+				pins = "gpio19";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+		};
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

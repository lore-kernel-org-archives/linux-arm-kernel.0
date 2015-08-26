From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Aug 2015 14:08:00 +0100
Subject: [PATCH 1/4] remoteproc: dt: Provide bindings for ST's Remote
 Processor Controller driver
In-Reply-To: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
References: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1440594483-29601-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/remoteproc/st-rproc.txt    | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
new file mode 100644
index 0000000..6a933c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
@@ -0,0 +1,38 @@
+STMicroelectronics Remote Processor
+-----------------------------------
+
+This binding provides support for adjunct processors found on ST SoCs.
+
+The remote processors can be controlled from the bootloader or the primary OS.
+If the bootloader starts a remote processor processor the primary OS must detect
+its state and act accordingly.
+
+The node name is significant, as it defines the name of the CPU and the name
+of the firmware to load: "rproc-<name>-fw".
+
+Required properties:
+- compatible		Should be one of:
+				"st,st231-rproc"
+				"st,st40-rproc"
+- reg			Size and length of reserved co-processor memory
+- resets		Reset lines (See: ../reset/reset.txt)
+- reset-names		Must be "sw_reset" and "pwr_reset"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Must be "rproc_clk"
+- clock-frequency	Clock frequency to set co-processor at if the bootloader
+			hasn't already done so
+- st,syscfg-boot	The register that holds the boot vector for the co-processor
+
+Example:
+
+	st231-audio at bae00000 {
+		compatible	= "st,st231-rproc";
+		reg		= <0xbae00000 0x01000000>;
+		reg-names	= "rproc_mem";
+		resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
+		reset-names	= "sw_reset";
+		clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+		clock-names	= "rproc_clk";
+		clock-frequency	= <600000000>;
+		st,syscfg-boot	= <&syscfg_core 0x228>;
+	};
-- 
1.9.1

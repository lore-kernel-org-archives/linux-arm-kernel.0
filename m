From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Feb 2015 17:33:42 +0000
Subject: [PATCH v3 4/4] clk: dt: Introduce always-on clock domain documentation
In-Reply-To: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1424799222-9301-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/clock/clk-always-on.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-always-on.txt

diff --git a/Documentation/devicetree/bindings/clock/clk-always-on.txt b/Documentation/devicetree/bindings/clock/clk-always-on.txt
new file mode 100644
index 0000000..d61eaca
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clk-always-on.txt
@@ -0,0 +1,35 @@
+Always-on Clock Domain
+
+Some hardware contains bunches of clocks which must never be turned
+off.  If drivers a) fail to obtain a reference to any of these or b)
+give up a previously obtained reference during suspend, the common clk
+framework will attempt to disable them and the hardware can fail
+irrecoverably.  Usually the only way to recover from these failures is
+to restart.
+
+To avoid either of these two scenarios from catastrophically disabling
+an otherwise perfectly healthy running system, an always-on clock
+domain has been provided.  In this implementation clocks are consumed
+and references are taken, thus preventing them from being shut down by
+the framework.
+
+This binding is not to be abused.  It is only to be used to protect
+platforms from being crippled by gated clocks, not as a convenience
+function to avoid using clk_disable_unused.
+
+We use the generic clock bindings found in:
+  Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : Must be "clk-always-on"
+
+Example:
+
+icn {
+	compatible = "clk-always-on";
+	clocks = <&clk_s_c0_flexgen CLK_ICN_SBC>,
+		 <&clk_s_c0_flexgen CLK_ICN_LMI>,
+		 <&clk_s_c0_flexgen CLK_ICN_CPU>,
+		 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+		 <&clk_s_a0_flexgen CLK_IC_LMI0>,
+};
-- 
1.9.1

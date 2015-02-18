From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 16:15:01 +0000
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain documentation
In-Reply-To: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1424276101-30137-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/clock/clk-domain.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-domain.txt

diff --git a/Documentation/devicetree/bindings/clock/clk-domain.txt b/Documentation/devicetree/bindings/clock/clk-domain.txt
new file mode 100644
index 0000000..b86772f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clk-domain.txt
@@ -0,0 +1,35 @@
+Always-on Clock Domain
+
+Some hardware is contains bunches of clocks which must never be
+turned off.  If drivers a) fail to obtain a reference to any of
+these or b) give up a previously obtained reference during suspend,
+the common clk framework will attempt to disable them and the
+hardware can fail irrecoverably.  Usually, the only way to recover
+from these failures is to restart.
+
+To avoid either of these two scenarios from catastrophically
+disabling an otherwise perfectly healthy running system, we have
+implemented a clock domain where clocks are consumed and references
+are taken, thus preventing them from being shut down by the
+framework.
+
+We use the generic clock bindings found in:
+  Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : Must be "always-on-clk-domain"
+
+Example:
+
+clk-domain {
+	compatible = "always-on-clk-domain";
+	clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+		 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+		 <&clk_s_c0_flexgen CLK_MMC_1>,
+		 <&clk_s_c0_flexgen CLK_ICN_SBC>,
+		 <&clk_s_c0_flexgen CLK_ICN_LMI>,
+		 <&clk_s_c0_flexgen CLK_ICN_CPU>,
+		 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+		 <&clk_s_a0_flexgen CLK_IC_LMI0>,
+		 <&clk_m_a9>;
+};
-- 
1.9.1

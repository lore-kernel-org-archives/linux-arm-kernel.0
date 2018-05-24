From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu, 24 May 2018 10:50:15 +0300
Subject: [PATCH v12 5/8] dt-bindings: clk: qcom: Add bindings for CPU clock
 for msm8996
In-Reply-To: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
References: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1527148218-16540-6-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each of the CPU clusters (Power and Perf) on msm8996 are
clocked via 2 PLLs, a primary and alternate. There are also
2 Mux'es, a primary and secondary all connected together
as shown below

                             +-------+
              XO             |       |
          +------------------>0      |
                             |       |
                   PLL/2     | SMUX  +----+
                     +------->1      |    |
                     |       |       |    |
                     |       +-------+    |    +-------+
                     |                    +---->0      |
                     |                         |       |
+---------------+    |             +----------->1      | CPU clk
|Primary PLL    +----+ PLL_EARLY   |           |       +------>
|               +------+-----------+    +------>2 PMUX |
+---------------+      |                |      |       |
                       |   +------+     |   +-->3      |
                       +--^+  ACD +-----+   |  +-------+
+---------------+          +------+         |
|Alt PLL        |                           |
|               +---------------------------+
+---------------+         PLL_EARLY

The primary PLL is what drives the CPU clk, except for times
when we are reprogramming the PLL itself (for rate changes) when
we temporarily switch to an alternate PLL. A subsequent patch adds
support to switch between primary and alternate PLL during rate
changes.

The primary PLL operates on a single VCO range, between 600MHz
and 3GHz. However the CPUs do support OPPs with frequencies
between 300MHz and 600MHz. In order to support running the CPUs
at those frequencies we end up having to lock the PLL at twice
the rate and drive the CPU clk via the PLL/2 output and SMUX.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
new file mode 100644
index 0000000..8458783
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
@@ -0,0 +1,17 @@
+Qualcomm CPUSS clock controller for Kryo CPUs
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,msm8996-apcc"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+
+Example:
+	kryocc: clock-controller at 6400000 {
+		compatible = "qcom,msm8996-apcc";
+		reg = <0x6400000 0x90000>;
+		#clock-cells = <1>;
+	};
-- 
1.9.1

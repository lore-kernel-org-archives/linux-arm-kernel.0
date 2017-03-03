From: leo.yan@linaro.org (Leo Yan)
Date: Fri,  3 Mar 2017 14:00:05 +0800
Subject: [PATCH v3 1/5] coresight: bindings for debug module
In-Reply-To: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
References: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1488520809-31670-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ARMv8 architecture reference manual (ARM DDI 0487A.k)
Chapter 'Part H: External debug', the CPU can integrate debug module
and it can support self-hosted debug and external debug. Especially
for supporting self-hosted debug, this means the program can access
the debug module from mmio region; and usually the mmio region is
integrated with coresight.

So add document for binding debug component, includes binding to APB
clock; and also need specify the CPU node which the debug module is
dedicated to specific CPU.

Suggested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/arm/coresight-debug.txt    | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-debug.txt

diff --git a/Documentation/devicetree/bindings/arm/coresight-debug.txt b/Documentation/devicetree/bindings/arm/coresight-debug.txt
new file mode 100644
index 0000000..92e5003
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-debug.txt
@@ -0,0 +1,40 @@
+* CoreSight Debug Component:
+
+CoreSight debug component are compliant with the ARMv8 architecture reference
+manual (ARM DDI 0487A.k) Chapter 'Part H: External debug'. The external debug
+module is mainly used for two modes: self-hosted debug and external debug, and
+it can be accessed from mmio region from Coresight and eventually the debug
+module connects with CPU for debugging. And the debug module provides
+sample-based profiling extension, which can be used to sample CPU program
+counter, secure state and exception level, etc; usually every CPU has one
+dedicated debug module to be connected.
+
+Required properties:
+
+- compatible : should be
+	     * "arm,coresight-debug"; supplemented with "arm,primecell" since
+	       this driver is using the AMBA bus interface.
+
+- reg : physical base address and length of the register set.
+
+- clocks : the clock associated to this component.
+
+- clock-names : the name of the clock referenced by the code. Since we are
+                using the AMBA framework, the name of the clock providing
+		the interconnect should be "apb_pclk" and the clock is
+		mandatory. The interface between the debug logic and the
+		processor core is clocked by the internal CPU clock, so it
+		is enabled with CPU clock by default.
+
+- cpu : the cpu phandle the debug module is affined to. When omitted
+	the module is considered to belong to CPU0.
+
+Example:
+
+	debug at f6590000 {
+		compatible = "arm,coresight-debug","arm,primecell";
+		reg = <0 0xf6590000 0 0x1000>;
+		clocks = <&sys_ctrl HI6220_DAPB_CLK>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu0>;
+	};
-- 
2.7.4

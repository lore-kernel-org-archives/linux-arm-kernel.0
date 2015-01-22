From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 09:48:48 +0000
Subject: [PATCH v2 RESEND 3/8] irqchip: irq-st: Add documentation for STi
 based syscfg IRQs
In-Reply-To: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421920133-7914-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../interrupt-controller/st,sti-irq-syscfg.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
new file mode 100644
index 0000000..ced6014
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
@@ -0,0 +1,35 @@
+STMicroelectronics STi System Configuration Controlled IRQs
+-----------------------------------------------------------
+
+On STi based systems; External, CTI (Core Sight), PMU (Performance Management),
+and PL310 L2 Cache IRQs are controlled using System Configuration registers.
+This driver is used to unmask them prior to use.
+
+Required properties:
+- compatible	: Should be set to one of:
+			"st,stih415-irq-syscfg"
+			"st,stih416-irq-syscfg"
+			"st,stih407-irq-syscfg"
+			"st,stid127-irq-syscfg"
+- st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
+- st,irq-device	: Array of IRQs to enable - should be 2 in length
+- st,fiq-device	: Array of FIQs to enable - should be 2 in length
+
+Optional properties:
+- st,invert-ext	: External IRQs can be inverted at will.  This property inverts
+		  these IRQs using bitwise logic.  A number of defines have been
+		  provided for convenience:
+			ST_IRQ_SYSCFG_EXT_1_INV
+			ST_IRQ_SYSCFG_EXT_2_INV
+			ST_IRQ_SYSCFG_EXT_3_INV
+Example:
+
+irq-syscfg {
+	compatible    = "st,stih416-irq-syscfg";
+	st,syscfg     = <&syscfg_cpu>;
+	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+			<ST_IRQ_SYSCFG_PMU_1>;
+	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+			<ST_IRQ_SYSCFG_DISABLED>;
+	st,invert-ext = <(ST_IRQ_SYSCFG_EXT_1_INV | ST_IRQ_SYSCFG_EXT_3_INV)>;
+};
-- 
1.9.1

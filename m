From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue,  9 Sep 2014 15:26:58 +0530
Subject: [PATCH 4/5] dt-bindings: Add binding info for Xgene QMTM UIO driver
In-Reply-To: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
References: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1410256619-3213-5-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding documentation for
Xgene QMTM UIO driver.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 .../devicetree/bindings/uio/uio_xgene_qmtm.txt     |   45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt

diff --git a/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
new file mode 100644
index 0000000..b71831b
--- /dev/null
+++ b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
@@ -0,0 +1,45 @@
+APM X-Gene QMTM UIO nodes
+
+QMTM UIO nodes are defined for user space access to on-chip QMTM device
+on APM X-Gene SOC using UIO framework.
+
+Required properties:
+- compatible: Should be "apm,xgene-qmtm-uio"
+- reg: Address and length of the register set for the device. It contains the
+  information of registers in the same order as described by reg-names.
+- reg-names: Should contain the register set names
+  - "csr": QMTM control and status register address space.
+  - "fabric": QMTM memory mapped access to queue states.
+  - "qpool": Memory location for creating QMTM queues. This could be some
+    SRAM or reserved portion of RAM. It is expected that size and location
+    of qpool memory will be configurable via bootloader.
+- clocks: Reference to the clock entry.
+- num_queues: Number of queues under this QMTM device.
+- devid: QMTM identification number for the system having multiple QMTM devices
+
+Optional properties:
+- status: Should be "ok" or "disabled" for enabled/disabled. Default is "ok".
+
+Example:
+	qmtm1clk: qmtmclk at 1f20c000 {
+		compatible = "apm,xgene-device-clock";
+		clock-output-names = "qmtm1clk";
+		status = "ok";
+	};
+
+	qmtm1_uio: qmtm_uio at 1f200000 {
+		compatible = "apm,xgene-qmtm-uio";
+		status = "disabled";
+		reg =  <0x0 0x1f200000 0x0 0x10000
+			0x0 0x1b000000 0x0 0x400000
+			0x0 0x00000000 0x0 0x0>;/* filled by bootloader */
+		reg-names = "csr", "fabric", "qpool";
+		clocks = <&qmtm1clk 0>;
+		num_queues = <0x400>;
+		devid = <1>;
+	};
+
+	/* Board-specific peripheral configurations */
+	&qmtm1_uio {
+		status = "ok";
+	};
-- 
1.7.9.5

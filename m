From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Mon, 17 Nov 2014 16:06:11 +0530
Subject: [PATCH v5 5/6] Documentation: dt-bindings: Add binding info for
 X-Gene QMTM UIO driver
In-Reply-To: <1416220572-13381-1-git-send-email-ankit.jindal@linaro.org>
References: <1416220572-13381-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1416220572-13381-6-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding documentation for
X-Gene QMTM UIO driver.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 .../devicetree/bindings/uio/uio_xgene_qmtm.txt     |   50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt

diff --git a/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
new file mode 100644
index 0000000..7afe78c
--- /dev/null
+++ b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
@@ -0,0 +1,50 @@
+APM X-Gene QMTM nodes
+
+The Applied Micro X-Gene SOC has on-chip QMTM (Queue manager
+and Traffic manager). It is a device for managing hardware queues.
+It also implements QoS among hardware queues hence term "traffic"
+manager is present in its name.
+
+Required properties:
+- compatible: Should be "apm,xgene-qmtm"
+- reg: Address and length of the register set for the device. It contains the
+  information of registers in the same order as described by reg-names.
+- reg-names: Should contain the register set names
+  - "csr": QMTM control and status register address space.
+  - "fabric": QMTM memory mapped access to queue states.
+- qpool-memory: Points to the phandle of the node defining memory location for
+	 creating QMTM queues. This must point to the reserved-memory node
+	 (as-per reserved memory bindings). It is expected that size and
+	 location of qpool memory will be configurable via bootloader.
+- clocks: Reference to the clock entry.
+- num-queues: Number of queues under this QMTM device.
+- devid: QMTM identification number for the system having multiple QMTM devices.
+	 This is used to form a unique id (a tuple of queue number and
+	 device id) for the queues belonging to this device.
+
+Example:
+	qmtm1_uio_qpool: qmtm1_uio_qpool {
+		reg = <0x0 0x0 0x0 0x0>;
+	};
+
+	qmtm1clk: qmtmclk at 1f20c000 {
+		compatible = "apm,xgene-device-clock";
+		clock-output-names = "qmtm1clk";
+	};
+
+	qmtm1_uio: qmtm_uio at 1f200000 {
+		compatible = "apm,xgene-qmtm";
+		status = "disabled";
+		reg = <0x0 0x1f200000 0x0 0x10000>,
+		      <0x0 0x1b000000 0x0 0x400000>;
+		reg-names = "csr", "fabric";
+		qpool-memory = <&qmtm1_uio_qpool>;
+		clocks = <&qmtm1clk 0>;
+		num-queues = <0x400>;
+		devid = <1>;
+	};
+
+	/* Board-specific peripheral configurations */
+	&qmtm1_uio {
+		status = "okay";
+	};
-- 
1.7.9.5

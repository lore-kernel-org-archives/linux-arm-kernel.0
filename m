From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 22:08:55 -0700
Subject: [PATCH v4 3/5] dt-binding: soc: qcom: Add binding for rmtfs memory
In-Reply-To: <20171011050857.7588-1-bjorn.andersson@linaro.org>
References: <20171011050857.7588-1-bjorn.andersson@linaro.org>
Message-ID: <20171011050857.7588-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding for describing shared memory used to exchange file
system blocks between the RMTFS client and service. A client for this is
generally found in the modem firmware and is used for accessing
persistent storage for things such as radio calibration.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None 

Changes since v2:
- Renamed compatible to "rmtfs-mem" in attempt to clarify that this is not a
  file system, but some chunk of memory.

Changed since v1:
- Memory described in a single reserved-memory node, rather than by reference
  from a "dummy" node
- qcom,vmdid added

 .../bindings/reserved-memory/qcom,rmtfs-mem.txt    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
new file mode 100644
index 000000000000..8562ba1dce69
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
@@ -0,0 +1,51 @@
+Qualcomm Remote File System Memory binding
+
+This binding describes the Qualcomm remote filesystem memory, which serves the
+purpose of describing the shared memory region used for remote processors to
+access block device data using the Remote Filesystem protocol.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be:
+		    "qcom,rmtfs-mem"
+
+- reg:
+	Usage: required for static allocation
+	Value type: <prop-encoded-array>
+	Definition: must specify base address and size of the memory region,
+		    as described in reserved-memory.txt
+
+- size:
+	Usage: required for dynamic allocation
+	Value type: <prop-encoded-array>
+	Definition: must specify a size of the memory region, as described in
+		    reserved-memory.txt
+
+- qcom,client-id:
+	Usage: required
+	Value type: <u32>
+	Definition: identifier of the client to use this region for buffers.
+
+- qcom,vmid:
+	Usage: optional
+	Value type: <u32>
+	Definition: vmid of the remote processor, to set up memory protection.
+
+= EXAMPLE
+The following example shows the remote filesystem memory setup for APQ8016,
+with the rmtfs region for the Hexagon DSP (id #1) located at 0x86700000.
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rmtfs at 86700000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x86700000 0x0 0xe0000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
-- 
2.12.0

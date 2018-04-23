From: rishabhb@codeaurora.org (Rishabh Bhatnagar)
Date: Mon, 23 Apr 2018 16:09:31 -0700
Subject: [PATCH v5 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
Message-ID: <1524524972-12014-2-git-send-email-rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for last level cache controller device tree bindings,
client bindings usage examples.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
new file mode 100644
index 0000000..c30d433
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -0,0 +1,60 @@
+== Introduction==
+
+LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
+that can be shared by multiple clients. Clients here are different cores in the
+SOC, the idea is to minimize the local caches at the clients and migrate to
+common pool of memory. Cache memory is divided into partitions called slices
+which are assigned to clients. Clients can query the slice details, activate
+and deactivate them.
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-llcc"
+
+- reg:
+	Usage: required
+	Value Type: <prop-encoded-array>
+	Definition: Start address and the range of the LLCC registers.
+
+- #cache-cells:
+	Usage: required
+	Value Type: <u32>
+	Definition: Number of cache cells, must be 1
+
+- max-slices:
+	usage: required
+	Value Type: <u32>
+	Definition: Number of cache slices supported by hardware
+
+Example:
+
+	llcc: qcom,llcc at 1100000 {
+		compatible = "qcom,sdm845-llcc";
+		reg = <0x1100000 0x250000>;
+		#cache-cells = <1>;
+		max-slices = <32>;
+	};
+
+== Client ==
+
+Properties:
+- cache-slice-names:
+Usage: required
+	Value type: <stringlist>
+	Definition: A set of names that identify the usecase names of a
+		client that uses cache slice. These strings are
+		used to look up the cache slice entries by name.
+
+- cache-slices:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The tuple has phandle to llcc device as the first
+			argument and the second argument is the usecase
+			id of the client.
+For Example:
+	venus {
+		cache-slice-names = "vidsc0", "vidsc1";
+		cache-slices = <&llcc VIDSC0_ID>, <&llcc VIDSC1_ID>;
+	};
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

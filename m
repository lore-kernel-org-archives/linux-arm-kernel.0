From: ckadabi@codeaurora.org (Channagoud Kadabi)
Date: Thu, 25 Jan 2018 15:55:12 -0800
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
Message-ID: <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for last level cache controller device tree bindings,
client bindings usage examples.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
new file mode 100644
index 0000000..d433b0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -0,0 +1,93 @@
+* LLCC (Last Level Cache Controller)
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,llcc-core"
+
+- reg:
+	Usage: required
+	Value Type: <prop-encoded-array>
+	Definition: must be addresses and sizes of the LLCC registers
+
+- llcc-bank-off:
+	Usage: required
+	Value Type: <u32 array>
+	Definition: Offsets of llcc banks from llcc base address starting from
+		    LLCC bank0.
+
+- llcc-broadcast-off:
+	Usage: required
+	Value Type: <u32>
+	Definition: Offset of broadcast register from LLCC bank0 address.
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
+- status:
+	Usage: optional
+	Value type: <string>
+	Definition: Property to enable or disable the driver
+
+== llcc amon device ==
+
+Properties:
+-qcom,fg-cnt : The value of fine grained counter of activity monitor
+	        block.
+
+compatible devices:
+		qcom,sdm845-llcc
+
+Example:
+
+	qcom,system-cache at 1300000 {
+		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
+		reg = <0x1300000 0x50000>;
+		reg-names = "llcc_base";
+
+		llcc: qcom,sdm845-llcc {
+			compatible = "qcom,sdm845-llcc";
+			#cache-cells = <1>;
+			max-slices = <32>;
+		};
+
+		qcom,llcc-ecc {
+			compatible = "qcom,llcc-ecc";
+		};
+
+		qcom,llcc-amon {
+			compatible = "qcom,llcc-amon";
+			qcom,fg-cnt = <0x7>;
+		};
+
+	};
+
+== Client ==
+
+Properties:
+- cache-slice-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: A set of names that identify the usecase names of a client that uses
+		    cache slice. These strings are used to look up the cache slice
+		    entries by name.
+
+- cache-slices:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The tuple has phandle to llcc device as the first argument and the
+		    second argument is the usecase id of the client.
+For example:
+
+	video-decoder-encoder {
+		cache-slice-names = "vidsc0", "vidsc1";
+		cache-slices = <&llcc 2>, <&llcc 3>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

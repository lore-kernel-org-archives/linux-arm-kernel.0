From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon,  9 Jul 2018 18:51:03 +0300
Subject: [PATCH v6 7/8] dt-bindings: Introduce interconnect consumers bindings
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
Message-ID: <20180709155104.25528-8-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the interconnect consumer bindings, that will allow
to link a device node (consumer) to its interconnect controller hardware.

Tha aim is to enable drivers to request a framework API to configure an
interconnect path by providing their struct device pointer and a name.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6e2b2971b094..0ad65dccbe8b 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -31,3 +31,30 @@ Example:
 			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
 				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
+
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which consume the interconnect
+path(s) provided by the interconnect provider. There can be multiple
+interconnect providers on a SoC and the consumer may consume multiple paths
+from different providers depending on use case and the components it has to
+interact with.
+
+Required properties:
+interconnects : Pairs of phandles and interconnect provider specifier to denote
+	        the edge source and destination ports of the interconnect path.
+
+Optional properties:
+interconnect-names : List of interconnect path name strings sorted in the same
+		     order as the interconnects property. Consumers drivers will use
+		     interconnect-names to match interconnect paths with interconnect
+		     specifiers.
+
+Example:
+
+	sdhci at 7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "ddr";
+	};

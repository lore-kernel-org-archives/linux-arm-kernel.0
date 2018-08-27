From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:09 -0600
Subject: [PATCH 6/9]  PM / OPP: dt-bindings: Add opp-interconnect-bw
In-Reply-To: <20180827151112.25211-1-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
Message-ID: <20180827151112.25211-7-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "opp-interconnect-bw" property to specify the
average and peak bandwidth for an interconnect path for
a specific operating power point. A separate bandwidth
pair can be specified for each of the interconnects
defined for the device by appending the interconnect
name to the property.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c396c4c0af92..d714c084f36d 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -170,6 +170,11 @@ Optional properties:
   functioning of the current device at the current OPP (where this property is
   present).
 
+- opp-interconnect-bw-<name>: This is an array of pairs specifying the average
+  and peak bandwidth in bytes per second for the interconnect path known by
+  'name'.  This should match the name(s) specified by interconnect-names in the
+  device definition.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
@@ -543,3 +548,34 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		};
 	};
 };
+
+Example 7: opp-interconnect-bw:
+(example: leaf device with frequency and BW quotas)
+
+/ {
+	soc {
+		gpu at 5000000 {
+			...
+			interconnects = <&qnoc 26 &qnoc 512>;
+			interconnect-names = "port0";
+			...
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+	};
+
+	gpu_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp-710000000 {
+			op-hz = /bits/ 64 <710000000>;
+			/* Set peak bandwidth @ 7216000 KB/s */
+			opp-interconnect-bw-port0 = /bits/ 64 <0 7216000000>;
+		};
+
+		opp-210000000 {
+			op-hz = /bits/ 64 <210000000>;
+			/* Set peak bandwidth @ 1200000 KB/s */
+			opp-interconnect-bw-port0 = /bits/ 64 <0 1200000000>;
+		};
+	};
+};
-- 
2.18.0

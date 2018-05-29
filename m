From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 29 May 2018 12:04:17 +0200
Subject: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to be a
 list of specifiers
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
Message-ID: <20180529100421.31022-6-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to describe topologies where devices are partitioned across
multiple power domains, let's extend the power-domain property to allow
being a list of PM domain specifiers.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Fixed comments from Geert. Re-worded to "PM domain specifiers" and
	clarified DT example.

---
 .../bindings/power/power_domain.txt           | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 4733f76cbe48..9b387f861aed 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -111,8 +111,8 @@ Example 3:
 ==PM domain consumers==
 
 Required properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
+ - power-domains : A list of PM domain specifiers, as defined by bindings of
+		the power controller that is the PM domain provider.
 
 Example:
 
@@ -122,9 +122,18 @@ Example:
 		power-domains = <&power 0>;
 	};
 
-The node above defines a typical PM domain consumer device, which is located
-inside a PM domain with index 0 of a power controller represented by a node
-with the label "power".
+	leaky-device at 12351000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12351000 0x1000>;
+		power-domains = <&power 0>, <&power 1> ;
+	};
+
+The first example above defines a typical PM domain consumer device, which is
+located inside a PM domain with index 0 of a power controller represented by a
+node with the label "power".
+In the second example the consumer device are partitioned across two PM domains,
+the first with index 0 and the second with index 1, of a power controller that
+is represented by a node with the label "power.
 
 Optional properties:
 - required-opps: This contains phandle to an OPP node in another device's OPP
-- 
2.17.0
